import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

/// inner error
@JsonSerializable()
class ErrInner {
  /// error
  const ErrInner({
    required this.code,
    required this.message,
  });

  ///
  factory ErrInner.fromJson(Map<String, dynamic> json) =>
      _$ErrInnerFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$ErrInnerToJson(this);

  /// http status code
  final int code;

  /// error message
  final String message;

  @override
  String toString() => '[$code] $message';
}

/// returned error type
@JsonSerializable()
class Err {
  /// returned error type constructor
  const Err(this.error);

  ///
  factory Err.fromJson(Map<String, dynamic> json) => _$ErrFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$ErrToJson(this);

  /// error
  final ErrInner error;

  @override
  String toString() => '$error';
}
