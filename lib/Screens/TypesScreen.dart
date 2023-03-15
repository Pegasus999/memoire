import 'package:admins/Screens/LoginScreen.dart';
import 'package:admins/Screens/RegisterScreen.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key});

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
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
                          "نوع الحساب",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterScreen()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Constant.Background,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  height: 150,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.building,
                                    size: 80,
                                  )),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "روضة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Constant.Background,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  height: 150,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.userTie,
                                    size: 80,
                                  )),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "موظف",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
    ));
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
