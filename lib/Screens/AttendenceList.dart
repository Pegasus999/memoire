import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendenceList extends StatefulWidget {
  const AttendenceList({super.key});

  @override
  State<AttendenceList> createState() => _AttendenceListState();
}

class _AttendenceListState extends State<AttendenceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                  Text(
                    "الغيابات",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox()
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.transparent,
                ),
                itemBuilder: (context, index) {
                  return _listTile();
                },
                itemCount: 4,
              ),
            ))
          ],
        ),
      ),
    );
  }

  _listTile() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Constant.Green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(16),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Constant.Yellow,
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: Constant.White,
                ),
              )),
          Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "اسم الطفل",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constant.White),
                ),
              ],
            )),
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Constant.Creamy,
                  backgroundImage: AssetImage("assets/images/Girl.png"))),
        ],
      ),
    );
  }
}
