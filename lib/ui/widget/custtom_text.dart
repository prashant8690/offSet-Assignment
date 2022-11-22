import 'package:flutter/material.dart';

class CusttomText extends StatefulWidget {
  final String text;

  const CusttomText({Key? key, required this.text}) : super(key: key);

  @override
  State<CusttomText> createState() => _CusttomTextState();
}

class _CusttomTextState extends State<CusttomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}
