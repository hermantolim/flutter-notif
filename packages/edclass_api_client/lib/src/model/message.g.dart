// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      content: json['content'] as String,
      state: $enumDecode(_$MessageStateEnumMap, json['state']),
      createdAt: DateTime.parse(json['created_at'] as String),
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
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
      receiverId: json['receiver_id'] as String,
      content: json['content'] as String,
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$MessageBodyToJson(MessageBody instance) =>
    <String, dynamic>{
      'receiver_id': instance.receiverId,
      'subject': instance.subject,
      'content': instance.content,
    };
