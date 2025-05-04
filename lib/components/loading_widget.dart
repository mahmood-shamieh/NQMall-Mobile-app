import 'package:app/enums/loading_type.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final LoadingType? loadingType;
  const LoadingWidget({super.key, this.loadingType});

  @override
  Widget build(BuildContext context) {
    return loadingType == LoadingType.bar
        ? const SizedBox(
            width: 220,
            child: LinearProgressIndicator(
              backgroundColor: MyTheme.offWhiteColor,
              color: MyTheme.buttonColor,
            ),
          )
        : CircularProgressIndicator(
            color: MyTheme.buttonColor,
          );
  }
}
