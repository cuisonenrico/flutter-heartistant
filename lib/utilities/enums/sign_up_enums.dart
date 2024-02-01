import 'package:flutter_heartistant/utilities/string_constants.dart';

enum SignUpErrorCodes {
  FIRST_NAME(firstNameLabel),
  LAST_NAME(lastNameLabel),
  EMAIL(emailLabel),
  PASSWORD(passwordHint),
  CONFIRM_PASSWORD(confirmPasswordLabel),
  TERMS(terms);

  final String label;
  const SignUpErrorCodes(this.label);
}
