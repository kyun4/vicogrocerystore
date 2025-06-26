import 'package:flutter/material.dart';

class TextFieldCashIn extends StatefulWidget {
  final TextEditingController textController;
  final String hintTextLabel;
  const TextFieldCashIn({
    super.key,
    required this.textController,
    required this.hintTextLabel,
  });

  State<TextFieldCashIn> createState() => _textFieldCashInState();
}

class _textFieldCashInState extends State<TextFieldCashIn> {
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      controller: widget.textController,
      style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: widget.hintTextLabel,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.3),
          fontSize: 56,
          fontWeight: FontWeight.bold,
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
