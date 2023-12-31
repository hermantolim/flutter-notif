import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// user role
@JsonEnum()
enum UserRole {
  /// student
  student,

  /// parent
  parent,

  /// teacher
  teacher,

  /// admin
  admin,

  /// system
  system,
}

/// user class without password
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  /// user constructor
  const User({
    required this.uid,
    required this.email,
    required this.role,
    required this.name,
  });

  ///
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// uuid
  final String uid;

  /// email address
  final String email;

  /// user role
  final UserRole role;

  /// user name
  final String name;

  /// to JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// user class without password
@JsonSerializable(fieldRename: FieldRename.snake)
class UserWithPassword {
  /// user constructor
  const UserWithPassword({
    required this.uid,
    required this.email,
    required this.role,
    required this.name,
    required this.password,
  });

  ///
  factory UserWithPassword.fromJson(Map<String, dynamic> json) =>
      _$UserWithPasswordFromJson(json);

  /// uuid
  final String uid;

  /// email address
  final String email;

  /// user role
  final UserRole role;

  /// user name
  final String name;

  /// hashed password
  final String password;

  /// to JSON
  Map<String, dynamic> toJson() => _$UserWithPasswordToJson(this);
}

/// user device junction
@JsonSerializable(fieldRename: FieldRename.snake)
class UsersDevices {
  /// constructor
  const UsersDevices({
    required this.id,
    required this.userId,
  });

  ///
  factory UsersDevices.fromJson(Map<String, dynamic> json) =>
      _$UsersDevicesFromJson(json);

  /// device uuid
  final String id;

  /// user owner uuid
  final String userId;

  /// to JSON
  Map<String, dynamic> toJson() => _$UsersDevicesToJson(this);
}
