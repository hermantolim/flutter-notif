import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/home_controller.dart';
import 'package:notif/services/notification_service.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final fcmService = Get.find<FCMService>();
    final user = authController.getProfile();

    fcmService.setupFCM();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Inbox'),
              leading: const Icon(Icons.inbox_outlined),
              onTap: () {
                Get.offAllNamed(Routes.inbox);
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Sent'),
              leading: const Icon(Icons.outbox_outlined),
              onTap: () {
                Get.offAllNamed(Routes.sent);
                // Update the state of the app.
                // ...
              },
            ),
            if (user?.role == UserRole.student)
              ListTile(
                title: const Text('Courses'),
                leading: const Icon(Icons.class_outlined),
                onTap: () {
                  Get.offAllNamed(Routes.course);
                  // Update the state of the app.
                  // ...
                },
              ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('${user?.email[0]}'),
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Log Out',
            onPressed: () {
              Get.find<AuthController>().logOut();
              Get.offAllNamed(Routes.login);
            },
          )
        ],
      ),
      body: controller.obx(
        (state) => Center(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('This is the home page'),
              ElevatedButton(
                onPressed: () {
                  Get.find<AuthController>().logOut();
                  Get.offAllNamed(Routes.login);
                },
                child: const Text("Log Out",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          )),
        ),

        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: const CircularProgressIndicator(),
        onEmpty: const Column(
          children: [
            Text('No Data found'),
          ],
        ),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error) => const Text(''),
      ),
    );
  }
}
