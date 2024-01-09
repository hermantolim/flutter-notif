import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/kid_controller.dart';

class KidScreen extends GetView<KidController> {
  const KidScreen({super.key});

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
          'My Kids',
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
          final kids = (state as List? ?? []) as List<Kid>;
          return ListView.separated(
            separatorBuilder: (c, i) => const Divider(),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: kids.length,
            itemBuilder: (BuildContext context, int index) {
              print(
                  '====================================== list view builder $index ${kids}');

              return Container(
                color: index % 2 == 0 ? Colors.grey : Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(kids[index].user.email)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Enrolled Courses:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.separated(
                        separatorBuilder: (c, i) => const Divider(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: kids[index].courses.length,
                        itemBuilder: (BuildContext context, int courseIdx) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Course: ${kids[index].courses[courseIdx].title}"),
                                Text(
                                    "Teacher: ${kids[index].courses[courseIdx].teacherId}")
                              ],
                            ),
                          );
                        },
                      )
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
