import 'dart:async';

import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("MaND") == null ||
        sharedPreferences.getString("MaND") == "") {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AppScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Image.asset('assets/images/img_splash.png'),
              LoadingAnimationWidget.discreteCircle(
                color: Colors.blueAccent,
                size: 45,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
