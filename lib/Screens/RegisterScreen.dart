import 'package:admins/Screens/TypesScreen.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.Blue,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                          child: Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: Text(
                      "تسجيل روضتك",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ))),
                  GestureDetector(
                    onTap: () {},
                    child: FaIcon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          Form(
              child: Column(
            children: [
              SizedBox(height: 20),
              _buildInputField("اسم الروضة", false),
              SizedBox(height: 20),
              _buildInputField("عنوان الروضة", false),
              SizedBox(height: 20),
              _buildInputField("رقم هاتف الروضة", false),
              SizedBox(height: 20),
              _buildInputField("بريد الالكتروني", false),
              SizedBox(height: 20),
              _buildInputField("الاسم", false),
              SizedBox(height: 20),
              _buildInputField("اللقب", false),
              SizedBox(height: 20),
              _buildInputField("اسم المستخدم", false),
              SizedBox(height: 20),
              _buildInputField("كلمة السر", false),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "تأكيد",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[400]),
                ),
                icon: FaIcon(FontAwesomeIcons.check, color: Colors.green[400]),
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(16, 8, 16, 8)),
                    backgroundColor:
                        MaterialStatePropertyAll(Constant.Background)),
              )
            ],
          ))
        ]),
      )),
    );
  }

  _buildInputField(String label, bool pass) {
    return (Container(
        width: 300,
        height: 50,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              style: TextStyle(color: Colors.white),
              obscureText: pass,
              decoration: InputDecoration(
                  label: Text(label),
                  labelStyle: TextStyle(color: Colors.white)),
            ))));
  }
}
