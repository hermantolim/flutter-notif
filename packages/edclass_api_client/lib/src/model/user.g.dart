// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      name: json['name'] as String,
      devices:
          (json['devices'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'name': instance.name,
      'devices': instance.devices,
    };

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.parent: 'parent',
  UserRole.teacher: 'teacher',
  UserRole.admin: 'admin',
  UserRole.system: 'system',
};

UserWithPassword _$UserWithPasswordFromJson(Map<String, dynamic> json) =>
    UserWithPassword(
      uid: json['uid'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      name: json['name'] as String,
      password: json['password'] as String,
      devices:
          (json['devices'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserWithPasswordToJson(UserWithPassword instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'name': instance.name,
      'password': instance.password,
      'devices': instance.devices,
    };
