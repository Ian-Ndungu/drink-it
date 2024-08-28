import 'package:flutter/material.dart';
import 'package:drinkit/utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final double height;
  final TextOverflow? overflow;

  const SmallText({
    super.key,
    this.color = AppColors.listColor,
    required this.text,
    this.size = 14.0,
    this.fontWeight,
    this.height = 1.2, 
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        height: height,
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        overflow: overflow,
      ),
    );
  }
}
