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
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'name': instance.name,
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
    );

Map<String, dynamic> _$UserWithPasswordToJson(UserWithPassword instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'name': instance.name,
      'password': instance.password,
    };

UsersDevices _$UsersDevicesFromJson(Map<String, dynamic> json) => UsersDevices(
      id: json['id'] as String,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$UsersDevicesToJson(UsersDevices instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
    };
