import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';
import 'package:tcp_workers/app/views/signIn/Login_page.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashCtrl extends GetxController {
  String dialogTitle = "";
  String dialogText = "";
  String dismissText = "";
  String dismissAction = "";
  String updateText = "";
  final box = GetStorage();
  NewVersion newVersion = NewVersion(
    context: Get.context,
    iOSId: 'com.google.Vespa',
    androidId: 'com.google.android.apps.cloudconsole',
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    final status = await newVersion.getVersionStatus();
    print(status.canUpdate);
    if (status.canUpdate) {
      showUpdateDialog(status);
    } else {
      verifyIsLogin();
    }
  }

  void verifyIsLogin() async {
    if (box.hasData('userData')) {
      Timer(Duration(seconds: 3),
          () => Get.off(() => HomePage(), transition: Transition.zoom));
    } else {
      await box.erase();
      Timer(Duration(seconds: 3),
          () => Get.off(() => SignInPage(), transition: Transition.zoom));
    }
  }

  void showUpdateDialog(VersionStatus versionStatus) async {
    final title = Text("Update");
    final content = Text(
      'You can now update this app from ${versionStatus.localVersion} to ${versionStatus.storeVersion}, data of test.',
    );
    final dismissText = Text("dismiss");
    final dismissAction = () {
      Get.back();
      verifyIsLogin();
    };
    final updateText = Text("Update");
    final updateAction = () {
      _launchAppStore(versionStatus.appStoreLink);
      Navigator.of(Get.context, rootNavigator: true).pop();
      verifyIsLogin();
    };
    final platform = Theme.of(Get.context).platform;
    showDialog(
      context: Get.context,
      builder: (BuildContext context) {
        return platform == TargetPlatform.android
            ? AlertDialog(
                title: title,
                content: content,
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: dismissText,
                    onPressed: dismissAction,
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: updateText,
                    onPressed: updateAction,
                  ),
                ],
              )
            : CupertinoAlertDialog(
                title: title,
                content: content,
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: dismissText,
                    onPressed: dismissAction,
                  ),
                  CupertinoDialogAction(
                    child: updateText,
                    onPressed: updateAction,
                  ),
                ],
              );
      },
    );
  }

  void _launchAppStore(String appStoreLink) async {
    if (await canLaunch(appStoreLink)) {
      await launch(appStoreLink);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}
