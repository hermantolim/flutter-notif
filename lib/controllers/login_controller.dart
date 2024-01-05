import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notif/controllers/fcm_controller.dart';
import 'package:notif/mixins/cache_mixin.dart';

import 'auth_controller.dart';

class LoginController extends AuthController {
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: '__loginFormKey__');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fcmController = Get.find<FcmController>();

  LoginController(super.authenticationService);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    log('validator');

    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  Future<void> login() async {
    final box = GetStorage();
    log('${emailController.text}, ${passwordController.text}');
    if (loginFormKey.currentState!.validate()) {
      try {
        await loginUser(emailController.text, passwordController.text);
        String? storedToken = box.read(CacheManagerKey.fcmToken.toString());
        print(
            "================================================================= storedToken $storedToken");
        if (storedToken != null) {
          await fcmController.storeToken(storedToken);
        }
        //_fcmController.storeToken();
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        passwordController.clear();
        rethrow;
      }
    } else {
      throw Exception('An error occurred, invalid inputs value');
    }
  }
}
