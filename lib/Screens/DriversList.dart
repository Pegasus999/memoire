import 'package:admins/Models/Kid.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriversList extends StatefulWidget {
  const DriversList({super.key});

  @override
  State<DriversList> createState() => _DriversListState();
}

// TODO: request the list of kids in the related zone , and figure out how to update their position per click , also remove the place holders
class _DriversListState extends State<DriversList> {
  int state = 0;
  List<Kid>? kids = [];
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                    flex: 1,
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                        "سيدي عمار",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      )),
                      flex: 5),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: FaIcon(FontAwesomeIcons.layerGroup),
                        ),
                      ))
                ],
              ),
            ),
            Expanded(child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildTile();
              },
            ))
          ],
        ),
      ),
    );
  }

  _handleClick(int index) {
    if (state != index) {
      setState(() {
        state = index;
      });
    } else {
      setState(() {
        state = 0;
      });
    }
  }

  _buildTile() {
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _handleClick(1);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.truck,
                              color: state == 1 ? Colors.red : null,
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              _handleClick(2);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: state == 2 ? Colors.red : null,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            ],
                          )
                        ]),
                  ],
                ),
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
