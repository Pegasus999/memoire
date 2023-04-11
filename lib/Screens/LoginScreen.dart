import 'dart:convert';
import 'package:admins/Models/User.dart';
import 'package:admins/Screens/DriverScreen.dart';
import 'package:admins/Screens/HomePage.dart';
import 'package:admins/Screens/RegisterScreen.dart';
import 'package:admins/Services/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admins/constant.dart';
import 'dart:ui';

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Constant.Background,
        body: SafeArea(
            child:
                Stack(children: [Center(child: _buildUi()), _buildPopUp()])));
  }

  _buildUi() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.all(8),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                semanticsLabel: 'logo',
                height: 50,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Constant.Blue,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    child: Center(
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      height: 300,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildInputField(
                                'اسم المستخدم',
                                false,
                                usernameController,
                              ),
                              SizedBox(height: 40),
                              _buildInputField(
                                  'كلمة السر', true, passwordController),
                              SizedBox(height: 60),
                              TextButton(
                                onPressed: () async => {
                                  await API.login(usernameController.text,
                                      passwordController.text, context)
                                  // _handleSubmit()
                                },
                                child: Text(
                                  "دخول",
                                  style: TextStyle(
                                      color: Constant.Blue,
                                      fontSize: 20,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700),
                                ),
                                style: ButtonStyle(
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(90, 40)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Constant.Background),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
                  SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.info,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _showPopup = true;
                          });
                        },
                      ),
                      Text(
                        'لا تمنلك حساب؟',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]);
  }

  _buildInputField(String label, bool pass, TextEditingController controller) {
    return (Container(
        width: 300,
        height: 50,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: controller,
              style: TextStyle(color: Colors.white),
              obscureText: pass,
              decoration: InputDecoration(
                  label: Text(label),
                  labelStyle: TextStyle(color: Colors.white)),
            ))));
  }

  _buildPopUp() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _showPopup ? 1.0 : 0.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showPopup = false;
          });
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Visibility(
              visible: _showPopup,
              child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Constant.Background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPopup = false;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                size: 30,
                              ),
                            ),
                            width: 50,
                            height: 40,
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "اذا كنت لا تملك حساب الرجاء التواصل مع ادارة الروضة التي تستعمل تطبيق من اجل فتح حساب",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: ((context) => RegisterScreen())));
  }
}
