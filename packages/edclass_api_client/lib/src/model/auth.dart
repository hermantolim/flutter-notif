import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

///
@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  ///
  AuthResponse({required this.user, required this.token});

  ///
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  ///
  final User user;

  ///
  final String token;
}

///
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterUserBody {
  /// constructor
  RegisterUserBody({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.role,
    this.students,
  });

  ///
  factory RegisterUserBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserBodyFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$RegisterUserBodyToJson(this);

  /// name
  final String name;

  /// email
  final String email;

  /// password
  final String password;

  ///
  final String confirmPassword;

  ///
  final UserRole role;

  ///
  final List<String>? students;
}
