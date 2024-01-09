import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';

import 'api_service.dart';

class AuthApiService extends ApiService {
  static String signUpUrl = '/auth/register';
  static String signInUrl = '/auth';

  Future<AuthResponse?> login(String email, String password) async {
    try {
      Response<dynamic> res = await get(signInUrl, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${base64.encode(
          utf8.encode("$email:$password"),
        )}'
      });

      log('RESPONSE HERE ====================================================================================> $res');
      print(inspect(res));

      AuthResponse authResponse = AuthResponse.fromJson(res.body);
      return authResponse;
    } catch (e) {
      printError(info: e.toString());
      rethrow;
    }
  }

  Future<User?> register(RegisterUserBody body) async {
    try {
      Response<dynamic> res = await post(signUpUrl, body.toJson());
      User user = User.fromJson(res.body);
      return user;
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
  }

//   void signOut() async {
//     await _authenticationService.signOut();
//     _authenticationStateStream.value = UnAuthenticated();
//   }
}
