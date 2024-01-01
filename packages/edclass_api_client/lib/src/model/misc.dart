import 'package:json_annotation/json_annotation.dart';

part 'misc.g.dart';

///
@JsonSerializable()
class BoolResponse {
  ///
  const BoolResponse({required this.success});

  ///
  factory BoolResponse.fromJson(Map<String, dynamic> json) =>
      _$BoolResponseFromJson(json);

  ///
  final bool success;

  ///
  Map<String, dynamic> toJson() => _$BoolResponseToJson(this);

  @override
  String toString() => 'BoolResponse(success: $success)';
}
