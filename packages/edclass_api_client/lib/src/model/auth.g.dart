// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

RegisterUserBody _$RegisterUserBodyFromJson(Map<String, dynamic> json) =>
    RegisterUserBody(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirm_password'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RegisterUserBodyToJson(RegisterUserBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
      'role': _$UserRoleEnumMap[instance.role]!,
      'students': instance.students,
    };

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.parent: 'parent',
  UserRole.teacher: 'teacher',
  UserRole.admin: 'admin',
  UserRole.system: 'system',
};
