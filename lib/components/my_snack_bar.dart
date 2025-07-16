import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onAction, closeAction;
  final String? actionLabel, closeLabel;

  const MySnackBar(
      {super.key,
      required this.title,
      required this.message,
      this.onAction,
      required this.actionLabel,
      this.closeAction,
      required this.closeLabel});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyTheme.thirdColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: MyTheme.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info,
              color: MyTheme.iconColor,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: title,
                    color: Colors.white,
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  MyText(
                    text: message,
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Visibility(
              visible: onAction != null && actionLabel != null,
              child: MyButton(
                height: 50,
                width: 80,
                text: actionLabel!,
                onPressed: onAction!,
              ),
            ),
            Visibility(
              visible: closeLabel != null && closeAction != null,
              child: MyButton(
                height: 50,
                width: 80,
                backgroundColor: Colors.transparent,
                text: closeLabel!,
                onPressed: closeAction!,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
