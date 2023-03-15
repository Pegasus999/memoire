import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constant.dart';

class KidsScreen extends StatefulWidget {
  const KidsScreen({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<KidsScreen> createState() => _KidsScreenState();
}

class _KidsScreenState extends State<KidsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 8),
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.2,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: Constant.Blue,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Container(
                height: 100,
                padding: EdgeInsets.only(right: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "أسم الطفل",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // callNumber("tel:+213556996758");
                            },
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.green[400],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.phone,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text("0556996758")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "سيدي عمار",
                            style: TextStyle(fontSize: 15),
                          ),
                          Icon(Icons.location_pin)
                        ],
                      )
                    ]),
              )),
          Expanded(
              flex: 1,
              child: Center(
                  child: CircleAvatar(
                radius: 50, // set the radius as per your requirement
                backgroundImage: NetworkImage("https://picsum.photos/130"),
              )))
        ]),
      ),
    );
  }
}
