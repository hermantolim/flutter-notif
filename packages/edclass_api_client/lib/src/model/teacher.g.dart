// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      courses: (json['courses'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => _$recordConvert(
                      e,
                      ($jsonValue) => (
                        Course.fromJson(
                            $jsonValue[r'$1'] as Map<String, dynamic>),
                        User.fromJson(
                            $jsonValue[r'$2'] as Map<String, dynamic>),
                      ),
                    ))
                .toList()),
      ),
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'user': instance.user,
      'courses': instance.courses.map((k, e) => MapEntry(
          k,
          e
              .map((e) => {
                    r'$1': e.$1,
                    r'$2': e.$2,
                  })
              .toList())),
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
