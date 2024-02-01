import 'package:flutter_heartistant/state/forms/sign_up_form_state.dart';
import 'package:flutter_heartistant/utilities/enums/sign_up_enums.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';

extension SignUpExt on SignUpFormState {
  String get fullName => (firstName ?? emptyString) + space + (lastName ?? emptyString);
}

extension SignUpErrors on SignUpErrorCodes {
  String? validate(List<SignUpErrorCodes> inputErrorList) {
    return inputErrorList.contains(this) ? errorMessage : null;
  }

  String get errorMessage {
    switch (this) {
      case SignUpErrorCodes.FIRST_NAME:
        return firstNameError;
      case SignUpErrorCodes.LAST_NAME:
        return lastNameError;
      case SignUpErrorCodes.EMAIL:
        return emailError;
      case SignUpErrorCodes.PASSWORD:
        return passwordError;
      case SignUpErrorCodes.CONFIRM_PASSWORD:
        return confirmPasswordError;
      case SignUpErrorCodes.TERMS:
        return termsError;
    }
  }
}
