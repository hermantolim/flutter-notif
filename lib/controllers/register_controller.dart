import 'dart:developer';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class RegisterController extends AuthController {
  final GlobalKey<FormState> registerFormKey =
      GlobalKey<FormState>(debugLabel: '__registerFormKey__');
  final nameController = TextEditingController();
  final formNameFieldKey = GlobalKey<FormFieldState>();
  final emailController = TextEditingController();
  final formEmailFieldKey = GlobalKey<FormFieldState>();
  final passwordController = TextEditingController();
  final formPasswordFieldKey = GlobalKey<FormFieldState>();
  final confirmPasswordController = TextEditingController();
  final formConfirmPasswordFieldKey = GlobalKey<FormFieldState>();
  final kidsController = TextEditingController();
  final formKidsFieldKey = GlobalKey<FormFieldState>();
  final Rx<UserRole> roleValue = UserRole.student.obs;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode kidsFocusNode = FocusNode();

  RegisterController(
    super.authenticationService,
  );

  @override
  void onInit() {
    _addListener();
    // textFieldFocusNode.hasFocus = false;
    super.onInit();
  }

  void _addListener() {
    nameFocusNode.addListener(() {
      log('nameFocusNode-----${nameFocusNode.hasFocus}');
      if (!nameFocusNode.hasFocus) {
        formNameFieldKey.currentState!.validate();
      }
    });

    emailFocusNode.addListener(() {
      log('emailFocusNode-----${emailFocusNode.hasFocus}');
      if (!emailFocusNode.hasFocus) {
        formEmailFieldKey.currentState!.validate();
      }
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        formPasswordFieldKey.currentState!.validate();
      }
    });
    confirmPasswordFocusNode.addListener(() {
      if (!confirmPasswordFocusNode.hasFocus) {
        formConfirmPasswordFieldKey.currentState!.validate();
      }
    });
    kidsFocusNode.addListener(() {
      if (!kidsFocusNode.hasFocus) {
        formKidsFieldKey.currentState!.validate();
      }
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    nameFocusNode.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordController.dispose();
    confirmPasswordFocusNode.dispose();
    kidsController.dispose();
    kidsFocusNode.dispose();
    super.onClose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    // Check if the entered email has the right format
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the entered email is valid
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length < 3) {
      return 'Password must be at least 8 characters in length';
    }
    // Return null if the entered password is valid
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    log('$value--${passwordController.value.text}');
    if (value != passwordController.value.text) {
      return 'Confirmation password does not match the entered password';
    }

    return null;
  }

  String? validator(String? value) {
    log('validator');

    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  Future<void> register() async {
    // log('${emailController.text}, ${passwordController.text}');
    if (registerFormKey.currentState!.validate()) {
      try {
        final body = RegisterUserBody(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          confirmPassword: confirmPasswordController.text.trim(),
          role: roleValue.value,
          students: kidsController.text
              .split(",")
              .map((e) => e.trim())
              .toList(growable: false),
        );
        print("========================= REGISTER BODY $body");
        await registerUser(body);

        await loginUser(emailController.text, passwordController.text);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +
        //passwordController.clear();
        //confirmPasswordController.clear();
        rethrow;
      }
    } else {
      throw Exception('An error occurred, invalid inputs value');
    }
  }
}
