import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_image_path_exception.dart';

/// Validates profile image paths according to the Domain rules.
///
/// [ImagePathValidator] is responsible for ensuring that a provided
/// image path:
///
/// - Is not empty.
/// - Contains a supported image file extension.
///
/// Currently supported image formats are:
///
/// - `.png`
/// - `.jpg`
/// - `.jpeg`
/// - `.webp`
///
/// This validator does not load, open, or verify the actual image file.
/// Its responsibility is limited to validating the image path string.
///
/// The validation flow is:
///
/// ```text
/// Raw Image Path
///       ↓
/// Trim Whitespace
///       ↓
/// Empty Check
///       ↓
/// Extension Check
///       ↓
/// Valid Image Path
/// ```
///
/// If validation fails, the appropriate Domain exception is thrown.
abstract final class ImagePathValidator {
  /// Validates an image path and returns its cleaned value.
  ///
  /// [imagePath] represents the raw path provided by the caller.
  ///
  /// The method first removes unnecessary whitespace from the beginning
  /// and end of the path.
  ///
  /// It then verifies that the path is not empty and ends with one
  /// of the supported image extensions.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] when the image path is empty.
  /// - [InvalidProfileImageException] when the image extension
  ///   is not supported.
  static String validateOrThrow(String imagePath) {
    // Remove unnecessary whitespace surrounding the image path.
    //
    // Example:
    //
    // "  /images/profile.png  "
    //
    // becomes:
    //
    // "/images/profile.png"
    final path = imagePath.trim();

    // Reject an empty image path.
    //
    // This prevents an invalid empty String from being represented
    // as a ProfileImage Value Object.
    if (path.isEmpty) {
      throw EmptyValueException("The image path is empty.");
    }

    // Define the image extensions supported by the Domain.
    //
    // Keeping the supported formats in one place makes the rule
    // explicit and easy to maintain.
    final validExtensions = ['.png', '.jpg', '.jpeg', '.webp'];

    // Check whether the image path ends with one of the supported
    // extensions.
    //
    // The path is converted to lowercase before checking so that
    // extensions are treated case-insensitively.
    //
    // Therefore:
    //
    // ".png"
    // ".PNG"
    // ".Png"
    //
    // are all considered valid.
    final hasValidExtension = validExtensions.any(
      (ext) => path.toLowerCase().endsWith(ext),
    );

    // Reject paths that do not contain a supported image extension.
    if (!hasValidExtension) {
      throw InvalidProfileImageException(
        "The image extension is not supported.",
      );
    }

    // Return the cleaned and validated image path.
    return path;
  }
}
