import 'dart:io';

import 'package:caution_companion/data/models/result.dart';
import 'package:caution_companion/data/models/user_model.dart';

abstract class AuthRepository{
  Future<Result<bool>> login({
    required String email,
    required String password
  });
  Future<Result<bool>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName
  });

  Future<Result<UserModel>> getUser();
  Future<Result<bool>> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String userName,
    required String location,
    required String phone,
    required String avatar
  });

  Future<Result<String>> uploadFile({
    required File file
  });

  Future<Result<bool>> changePassword({
    required String oldPassword,
    required String newPassword
  });
}