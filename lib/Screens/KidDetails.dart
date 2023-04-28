import 'dart:convert';
import 'package:admins/Models/Kid.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class KidDetailScreen extends StatefulWidget {
  const KidDetailScreen({super.key, required this.kid});
  final Kid kid;
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.arrowLeft),
                          ))
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.kid.name} ${widget.kid.lastname}",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            "تاريخ الميلاد : ${DateFormat('dd/MM/yyyy').format(widget.kid.birthday)}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            "${widget.kid.zone.name}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            "المستوى : ${widget.kid.grade}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.kid.position}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.green[300]),
                              ),
                              FaIcon(FontAwesomeIcons.locationDot)
                            ],
                          )
                        ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(widget.kid.picture),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.kid.flag != null
                    ? ListView.builder(
                        itemCount: widget.kid.flag?.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 150,
                            margin: EdgeInsets.only(top: 20),
                            width: 100,
                            decoration: BoxDecoration(
                                color: Constant.Blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${widget.kid.flag![index].title}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "${widget.kid.flag![index].details}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
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
                        })
                    : Center(
                        child: Text("No Flags"),
                      )))
      ],
    )));
  }
}
