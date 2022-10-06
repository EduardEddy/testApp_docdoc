import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String? label;
  final TextInputType inputType;
  final void Function(String text) onChange;
  final String? Function(String? text) validator;
  final String? hintText;
  final String? value;
  final bool readOnly;
  final bool obscureText;
  final IconButton? iconRight;
  final Icon? iconLeft;
  final Key? keyInput;
  final String? prefixText;

  const InputWidget({
    Key? key,
    this.label,
    this.inputType = TextInputType.text,
    required this.onChange,
    required this.validator,
    this.hintText,
    this.value,
    this.readOnly = false,
    this.obscureText = false,
    this.iconRight,
    this.keyInput,
    this.prefixText,
    this.iconLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: keyInput,
      obscureText: obscureText,
      initialValue: value,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        suffixIcon: iconRight,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        prefixText: prefixText,
        prefixIcon: iconLeft,
      ),
      onChanged: onChange,
      validator: validator,
      readOnly: readOnly,
    );
  }
}
