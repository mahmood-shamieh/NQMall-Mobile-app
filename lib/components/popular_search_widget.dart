import 'package:app/components/my_text.dart';
import 'package:app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopularSearchWidget extends StatelessWidget {
  final String? text;
  const PopularSearchWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: MyTheme.borderColor),
        borderRadius: BorderRadius.circular(MyTheme.buttonsRadius),
      ),
      child: FittedBox(
        child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.history,
              size: 16,
            ),
            const SizedBox(
              width: 8,
            ),
            MyText(
              text: text ?? '',
              size: MyTheme.textSizeXSmall,
              color: MyTheme.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
