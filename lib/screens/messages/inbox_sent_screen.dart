import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/inbox_sent_controller.dart';

class InboxSentScreen extends GetView<InboxSentController> {
  const InboxSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.getProfile();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Get.offAllNamed(Routes.home);
          },
        ),
        title: const Text(
          'Sent Items',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('${user?.email[0]}'),
          ),
        ],
      ),
      body: controller.obx(
        (state) {
          print('OBX state $state');
          final messages = (state as List? ?? []) as List<Message>;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              print(
                  '====================================== list view builder $index ${messages}');
              return Container(
                color: index % 2 == 0 ? Colors.grey : Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(messages[index].subject ?? 'No Subject'),
                      Text(messages[index].content),
                      Text(
                        'Read State: ${messages[index].state == MessageState.read}',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },

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
