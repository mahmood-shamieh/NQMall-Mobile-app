import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final EdgeInsetsGeometry? padding, margin;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  const MyText({
    super.key,
    this.color,
    this.fontWeight,
    this.size,
    required this.text,
    this.margin,
    this.padding,
    this.textAlign,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          text: text,
          style: MyTheme.getButtonStyle(
              color: color,
              fontSize: size,
              fontWeight: fontWeight,
              textDecoration: textDecoration),
        ),
      ),
    );
  }
}
