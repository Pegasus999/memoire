import 'package:admins/Models/User.dart';
import 'package:admins/Screens/DriversList.dart';
import 'package:admins/Screens/LoginScreen.dart';
import 'package:admins/Services/Api.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key, required this.user});
  final User user;
  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  List<Map<String, dynamic>> icons = [
    {
      "icon": FaIcon(
        FontAwesomeIcons.house,
        size: 100,
        color: Colors.black,
      ),
      "text": Text(
        "في المنزل",
        style: TextStyle(color: Color.fromRGBO(40, 3, 43, 1), fontSize: 60),
      ),
      "position": "HOME"
    },
    {
      "icon": FaIcon(
        FontAwesomeIcons.truck,
        size: 100,
        color: Colors.black,
      ),
      "text": Text(
        "في الطريق",
        style: TextStyle(color: Color.fromRGBO(159, 49, 46, 1), fontSize: 60),
      ),
      "position": "ROAD"
    },
    {
      "icon": FaIcon(
        FontAwesomeIcons.faceSmile,
        size: 100,
        color: Colors.black,
      ),
      "text": Text(
        "في الروضة",
        style: TextStyle(color: Color.fromRGBO(60, 222, 87, 1), fontSize: 60),
      ),
      "position": "DAYCARE"
    },
    {
      "icon": FaIcon(
        FontAwesomeIcons.truck,
        size: 100,
        color: Colors.black,
      ),
      "text": Text(
        "في الطريق",
        style: TextStyle(color: Color.fromRGBO(159, 49, 46, 1), fontSize: 60),
      ),
      "position": "ROAD"
    },
  ];
  int state = 0;

  _handleState() async {
    if (state == 3) {
      setState(() {
        state = 0;
      });
    } else {
      setState(() {
        state++;
      });
    }
    String message = await API.updateAllPosition(
        icons[state]['position'], widget.user.zone!.name);

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.Background,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    "5",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )),
                  flex: 1,
                ),
                Expanded(
                    child: Center(
                        child: Text(
                      "${widget.user.zone!.name}",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    )),
                    flex: 5),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DriversList())));
                        },
                        child: FaIcon(FontAwesomeIcons.list),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icons[state]["text"],
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _handleState();
                  },
                  child: Container(
                    child:
                        CircleAvatar(radius: 150, child: icons[state]["icon"]),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LoginScreen())));
            },
            style: ButtonStyle(
                iconColor: MaterialStatePropertyAll(Colors.red[400]),
                backgroundColor: MaterialStatePropertyAll(Constant.Background),
                elevation: MaterialStatePropertyAll(0)),
            icon: FaIcon(FontAwesomeIcons.rightFromBracket),
            label: Text(
              'تسحيل الخروج',
              style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ), // <-- Text
          ),
        ],
      )),
    );
  }
}
