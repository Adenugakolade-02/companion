import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:caution_companion/data/models/result.dart';
import 'package:caution_companion/data/models/user_model.dart';
import 'package:caution_companion/domain/auth_repo.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/http_service.dart';
import 'package:caution_companion/services/storage_service.dart';

class AuthRepositoryImpl implements AuthRepository{

  @override
  Future<Result<bool>> login({required String email, required String password}) async{

    final response =  await HttpService.post(
      HttpService.login, {
        "email": email,
        "password": password
      });
      
    return response.when(
      success: (success){
        serviceLocator<StorageService>().storeToken("token", success["data"]["access_token"]);
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }

  @override
  Future<Result<bool>> signUp({required String email, required String password, required String firstName, required String lastName}) async{
    
    final response =  await HttpService.post(
      HttpService.register, {
         "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName
      });
      
    return response.when(
      success: (success){
        // final user = UserModel.fromJson(success['data']);
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }
  
  @override
  Future<Result<UserModel>> getUser() async{

    final response = await HttpService.get(HttpService.getUser, {});
    return response.when(
      success: (success){
        final user = UserModel.fromJson(success["data"]);
        
        return  Result.success(user);
      }, error: (error){
        if(error.statusCode==401){
          return Result.error(CustomError.message("Kindly log in again"));
        }else{
          return Result.error(error);
        }
      });
  }
  
  @override
  Future<Result<bool>> updateProfile({required String email, required String firstName, required String lastName, required String userName, required String location, required String phone, required String avatar}) async{
    final response = await HttpService.put(HttpService.register, {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "user_name": userName,
      "location": location,
      "phone": phone,
      "avatar":avatar
    });

    return response.when(
      success: (success){
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }

  @override
  Future<Result<String>> uploadFile({required File file}) async{
   final response = await HttpService.uploadFile(HttpService.uploadfile, file);
   return response.when(
    success: (success){
      final decodedJson = jsonDecode(success);

      final String url = decodedJson['data']['url'];
      log("upload done");
      return Result.success(url);
    }, 
    error: (error){
      return Result.error(error);
    }
    );
  }
  
  @override
  Future<Result<bool>> changePassword({required String oldPassword, required String newPassword}) async{
    final response = await HttpService.put(HttpService.changePassword, {
      "old_password": oldPassword,
      "new_password": newPassword
    });

    return response.when(
      success: (success){
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }
  
  @override
  Future<Result<bool>> forgotPassword({required String email}) async{
    final response = await HttpService.post(HttpService.forgotPassword, {"email":email});

    return response.when(
      success: (success){
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }
  
  @override
  Future<Result<bool>> resetPassword({required String token, required String password, required String cPassword}) async{
    final response = await HttpService.post(HttpService.resetPassword, {
      "token":token,
      "password": password,
      "confirm_password": cPassword
    });

    return response.when(
      success: (success){
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }
  
  @override
  Future<Result<bool>> verifyToken({required String token}) async{
    final response = await HttpService.post(HttpService.verifyToken, {"token": token});

    return response.when(
      success: (success){
        return const Result.success(true);
      }, 
      error: (error){
        return Result.error(error);
      }
    );
  }

  
  
}