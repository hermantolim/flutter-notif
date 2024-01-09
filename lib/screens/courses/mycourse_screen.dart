import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/mycourse_controller.dart';

class MyCourseScreen extends GetView<MyCourseController> {
  const MyCourseScreen({super.key});

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
          'My Courses',
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
          final courses = (state as List? ?? []) as List<MyCourse>;
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.courseDetail,
                        parameters: {"id": courses[index].course.id});
                  },
                  child: Container(
                    color: index % 2 == 0 ? Colors.grey : Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(courses[index].course.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(courses[index].course.content),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.person_outline),
                              const SizedBox(width: 8),
                              Text("${courses[index].students} students"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
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
