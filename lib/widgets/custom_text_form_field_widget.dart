import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    Key? key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.hasError = false,
    this.errorText,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;
  final int maxLines;
  final bool hasError;
  final String? errorText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: hasError ? errorText : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff03dac6),
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff03dac6),
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
