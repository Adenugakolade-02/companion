import 'package:caution_companion/data/models/result.dart';
import 'package:caution_companion/domain/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<Result<bool>> login({required String email, required String password}) {
    
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> signUp({required String email, required String password, required String firstName, required String lastName}) {
   
    throw UnimplementedError();
  }
  
  @override
  Future<Result<bool>> getUser() {

    throw UnimplementedError();
  }
  
}