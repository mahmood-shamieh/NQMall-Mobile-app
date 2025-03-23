import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final EdgeInsetsGeometry? padding, margin;
  const MyText({
    super.key,
    this.color,
    this.fontWeight,
    this.size,
    required this.text,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: RichText(
        text: TextSpan(
          text: text,
          style: MyTheme.getButtonStyle(
              color: color, fontSize: size, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
