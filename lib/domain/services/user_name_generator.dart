import 'package:finora/domain/Extensions/random_item.dart';
import 'package:finora/domain/services/random_digits_generator.dart';
import 'package:finora/domain/validators/name_validator.dart';
import 'package:finora/domain/value_object/user_name.dart';

abstract final class UserNameGenerator {
  static const List<String> _symbols = ['@', '_', '-'];

  static UserName generate({required String name}) {
    NameValidator.validateOrThrow(
      name: name,
      nameType: "first name be used in generate username.",
    );

    final symbol = _symbols.randomItem();

    final number = RandomDigitsGenerator.generate();

    final userName = "$name$symbol$number";

    return UserName.create(value: userName);
  }
}
