import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_image_path_exception.dart';

abstract final class ImagePathValidator {
  static String validateOrThrow(String imagePath) {
    final path = imagePath.trim();
    if (path.isEmpty) {
      throw EmptyValueException("The image path is empty.");
    }
    final validExtensions = ['.png', '.jpg', '.jpeg', '.webp'];
    final hasValidExtension = validExtensions.any(
      (ext) => path.toLowerCase().endsWith(ext),
    );

    if (!hasValidExtension) {
      throw InvalidProfileImageException(
        "The image extention is not supported.",
      );
    }
    return path;
  }
}
