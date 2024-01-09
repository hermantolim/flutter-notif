// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('EdclassApiClient', () {
    test('test message can be deserialize', () {
      final response =
          '[{"id":"75cdb642-ec7d-41be-ad2f-27a89c6d2b0c","sender_id":"21857bd9-f520-4842-b608-e07d858e9518","receiver_ids":["t1@t1.com"],"subject":null,"content":"message content","state":"pending","created_at":"2023-12-29T23:04:48.570558724Z"},{"id":"8680d832-07ad-4f8d-9e89-116d30aa902b","sender_id":"21857bd9-f520-4842-b608-e07d858e9518","receiver_ids":["t1@t1.com"],"subject":null,"content":"message content","state":"sent","created_at":"2023-12-29T08:28:37.255211818Z"}]';
      final decoded = jsonDecode(response) as List<dynamic>;
      final deser =
          decoded.map((e) => Message.fromJson(e as Map<String, dynamic>));
      expect(deser, isNotNull);
      expect(deser.length, 2);
    });
  });
}
