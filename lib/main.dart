import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gameon_active/screens/login_screen.dart';
import 'package:gameon_active/config/app_copy.dart';
import 'package:gameon_active/config/app_theme.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}

void main() {
  runApp(const GameOnActiveApp());
}

class GameOnActiveApp extends StatelessWidget {
  const GameOnActiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppCopy.appName,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: ThemeData(
        primarySwatch: AppTheme.primaryColor,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

