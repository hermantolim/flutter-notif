import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/services/inbox_compose_api_service.dart';

class InboxComposeController extends GetxController {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '__inboxComposeFormKey__');
  final subjectController = TextEditingController();
  final formSubjectFieldKey = GlobalKey<FormFieldState>();
  final bodyController = TextEditingController();
  final formBodyFieldKey = GlobalKey<FormFieldState>();
  final receiverController = TextEditingController();
  final formReceiverFieldKey = GlobalKey<FormFieldState>();

  FocusNode subjectFocusNode = FocusNode();
  FocusNode bodyFocusNode = FocusNode();
  FocusNode receiverFocusNode = FocusNode();

  final InboxComposeApiService _inboxComposeApiService;

  InboxComposeController(this._inboxComposeApiService);

  @override
  void onInit() {
    _addListener();
    // textFieldFocusNode.hasFocus = false;
    super.onInit();
  }

  void _addListener() {
    subjectFocusNode.addListener(() {
      log('subjectFocusNode-----${subjectFocusNode.hasFocus}');
      if (!subjectFocusNode.hasFocus) {
        formSubjectFieldKey.currentState!.validate();
      }
    });

    bodyFocusNode.addListener(() {
      log('bodyFocusNode-----${bodyFocusNode.hasFocus}');
      if (!bodyFocusNode.hasFocus) {
        formBodyFieldKey.currentState!.validate();
      }
    });

    receiverFocusNode.addListener(() {
      log('receiverFocusNode-----${receiverFocusNode.hasFocus}');
      if (!receiverFocusNode.hasFocus) {
        formReceiverFieldKey.currentState!.validate();
      }
    });
  }

  @override
  void onClose() {
    subjectController.dispose();
    subjectFocusNode.dispose();
    bodyController.dispose();
    bodyFocusNode.dispose();
    receiverController.dispose();
    receiverFocusNode.dispose();
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

  String? validator(String? value) {
    log('validator');

    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  Future<void> send() async {
    final receivers =
        receiverController.text.split(",").map((r) => r.trim()).toList();

    final response = await _inboxComposeApiService.send(
        subjectController.text, bodyController.text, receivers);

    print(
        'send message ========================================================================== $response');
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
}
