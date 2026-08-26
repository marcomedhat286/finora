import 'package:finora/domain/validators/user/image_path_validator.dart';

/// Represents a validated profile image within the Domain.
///
/// [ProfileImage] is a Value Object responsible for representing
/// the path of a user's profile image.
///
/// Instead of allowing a raw [String] to be used as a profile image
/// throughout the Domain:
///
/// ```dart
/// String imagePath;
/// ```
///
/// the Domain uses:
///
/// ```dart
/// ProfileImage image;
/// ```
///
/// This ensures that every [ProfileImage] instance is created only
/// after its path has passed the rules defined by [ImagePathValidator].
///
/// [ProfileImage] does not load, upload, delete, or manipulate the
/// actual image file. Its responsibility is only to represent a
/// valid image path.
///
/// Creation flow:
///
/// ```text
/// Raw Image Path
///       ↓
/// ProfileImage.create()
///       ↓
/// ImagePathValidator
///       ↓
/// Validated Path
///       ↓
/// ProfileImage
/// ```
///
/// Since this is a Value Object, two [ProfileImage] instances are
/// considered equal when they contain the same path.
class ProfileImage {
  /// Stores the validated image path.
  ///
  /// The field is final, making [ProfileImage] immutable after creation.
  final String path;

  /// Private constructor used after successful validation.
  ///
  /// Keeping the constructor private ensures that callers cannot
  /// create a [ProfileImage] without going through [ProfileImage.create].
  const ProfileImage._({required this.path});

  /// Creates a validated [ProfileImage] from a raw image path.
  ///
  /// The provided [imagePath] is passed to [ImagePathValidator],
  /// which applies the Domain rules for valid image paths.
  ///
  /// If the path is invalid, the validator throws the appropriate
  /// Domain exception and the [ProfileImage] is not created.
  factory ProfileImage.create({required String imagePath}) {
    // Validate and normalize the raw image path before allowing
    // it to enter the Domain.
    final trimmedImagePath = ImagePathValidator.validateOrThrow(imagePath);

    // Create the Value Object only after successful validation.
    return ProfileImage._(path: trimmedImagePath);
  }

  /// Returns the image path as a String.
  ///
  /// Useful when the path needs to be displayed, serialized,
  /// persisted, or passed to another layer.
  @override
  String toString() => path;

  /// Determines whether two [ProfileImage] objects represent
  /// the same image path.
  ///
  /// Value Objects use value-based equality, meaning that two
  /// different objects containing the same path are considered equal.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProfileImage && other.path == path);
  }

  /// Generates a hash code based on the image path.
  ///
  /// This keeps [hashCode] consistent with the custom equality
  /// implementation.
  @override
  int get hashCode => path.hashCode;
}
