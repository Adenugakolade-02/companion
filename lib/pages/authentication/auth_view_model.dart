// import 'dart:html';

import 'dart:io';

import 'package:caution_companion/base_model.dart';
import 'package:caution_companion/data/models/result.dart';
import 'package:caution_companion/data/models/user_model.dart';
import 'package:caution_companion/data/repos/auth_repo_impl.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/dialog_service.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AuthViewModel extends BaseModel{

  final authRepositoryImpl = AuthRepositoryImpl();
  final DialogService dialogService = serviceLocator<DialogService>();

  UserModel? user;


  void setUser(UserModel userModel){
    user = userModel;
    notifyListeners();
  }

  // Stream<UserModel> 

  Future<bool> getUser() async{
    setState(true);
    final response =  await authRepositoryImpl.getUser();
    setState(false);
    return response.when(
      success: (success){
        setUser(success);
        return true;
      }, 
      error: (error){
        // dialogService.displayMessage("Failed to login",title: "Login Failed");
        return false;
      }
    );
  }

  void login({required String email, required String password}) async{
    setState(true);
    final response = await authRepositoryImpl.login(email: email, password: password);
    setState(false);
    response.when(
      success: (success) async{
        dialogService.displayMessage("Login Successful", status: Status.success);
        await getUser();
        AppRoute.go(AppRoute.homePage);
      }, 
      error: (error){
        dialogService.displayMessage(error.message, title: "Failed to login");
      }
    );
  }

  void signUp({required String email, required String password, required String firstName, required String lastName}) async{
    setState(true);
    final response = await authRepositoryImpl.signUp(email: email, password: password, firstName: firstName, lastName: lastName);
    setState(false);

    response.when(
      success: (success){
        dialogService.displayMessage("Sign up successful, kindly login", title: "Success" ,status: Status.success);
        AppRoute.go(AppRoute.login);
      }, 
      error: (error){
        dialogService.displayMessage(error.message, title: "Failed to create account");
      }
    );
  }

  Future<bool> updateProfile({ required String email, required String firstName, required String lastName, required String userName, required String location, required String phone, required String avatar}) async{
    setState(true);
    final response = await authRepositoryImpl.updateProfile(email: email, firstName: firstName, lastName: lastName, userName: userName, location: location, phone: phone, avatar: avatar);
    setState(false);

    return response.when(
      success: (success){
        dialogService.displayMessage("Profile updated successfully", status: Status.success);
        return true;
      }, error: (error){
        dialogService.displayMessage(error.message, title: "Failed to update user profile");
        return false;
      }
    );
  }


  Future<File?> pickSingleImageAndCrop({required bool isGallery}) async {
    File? selectedFile;
    final ImagePicker picker = ImagePicker();
    final XFile? imageXFile = await picker.pickImage(
        source: isGallery == true ? ImageSource.gallery : ImageSource.camera);
    if (imageXFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageXFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: warning400,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        selectedFile = File(croppedFile.path);
      }
    }
    return selectedFile;
  }

  Future<String?> uploadProfilePicture(File? file) async{
    if(file==null){return null;}
    else{
      setState(true);
      final response = await authRepositoryImpl.uploadFile(file: file);
      setState(false);

      return response.when(
        success: (success){
          dialogService.displayMessage("Profile picture updated successfully", status: Status.success);
          return success;
        }, 
        error: (error){
          dialogService.displayMessage(error.message);
        }
      );
    }
  }

  Future<bool> changePassword({required String oldPassword, required String newPassword}) async{
    setState(true);
    final response = await authRepositoryImpl.changePassword(oldPassword: oldPassword, newPassword: newPassword);
    setState(false);

    return response.when(success: (success){
      dialogService.displayMessage("Password updated successfully", status: Status.success);
      return true;
    }, error: (error){
      dialogService.displayMessage(error.message);
      return false;
      }
    );
  }

}