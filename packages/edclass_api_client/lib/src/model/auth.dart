import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

///
@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  ///
  AuthResponse({required this.token});

  ///
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  ///
  final String token;
}

///
