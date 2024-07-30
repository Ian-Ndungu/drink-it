import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final TextOverflow overflow;

  const BigText({
    super.key,
    this.color = const Color(0xFF090305),
    required this.text,
    this.size = 20,
    this.fontWeight,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold, 
      ),
    );
  }
}
