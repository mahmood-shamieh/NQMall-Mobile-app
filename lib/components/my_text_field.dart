import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Color? color;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final Function(String)? onChanged;

  const MyTextField({
    super.key,
    this.errorText,
    this.color,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.onChanged,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 85,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        style: textStyle ??
            MyTheme.getButtonStyle(
                color: MyTheme.textColor, fontSize: MyTheme.textFieldTextSize),
        decoration: InputDecoration(
          fillColor: color,
          filled: color == null ? false : true,
          hintText: hintText,
          errorText: errorText,
          errorStyle: MyTheme.getButtonStyle(
              color: Colors.red[400], fontSize: MyTheme.textSizeXXSmall),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyTheme.borderColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyTheme.borderColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: MyTheme.buttonColor, width: 2),
          ),
        ),
      ),
    );
  }
}
