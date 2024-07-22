import 'package:freezed_annotation/freezed_annotation.dart';


part 'generated/user_model.freezed.dart';
part 'generated/user_model.g.dart';

@freezed
class UserModel with _$UserModel{
  const factory UserModel({
    @Default('') String id,
    @Default('') String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String avatar,
    @Default('') String userName,
    @Default('') String location,
    @Default('') String phone
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json){
    json['firstName'] ??= json['first_name'];
    json['lastName'] ??= json['last_name'];
    json['userName'] ??= json['user_name'];
    return  _$UserModelFromJson(json);
  }

  // factory UserModel.fromJson(Map<String, dynamic> json)=> _$UserModelFromJson(json);
}