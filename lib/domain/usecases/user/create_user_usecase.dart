import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/exception/user/taken_user_name_exception.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/services/user/identity_generator.dart';
import 'package:finora/domain/value_object/user/birthday_date.dart';
import 'package:finora/domain/value_object/user/person_name.dart';
import 'package:finora/domain/value_object/user/user_id.dart';
import 'package:finora/domain/value_object/user/user_name.dart';
import 'package:finora/domain/services/user/user_name_generator.dart';

/// Use case responsible for creating and registering a new [User].
///
/// This class represents the application's business workflow for user
/// registration. It coordinates the creation and validation of the user's
/// domain objects before finally persisting the new user through the
/// [UserRepository].
///
/// The registration process is responsible for:
/// - Validating and creating the user's first name.
/// - Optionally validating the middle and last names.
/// - Validating and wrapping the birthday date inside [BirthdayDate].
/// - Creating or validating a username.
/// - Generating a unique [UserId].
/// - Creating the final immutable [User] entity.
/// - Persisting the user through the repository.
///
/// Username handling follows two possible flows:
///
/// 1. If the user provides a username:
///    - The username is validated through [UserName].
///    - The repository is checked to ensure that it is not already taken.
///
/// 2. If the user does not provide a username:
///    - A username is automatically generated from the first name.
///    - The generated username is checked against the repository.
///    - The generation process is retried up to [_maxUsernameGenerationAttempts]
///      times to avoid an infinite retry loop.
///
/// This class intentionally depends on [UserRepository] rather than on a
/// concrete data source. This keeps the use case independent from the
/// persistence mechanism and follows the Dependency Inversion Principle.
///
/// Any invalid domain data or business rule violation is allowed to propagate
/// as a domain exception to the presentation/application layer.
class CreateUserUseCase {
  /// Repository responsible for persisting users and checking username
  /// availability.
  final UserRepository _userRepository;

  /// Maximum number of attempts allowed when automatically generating a
  /// unique username.
  ///
  /// This limit prevents the username generation process from entering an
  /// infinite loop in case the generated usernames repeatedly collide with
  /// existing usernames.
  static const int _maxUsernameGenerationAttempts = 5;

  const CreateUserUseCase({required this._userRepository});

  /// Creates a new [User] and saves it through the user repository.
  ///
  /// The method accepts raw input values because it is the entry point of the
  /// registration workflow. Raw values are converted into domain value objects
  /// before the [User] entity is created.
  ///
  /// If [userName] is provided, it must be valid and available.
  /// If [userName] is null, a unique username is generated automatically.
  ///
  /// Throws domain exceptions when any business rule is violated, such as:
  /// - Invalid name format.
  /// - Invalid birthday date.
  /// - Invalid username format.
  /// - Already-taken username.
  /// - Failure to generate a unique username.
  ///
  /// Returns the newly created and persisted [User].
  Future<User> execute({
    String? userName,
    required String firstName,
    required DateTime? birthDate,
    String? middleName,
    String? lastName,
  }) async {
    // Convert the raw first name into a validated PersonName value object.
    //
    // Validation is delegated to the domain layer, ensuring that the User
    // entity can never receive an invalid first name.
    final firstNamePerson = PersonName.create(
      value: firstName,
      nameType: 'first name',
    );

    // Optional names are represented as nullable domain value objects.
    //
    // They are created only when the corresponding raw value is provided.
    PersonName? middleNamePerson;
    PersonName? lastNamePerson;

    // Validate and create the middle name only when it exists.
    if (middleName != null) {
      middleNamePerson = PersonName.create(
        value: middleName,
        nameType: 'middle name',
      );
    }

    // Validate and create the last name only when it exists.
    if (lastName != null) {
      lastNamePerson = PersonName.create(
        value: lastName,
        nameType: 'last name',
      );
    }

    // Validate the birthday and wrap it inside the BirthdayDate value object.
    //
    // BirthdayDate is responsible for enforcing birthday-related business
    // rules such as valid age boundaries and preventing future dates.
    final BirthdayDate birthdayDate = BirthdayDate.create(birthDate);

    // Capture one timestamp and use it consistently for the newly created
    // user's creation date.
    final now = DateTime.now();

    // Resolve the username according to the registration rules.
    //
    // If the user supplied a username, it will be validated and checked for
    // uniqueness. Otherwise, a username will be generated automatically.
    final newUserName = await _getNewUserName(userName, firstName);

    // Generate a globally unique identifier for the new user and immediately
    // wrap it inside the UserId value object so the identifier is validated
    // before entering the User entity.
    final id = UserId.create(IdentityGenerator.generateUuid());

    // At this point all raw input has been transformed into valid domain
    // objects, allowing us to safely construct the User entity.
    final user = User.create(
      id: id,
      userName: newUserName,
      firstName: firstNamePerson,
      middleName: middleNamePerson,
      lastName: lastNamePerson,
      createdAt: now,
      birthDayDate: birthdayDate,
      imagePath: null,
    );

    // Persist the fully validated User through the repository abstraction.
    //
    // The use case does not know whether the user will be stored in a
    // database, API, local storage, or any other data source.
    await _userRepository.saveUser(user);

    // Return the created domain entity to the caller.
    return user;
  }

  /// Resolves the username that will be assigned to the new user.
  ///
  /// There are two possible paths:
  ///
  /// - A username was explicitly provided by the user.
  /// - No username was provided, so one must be generated automatically.
  Future<UserName> _getNewUserName(String? userName, String firstName) async {
    // When the user provides a username, validate it and make sure it is
    // not already registered.
    if (userName != null) {
      return await _getValidatedUserName(userName);
    }

    // Otherwise, generate a unique username based on the first name.
    return await _retryGenerateUserNameLoop(firstName);
  }

  /// Generates usernames until a unique username is found.
  ///
  /// Each generated username is checked against the repository before being
  /// accepted. If all attempts result in usernames that are already taken,
  /// [TakenUserNameException] is thrown.
  ///
  /// The retry limit is controlled by [_maxUsernameGenerationAttempts].
  Future<UserName> _retryGenerateUserNameLoop(String firstName) async {
    // Try generating a username a limited number of times.
    //
    // Limiting the attempts prevents an endless loop in case of repeated
    // username collisions.
    for (int attempt = 0; attempt < _maxUsernameGenerationAttempts; attempt++) {
      // Generate a username using the first name and the domain's
      // username-generation rules.
      final newUserName = UserNameGenerator.generate(name: firstName);

      // Check whether the generated username already exists.
      final isTaken = await _userRepository.isUserNameTaken(newUserName.value);

      // If nobody is using the username, it can safely be assigned.
      if (!isTaken) {
        return newUserName;
      }

      // If the username is already taken, the loop generates another one.
    }

    // All allowed attempts were exhausted without finding a unique username.
    throw const TakenUserNameException(
      message: 'Could not generate a unique username. Please try again.',
    );
  }

  /// Validates a username explicitly provided by the user and checks whether
  /// it is already registered.
  ///
  /// The username is first converted into the [UserName] value object. This
  /// guarantees that format validation happens before querying the repository.
  Future<UserName> _getValidatedUserName(String userName) async {
    // Convert and validate the raw username using the domain value object.
    final validatedUserName = UserName.create(value: userName);

    // Check the repository only after the username has passed domain
    // validation.
    final isTaken = await _userRepository.isUserNameTaken(
      validatedUserName.value,
    );

    // Reject the registration when another user already owns this username.
    if (isTaken) {
      throw const TakenUserNameException(
        message: 'This Username is already taken.',
      );
    }

    // The username is valid and available.
    return validatedUserName;
  }
}
