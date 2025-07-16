import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
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
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: widget.textStyle ??
            MyTheme.getButtonStyle(
                color: MyTheme.textColor, fontSize: MyTheme.textFieldTextSize),
        decoration: InputDecoration(
          fillColor: widget.color,
          filled: widget.color == null ? false : true,
          hintText: widget.hintText,
          errorText: widget.errorText,
          errorStyle: MyTheme.getButtonStyle(
              color: Colors.red[400], fontSize: MyTheme.textSizeXXSmall),
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: widget.onSuffixTap,
                  child: Icon(widget.suffixIcon),
                )
              : widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
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
