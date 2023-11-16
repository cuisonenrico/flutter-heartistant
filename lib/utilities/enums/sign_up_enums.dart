import 'package:flutter_heartistant/utilities/string_constants.dart';

enum SignUpErrorCodes {
  FIRST_NAME(firstNameLabel),
  LAST_NAME(lastNameLabel),
  EMAIL(emailLabel),
  PASSWORD(passwordHint),
  CONFIRM_PASSWORD(confirmPasswordLabel);

  final String label;
  const SignUpErrorCodes(this.label);
}
