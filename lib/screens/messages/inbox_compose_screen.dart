import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/inbox_compose_controller.dart';
import 'package:notif/widgets/loading_overlay.dart';

class InboxComposeScreen extends GetView<InboxComposeController> {
  const InboxComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        title: const Text(
          'Compose',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancel',
            onPressed: () {
              //Get.find<AuthController>().logOut();
              Get.offAllNamed(Routes.inbox);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: controller.formReceiverFieldKey,
                controller: controller.receiverController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(),
                  label: Text('To'),
                  helperText: "email separated by comma",
                ),
                focusNode: controller.receiverFocusNode,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                key: controller.formSubjectFieldKey,
                controller: controller.subjectController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(),
                  label: Text('Subject'),
                ),
                focusNode: controller.subjectFocusNode,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                key: controller.formBodyFieldKey,
                controller: controller.bodyController,
                maxLines: 20,
                minLines: 4,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(),
                  label: Text('Content'),
                ),
                focusNode: controller.bodyFocusNode,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      LoadingOverlay.show(message: 'Registering...');
                      try {
                        await controller.send();

                        controller.formKey.currentState!.save();
                        log('message sent');

                        Get.offAllNamed(Routes.inbox);
                      } catch (err, _) {
                        printError(info: err.toString());
                        LoadingOverlay.hide();
                        Get.snackbar(
                          "Error",
                          err.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(1),
                          colorText: Colors.white,
                          icon: const Icon(Icons.error, color: Colors.white),
                          shouldIconPulse: true,
                          barBlur: 20,
                        );
                      } finally {}
                    }
                  },
                  child: const Text('Send'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
