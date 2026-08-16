import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/exception/taken_user_name_exception.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/services/convert_string_todouble_balance.dart';
import 'package:finora/domain/value_object/birthday_date.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/services/account_id_generator.dart';
import 'package:finora/domain/services/user_name_generator.dart';

/// Handles the complete business workflow for registering a new user.
///
/// [RegisterUserUseCase] is responsible for coordinating the different
/// Domain components required to create and register a new [User].
///
/// The use case receives raw registration data and transforms it into
/// validated Domain objects before creating the final [User] entity.
///
/// The registration process includes:
///
/// - Validating the user's first name.
/// - Validating the optional middle name.
/// - Validating the optional last name.
/// - Validating and creating the user's birthday.
/// - Generating a new account ID.
/// - Converting and validating the initial account balance.
/// - Creating the user's initial [Account].
/// - Validating a user-provided username and checking its availability.
/// - Automatically generating a username when one is not provided.
/// - Retrying username generation when a generated username is already taken.
/// - Creating the final [User] entity.
/// - Persisting the user through [UserRepository].
///
/// This class belongs to the Domain Layer and contains business logic
/// rather than presentation or infrastructure logic.
///
/// The use case does not directly communicate with a database or API.
/// Instead, it depends on [UserRepository], which provides an abstraction
/// for accessing and storing user data.
///
/// This keeps the business logic independent from the underlying
/// data source and follows Clean Architecture and Domain-Driven Design
/// principles.
class RegisterUserUseCase {
  /// Repository responsible for checking username availability
  /// and saving the newly registered user.
  ///
  /// The repository is injected into the use case instead of creating
  /// a concrete implementation here. This keeps the use case independent
  /// from the actual data source.
  final UserRepository _userRepository;

  /// Maximum number of additional attempts allowed when generating
  /// an available username before registration fails.
  static const int _maxUsernameGenerationAttempts = 5;

  /// Creates a [RegisterUserUseCase].
  ///
  /// [userRepository] is required because the registration workflow
  /// needs to communicate with the user data source to:
  ///
  /// - Check whether a username is already taken.
  /// - Save the newly created user.
  const RegisterUserUseCase.RegisterNewUserUseCase({
    required this._userRepository,
  });

  /// Executes the user registration workflow.
  ///
  /// The method accepts the raw data provided during registration
  /// and converts that data into validated Domain objects.
  ///
  /// [userName] is optional:
  ///
  /// - If provided, it is checked for availability and converted into
  ///   a validated [UserName] Value Object.
  /// - If not provided, a username is automatically generated from
  ///   [firstName].
  ///
  /// [firstName] is required and is converted into a validated
  /// [PersonName] Value Object.
  ///
  /// [middleName] and [lastName] are optional. When provided, each one
  /// is validated and converted into its corresponding [PersonName]
  /// Value Object.
  ///
  /// [initialBalance] represents the initial account balance as a
  /// String. It is converted into a numeric value and validated before
  /// being used to create the [Account].
  ///
  /// [birthDate] is validated through the [BirthdayDate] Value Object.
  ///
  /// After all required data has been successfully validated, a new
  /// [User] entity is created and persisted through [UserRepository].
  ///
  /// [TakenUserNameException] is thrown when:
  ///
  /// - The username provided by the user is already taken.
  /// - Automatic username generation fails to find an available
  ///   username within the allowed number of attempts.
  ///
  /// Returns the newly created and persisted [User].
  Future<User> execute({
    String? userName,
    required String firstName,
    required String initialBalance,
    required DateTime? birthDate,
    String? middleName,
    String? lastName,
  }) async {
    // Validate the required first name and convert it into
    // a PersonName Value Object.
    //
    // After this operation succeeds, firstNamePerson is guaranteed
    // to satisfy the domain rules defined for personal names.
    final firstNamePerson = PersonName.create(
      value: firstName,
      nameType: 'first name',
    );

    // Middle name and last name are optional, so they are initially
    // represented as null.
    PersonName? middleNamePerson;
    PersonName? lastNamePerson;

    // Create the middle-name Value Object only when a value
    // was provided by the user.
    if (middleName != null) {
      middleNamePerson = PersonName.create(
        value: middleName,
        nameType: 'middle name',
      );
    }

    // Create the last-name Value Object only when a value
    // was provided by the user.
    if (lastName != null) {
      lastNamePerson = PersonName.create(
        value: lastName,
        nameType: 'last name',
      );
    }

    // Validate the provided birth date and convert it into
    // a BirthdayDate Value Object.
    //
    // This ensures that an invalid birthday cannot be used
    // to create the User entity.
    final BirthdayDate birthdayDate = BirthdayDate.create(birthDate);

    // Capture the current timestamp once and reuse it for both
    // the User and Account.
    //
    // Using the same timestamp keeps the creation time of the
    // related Domain objects consistent.
    final now = DateTime.now();

    // Create the initial account for the new user.
    //
    // This method is responsible for generating the account ID,
    // converting the initial balance, and creating the Account entity.
    final Account initialAccount = _getNewAccount(
      initialBalance: initialBalance,
      createdAt: now,
    );

    // Resolve the username that will be assigned to the user.
    //
    // If the user provided a username, it will be validated and
    // checked for availability.
    //
    // Otherwise, a username will be generated automatically
    // from the user's first name.
    final newUserName = await _getNewUserName(userName, firstName);

    // Create the final User entity using the validated Domain objects.
    //
    // At this point, the individual pieces of data have already
    // passed their corresponding Domain validation rules.
    final user = User(
      userName: newUserName,
      firstName: firstNamePerson,
      account: initialAccount,
      middleName: middleNamePerson,
      lastName: lastNamePerson,
      createdAt: now,
      birthdayDate: birthdayDate,
      image: null,
    );

    // Persist the newly created user through the repository abstraction.
    //
    // The use case does not need to know whether the repository stores
    // the user in a local database, remote server, file, or any other
    // data source.
    await _userRepository.saveUser(user);

    // Return the successfully created and persisted user.
    return user;
  }

  /// Creates the initial [Account] for the newly registered user.
  ///
  /// This method coordinates the account creation process by:
  ///
  /// 1. Generating a new account ID.
  /// 2. Converting the initial balance from String to double.
  /// 3. Validating the converted balance.
  /// 4. Creating the [Account] entity.
  ///
  /// Keeping this logic in a separate method makes the main
  /// registration workflow easier to read and maintain.
  Account _getNewAccount({
    required String initialBalance,
    required DateTime createdAt,
  }) {
    // Generate a new unique account ID according to
    // the domain's account ID generation rules.
    final newIdAccount = AccountIdGenerator.generateAccountId();

    // Convert the initial balance from the raw String representation
    // into a numeric value.
    //
    // The conversion service is also responsible for validating
    // the provided balance according to the domain rules.
    final initialBalanceDouble = ConvertStringTodoubleBalance.convert(
      value: initialBalance,
      valueName: 'initial balance',
    );

    // Create the Account entity using the generated ID,
    // validated balance, and registration timestamp.
    final initialAccount = Account.create(
      id: newIdAccount,
      initialBalance: initialBalanceDouble,
      createdAt: createdAt,
    );

    return initialAccount;
  }

  /// Resolves the username that will be assigned to the new user.
  ///
  /// There are two possible scenarios:
  ///
  /// 1. A username was provided by the user.
  ///    The username is validated and checked for availability.
  ///
  /// 2. No username was provided.
  ///    A username is automatically generated using the user's
  ///    first name, with retry logic in case the generated username
  ///    is already taken.
  Future<UserName> _getNewUserName(String? userName, String firstName) async {
    // When the user provides a username, validate it and make sure
    // that no other user is already using it.
    if (userName != null) {
      return await _getValidatedUserName(userName);
    }

    // When no username is provided, generate one automatically
    // from the user's first name.
    return await _retryGenerateUseraNameLoop(firstName);
  }

  /// Generates an available username using [firstName].
  ///
  /// The method first generates a random username and checks whether
  /// it is already taken.
  ///
  /// If the generated username is taken, the method attempts to
  /// generate another username up to five additional times.
  ///
  /// Therefore, the total number of possible attempts is:
  ///
  /// ```text
  /// 1 initial attempt + 5 retry attempts = 6 attempts
  /// ```
  ///
  /// If all attempts produce usernames that are already taken,
  /// [TakenUserNameException] is thrown.
  Future<UserName> _retryGenerateUseraNameLoop(String firstName) async {
    // Generate the first candidate username using the user's
    // validated first name.
    final newUserName = UserNameGenerator.generate(name: firstName);

    // Check whether the generated username already exists.
    final isTaken = await _userRepository.isUsernameTaken(newUserName.value);

    // If the first generated username is available,
    // return it immediately without performing additional attempts.
    if (!isTaken) {
      return newUserName;
    }

    // The first generated username was already taken.
    //
    // Try generating another username up to five additional times.
    for (
      int loopIndex = 0;
      loopIndex < _maxUsernameGenerationAttempts;
      loopIndex++
    ) {
      // Generate another candidate username.
      final newUserNameInLoop = UserNameGenerator.generate(name: firstName);

      // Check whether the newly generated username is already taken.
      final isTaken = await _userRepository.isUsernameTaken(
        newUserNameInLoop.value,
      );

      // If the username is already taken, skip this candidate
      // and continue with the next generation attempt.
      if (isTaken) {
        continue;
      }

      // An available username has been found.
      return newUserNameInLoop;
    }

    // All allowed generation attempts have failed.
    //
    // The operation is stopped instead of continuing indefinitely.
    throw TakenUserNameException(message: 'Sorry, can u retry laiter.');
  }

  /// Validates a user-provided username and verifies its availability.
  ///
  /// The username is first checked against the repository to determine
  /// whether another user is already using it.
  ///
  /// If the username is available, it is converted into a validated
  /// [UserName] Value Object.
  ///
  /// If the username is already taken, [TakenUserNameException]
  /// is thrown.
  Future<UserName> _getValidatedUserName(String userName) async {
    // Check whether another user has already registered
    // using this username.
    final isTaken = await _userRepository.isUsernameTaken(userName);

    // The username is available, so validate it through the
    // UserName Value Object before returning it.
    if (!isTaken) {
      return UserName.create(value: userName);
    }

    // The requested username is already associated with another user.
    throw TakenUserNameException(message: 'This Username is already taken.');
  }
}
