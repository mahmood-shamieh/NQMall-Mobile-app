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
  TextStyle? textStyle; // Text font size

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
    this.textStyle, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: RichText(
            text: TextSpan(
                text: text, style: textStyle ?? MyTheme.getButtonStyle())),
      ),
    );
  }
}
