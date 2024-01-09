import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Get.offAllNamed(Get.previousRoute);
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
              if (user?.role != UserRole.teacher)
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.badge_outlined),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Teacher: ${course?.teacher.name}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
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
              if (course != null && user?.role == UserRole.student)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: course.enrolled
                        ? null
                        : () async => await controller.enroll(course.course.id),
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.black26,
                    ),
                    child: Text(
                      course.enrolled ? 'Enrolled' : 'Enroll',
                    ),
                  ),
                ),
              if (course != null && user?.role == UserRole.teacher)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      width: double.infinity,
                      child: const Text(
                        'Students',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black26,
                      ),
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const Icon(Icons.person_outline),
                            Text(course.students[index].name)
                          ],
                        );
                      },
                      itemCount: course.students.length ?? 0,
                    ),
                  ],
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
