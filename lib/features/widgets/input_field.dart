import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.onChangeText,
    this.hintText = 'Input Here',
    this.obscureText = false,
    super.key,
  });

  final String hintText;
  final bool obscureText;
  final ValueChanged<String> onChangeText;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, // Shadow color
            offset: Offset(0, 4), // Shadow offset (x, y)
            blurRadius: 4, // Blur radius
            spreadRadius: 2, // Spread radius
          ),
        ],
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
            onChanged: (text) => onChangeText(text),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                controller.clear();
                onChangeText('');
              },
              child: Icon(
                Icons.close,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
