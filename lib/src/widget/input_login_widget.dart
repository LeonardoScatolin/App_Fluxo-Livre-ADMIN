import 'package:flutter/material.dart';

class InputLoginWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? iconColor;
  
  const InputLoginWidget({
    required this.icon,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.type = TextInputType.text,
    this.validator,
    this.textStyle,
    this.hintStyle,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon, color: iconColor ?? const Color(0xFFFFFFFF)),
        hintText: hint,
        hintStyle: hintStyle ?? const TextStyle(color: Color(0xFFFFFFFF)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: iconColor ?? const Color(0xFFFFFFFF)),
        ),
      ),
      style: textStyle ?? const TextStyle(color: Color(0xFFFFFFFF)),
      obscureText: obscure,
      keyboardType: type,
      validator: validator,
    );
  }
}
