import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/course_detail_controller.dart';

class CourseDetailScreen extends GetView<CourseDetailController> {
  const CourseDetailScreen({super.key});

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
            Get.offAllNamed(Routes.course);
          },
        ),
        title: const Text(
          'Course Info',
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
          final course = state as GetCourseResponse?;
          return Column(
            children: [
              Text(
                course?.course.title ?? "",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                course?.course.content ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: course != null && !course.enrolled
                      ? () async => await controller.enroll(course.course.id)
                      : null,
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.grey,
                    disabledForegroundColor: Colors.black26,
                  ),
                  child: Text(
                    course != null && course.enrolled ? 'Enrolled' : 'Enroll',
                  ),
                ),
              )
            ],
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
