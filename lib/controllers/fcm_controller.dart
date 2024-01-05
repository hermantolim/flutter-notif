import 'dart:developer';

import 'package:get/get.dart';
import 'package:notif/services/fcm_api_service.dart';

class FcmController extends GetxController {
  final FcmApiService _fcmApiService;

  FcmController(this._fcmApiService);

  Future<void> storeToken(String token) async {
    try {
      await _fcmApiService.storeToken(token);
      log('device token stored: $token');
    } catch (err, _) {
      log('$err');
      rethrow;
    }
    // Implement your API call to store the token in the database
    // Example: Use Dio or other HTTP client for the API request
    // Replace 'your_api_endpoint' with the actual API endpoint
    // Replace 'your_api_key' with any authentication header or API key needed

    // Example using Dio:
    // final response = await Dio().post(
    //   'your_api_endpoint',
    //   data: {'token': token},
    //   options: Options(
    //     headers: {'Authorization': 'Bearer your_api_key'},
    //   ),
    // );

    // Check response status and handle accordingly
    // if (response.statusCode == 200) {
    //   print('Token stored successfully');
    // } else {
    //   print('Failed to store token');
    // }
  }
}
