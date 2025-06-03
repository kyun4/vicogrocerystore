import 'package:flutter/material.dart';

class TextFieldObscureCustom extends StatefulWidget {
  final bool isObscureText;
  final String hintText;
  final Icon iconSuffix;
  final Icon iconPrefix;
  final TextEditingController textController;

  const TextFieldObscureCustom({
    super.key,
    required this.isObscureText,
    required this.hintText,
    required this.iconPrefix,
    required this.iconSuffix,
    required this.textController,
  });

  @override
  State<TextFieldObscureCustom> createState() => _textFieldObscureCustomState();
}

class _textFieldObscureCustomState extends State<TextFieldObscureCustom> {
  bool toggleEye = true;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 7.5, left: 15, right: 15),

      child: TextField(
        obscureText: toggleEye,
        controller: widget.textController,

        decoration: InputDecoration(
          prefixIcon: widget.iconPrefix,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                toggleEye = !toggleEye;
              });
            },
            child:
                toggleEye == true
                    ? widget.iconSuffix
                    : Icon(Icons.visibility_off_outlined),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black38),
          contentPadding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 20,
            bottom: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.lightBlue, width: 1),
          ),
        ),
      ),
    );
  }
}
