import 'package:edclass_api_client/edclass_api_client.dart';
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
    required this.devices,
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

  /// user devices
  final List<String> devices;

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
    required this.devices,
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

  /// user devices
  final List<String> devices;

  /// to JSON
  Map<String, dynamic> toJson() => _$UserWithPasswordToJson(this);
}

/// user class without password
@JsonSerializable(fieldRename: FieldRename.snake)
class Kid {
  /// user constructor
  const Kid({
    required this.user,
    required this.courses,
  });

  ///
  factory Kid.fromJson(Map<String, dynamic> json) => _$KidFromJson(json);

  /// user
  final User user;

  /// courses taken
  final List<Course> courses;

  /// to JSON
  Map<String, dynamic> toJson() => _$KidToJson(this);
}
