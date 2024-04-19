import 'package:caution_companion/config/theme.dart';
import 'package:caution_companion/pages/authentication/login_page.dart';
import 'package:caution_companion/pages/home/home_screen.dart';
import 'package:caution_companion/pages/home/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      home: const HomePage()
    );
  }
}
