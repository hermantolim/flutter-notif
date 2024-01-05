import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay {
  static void hide() {
    Get.back();
  }

  static void show({String? message}) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Row(children: [
          // Icon(Icons.signal_wifi_off_outlined),
          Text(message ?? 'loading...'),
        ]),
        content: const Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: true,
    );
  }
}
