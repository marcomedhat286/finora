// domain/usecases/user/update_user_usecase.dart

import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/value_object/user/birthday_date.dart';
import 'package:finora/domain/value_object/user/person_name.dart';
import 'package:finora/domain/value_object/user/profile_image_path.dart';
import 'package:finora/domain/value_object/user/user_name.dart';
import 'package:finora/domain/exception/user/taken_user_name_exception.dart';

/// Application use case responsible for updating an existing [User].
///
/// This class represents the business operation of modifying user data.
/// It does NOT directly manipulate raw strings or trust input coming from
/// the UI. Instead, every changed value is converted into its corresponding
/// Domain Value Object so that the Domain rules remain enforced.
///
/// The use case supports **partial updates**, meaning the caller can update
/// one field, several fields, or all editable fields without recreating the
/// entire user manually.
///
/// Responsibilities:
/// - Validate changed user data through Domain Value Objects.
/// - Distinguish between "keep the old value" and "clear the value".
/// - Check username uniqueness when the username actually changes.
/// - Create a new immutable [User] using [User.copyWith].
/// - Persist the updated entity through [UserRepository].
///
/// Important:
/// The use case does not know anything about Flutter widgets, TextFields,
/// screens, or controllers. It only coordinates the Domain rules and the
/// repository required to complete the update operation.
class UpdateUserUseCase {
  final UserRepository _userRepository;

  const UpdateUserUseCase({required this._userRepository});

  /// Executes the user update operation.
  ///
  /// [currentUser]
  /// The existing user that will be updated.
  ///
  /// [rawUserName]
  /// Optional new username.
  /// If null, the current username is preserved.
  /// If provided, it is validated and checked for uniqueness when changed.
  ///
  /// [rawFirstName]
  /// Optional new first name.
  ///
  /// [rawMiddleName]
  /// Uses [User.sentinel] to distinguish between:
  ///
  /// 1. Parameter was not provided → keep the existing middle name.
  /// 2. Parameter was provided with a String → replace the old value.
  /// 3. Parameter was provided with null/empty value → remove the middle name.
  ///
  /// [rawLastName]
  /// Behaves exactly like [rawMiddleName].
  ///
  /// [rawProfileImagePath]
  /// Uses the same sentinel mechanism to distinguish between:
  ///
  /// 1. Not provided → keep the current image.
  /// 2. Valid path → replace the current image.
  /// 3. null/empty → remove the current image.
  ///
  /// [rawBirthdayDate]
  /// Optional new birthday date. If provided, it is validated through
  /// [BirthdayDate].
  ///
  /// Returns:
  /// The updated [User] entity.
  ///
  /// Throws:
  /// Domain exceptions when any supplied value violates a business rule,
  /// or when the requested username is already taken.
  Future<User> execute({
    required User currentUser,
    String? rawUserName,
    String? rawFirstName,
    Object? rawMiddleName = User.sentinel,
    Object? rawLastName = User.sentinel,
    Object? rawProfileImagePath = User.sentinel,
    DateTime? rawBirthdayDate,
  }) async {
    // ============================================================
    // 1. VALIDATE AND CONVERT RAW VALUES INTO DOMAIN VALUE OBJECTS
    // ============================================================
    //
    // The UI provides primitive values such as String and DateTime.
    // The Domain should not receive unvalidated raw data.
    //
    // Therefore, every provided value is passed through its corresponding
    // Value Object factory, which is responsible for enforcing its rules.

    // ------------------------------------------------------------
    // First Name
    // ------------------------------------------------------------
    //
    // If no new first name was supplied, keep the current value.
    // Otherwise, create a validated PersonName.
    final newFirstName = rawFirstName != null
        ? PersonName.create(value: rawFirstName, nameType: 'first name')
        : null;

    // ------------------------------------------------------------
    // Middle Name
    // ------------------------------------------------------------
    //
    // The sentinel is necessary here because null has a meaning.
    //
    // null by itself cannot tell us whether:
    //
    // "the caller did not send a middle name"
    //
    // or:
    //
    // "the caller explicitly wants to remove the middle name".
    //
    // User.sentinel solves this ambiguity.
    Object? newMiddleName = User.sentinel;

    if (rawMiddleName != User.sentinel) {
      final strVal = rawMiddleName as String?;

      // A null or empty value means:
      // "Remove the existing middle name."
      //
      // A non-empty value means:
      // "Replace it with this validated name."
      newMiddleName = (strVal != null && strVal.trim().isNotEmpty)
          ? PersonName.create(value: strVal, nameType: 'middle name')
          : null;
    }

    // ------------------------------------------------------------
    // Last Name
    // ------------------------------------------------------------
    //
    // Same sentinel-based partial update strategy used for middle name.
    Object? newLastName = User.sentinel;

    if (rawLastName != User.sentinel) {
      final strVal = rawLastName as String?;

      newLastName = (strVal != null && strVal.trim().isNotEmpty)
          ? PersonName.create(value: strVal, nameType: 'last name')
          : null;
    }

    // ------------------------------------------------------------
    // Birthday Date
    // ------------------------------------------------------------
    //
    // BirthdayDate is a Value Object.
    // Its factory validates the supplied date and guarantees that the
    // resulting object satisfies the Domain's birthday rules.
    final newBirthdayDate = rawBirthdayDate != null
        ? BirthdayDate.create(rawBirthdayDate)
        : null;

    // ============================================================
    // 2. USERNAME VALIDATION + UNIQUENESS CHECK
    // ============================================================
    //
    // Username has two different responsibilities:
    //
    // 1. Format validation → handled by UserName Value Object.
    // 2. Uniqueness → handled through the Repository.
    //
    // This distinction is important:
    //
    // "Is this username structurally valid?"
    //       ↓
    // UserName
    //
    // "Does another user already own it?"
    //       ↓
    // UserRepository

    UserName? newUserName;

    if (rawUserName != null && rawUserName.trim().isNotEmpty) {
      // Convert the raw username into a validated Domain Value Object.
      final parsedUserName = UserName.create(value: rawUserName);

      // ----------------------------------------------------------
      // Only check the repository when the username changed.
      // ----------------------------------------------------------
      //
      // If the user keeps the exact same username, there is no reason
      // to ask the repository whether it is taken.
      //
      // This also prevents the current user's own username from being
      // incorrectly treated as a duplicate.
      if (parsedUserName != currentUser.userName) {
        final isTaken = await _userRepository.isUserNameTaken(
          parsedUserName.value,
        );

        if (isTaken) {
          throw const TakenUserNameException(
            message: 'The username is already taken',
          );
        }
      }

      newUserName = parsedUserName;
    }

    // ============================================================
    // 3. PROFILE IMAGE UPDATE
    // ============================================================
    //
    // Profile image also uses the sentinel pattern because the update
    // operation needs to support three different states:
    //
    // sentinel → keep old image
    // valid path → replace old image
    // null/empty → remove old image

    Object? newProfileImagePath = User.sentinel;

    if (rawProfileImagePath != User.sentinel) {
      final strVal = rawProfileImagePath as String?;

      newProfileImagePath = (strVal != null && strVal.trim().isNotEmpty)
          ? ProfileImage.create(imagePath: strVal)
          : null;
    }

    // ============================================================
    // 4. CREATE A NEW USER INSTEAD OF MUTATING THE OLD USER
    // ============================================================
    //
    // User is treated as an immutable Domain Entity.
    //
    // We do not modify currentUser directly.
    // Instead, copyWith creates a new User containing:
    //
    // - old values for fields that were not changed
    // - new values for fields that were changed
    //
    // This keeps the original entity untouched and makes state changes
    // predictable and easier to reason about.
    final updatedUser = currentUser.copyWith(
      userName: newUserName,
      firstName: newFirstName,
      middleName: newMiddleName,
      lastName: newLastName,
      profileImagePath: newProfileImagePath,
      birthdayDate: newBirthdayDate,
    );

    // ============================================================
    // 5. PERSIST ONLY IF SOMETHING ACTUALLY CHANGED
    // ============================================================
    //
    // User equality determines whether the resulting entity is different
    // from the original one.
    //
    // If nothing changed, there is no reason to perform a repository update.
    if (updatedUser != currentUser) {
      await _userRepository.updateUser(updatedUser);
    }

    // Return the final state of the user.
    return updatedUser;
  }
}
