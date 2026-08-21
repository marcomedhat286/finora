import 'package:uuid/uuid.dart';

abstract class IdentityGenerator {
  static final Uuid _uuid = const Uuid();

  static String generateUuid() => _uuid.v4();
}
