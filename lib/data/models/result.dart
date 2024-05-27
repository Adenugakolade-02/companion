import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T>{
  const factory Result.success(T value) = _SuccessResult;
  const factory Result.error(CustomError error) = _ErrorResult;
}

class CustomError implements Exception {
  final String message;
  int? statusCode;
  CustomError({required this.message, this.statusCode});

  factory CustomError.message(String msg) => CustomError(message: msg);

  @override
  String toString() => 'Message: $message';
}