import 'dart:convert';
import 'package:rayto/Models/User.dart';
import 'package:rayto/Services/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rayto/constant.dart';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPopup = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            color: Constant.White,
            height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/background.png',
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
                child: Container(
              width: 350,
              height: 250,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _input("اسم المستخدم", usernameController, false),
                    _input("كلمة السر", passwordController, true),
                    GestureDetector(
                        onTap: () {
                          _login();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Constant.Yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          height: 50,
                          width: 250,
                          child: Center(
                              child: Text(
                            "دخول",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Constant.White,
                                fontSize: 20),
                          )),
                        ))
                  ]),
            )),
          )
        ],
      ),
    )));
  }

  _login() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      await API.login(
          usernameController.text, passwordController.text, context);
    } else {
      Fluttertoast.showToast(msg: "الرجاء ادخال معلومات");
    }
  }

  _input(String hint, TextEditingController controller, bool pass) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      height: 50,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Constant.Creamy),
          obscureText: pass,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintText: hint,
              hintStyle: TextStyle(color: Constant.Creamy)),
        ),
      ),
    );
  }
}
