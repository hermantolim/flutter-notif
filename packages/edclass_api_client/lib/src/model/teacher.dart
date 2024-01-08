import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

/// message class
@JsonSerializable(fieldRename: FieldRename.snake)
class Teacher {
  /// Message constructor
  const Teacher({
    required this.user,
    required this.courses,
  });

  ///
  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  /// user
  final User user;

  /// courses;
  final Map<String, List<(Course, User)>> courses;

  /// to JSON
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
