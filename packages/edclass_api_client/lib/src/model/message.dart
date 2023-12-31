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

@JsonSerializable(fieldRename: FieldRename.snake)
class Message {
  /// Message constructor
  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
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
  final String receiverId;

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
