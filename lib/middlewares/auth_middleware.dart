import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notif/config/routes.dart';
import 'package:notif/mixins/cache_mixin.dart';

class AuthMiddleware extends GetMiddleware {
  final box = GetStorage();
  //final OAuthClientService _OAuthClientService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final token = box.read(CacheManagerKey.token.toString());
    if (token == null) {
      return const RouteSettings(name: Routes.login);
    }
    return null;
    //if (_OAuthClientService.sessionIsEmpty()) {
    //  return RouteSettings(name: Routes.LOGIN);
    //}
  }
}
