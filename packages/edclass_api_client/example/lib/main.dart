import 'dart:io';

import 'package:edclass_api_client/edclass_api_client.dart';

Future<void> main() async {
  final apiClient = EdclassApiClient();

  try {
    var res = await apiClient.auth("hl@hl.com", "hl");
    print('$res');
    exit(0);
  } catch (e) {
    print(e);
    exit(0);
  }
}
