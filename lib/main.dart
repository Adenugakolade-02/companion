import 'package:caution_companion/config/router.dart';
import 'package:caution_companion/config/theme.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/pages/authentication/login_page.dart';
import 'package:caution_companion/pages/home/homepage.dart';
import 'package:caution_companion/services/navigator_service.dart';
import 'package:caution_companion/utils/app_aware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppAware(
      child: Portal(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeClass.lightTheme,
          // home: const HomePage(),
          home: FutureBuilder(
            future: serviceLocator<AuthViewModel>().getUser(), 
            builder: (_, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.data==true){
                  return HomePage();
                }else{
                  return const LoginPage();
                }
              }else{
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator.adaptive()));
              }
            }
          ),
          navigatorKey: serviceLocator<NavigatorService>().navigatorKey,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
