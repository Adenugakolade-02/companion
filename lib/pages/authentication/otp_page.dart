import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final AuthViewModel model = serviceLocator<AuthViewModel>();
  
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;
  late TextEditingController controller5;
  late TextEditingController controller6;

  bool hasError = false;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
    controller6 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 79,),
                    Text("OTP Page", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                    const SizedBox(height: 8,),
                    Text("Enter OTP code sent ", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
                    const SizedBox(height: 60,),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OTPFormField(controller: controller1, hasError: hasError, hasFocus: true,),
                        OTPFormField(controller: controller2, hasError: hasError),
                        OTPFormField(controller: controller3, hasError: hasError),
                        OTPFormField(controller: controller4, hasError: hasError),
                        OTPFormField(controller: controller5, hasError: hasError),
                        OTPFormField(controller: controller6, hasError: hasError),
                      ],
                    ),
    
                    // kFormField(hintText: "Enter your email address", controller: TextEditingController(), prefixIcon: Icon(Icons.email_outlined, color: warning400,),),
    
                    const SizedBox(height: 40,),
    
                    ElevatedButton(onPressed: () async{
                      final otpcode = controller1.text + controller2.text + controller3.text + controller4.text + controller5.text + controller6.text;
                      final res = await model.verifyToken(token: otpcode);
                      if(res){
                        model.otpCode = otpcode;
                        AppRoute.go(AppRoute.resetPageTwo);
                      }else{
                        hasError = true;
                        setState(() {
                          
                        });
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