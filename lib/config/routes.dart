import 'package:get/get.dart';
import 'package:notif/bindings/course_binding.dart';
import 'package:notif/bindings/course_detail_binding.dart';
import 'package:notif/bindings/home_binding.dart';
import 'package:notif/bindings/inbox_binding.dart';
import 'package:notif/bindings/inbox_compose_binding.dart';
import 'package:notif/bindings/inbox_detail_binding.dart';
import 'package:notif/bindings/login_binding.dart';
import 'package:notif/bindings/mycourse_binding.dart';
import 'package:notif/bindings/register_binding.dart';
import 'package:notif/middlewares/auth_middleware.dart';
import 'package:notif/screens/courses/course_detail_screen.dart';
import 'package:notif/screens/courses/course_screen.dart';
import 'package:notif/screens/courses/mycourse_screen.dart';
import 'package:notif/screens/home/home_screen.dart';
import 'package:notif/screens/login/login_screen.dart';
import 'package:notif/screens/messages/inbox_compose_screen.dart';
import 'package:notif/screens/messages/inbox_detail_screen.dart';
import 'package:notif/screens/messages/inbox_screen.dart';
import 'package:notif/screens/messages/inbox_sent_screen.dart';
import 'package:notif/screens/register/register_screen.dart';

abstract class Routes {
  static const login = '/login';
  static const register = '/register';
  static const inbox = '/inbox';
  static const inboxCompose = '/inbox/compose';
  static const sent = '/sent';
  static const message = '/message';
  static const course = '/course';
  static const myCourse = '/my-course';
  static const courseDetail = '/course_detail';
  static const home = '/';
}

final appPages = [
  GetPage(
    name: Routes.home,
    page: () => const HomeScreen(),
    binding: HomeBinding(),
    middlewares: [AuthMiddleware()],
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Routes.login,
    page: () => const LoginScreen(),
    binding: LoginBinding(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.register,
    page: () => const RegisterScreen(),
    binding: RegisterBinding(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.inbox,
    page: () => const InboxScreen(),
    binding: InboxBinding(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: Routes.sent,
    page: () => const InboxSentScreen(),
    binding: InboxBinding(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: Routes.inboxCompose,
    page: () => const InboxComposeScreen(),
    binding: InboxComposeBinding(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: Routes.message,
    page: () => const InboxDetailScreen(),
    binding: InboxDetailBinding(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.course,
    page: () => const CourseScreen(),
    binding: CourseBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Routes.courseDetail,
    page: () => const CourseDetailScreen(),
    binding: CourseDetailBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
      name: Routes.myCourse,
      page: () => const MyCourseScreen(),
      binding: MyCourseBinding(),
      transition: Transition.fadeIn)
];
