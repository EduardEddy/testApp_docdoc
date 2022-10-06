import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double? verticalPadding;
  final double fontSize;
  final Function() action;
  const ButtonWidget({
    super.key,
    required this.text,
    this.verticalPadding,
    this.fontSize = 14,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        padding: verticalPadding != null
            ? EdgeInsets.symmetric(vertical: verticalPadding!)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
