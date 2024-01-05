import 'package:get/get.dart';

import 'api_service.dart';

class FcmApiService extends ApiService {
  static String url = '/users/devices';

  Future<Response<dynamic>> storeToken(String token) async {
    return post(url, {"device_token": token}, contentType: 'application/json');
  }
}
