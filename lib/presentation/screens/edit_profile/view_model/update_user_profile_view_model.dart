import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_birthdate_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/exception/user/not_valid_identical_user_id.dart';
import 'package:finora/domain/exception/user/taken_user_name_exception.dart';
import 'package:finora/domain/usecases/user/update_user_usecase.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// ViewModel responsible for managing the user-profile editing screen.
///
/// This class belongs to the Presentation layer and acts as the bridge
/// between the UI and the Domain [UpdateUserUseCase].
///
/// Its responsibilities are focused on presentation/state management:
///
/// - Load the currently authenticated user's data.
/// - Populate form controllers with existing user information.
/// - Hold the current form state reactively.
/// - Handle profile-image selection/removal.
/// - Collect raw values entered by the user.
/// - Send the collected data to [UpdateUserUseCase].
/// - Convert Domain exceptions into UI-friendly error messages.
/// - Update the global authenticated-user state after a successful update.
/// - Control loading state while the update operation is running.
///
/// Important architectural rule:
///
/// This ViewModel does NOT perform the actual business validation.
/// Validation belongs to the Domain layer and is executed by
/// [UpdateUserUseCase] through Value Objects and Validators.
///
/// In other words:
///
/// UI
///   ↓
/// ViewModel
///   ↓
/// UpdateUserUseCase
///   ↓
/// Domain Value Objects / Business Rules
///   ↓
/// Repository
class UpdateUserInfoViewModel extends GetxController {
  /// Domain use case responsible for executing the actual user update.
  ///
  /// Dependency Injection provides this use case to the ViewModel.
  final UpdateUserUseCase updateUserUseCase;

  UpdateUserInfoViewModel({required this.updateUserUseCase});

  /// Snapshot of the authenticated user when the screen is initialized.
  ///
  /// This entity represents the original state that the user is editing.
  late final User currentUser;

  // ============================================================
  // FORM CONTROLLERS
  // ============================================================

  /// Controller for the first-name input field.
  late final TextEditingController firstNameController;

  /// Controller for the middle-name input field.
  late final TextEditingController middleNameController;

  /// Controller for the last-name input field.
  late final TextEditingController lastNameController;

  /// Controller for the username input field.
  late final TextEditingController userNameController;

  /// Reactive birthday-date selected by the user.
  ///
  /// Rxn means the value can be null.
  final birthDate = Rxn<DateTime>();

  /// Currently selected profile-image path.
  ///
  /// null means that no profile image is currently selected.
  final selectedImagePath = RxnString();

  // ============================================================
  // REACTIVE ERROR STATES
  // ============================================================
  //
  // Each field has its own reactive error state.
  //
  // The UI can listen to these values using Obx and display the
  // corresponding validation message beside the affected field.

  var firstNameError = RxnString();
  var middleNameError = RxnString();
  var lastNameError = RxnString();
  var birthDateError = RxnString();
  var userNameError = RxnString();

  // ============================================================
  // UI STATE
  // ============================================================

  /// Indicates that the update operation is currently running.
  ///
  /// The UI can use this state to:
  /// - show a loading indicator,
  /// - disable the save button,
  /// - prevent duplicate submissions.
  var isLoading = false.obs;

  /// Indicates whether the user has explicitly changed the profile image.
  ///
  /// This is important because:
  ///
  /// false → keep the existing image untouched.
  ///
  /// true + path → replace the existing image.
  ///
  /// true + null → remove the existing image.
  var isImageChanged = false.obs;

  // ============================================================
  // INITIALIZATION
  // ============================================================

  /// Called automatically by GetX when the ViewModel is initialized.
  ///
  /// The current authenticated user's data is loaded here so that
  /// the editing form starts with the user's existing information.
  @override
  void onInit() {
    super.onInit();

    _loadCurrentUserData();
  }

  /// Loads the currently authenticated user from [AuthUserController]
  /// and initializes the form with the existing values.
  ///
  /// This method keeps the ViewModel independent from the actual UI.
  /// The UI simply observes the controllers and reactive states.
  void _loadCurrentUserData() {
    // Retrieve the currently authenticated user from the global
    // authentication state.
    final user = AuthUserController.to.currentUser;

    // There is no user to edit.
    if (user == null) return;

    // Store the original user entity.
    currentUser = user;

    // Populate the first-name field.
    firstNameController = TextEditingController(
      text: currentUser.firstName.value,
    );

    // Optional middle name.
    // If it does not exist, display an empty field.
    middleNameController = TextEditingController(
      text: currentUser.middleName?.value ?? '',
    );

    // Optional last name.
    lastNameController = TextEditingController(
      text: currentUser.lastName?.value ?? '',
    );

    // Populate the username field.
    userNameController = TextEditingController(
      text: currentUser.userName.value,
    );

    // Initialize the birthday state.
    birthDate.value = currentUser.birthdayDate.value;

    // Initialize the current profile image.
    selectedImagePath.value = currentUser.profileImage?.path;
  }

  // ============================================================
  // FORM STATE MANAGEMENT
  // ============================================================

  /// Updates the selected birthday date.
  ///
  /// The UI calls this method after the user selects a date
  /// from a date picker.
  void setBirthDate(DateTime date) {
    birthDate.value = date;
  }

  // ============================================================
  // PROFILE IMAGE MANAGEMENT
  // ============================================================

  /// Opens the device gallery and allows the user to select
  /// a new profile image.
  ///
  /// This method only changes the ViewModel state.
  /// The actual persistence of the image path is handled later
  /// when [submitUpdate] is executed.
  Future<void> pickNewProfileImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    // User cancelled the image picker.
    if (image != null) {
      // Store the newly selected image path.
      selectedImagePath.value = image.path;

      // Mark the image as explicitly changed.
      isImageChanged.value = true;
    }
  }

  /// Removes the current profile image from the user's profile.
  ///
  /// Setting the path to null does not immediately update the database.
  /// It only changes the pending form state.
  ///
  /// The actual update occurs when [submitUpdate] is called.
  void removeProfileImage() {
    selectedImagePath.value = null;

    // true is important here because null now means:
    // "The user explicitly wants to remove the image."
    isImageChanged.value = true;
  }

  // ============================================================
  // SUBMIT UPDATE
  // ============================================================

  /// Collects the current form values and sends them to
  /// [UpdateUserUseCase].
  ///
  /// This is the main entry point used by the Save button.
  ///
  /// Flow:
  ///
  /// 1. Clear previous errors.
  /// 2. Enable loading state.
  /// 3. Convert empty optional fields into null.
  /// 4. Determine whether the image should be changed.
  /// 5. Call the Domain Use Case.
  /// 6. Update the global authenticated-user state.
  /// 7. Return to the previous screen.
  /// 8. Handle Domain exceptions.
  /// 9. Disable loading state.
  Future<void> submitUpdate() async {
    // Remove errors from the previous submission.
    _resetErrors();

    // Tell the UI that the update operation has started.
    isLoading.value = true;

    try {
      // ========================================================
      // OPTIONAL MIDDLE NAME
      // ========================================================
      //
      // An empty text field means that the user wants to remove
      // the middle name.
      final rawMiddleName = middleNameController.text.trim().isEmpty
          ? null
          : middleNameController.text;

      // ========================================================
      // OPTIONAL LAST NAME
      // ========================================================

      final rawLastName = lastNameController.text.trim().isEmpty
          ? null
          : lastNameController.text;

      // ========================================================
      // PROFILE IMAGE UPDATE INTENT
      // ========================================================
      //
      // Sentinel means:
      //
      // "The user did not modify the image, so keep the old image."
      Object? rawProfileImagePath = User.sentinel;

      if (isImageChanged.value) {
        // If the user selected a new image:
        //     path != null
        //
        // If the user removed the image:
        //     path == null
        //
        // Both cases mean that the image was explicitly modified.
        rawProfileImagePath = selectedImagePath.value;
      }

      // ========================================================
      // CALL THE DOMAIN USE CASE
      // ========================================================
      //
      // From this point onward, the ViewModel delegates the actual
      // business operation to the Domain.
      final updatedUser = await updateUserUseCase.execute(
        currentUser: currentUser,
        rawFirstName: firstNameController.text,
        rawMiddleName: rawMiddleName,
        rawLastName: rawLastName,
        rawUserName: userNameController.text,
        rawBirthdayDate: birthDate.value,
        rawProfileImagePath: rawProfileImagePath,
      );

      // ========================================================
      // UPDATE GLOBAL AUTHENTICATION STATE
      // ========================================================
      //
      // The user object stored globally must be replaced with the
      // newly updated entity so the rest of the application sees
      // the latest user information.
      AuthUserController.to.setUser(updatedUser);

      // Return to the previous screen after successful update.
      Get.back();
    }
    // ============================================================
    // DOMAIN EXCEPTION HANDLING
    // ============================================================
    //
    // Domain exceptions are translated into reactive UI errors.
    //
    // The ViewModel knows where an error should be displayed,
    // while the Domain only knows that a business rule was violated.
    on Exception catch (e) {
      _handleErrors(e);
    }
    // ============================================================
    // CLEANUP LOADING STATE
    // ============================================================
    finally {
      // Always stop the loading indicator whether the operation
      // succeeds or fails.
      isLoading.value = false;
    }
  }

  // ============================================================
  // ERROR MANAGEMENT
  // ============================================================

  /// Clears all currently displayed validation errors.
  ///
  /// This ensures that old errors do not remain visible after
  /// a new submission attempt.
  void _resetErrors() {
    firstNameError.value = null;
    middleNameError.value = null;
    lastNameError.value = null;
    birthDateError.value = null;
    userNameError.value = null;
  }

  /// Converts Domain exceptions into field-specific UI errors.
  ///
  /// The Domain throws meaningful exceptions, while this Presentation
  /// layer decides where those messages should appear.
  ///
  /// Example:
  ///
  /// TakenUserNameException
  ///        ↓
  /// userNameError
  ///
  /// InvalidBirthdateException
  ///        ↓
  /// birthDateError
  void _handleErrors(Exception e) {
    final message = e.toString();

    // Username already exists.
    if (e is TakenUserNameException) {
      userNameError.value = message;

      // Birthday violates Domain rules.
    } else if (e is InvalidBirthdateException) {
      birthDateError.value = message;

      // Generic value/format validation errors.
    } else if (e is EmptyValueException || e is InvalidFormatException) {
      // Determine which field generated the exception.
      //
      // The validator includes the field name inside the exception
      // message, allowing the ViewModel to route the message to
      // the correct UI field.
      if (message.contains("first name")) {
        firstNameError.value = message;
      } else if (message.contains("middle name")) {
        middleNameError.value = message;
      } else if (message.contains("last name")) {
        lastNameError.value = message;
      } else if (message.contains("username")) {
        userNameError.value = message;
      }
    } else if (e is NotValidIdenticalUserId) {
      userNameError.value = message;
    }
  }

  // ============================================================
  // LIFECYCLE
  // ============================================================

  /// Releases all TextEditingController resources when the
  /// ViewModel is removed from memory.
  ///
  /// TextEditingController owns resources/listeners, so it must
  /// be disposed to avoid memory leaks.
  @override
  void onClose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();

    super.onClose();
  }
}
