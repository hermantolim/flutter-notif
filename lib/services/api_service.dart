import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:notif/config/config.dart';
import 'package:notif/controllers/auth_controller.dart';

import 'auth_service.dart';

class ApiService extends GetConnect {
  bool isLoginRequest(request) {
    return (Config.baseUrl + AuthApiService.signInUrl ==
        request.url.toString());
  }

  int retry = 0;
  @override
  void onInit() {
    httpClient.baseUrl = Config.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.maxAuthRetries = retry = 3;
    httpClient.followRedirects = true;
/*
//addAuthenticator only is called after
//a request (get/post/put/delete) that returns HTTP status code 401
    httpClient.addAuthenticator<dynamic>((request) async {
      retry--;
      log('addAuthenticator ${request.url.toString()}');

      AuthController authController = Get.find();
      String? token;
      //Credentials? oauthCredentails = oAuthClientService.credentials;
      try {
        if (token != null) {
          if (oauthCredentails!.accessToken.isNotEmpty) {
            request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
          } else {
            if (retry == 0) {
              retry = httpClient.maxAuthRetries;
              if (!isLoginRequest(request)) {
                // log('check is isLoginRequest(request): ${isLoginRequest(request)}');
                Get.offAllNamed(Routes.login);
              }
            }
          }
        } else {
          if (retry == 0) {
            retry = httpClient.maxAuthRetries;
            if (!isLoginRequest(request)) {
              Get.offAllNamed(Routes.login, arguments: {
                'message': {
                  'status': 'warning',
                  'status_text': 'session_expired',
                  'body': 'Session expired please log in again.!'
                }
              });
            }
          }
        }
      } catch (err, _) {
        printError(info: err.toString());

        Get.offAllNamed(Routes.login, arguments: {
          'message': {
            'status': 'warning',
            'status_text': 'session_expired',
            'body':
                'Session expired Or invalid refresh token, please log in again.!'
          }
        });
      }

      return request;
    });
*/
    httpClient.addResponseModifier((request, response) {
      //Some resources have been omitted because of insufficient authorization
      // var body = jsonDecode(response.body.toString());
      // if (body != null &&
      //     body.containsKey('meta') &&
      //     body['meta'].containsKey('omitted')) {
      //   return Response(request: request, statusCode: 401);
      // }
      return response;
    });

    httpClient.addRequestModifier<dynamic>((request) async {
      // log('call addRequestModifier , ${request.headers}');
      AuthController authController = Get.find();
      var tc = authController.getToken();

      log('=========================================================== request modifier start');
      if (tc != null && tc.isNotEmpty) {
        // log('Add Request Modifier is authenticated ${authController.tokenCredentials()!.accessToken}');
        log('Bearer $tc');
        request.headers[HttpHeaders.authorizationHeader] = 'Bearer $tc';
      }
      log('=========================================================== request modifier end');
      return request;
    });
  }
}
