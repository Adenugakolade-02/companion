import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height/12,
              ),
              _imageProfileContainer(),
              const SizedBox(height: 16,),
              Text("Kalu Udochukwu", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const SizedBox(height: 8,),
              Text("@kalu10", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),

              _profileAction(Icon(Icons.person, color: grey900,), "Edit profile", (){}),
              _profileAction(Icon(Icons.lock, color: grey900,), "Change password", (){}),
              _profileAction(Icon(Icons.share, color: grey900,), "Share location", (){}),
              _profileAction(Icon(Icons.logout_rounded, color: error400,), "Sign out", (){}),
            ],
          ),
        )
      ),
    );
  }

  Widget _imageProfileContainer(){
    return Container(
      height: 146,
      width: 146,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: grey900
      ),
    );
  }

  Widget _profileAction(Icon icon, String title, Function function){
    return InkWell(
      onTap: function.call(),
      child: Container(
        width: double.infinity,
        height: 56,
        margin: const EdgeInsets.only(bottom: 28),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: icon,
            ),
            const SizedBox(width: 16,),
            Text(title, style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),)
          ],
        ),
      ),
    );
  }
}