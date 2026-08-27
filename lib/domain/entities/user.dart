import 'package:finora/domain/validators/user/validate_date.dart';
import 'package:finora/domain/value_object/user/birthday_date.dart';
import 'package:finora/domain/value_object/user/person_name.dart';
import 'package:finora/domain/value_object/user/profile_image_path.dart';
import 'package:finora/domain/value_object/user/user_id.dart';
import 'package:finora/domain/value_object/user/user_name.dart';

/// Represents a user inside the Domain layer.
///
/// [User] is a Domain Entity that represents the application's
/// user and contains the user's identity, personal information,
/// birthday, profile image, and creation timestamp.
///
/// Unlike a simple data model, this Entity is responsible for
/// preserving Domain invariants when it is created or updated.
///
/// The User Entity is composed primarily of Value Objects:
///
/// ```text
/// User
///  │
///  ├── UserId
///  ├── UserName
///  ├── PersonName
///  │    ├── First Name
///  │    ├── Middle Name?
///  │    └── Last Name?
///  ├── BirthdayDate
///  ├── ProfileImage?
///  └── createdAt
/// ```
///
/// Important characteristics:
///
/// - The Entity is immutable.
/// - Important values are represented using Value Objects.
/// - Creation dates are validated by the Domain.
/// - Updates are performed through [copyWith] instead of directly
///   modifying the existing Entity.
/// - Nullable fields such as middle name, last name, and profile
///   image can explicitly be cleared using the sentinel pattern.
///
/// This keeps the User Entity consistent and prevents invalid
/// state from entering the Domain.
class User {
  /// Sentinel object used by [copyWith] to distinguish between:
  ///
  /// ```text
  /// Parameter not provided
  ///        vs
  /// Parameter explicitly set to null
  /// ```
  ///
  /// This distinction is important for nullable properties.
  ///
  /// For example:
  ///
  /// ```dart
  /// user.copyWith();
  /// ```
  ///
  /// means "keep the current value".
  ///
  /// While:
  ///
  /// ```dart
  /// user.copyWith(middleName: null);
  /// ```
  ///
  /// means "remove the middle name".
  static const Object sentinel = Object();

  /// The user's unique username.
  final UserName _userName;

  /// The user's unique Domain identity.
  final UserId _id;

  /// The user's first name.
  final PersonName _firstName;

  /// The user's optional middle name.
  final PersonName? _middleName;

  /// The user's optional last name.
  final PersonName? _lastName;

  /// The timestamp at which the user was created.
  final DateTime _createdAt;

  /// The user's optional profile image.
  final ProfileImage? _image;

  /// The user's validated date of birth.
  final BirthdayDate _birthdayDate;

  /// Private constructor used to create a [User].
  ///
  /// Keeping the constructor private forces object creation
  /// through [User.create], ensuring that Domain validation is
  /// performed before a User enters the Domain.
  const User._({
    required this._userName,
    required this._id,
    required this._firstName,
    required this._createdAt,
    required this._image,
    required this._birthdayDate,
    this._middleName,
    this._lastName,
  });

  /// Creates a new validated [User] Entity.
  ///
  /// Most properties are already represented by Value Objects,
  /// which means their own validation has already happened before
  /// reaching this factory.
  ///
  /// The [createdAt] timestamp is additionally validated here
  /// because it is an invariant of the User Entity.
  ///
  /// Creation flow:
  ///
  /// ```text
  /// User.create()
  ///      │
  ///      ├── UserId
  ///      ├── UserName
  ///      ├── PersonName
  ///      ├── BirthdayDate
  ///      ├── ProfileImage?
  ///      │
  ///      └── createdAt
  ///             │
  ///             ▼
  ///      CreatedAtValidator
  ///             │
  ///             ▼
  ///          User Entity
  /// ```
  factory User.create({
    required UserId id,
    required UserName userName,
    required PersonName firstName,
    required DateTime createdAt,
    required BirthdayDate birthDayDate,
    required ProfileImage? imagePath,
    PersonName? middleName,
    PersonName? lastName,
  }) {
    // Validate the creation timestamp before creating the Entity.
    //
    // This guarantees that a User cannot be created with an
    // invalid creation date.
    CreatedAtValidator.validateOrThrow(time: createdAt);

    // Create the Entity only after all required invariants
    // have successfully passed validation.
    return User._(
      userName: userName,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      id: id,
      createdAt: createdAt,
      image: imagePath,
      birthdayDate: birthDayDate,
    );
  }

  /// Creates a new User based on the current Entity while
  /// replacing only the values explicitly provided.
  ///
  /// The method preserves immutability by creating a completely
  /// new [User] instead of modifying the current instance.
  ///
  /// Nullable properties use the [sentinel] pattern so the method
  /// can distinguish between:
  ///
  /// ```text
  /// Not provided → keep the old value
  ///
  /// Explicit null → remove the existing value
  /// ```
  User copyWith({
    UserName? userName,
    PersonName? firstName,
    Object? middleName = sentinel,
    Object? lastName = sentinel,
    Object? profileImagePath = sentinel,
    BirthdayDate? birthdayDate,
  }) {
    return User.create(
      // The user's identity never changes during a normal update.
      id: _id,

      // Use the new username if provided;
      // otherwise preserve the current username.
      userName: userName ?? _userName,

      // Use the new first name if provided;
      // otherwise preserve the current first name.
      firstName: firstName ?? _firstName,

      // The original creation timestamp must remain unchanged.
      createdAt: _createdAt,

      // Use the new birthday when provided;
      // otherwise preserve the existing birthday.
      birthDayDate: birthdayDate ?? _birthdayDate,

      // Sentinel allows the caller to either keep the existing
      // image or explicitly remove it by passing null.
      imagePath: profileImagePath == sentinel
          ? _image
          : profileImagePath as ProfileImage?,

      // Same sentinel mechanism for the optional middle name.
      middleName: middleName == sentinel
          ? _middleName
          : middleName as PersonName?,

      // Same sentinel mechanism for the optional last name.
      lastName: lastName == sentinel ? _lastName : lastName as PersonName?,
    );
  }

  /// Compares two User Entities using their identity fields.
  ///
  /// This method is useful when the application wants to determine
  /// whether two objects represent the same User Entity.
  ///
  /// Two Users are considered the same Entity when they have the
  /// same [UserId] and [UserName].
  bool isEqual(Object other) =>
      identical(this, other) ||
      (other is User && other._userName == _userName && other._id == _id);

  /// Returns the user's username.
  UserName get userName => _userName;

  /// Returns the user's unique identifier.
  UserId get id => _id;

  /// Returns the user's first name.
  PersonName get firstName => _firstName;

  /// Returns the user's optional middle name.
  PersonName? get middleName => _middleName;

  /// Returns the user's optional last name.
  PersonName? get lastName => _lastName;

  /// Returns the timestamp at which the User was created.
  DateTime get createdAt => _createdAt;

  /// Returns the user's optional profile image.
  ProfileImage? get profileImage => _image;

  /// Returns the user's validated birthday.
  BirthdayDate get birthdayDate => _birthdayDate;

  /// Returns the complete name of the user.
  ///
  /// Only the names that actually exist are included.
  ///
  /// Examples:
  ///
  /// ```text
  /// John
  /// John Michael
  /// John Michael Smith
  /// ```
  String get fullName {
    return [
      firstName.value,
      if (middleName != null) middleName!.value,
      if (lastName != null) lastName!.value,
    ].join(' ');
  }

  /// Determines whether two User Entities contain the same
  /// complete state.
  ///
  /// Unlike [isEqual], which focuses on Entity identity,
  /// this equality operator compares the actual state of the
  /// two User objects.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is User &&
            other._userName == _userName &&
            other._firstName == _firstName &&
            other._middleName == _middleName &&
            other._lastName == _lastName &&
            other._createdAt == _createdAt &&
            other._image == _image &&
            other._birthdayDate == _birthdayDate);
  }

  /// Generates a hash code based on the complete state of the User.
  ///
  /// The same fields used by [operator ==] are included to preserve
  /// the equality/hashCode contract.
  @override
  int get hashCode {
    return Object.hash(
      _userName,
      _id,
      _firstName,
      _middleName,
      _lastName,
      _createdAt,
      _birthdayDate,
      _image,
    );
  }

  /// Returns a readable representation of the User.
  ///
  /// This is especially useful for debugging and logging.
  @override
  String toString() =>
      """
User name: ${_userName.value}
Name: $fullName
created at: $_createdAt
Image Path: ${_image?.path}""";
}
