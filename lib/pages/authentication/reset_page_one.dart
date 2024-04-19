import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class ResetPageone extends StatefulWidget {
  const ResetPageone({super.key});

  @override
  State<ResetPageone> createState() => _ResetPageoneState();
}

class _ResetPageoneState extends State<ResetPageone> {
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
              Text("You will receive instructions for resetting your password", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
              const SizedBox(height: 60,),
              kFormField(hintText: "Enter your email address", controller: TextEditingController(), prefixIcon: Icon(Icons.email_outlined, color: warning400,),),

              const SizedBox(height: 40,),

              ElevatedButton(onPressed: (){}, child: const Text("Send OTP code"))
            ],
          ),
          )
      ),
    );
  }
}