// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrInner _$ErrInnerFromJson(Map<String, dynamic> json) => ErrInner(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrInnerToJson(ErrInner instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

Err _$ErrFromJson(Map<String, dynamic> json) => Err(
      ErrInner.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrToJson(Err instance) => <String, dynamic>{
      'error': instance.error,
    };
