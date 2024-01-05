import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

/// message state
@JsonEnum()
enum MessageState {
  /// pending
  pending,

  /// failed
  failed,

  /// sent
  sent,

  /// received
  received,

  /// read
  read,
}

/// message class
@JsonSerializable(fieldRename: FieldRename.snake)
class Message {
  /// Message constructor
  const Message({
    required this.id,
    required this.senderId,
    required this.receiverIds,
    required this.content,
    required this.state,
    required this.createdAt,
    this.subject,
  });

  ///
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// uuid
  final String id;

  /// sender / user uuid
  final String senderId;

  /// receiver / user uuid
  final List<String> receiverIds;

  /// subject optional
  final String? subject;

  /// message body
  final String content;

  /// message state
  final MessageState state;

  /// message creation timestamp
  final DateTime createdAt;

  /// to JSON
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

/// message request body
@JsonSerializable(fieldRename: FieldRename.snake)
class MessageBody {
  /// constructor
  const MessageBody({
    required this.receiverIds,
    required this.content,
    this.subject,
  });

  /// from json
  factory MessageBody.fromJson(Map<String, dynamic> json) =>
      _$MessageBodyFromJson(json);

  /// user uuid
  final List<String> receiverIds;

  /// optional subject
  final String? subject;

  /// message content
  final String content;

  /// toJSON
  Map<String, dynamic> toJson() => _$MessageBodyToJson(this);
}

/// update message status
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateMessageStateBody {
  /// constructor
  const UpdateMessageStateBody({
    required this.state,
  });

  /// from json
  factory UpdateMessageStateBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateMessageStateBodyFromJson(json);

  /// next state
  final MessageState state;

  /// toJSON
  Map<String, dynamic> toJson() => _$UpdateMessageStateBodyToJson(this);
}
