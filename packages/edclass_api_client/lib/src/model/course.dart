import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

/// message class
@JsonSerializable(fieldRename: FieldRename.snake)
class Course {
  /// Message constructor
  const Course({
    required this.id,
    required this.title,
    required this.content,
    required this.teacherId,
  });

  ///
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  /// uuid
  final String id;

  /// content title
  final String title;

  /// content description
  final String content;

  /// course teacher id
  final String teacherId;

  /// to JSON
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
