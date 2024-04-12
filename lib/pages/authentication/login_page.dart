import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height/12,),
              Text("Welcome back!", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
              const SizedBox(height: 7,),
              Text("Sign in using your registered account", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
              
              SizedBox(height: size.height/12,),
              
              kFormField(hintText: "Email", controller: TextEditingController(), suffixIcon: Icon(Icons.email_outlined, color: warning400,),),
              const SizedBox(height: 24,),
              kFormField(hintText: "Password", controller: TextEditingController(), suffixIcon: Icon(Icons.lock, color: warning400,),),
              const SizedBox(height: 16,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){}, child: const Text("Forgot Password?")),
              ),
              SizedBox(height: size.height/14,),
              ElevatedButton(onPressed: (){}, child: const Text("Sign in")),
              
              const Spacer(),
              
              RichText(
                text: TextSpan(
                  text: "Don’t have an account? ",
                  style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: error400),
                      // recognizer: 
                    )
                  ]
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}