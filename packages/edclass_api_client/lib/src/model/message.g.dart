// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      receiverIds: (json['receiver_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      content: json['content'] as String,
      state: $enumDecode(_$MessageStateEnumMap, json['state']),
      createdAt: DateTime.parse(json['created_at'] as String),
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'receiver_ids': instance.receiverIds,
      'subject': instance.subject,
      'content': instance.content,
      'state': _$MessageStateEnumMap[instance.state]!,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$MessageStateEnumMap = {
  MessageState.pending: 'pending',
  MessageState.failed: 'failed',
  MessageState.sent: 'sent',
  MessageState.received: 'received',
  MessageState.read: 'read',
};

MessageBody _$MessageBodyFromJson(Map<String, dynamic> json) => MessageBody(
      receiverIds: (json['receiver_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      content: json['content'] as String,
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$MessageBodyToJson(MessageBody instance) =>
    <String, dynamic>{
      'receiver_ids': instance.receiverIds,
      'subject': instance.subject,
      'content': instance.content,
    };

UpdateMessageStateBody _$UpdateMessageStateBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateMessageStateBody(
      state: $enumDecode(_$MessageStateEnumMap, json['state']),
    );

Map<String, dynamic> _$UpdateMessageStateBodyToJson(
        UpdateMessageStateBody instance) =>
    <String, dynamic>{
      'state': _$MessageStateEnumMap[instance.state]!,
    };
