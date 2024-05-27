import 'package:caution_companion/data/models/result.dart';

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

  Future<Result<bool>> getUser();
}