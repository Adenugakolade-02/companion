import 'package:caution_companion/base_model.dart';
import 'package:caution_companion/data/models/user_model.dart';
import 'package:caution_companion/data/repos/auth_repo_impl.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/dialog_service.dart';
import 'package:caution_companion/utils/app_routes.dart';

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
      success: (success){
        dialogService.displayMessage("Login Successful", status: Status.success);
        AppRoute.go(AppRoute.homePage);
      }, 
      error: (error){
        dialogService.displayMessage(error.message, title: "Failer to login");
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


}