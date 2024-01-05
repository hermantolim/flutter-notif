import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';

import 'api_service.dart';

class InboxApiService extends ApiService {
  static String inboxUrl = '/messages/list/inbox';
  static String sentUrl = '/messages/list/sent';

  Future<Response<dynamic>> load() async {
    return get(inboxUrl, contentType: 'application/json');
  }

  Future<Response<dynamic>> loadSent() async {
    return get(sentUrl, contentType: 'application/json');
  }

  Future<List<Message>> loadMessages() async {
    final res = await get(inboxUrl, contentType: 'application/json');
    if (res.statusCode == 200) {
      final bodyList = res.body as List? ?? [];
      return bodyList.map((e) {
        return Message.fromJson(e);
      }).toList();
    } else {
      return List.empty(growable: true);
    }
  }
}
