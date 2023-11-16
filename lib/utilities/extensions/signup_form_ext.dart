import 'package:flutter_heartistant/state/forms/sign_up_form_state.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';

extension SignUpExt on SignUpFormState {
  String get fullName => (firstName ?? emptyString) + space + (lastName ?? emptyString);
}
