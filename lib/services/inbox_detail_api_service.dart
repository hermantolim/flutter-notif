import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';

import 'api_service.dart';

class InboxDetailApiService extends ApiService {
  static String inboxUrl = '/messages';

  Future<Response<dynamic>> load(String id) async {
    return get("$inboxUrl/$id", contentType: 'application/json');
  }

  Future<Response<dynamic>> updateState(String id) async {
    return post(
        "$inboxUrl/$id/state",
        const UpdateMessageStateBody(
          state: MessageState.read,
        ).toJson(),
        contentType: 'application/json');
  }
}
