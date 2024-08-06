import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPageone extends StatefulWidget {
  const ResetPageone({super.key});

  @override
  State<ResetPageone> createState() => _ResetPageoneState();
}

class _ResetPageoneState extends State<ResetPageone> {
  late TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  final AuthViewModel model = serviceLocator<AuthViewModel>();

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
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
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 79,),
                      Text("Reset Password", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                      const SizedBox(height: 8,),
                      Text("You will receive instructions for resetting your password", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500,), textAlign: TextAlign.center,),
                      const SizedBox(height: 60,),
                      kFormField(hintText: "Enter your email address", controller: controller, prefixIcon: Icon(Icons.email_outlined, color: warning400,), validator: emailValidator,),
                  
                      const SizedBox(height: 40,),
                  
                      ElevatedButton(onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          final res = await model.forgotPassword(email: controller.text);
                          if(res){
                            AppRoute.go(AppRoute.otpPage);
                          }
                        }
                      }, child: const Text("Send OTP code"))
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
          )
        ),
      ),
    );
  }
}