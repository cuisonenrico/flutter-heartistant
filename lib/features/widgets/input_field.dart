import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/colors.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.onChangeText,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.icon,
    this.padding,
    super.key,
  });

  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final IconData? icon;
  final EdgeInsets? padding;

  final ValueChanged<String> onChangeText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: errorText,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: mediumGrey,
                  size: 25,
                )
              : null,
          fillColor: lightGrey,
          hintStyle: TextStyles.label2,
          hintText: hintText ?? inputHereHint,
        ),
        onChanged: (text) => onChangeText(text),
      ),
    );
  }
}
