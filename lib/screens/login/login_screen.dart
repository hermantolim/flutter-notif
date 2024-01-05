import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/login_controller.dart';
import 'package:notif/widgets/loading_overlay.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  void checkHeaderMessages(duration) {
    if (Get.arguments != null &&
        Get.arguments.containsKey('message') &&
        Get.arguments['message'].containsKey('status_text') &&
        Get.arguments['message']['status_text'] == 'session_expired') {
      var message = Get.arguments['message']['body'];
      Get.snackbar(
        "Warning",
        message.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        barBlur: 20,
      );
      Get.arguments.remove('message');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(checkHeaderMessages);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('LOGIN'),
            automaticallyImplyLeading: false,
          ),
          body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      TextFormField(
                        // key: const Key('username'),
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                          label: Text('Email'),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: controller.validator,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => TextFormField(
                          // key: const Key('password'),
                          controller: controller.passwordController,
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
                          validator: controller.validator,
                          obscureText: controller.showPassword.value,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              LoadingOverlay.show(message: 'Login...');
                              try {
                                await controller.login();
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
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  shouldIconPulse: true,
                                  barBlur: 20,
                                );
                              } finally {}

                              controller.loginFormKey.currentState!.save();
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(Routes.register);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
