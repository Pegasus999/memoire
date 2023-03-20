import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KidDetailScreen extends StatefulWidget {
  const KidDetailScreen({super.key});

  @override
  State<KidDetailScreen> createState() => _KidDetailScreenState();
}

class _KidDetailScreenState extends State<KidDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            decoration: BoxDecoration(
                color: Constant.Blue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: FaIcon(FontAwesomeIcons.arrowLeft))
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "اسم",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Text(
                              "تاريخ الميلاد : 2002/11/17",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              "العنوان : سيدي عمار",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              "المستوى : الاولى",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "في الروضة",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.green[300]),
                                ),
                                Icon(Icons.location_pin)
                              ],
                            )
                          ]),
                    ),
                    Expanded(
                        flex: 4,
                        child: Center(
                          child: CircleAvatar(radius: 60),
                        ))
                  ],
                ))
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 4,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 20),
                    width: 100,
                    decoration: BoxDecoration(
                        color: Constant.Blue,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "!حساسية",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "تفاصيل الحساسية",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ]),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.flag,
                                size: 50,
                              )),
                            ))
                      ],
                    )),
                  );
                }),
          ))
        ],
      )),
    );
  }
}
