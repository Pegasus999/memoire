import 'package:admins/Screens/LoginScreen.dart';
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
    Timer(
        Duration(seconds: 3),
        () => {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
              ),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SvgPicture.asset(
      'assets/images/logo.svg',
      semanticsLabel: 'logo',
    ));
  }
}
