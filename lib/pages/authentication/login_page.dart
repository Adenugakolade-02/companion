// import 'dart:ffi';

import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  
  final AuthViewModel model = serviceLocator<AuthViewModel>();
  final loginFormKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Form(
                key: loginFormKey,
                child: AutofillGroup(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    children: [
                      SizedBox(height: size.height/12,),
                      Text("Welcome back!", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                      const SizedBox(height: 7,),
                      Text("Sign in using your registered account", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
                      
                      SizedBox(height: size.height/12,),
                      
                      kFormField(hintText: "Email", controller: emailController, prefixIcon: Icon(Icons.email_outlined, color: warning400,), validator: emailValidator, autofillHints: const [AutofillHints.email],),
                      const SizedBox(height: 24,),
                      kFormField(hintText: "Password", controller: passwordController, prefixIcon: Icon(Icons.lock, color: warning400,), validator: genericValidator, autofillHints: const[AutofillHints.password],),
                      const SizedBox(height: 16,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: ()=>AppRoute.go(AppRoute.resetPageone), child: const Text("Forgot Password?")),
                      ),
                      SizedBox(height: size.height/14,),
                      ElevatedButton(onPressed: (){
                        if(loginFormKey.currentState!.validate()){
                          model.login(email: emailController.text, password: passwordController.text);
                        }
                      }, child: const Text("Sign in")),
                      
                      SizedBox(height: size.height/8,),
                      
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don’t have an account? ",
                            style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: error400),
                                recognizer:  TapGestureRecognizer()..onTap = ()=>AppRoute.go(AppRoute.registerPage)
                              )
                            ]
                          )
                        ),
                      )
                    ],
                  ),
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
          ),
        ),
      ),
    );
  }
}