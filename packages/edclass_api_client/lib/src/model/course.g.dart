// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      teacherId: json['teacher_id'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'teacher_id': instance.teacherId,
    };

GetCourseResponse _$GetCourseResponseFromJson(Map<String, dynamic> json) =>
    GetCourseResponse(
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      teacher: User.fromJson(json['teacher'] as Map<String, dynamic>),
      students: (json['students'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      enrolled: json['enrolled'] as bool,
    );

Map<String, dynamic> _$GetCourseResponseToJson(GetCourseResponse instance) =>
    <String, dynamic>{
      'course': instance.course,
      'teacher': instance.teacher,
      'students': instance.students,
      'enrolled': instance.enrolled,
    };

CourseEnrollment _$CourseEnrollmentFromJson(Map<String, dynamic> json) =>
    CourseEnrollment(
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      enrolled: json['enrolled'] as bool,
    );

Map<String, dynamic> _$CourseEnrollmentToJson(CourseEnrollment instance) =>
    <String, dynamic>{
      'course': instance.course,
      'enrolled': instance.enrolled,
    };
