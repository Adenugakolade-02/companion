import 'package:caution_companion/data/models/user_model.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthViewModel model = serviceLocator<AuthViewModel>();
  late TextEditingController fName;
  late TextEditingController lName;
  late TextEditingController uName;
  late TextEditingController email;
  late TextEditingController phone;

  @override
  void initState() {
    fName = TextEditingController(text: model.user?.firstName ??'');
    lName = TextEditingController(text: model.user?.lastName ??'');
    uName = TextEditingController(text: model.user?.userName ??'');
    email = TextEditingController(text: model.user?.email ??'');
    phone = TextEditingController(text: model.user?.phone ??'');
    super.initState();
  }

  @override
  void dispose() {
    fName.dispose();
    lName.dispose();
    uName.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>AppRoute.pop(), 
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            Center(
              child: Container(
                height: 146,
                width: 146,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: grey900
                ),
              ),
            ),
            const SizedBox(height: 40,),
            EditFormField(title: 'First Name', controller: fName),
            EditFormField(title: 'Last Name', controller: lName),
            EditFormField(title: 'UserName', controller: uName),
            EditFormField(title: 'Email', controller: email),
            EditFormField(title: 'Phone', controller: phone),

            const SizedBox(height: 10,),

            ElevatedButton(onPressed: (){}, child: const Text("Save Information"))
          ],
        )
      ),
    );
  }
}


class EditFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const EditFormField({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
        const SizedBox(height: 4,),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: grey300
              )
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: grey300
              )
            )
          ),
        ),
        const SizedBox(height: 24,)
      ],
    );
  }
}