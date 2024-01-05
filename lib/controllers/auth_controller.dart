import 'dart:convert';
import 'dart:developer';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notif/mixins/cache_mixin.dart';
import 'package:notif/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthApiService _authenticationService;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  AuthController(this._authenticationService);

  void toggleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void logOut() {
    removeAuth();
  }

  Future<void> loginUser(String email, String password) async {
    final response = await _authenticationService.login(email, password);

    log('LOGIN USER ======================================================================================>');
    inspect(response);

    if (response != null) {
      await saveAuth(response);
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Login Error!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> registerUser(String email, String password,
      String confirmPassword, String name) async {
    final response = await _authenticationService.register(
      email,
      password,
      confirmPassword,
      name,
    );

    if (response == null) {
      Get.defaultDialog(
          middleText: 'Register Error!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<bool> saveAuth(AuthResponse? authResponse) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.token.toString(), authResponse?.token);
    await box.write(
        CacheManagerKey.profile.toString(), jsonEncode(authResponse?.user));
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.token.toString());
  }

  User? getProfile() {
    final box = GetStorage();
    final profileStr = box.read(CacheManagerKey.profile.toString());
    return User.fromJson(jsonDecode(profileStr));
  }

  Future<void> removeAuth() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.token.toString());
    await box.remove(CacheManagerKey.profile.toString());
  }
}
