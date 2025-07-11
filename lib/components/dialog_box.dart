import 'package:app/components/my_text.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Widget? body;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final TextAlign? titleAlignment;
  final TextAlign? messageAlignment;

  const DialogBox({
    required this.title,
    this.icon,
    required this.message,
    this.onConfirm,
    this.onCancel,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.titleAlignment,
    this.messageAlignment,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                const Icon(Icons.warning_amber_rounded,
                    size: 60, color: MyTheme.buttonColor),
            const SizedBox(height: 16),
            MyText(
              text: title,
              fontWeight: FontWeight.bold,
              color: MyTheme.mainColor,
              size: MyTheme.textSizeXLarge,
              textAlign: titleAlignment,
            ),
            const SizedBox(height: 12),
            MyText(
              text: message,
              textAlign: TextAlign.center,
              color: MyTheme.textColor,
            ),
            const SizedBox(height: 24),
            body ?? Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.back(); // Close dialog
                    if (onCancel != null) onCancel!();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyTheme.offWhiteColor,
                        borderRadius:
                            BorderRadius.circular(MyTheme.buttonsRadius)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 8,
                    ),
                    child: Text(
                      cancelText,
                      style: MyTheme.getButtonStyle(
                        color: MyTheme.secondaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: onConfirm != null,
                  child: InkWell(
                    onTap: () {
                      Get.back(); // Close dialog
                      if (onConfirm != null) onConfirm!();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MyTheme.buttonsRadius),
                        color: MyTheme.mainColor,
                      ),
                      child: Text(
                        confirmText,
                        style: MyTheme.getButtonStyle(
                          color: MyTheme.offWhiteColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
