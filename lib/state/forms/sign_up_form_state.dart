import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_form_state.freezed.dart';
part 'sign_up_form_state.g.dart';

@freezed
class SignUpFormState with _$SignUpFormState {
  const factory SignUpFormState({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    @Default(false) bool agreeToTerms,
  }) = _SignUpFormState;

  factory SignUpFormState.fromJson(Map<String, dynamic> json) => _$SignUpFormStateFromJson(json);

  factory SignUpFormState.init() => const SignUpFormState();
}
