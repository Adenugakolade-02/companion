import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class ResetPageTwo extends StatefulWidget {
  const ResetPageTwo({super.key});

  @override
  State<ResetPageTwo> createState() => _ResetPageTwoState();
}

class _ResetPageTwoState extends State<ResetPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 79,),
              Text("Reset Password", style: TextStyle(fontSize: 24, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
              const SizedBox(height: 8,),
              Text("Please enter a new password", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),

              kFormField(hintText: "New password", controller: TextEditingController(), prefixIcon: Icon(Icons.email_outlined, color: warning400,),),
              const SizedBox(height: 24,),
              kFormField(hintText: "Confirm password", controller: TextEditingController(), prefixIcon: Icon(Icons.lock, color: warning400,),),

              const SizedBox(height: 40,),

              ElevatedButton(onPressed: (){}, child: const Text("Send OTP code"))
            ],
          ),
          )
      ),
    );;
  }
}