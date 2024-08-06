import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/services/storage_service.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final model = serviceLocator<AuthViewModel>();
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
              NetworkImageWidget(url: model.user?.avatar ?? '', name: model.user?.firstName ?? "CC"),
              const SizedBox(height: 16,),
              Text("${model.user?.firstName} ${model.user?.lastName}", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const SizedBox(height: 8,),
              Text("@${model.user?.userName}", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
              const SizedBox(height: 24,),

              _profileAction(Icon(Icons.person, color: grey900,), "Edit profile", ()=>AppRoute.go(AppRoute.editProfilePage)),
              _profileAction(Icon(Icons.lock, color: grey900,), "Change password", ()=>AppRoute.go(AppRoute.changePasswordPage)),
              _profileAction(
                Icon(Icons.logout_rounded, color: error400,), 
                "Sign out", 
                (){
                  AppRoute.go(AppRoute.login, popAll: true);
                  serviceLocator<StorageService>().clearToken("token");
                }),
            ],
          ),
        )
      ),
    );
  }

  Widget _profileAction(Icon icon, String title, void Function() function){
    return InkWell(
      onTap: function,
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