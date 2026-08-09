import 'package:finora/domain/validators/image_path_validator.dart';

class ProfileImage {
  final String? path;
  const ProfileImage._({required this.path});
  factory ProfileImage.create({required String? imagePath}) {
    if (imagePath != null) {
      final trimmedImagePath = ImagePathValidator.validateOrThrow(imagePath);
      return ProfileImage._(path: trimmedImagePath);
    } else {
      return ProfileImage._(path: null);
    }
  }
  @override
  String toString() => path ?? "";
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProfileImage && other.path == path);
  }

  @override
  int get hashCode => path.hashCode;
}
