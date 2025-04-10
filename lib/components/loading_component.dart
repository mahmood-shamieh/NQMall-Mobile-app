import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_text.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoadingComponent extends StatelessWidget {
  final Widget body;
  final bool loading;
  const LoadingComponent(
      {super.key, required this.body, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        Visibility(
          visible: loading,
          child: Container(
            color: MyTheme.shadowColor.withOpacity(
              0.8,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: 'loading'.tr,
                    fontWeight: FontWeight.bold,
                    size: MyTheme.textSizeXLarge,
                    color: MyTheme.textColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LoadingWidget(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
