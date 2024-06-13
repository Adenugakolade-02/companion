import 'package:caution_companion/base_model.dart';
import 'package:caution_companion/data/models/user_model.dart';
import 'package:caution_companion/data/repos/auth_repo_impl.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/dialog_service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends BaseModel{

  final authRepositoryImpl = AuthRepositoryImpl();
  final DialogService dialogService = serviceLocator<DialogService>();

  UserModel? user;
  late TextEditingController lEmailController;
  late TextEditingController lPasswordContoller;


 void setUser(UserModel userModel){
  user = userModel;
 }

 Future<bool> getUser() async{
  final response =  await authRepositoryImpl.getUser();
  return response.when(
    success: (success){
      return success;
    }, 
    error: (error){
      dialogService.displayMessage("Failed to login",title: "Login Failed");
      return false;
    }
  );
 }
}