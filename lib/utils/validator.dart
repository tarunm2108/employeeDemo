import 'package:employee_demo/app_const/app_strings.dart';

class Validator {
  static final Validator _instance = Validator._internal();

  static Validator get instance => _instance;

  Validator._internal();

  String? validField(String? value) {
    return value == null || value.trim().isEmpty
        ? AppStrings.instance.fieldCanNotBeEmpty
        : null;
  }
}
