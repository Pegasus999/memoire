import 'dart:convert';

import 'package:admins/Models/User.dart';
import 'package:admins/Screens/HomePage.dart';
import 'package:admins/Screens/LoginScreen.dart';
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

  // _loading() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userStr = prefs.getString("user");
  //   print(userStr);
  //   if (userStr != "" && userStr != null) {
  //     final userJson = jsonDecode(userStr);
  //     User user = User.fromJson(userJson);
  //     _redirectHomePage(user);
  //   } else {
  //     Timer(Duration(seconds: 3), () => {_redirectLogin()});
  //   }
  // }

  _redirectLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
  }

  _redirectHomePage(User user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) => HomePage(user: user)),
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
