import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPageTwo extends StatefulWidget {
  const ResetPageTwo({super.key});

  @override
  State<ResetPageTwo> createState() => _ResetPageTwoState();
}

class _ResetPageTwoState extends State<ResetPageTwo> {
  late TextEditingController passwordController;
  late TextEditingController cpasswordController;
  final _formKey = GlobalKey<FormState>();

  final AuthViewModel model = serviceLocator<AuthViewModel>();

  @override
  void initState() {
    passwordController = TextEditingController();
    cpasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  child: Column(
                    
                    children: [
                      const SizedBox(height: 79,),
                      Text("Reset Password", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                      const SizedBox(height: 8,),
                      Text("Please enter a new password", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),

                      const SizedBox(height: 40,),

                      kFormField(hintText: "New password", controller: passwordController, prefixIcon: Icon(Icons.lock, color: warning400,), validator: genericValidator,),
                      const SizedBox(height: 24,),
                      kFormField(hintText: "Confirm password", controller: cpasswordController, prefixIcon: Icon(Icons.lock, color: warning400,), validator:  genericValidator,),
              
                      const SizedBox(height: 40,),
              
                      ElevatedButton(onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          final res = await model.resetPassword(token: model.otpCode, password: passwordController.text, cPassword: cpasswordController.text);
                          if(res){
                            AppRoute.go(AppRoute.login, popAll: true);
                          }
                        }
                      }, child: const Text("Reset Password"))
                    ],
                  ),
                  ),
              )
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
    );
  }
}