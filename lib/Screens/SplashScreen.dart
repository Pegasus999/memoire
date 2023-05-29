import 'package:rayto/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _loading();
    Timer(const Duration(seconds: 3), () => _redirectLogin());
  }

  _redirectLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 150,
      height: 150,
      child: Image.asset(
        'assets/images/logo.png',
      ),
    ));
  }
}
