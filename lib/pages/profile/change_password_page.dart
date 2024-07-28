import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
   final AuthViewModel model = serviceLocator<AuthViewModel>();
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController passwordController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    newPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=>AppRoute.pop(), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,),),
          title: Text("Change Password", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  children: [
                    SizedBox(height: size.height/10,),
    
                    kFormField(hintText: "Old Password", controller: passwordController, prefixIcon: Icon(Icons.lock, color: warning400,), validator: genericValidator,),
                    const SizedBox(height: 24,),
                    kFormField(hintText: "New Password", controller: newPasswordController, prefixIcon: Icon(Icons.lock, color: warning400,), validator: genericValidator,),
    
                    const SizedBox(
                      height: 48,
                    ),
    
                    ElevatedButton(onPressed: () async{
                      final res = await model.changePassword(oldPassword: passwordController.text, newPassword: newPasswordController.text);
                      if(res){
                        AppRoute.pop();
                      }
                    }, child: const Text("Submit"))
                  ],
                ),
              ),

              Consumer<AuthViewModel>(
                builder: (_,model,__){
                  return model.isLoading ? Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.black54, child: const Center(child: CircularProgressIndicator.adaptive()),) : Container();
                }
              )
            ],
          )
        ),
      ),
    );
  }
}