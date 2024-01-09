import 'package:edclass_api_client/edclass_api_client.dart';
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

  @override
  bool operator ==(o) => o is Course && id == o.id;

  @override
  int get hashCode => id.hashCode;
}

/// message class
@JsonSerializable(fieldRename: FieldRename.snake)
class GetCourseResponse {
  /// Message constructor
  const GetCourseResponse({
    required this.course,
    required this.teacher,
    required this.students,
    required this.enrolled,
  });

  ///
  factory GetCourseResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCourseResponseFromJson(json);

  /// course
  final Course course;

  /// teacher
  final User teacher;

  /// students
  final List<User> students;

  /// current user is student and enrolled
  final bool enrolled;

  /// to JSON
  Map<String, dynamic> toJson() => _$GetCourseResponseToJson(this);
}

/// course enrollment response
@JsonSerializable(fieldRename: FieldRename.snake)
class CourseEnrollment {
  /// constructor
  const CourseEnrollment({
    required this.course,
    required this.enrolled,
  });

  /// fromJson
  factory CourseEnrollment.fromJson(Map<String, dynamic> json) =>
      _$CourseEnrollmentFromJson(json);

  /// course
  final Course course;

  /// is current user enrolled
  final bool enrolled;

  /// to json
  Map<String, dynamic> toJson() => _$CourseEnrollmentToJson(this);
}

/// course enrollment response
@JsonSerializable(fieldRename: FieldRename.snake)
class MyCourse {
  /// constructor
  const MyCourse({
    required this.course,
    required this.students,
  });

  /// fromJson
  factory MyCourse.fromJson(Map<String, dynamic> json) =>
      _$MyCourseFromJson(json);

  /// course
  final Course course;

  /// is current user enrolled
  final int students;

  /// to json
  Map<String, dynamic> toJson() => _$MyCourseToJson(this);
}
