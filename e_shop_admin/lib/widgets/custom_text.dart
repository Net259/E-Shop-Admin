import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const CustomText(
      {super.key, required this.text, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontFamily: 'Merienda',
        color: color,
      ),
    );
  }
}
