import 'dart:convert';
import 'package:rayto/Models/User.dart';
import 'package:rayto/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Timer(Duration(seconds: 3), () => {_redirectLogin()});
  }

  _redirectLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
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
