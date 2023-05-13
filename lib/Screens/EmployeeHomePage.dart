import 'package:rayto/Models/User.dart';
import 'package:rayto/Screens/AttendenceList.dart';
import 'package:rayto/Screens/EmployeesList.dart';
import 'package:rayto/Screens/LoginScreen.dart';
import 'package:rayto/Screens/NotificationsList.dart';
import 'package:rayto/Screens/SubsPage.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key, required this.user});
  final User user;
  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.White,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "مرحبا، ${widget.user.name}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Constant.Background,
                    child: !widget.user.picture.contains("assets/images/")
                        ? Image.network(widget.user.picture)
                        : widget.user.gender == "FEMALE"
                            ? Image.asset("assets/images/FemaleEmployee.png")
                            : Image.asset("assets/images/MaleEmployee.png"),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _card(
                          "المشتركين",
                          "assets/images/Subs.jpg",
                          context,
                          SubsPage(
                            user: widget.user,
                          )),
                      const SizedBox(height: 20),
                      _card("الموظفين", "assets/images/Employees.jpg", context,
                          EmployeesList(user: widget.user))
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _card("الغيابات", "assets/images/Attendence.jpg", context,
                          AttendenceList(user: widget.user)),
                      const SizedBox(height: 20),
                      _card("الإشعارات", "assets/images/Notification.jpg",
                          context, NotificationsList(user: widget.user))
                    ],
                  ),
                ],
              ),
            )),
            Container(
              color: Constant.White,
              child: Center(
                  child: Container(
                      width: 160,
                      height: 75,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Constant.Background,
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen()),
                            (Route<dynamic> route) =>
                                false, // Remove all the routes in the stack
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.rightFromBracket,
                              color: Constant.Red,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Constant.Red),
                            ),
                          ],
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }

  _card(String label, String picture, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(picture),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(color: Constant.Red, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
