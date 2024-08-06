import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final AuthViewModel model = serviceLocator<AuthViewModel>();
  final signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // fNameController.dispose();
    // lNameController.dispose();
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
                key: signupFormKey,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  children: [
                    SizedBox(height: size.height/12,),
                    Text("Register your account", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                    const SizedBox(height: 7,),
                    Text("Please register down below", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
                    
                    SizedBox(height: size.height/12,),
                    
                    kFormField(hintText: "First Name", controller: fNameController, prefixIcon: Icon(Icons.person, color: warning400,), validator: genericValidator,),
                    const SizedBox(height: 24,),
                    kFormField(hintText: "Last Name", controller: lNameController, prefixIcon: Icon(Icons.person, color: warning400,), validator: genericValidator,),
                    const SizedBox(height: 24,),
                    kFormField(hintText: "Email", controller: emailController, prefixIcon: Icon(Icons.email_outlined, color: warning400,), validator: emailValidator,),
                    const SizedBox(height: 24,),
                    kFormField(hintText: "Password", controller: passwordController, prefixIcon: Icon(Icons.lock, color: warning400,), validator: genericValidator,),
                 
                    SizedBox(height: size.height/14,),
                    ElevatedButton(onPressed: (){
                      if(signupFormKey.currentState!.validate()){
                        model.signUp(email: emailController.text, password: passwordController.text, firstName: fNameController.text, lastName: lNameController.text);
                      }
                    }, child: const Text("Sign Up")),
                    
                    SizedBox(height: size.height/8,),
                    
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: error400),
                              recognizer: TapGestureRecognizer()..onTap = ()=>AppRoute.go(AppRoute.login)
                            )
                          ]
                        )
                      ),
                    )
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
          ),
        ),
      ),
    );
  }
}