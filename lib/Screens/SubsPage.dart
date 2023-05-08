import 'package:rayto/Screens/KidsList.dart';
import 'package:rayto/Screens/ParentsList.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubsPage extends StatefulWidget {
  const SubsPage({super.key});

  @override
  State<SubsPage> createState() => _SubsPageState();
}

class _SubsPageState extends State<SubsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.White,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: FaIcon(FontAwesomeIcons.arrowLeft)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                  ),
                  Text(
                    "المشتركين",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParentsList()));
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
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/Parents.jpg"),
                          SizedBox(height: 10),
                          Text(
                            "الأولياء",
                            style: TextStyle(color: Constant.Red, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => KidsList()));
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
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/Kids.jpg"),
                          SizedBox(height: 10),
                          Text(
                            "الأطفال",
                            style: TextStyle(color: Constant.Red, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        )));
  }
}
