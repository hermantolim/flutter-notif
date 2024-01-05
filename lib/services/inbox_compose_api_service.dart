import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';

import 'api_service.dart';

class InboxComposeApiService extends ApiService {
  static String inboxUrl = '/messages';
  Future<Response<dynamic>> send(
      String? subject, String content, List<String> receiverIds) async {
    return post(
        inboxUrl,
        MessageBody(
          content: content,
          subject: subject,
          receiverIds: receiverIds,
        ).toJson(),
        contentType: 'application/json');
  }
}
