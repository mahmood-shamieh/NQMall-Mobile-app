import 'dart:io';

import 'package:app/models/app_config_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

class ValidateAppAvailability {
  static Future<Map<String, bool>> isAppAvailable(
      {required AppConfigModel appConfigModel}) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version; // e.g. "1.0.0"
      bool workingOrNot = false;
      if (kIsWeb) {
        workingOrNot = appConfigModel.App_Android_Version.toString().trim() ==
            version.trim();
      } else if (Platform.isAndroid) {
        workingOrNot = appConfigModel.App_Android_Version.toString().trim() ==
            version.trim();
      } else if (Platform.isIOS) {
        workingOrNot = appConfigModel.App_Android_Version.toString().trim() ==
            version.trim();
      }

      return {
        "AppEnabled": appConfigModel.AppEnabled ?? false,
        "WorkingOrNot": workingOrNot
      };
    } catch (e) {
      return {};
    }
  }
}
