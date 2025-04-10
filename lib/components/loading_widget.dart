import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 220,
      child: LinearProgressIndicator(
        backgroundColor: MyTheme.offWhiteColor,
        color: MyTheme.buttonColor,
      ),
    );
  }
}
