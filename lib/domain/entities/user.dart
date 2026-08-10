import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/validators/validate_date.dart';
import 'package:finora/domain/value_object/birthday_date.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/value_object/profile_image_path.dart';
import 'package:finora/domain/value_object/user_name.dart';

///               15/7
/// Represents a user within the domain.
///
/// A [User] is the central business entity responsible for
/// encapsulating all information related to a system user.
///
/// Unlike Value Objects, a User is uniquely identified by its
/// username. Two User instances are considered the same entity
/// when they share the same [UserName], regardless of the values
/// of their remaining properties.
///
/// ## Responsibilities
///
/// - Represent a registered user.
/// - Maintain a valid identity through [UserName].
/// - Encapsulate validated personal names using [PersonName].
/// - Own a validated financial [Account].
/// - Preserve the user's creation timestamp.
/// - Prevent invalid state from existing inside the Domain layer.
/// - Support serialization, deserialization and immutable updates.
///
/// ## Domain Model
///
/// A User consists of:
///
/// - Unique username.
/// - First name (required).
/// - Middle name (optional).
/// - Last name (optional).
/// - Financial account.
/// - Creation timestamp.
///
/// Every component is represented either by an Entity or a
/// Value Object, ensuring that all business rules are enforced
/// before the entity is created.
///
/// ## Validation
///
/// Object creation performs validation through specialized
/// domain components:
///
/// - [UserName] validates the user's identity.
/// - [PersonName] validates every supplied name.
/// - [Account] guarantees a valid financial account.
/// - [CreatedAtValidator] validates the creation timestamp.
///
/// If any validation fails, object creation is aborted and
/// a domain exception is thrown.
///
/// ## Identity
///
/// The username uniquely identifies a User.
///
/// Therefore, two User objects are considered equal when they
/// share the same [UserName], regardless of any other field.
///
/// ## Immutability
///
/// A User cannot be modified after creation.
///
/// Instead of mutating existing instances,
/// [copyWith] creates a new validated User while preserving
/// the original instance.
///
/// ## Domain Invariants
///
/// A User always satisfies the following business rules:
///
/// - Always has a valid username.
/// - Always has a valid first name.
/// - Optional names, when provided, are always valid.
/// - Always owns a valid account.
/// - Always has a valid creation timestamp.
/// - Invalid state cannot exist inside the Domain layer.
///
/// This class represents a **Domain Entity** in
/// Domain-Driven Design (DDD) and belongs to the Domain layer
/// of the application's Clean Architecture.

class User {
  /// Sentinel object used by [copyWith] to distinguish between:
  ///
  /// - An omitted optional parameter.
  /// - An explicit `null` value.
  ///
  /// This allows optional nullable fields to be intentionally
  /// cleared while preserving the ability to leave them unchanged.
  static const Object sentinel = Object();

  /// Unique identity of the user.
  final UserName _userName;

  /// Required first name.
  final PersonName _firstName;

  /// Optional middle name.
  final PersonName? _middleName;

  /// Optional last name.
  final PersonName? _lastName;

  /// Financial account owned by the user.
  final Account _account;

  /// Timestamp indicating when the user was created.
  final DateTime _createdAt;

  final ProfileImage _image;
  final BirthdayDate _date;

  /// Private constructor used internally after all domain
  /// validation has successfully completed.
  const User({
    required this._userName,
    required this._firstName,
    required this._account,
    required this._createdAt,
    required this._image,
    required this._date,
    this._middleName,
    this._lastName,
  });

  /// Creates a validated [User].
  ///
  /// Creation workflow:
  ///
  /// 1. Validate the first name.
  /// 2. Validate optional names when provided.
  /// 3. Validate the creation timestamp.
  /// 4. Reuse the validated [UserName].
  /// 5. Reuse the validated [Account].
  /// 6. Construct the entity.
  ///
  /// Throws any exception raised by the underlying
  /// domain validators or value objects.
  factory User.create({
    required String userName,
    required String firstName,
    required Account account,
    required DateTime createdAt,
    required DateTime birthDate,
    required String? imagePath,
    String? middleName,
    String? lastName,
  }) {
    final userNameInst = UserName.create(value: userName);

    /// Convert the supplied first name into a validated
    /// domain Value Object.
    final firstNamePerson = PersonName.create(
      value: firstName,
      nameType: "first name",
    );

    PersonName? middleNamePerson;
    PersonName? lastNamePerson;

    /// Validate optional middle name only when supplied.
    if (middleName != null) {
      middleNamePerson = PersonName.create(
        value: middleName,
        nameType: "middle name",
      );
    }

    /// Validate optional last name only when supplied.
    if (lastName != null) {
      lastNamePerson = PersonName.create(
        value: lastName,
        nameType: "last name",
      );
    }

    final birhtdayDate = BirthdayDate.create(birthDate);

    /// Ensure the supplied creation date satisfies the
    /// application's temporal business rules.
    CreatedAtValidator.validateOrThrow(createdAt);

    final profileImage = ProfileImage.create(imagePath: imagePath);
    return User(
      userName: userNameInst,
      firstName: firstNamePerson,
      middleName: middleNamePerson,
      lastName: lastNamePerson,
      account: account,
      createdAt: createdAt,
      image: profileImage,
      date: birhtdayDate,
    );
  }

  /// Reconstructs a validated [User] from its serialized
  /// representation.
  ///
  /// Deserialized values are passed through the standard
  /// creation workflow to preserve all domain invariants.
  factory User.fromJson({required Map<String, Object?> json}) {
    final userName = json['userName'] as String;
    final firstName = json['firstName'] as String;
    final middleName = json['middleName'] as String?;
    final lastName = json['lastName'] as String?;

    final accountMap = json['account'] as Map<String, Object?>;
    final createdAt = DateTime.parse(json['createdAt'] as String);
    final ProfileImagePath = json['imagePath'] as String;
    final birthdayDate = DateTime.parse(json['birthdayDate'] as String);

    /// Ensure the supplied creation date satisfies the
    /// application's temporal business rules.
    CreatedAtValidator.validateOrThrow(createdAt);

    return User.create(
      userName: userName,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      account: Account.fromJson(accountMap),
      createdAt: createdAt,
      imagePath: ProfileImagePath,
      birthDate: birthdayDate,
    );
  }

  /// Creates a modified copy of this User.
  ///
  /// Only the supplied values are replaced.
  ///
  /// Nullable properties support explicit null assignment
  /// through the internal sentinel object, allowing callers
  /// to distinguish between:
  ///
  /// - Leaving a value unchanged.
  /// - Clearing an existing value.
  ///
  /// The returned instance is fully revalidated before creation.
  User copyWith({
    UserName? userName,
    PersonName? firstName,
    Object? middleName = sentinel,
    Object? lastName = sentinel,
    Account? account,
    String? profileImagePath,
    DateTime? BirthdayDate,
  }) {
    return User.create(
      userName: (userName == null) ? _userName.value : userName.value,
      firstName: (firstName == null) ? _firstName.value : firstName.value,
      account: account ?? _account,

      middleName: middleName == sentinel
          ? _middleName!.value
          : middleName as String,

      lastName: lastName == sentinel ? _lastName!.value : lastName as String,
      createdAt: _createdAt,
      imagePath: profileImagePath ?? _image.path,
      birthDate: BirthdayDate ?? _date.value,
    );
  }

  /// Converts this User into a serializable map.
  ///
  /// Useful when persisting the entity or sending it
  /// across application boundaries.
  Map<String, dynamic> toMap() => {
    "userName": _userName.value,
    "firstName": _firstName.value,
    "middleName": _middleName?.value,
    "lastName": _lastName?.value,
    "account": _account.toMap(),
    "createdAt": _createdAt.toIso8601String(),
    "imagePath": _image.path,
    'birthdayDate': _date.formattedDate,
  };

  UserName get userName => _userName;

  PersonName get firstName => _firstName;

  PersonName? get middleName => _middleName;

  PersonName? get lastName => _lastName;

  Account get account => _account;

  DateTime get createdAt => _createdAt;

  ProfileImage get image => _image;

  BirthdayDate get birthdayDate => _date;

  /// Returns the user's complete display name.
  ///
  /// Optional name parts are included only when present
  String get fullName {
    return [
      firstName.value,
      if (middleName != null) middleName!.value,
      if (lastName != null) lastName!.value,
    ].join(' ');
  }

  /// Compares two User entities by their identity.
  ///
  /// Two users are considered equal when they have
  /// the same username.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is User && other.userName == _userName);
  }

  /// Hash code derived from the user's identity.
  @override
  int get hashCode {
    return _userName.hashCode;
  }

  /// Returns a readable representation of the User.
  @override
  String toString() =>
      """
  User name: ${_userName.value}
  Name: $fullName
  account: $_account
  created at: $_createdAt
  Image Path: ${_image.path}""";
}
