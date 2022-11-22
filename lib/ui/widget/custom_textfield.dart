import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';

class CustomTexfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final int? maxLength;
  final String? hintText;
  const CustomTexfield({
    Key? key,
    this.validator,
    this.textInputType,
    this.textEditingController,
    this.maxLength,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      controller: textEditingController,
      keyboardType: textInputType,
      validator: validator,
      style: const TextStyle(
        fontSize: 17,
        color: AppColor.primaryPurpleColour,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.normal),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryPurpleColour)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryPurpleColour)),
      ),
    );
  }
}
