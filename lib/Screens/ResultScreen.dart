import 'package:admins/Screens/HomePage.dart';
import 'package:admins/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.user});
  final user;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(
                          user: widget.user,
                        )),
              ),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Account added succefully"),
    );
  }
}
