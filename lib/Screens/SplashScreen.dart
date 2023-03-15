import 'package:admins/Screens/TypesScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => TypesScreen()),
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
