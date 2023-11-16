import 'package:flutter_heartistant/state/forms/sign_up_form_state.dart';
import 'package:flutter_heartistant/utilities/enums/sign_up_enums.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';

extension SignUpExt on SignUpFormState {
  String get fullName => (firstName ?? emptyString) + space + (lastName ?? emptyString);
}

extension SignUpErrors on SignUpErrorCodes {
  String? validate(List<String> inputErrorList) {
    return inputErrorList.contains(label) ? errorMessage : null;
  }

  String get errorMessage {
    switch (this) {
      case SignUpErrorCodes.FIRST_NAME:
        return 'Invalid first name';
      case SignUpErrorCodes.LAST_NAME:
        return 'Invalid last name';

      case SignUpErrorCodes.EMAIL:
        return 'Invalid email';

      case SignUpErrorCodes.PASSWORD:
        return 'Invalid password';

      case SignUpErrorCodes.CONFIRM_PASSWORD:
        return 'Does not match password';
    }
  }
}
