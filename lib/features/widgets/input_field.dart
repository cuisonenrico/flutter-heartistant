import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/styles/styles.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.onChangeText,
    this.hintText = 'Input Here',
    this.obscureText = false,
    this.icon = Icons.abc,
    super.key,
  });

  final String hintText;
  final bool obscureText;
  final IconData icon;
  final ValueChanged<String> onChangeText;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              prefixIcon: Icon(
                icon,
                color: mediumGrey,
                size: 25,
              ),
              fillColor: lightGrey,
              hintStyle: TextStyles.label2,
              hintText: hintText,
            ),
            onChanged: (text) => onChangeText(text),
          ),
          const VerticalSpace(defaultQuarterSpacing)
        ],
      ),
    );
  }
}
