import 'package:caution_companion/pages/authentication/login_page.dart';
import 'package:caution_companion/pages/authentication/otp_page.dart';
import 'package:caution_companion/pages/authentication/register_page.dart';
import 'package:caution_companion/pages/authentication/reset_page_one.dart';
import 'package:caution_companion/pages/authentication/reset_page_two.dart';
import 'package:caution_companion/pages/home/home_screen.dart';
import 'package:caution_companion/pages/report/create_report_page.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case AppRoute.homeScreen:
        return _buildRoute(const HomeScreen());
      case AppRoute.login:
        return _buildRoute(const LoginPage());
      case AppRoute.registerPage:
        return _buildRoute(const RegisterPage());
      case AppRoute.resetPageone:
        return _buildRoute(const ResetPageone());
      case AppRoute.resetPageTwo:
        return _buildRoute(const ResetPageTwo());
      case AppRoute.otpPage:
        return _buildRoute(const OTPPage());
      case AppRoute.createReportPage:
        return _buildRoute(const CreateReportPage());
      default:
        return _buildRoute(const Scaffold(
          body: Center(child: Text('Invalid route reached.'),),
      ));
    }
  }
}


Widget _transitionHandler(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var begin = const Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return FadeTransition(opacity: animation, child: SlideTransition(position: animation.drive(tween), child: child,),);
  }

  Duration _forward() {
    return const Duration(milliseconds: 200);
  }

  Duration _reverse() {
    return const Duration(milliseconds: 200);
  }

  PageRouteBuilder _buildRoute(Widget child, { RouteSettings? settings }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: _transitionHandler, transitionDuration: _forward(), reverseTransitionDuration: _reverse(),
    );
  }