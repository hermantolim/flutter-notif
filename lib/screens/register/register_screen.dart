import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/register_controller.dart';
import 'package:notif/widgets/loading_overlay.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACCOUNT REGISTRATION'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: controller.formEmailFieldKey,
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                    label: Text('Email'),
                  ),
                  focusNode: controller.emailFocusNode,
                  validator: controller.emailValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => TextFormField(
                    key: controller.formPasswordFieldKey,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        onPressed: controller.toggleShowPassword,
                        icon: Icon(
                          controller.showPassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      label: const Text('Password'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: controller.passwordValidator,
                    obscureText: controller.showPassword.value,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => TextFormField(
                    key: controller.formConfirmPasswordFieldKey,
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        onPressed: controller.toggleShowConfirmPassword,
                        icon: Icon(
                          controller.showConfirmPassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      label: const Text('Confirm Password'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: controller.confirmPasswordValidator,
                    obscureText: controller.showConfirmPassword.value,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.registerFormKey.currentState!.validate()) {
                        LoadingOverlay.show(message: 'Registering...');
                        try {
                          await controller.register();

                          controller.registerFormKey.currentState!.save();
                          log('response signup');

                          Get.offAllNamed(Routes.home);
                        } catch (err, _) {
                          printError(info: err.toString());
                          LoadingOverlay.hide();
                          Get.snackbar(
                            "Error",
                            err.toString(),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.withOpacity(.75),
                            colorText: Colors.white,
                            icon: const Icon(Icons.error, color: Colors.white),
                            shouldIconPulse: true,
                            barBlur: 20,
                          );
                        } finally {}
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.login);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
