import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/user_model.dart';

class IsarDatabase {
  static Isar? _instance;

  static Future<Isar> init() async {
    if (_instance != null) {
      return _instance!;
    }

    final directory = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [UserModelSchema],
      name: 'Finora',
      directory: directory.path,
    );

    return _instance!;
  }

  static Isar get instance {
    if (_instance == null) {
      throw StateError('IsarDatabase has not been initialized.');
    }

    return _instance!;
  }
}
