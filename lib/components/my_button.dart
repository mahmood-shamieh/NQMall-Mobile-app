import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text; // Text on the button
  final VoidCallback onPressed; // Function to execute when button is pressed
  final Color backgroundColor; // Button background color
  final Color textColor; // Text color
  final double borderRadius; // Button corner radius
  final double height; // Button height
  final double width; // Button width
  final double fontSize; // Text font size
  final FontWeight? fontWeight;
  final EdgeInsets? padding, margin;
  final Widget? icon;

  // Constructor
  MyButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = MyTheme.buttonColor, // Default color
    this.textColor = MyTheme.whiteColor, // Default text color
    this.borderRadius = MyTheme.buttonsRadius, // Default border radius
    this.height = 60.0, // Default height
    this.width = double.infinity, // Full width by default
    this.fontSize = 16.0, // Default font size
    this.fontWeight,
    this.padding,
    this.margin,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? InkWell(
            onTap: onPressed,
            child: Container(
              width: width,
              height: height,
              padding: padding,
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
                color: backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: text,
                        style: MyTheme.getButtonStyle(
                            fontSize: fontSize,
                            fontWeight: fontWeight ?? FontWeight.bold,
                            color: textColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  icon!
                ],
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              color: backgroundColor,
            ),
            child: InkWell(
              onTap: onPressed,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: text,
                    style: MyTheme.getButtonStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight ?? FontWeight.bold,
                        color: textColor),
                  ),
                ),
              ),
            ),
          );
  }
}
