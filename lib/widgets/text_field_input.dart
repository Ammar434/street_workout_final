import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldInput extends StatefulWidget {
  TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPassword = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                color: primaryColor,
                onPressed: () {
                  setState(
                    () {
                      isObscure = !isObscure;
                    },
                  );
                },
              )
            : null,
      ),
      cursorColor: primaryColor,
      keyboardType: widget.textInputType,
      obscureText: isObscure && widget.isPassword,
    );
  }
}
