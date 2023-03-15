import 'package:flutter/material.dart';

import '../constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
              flex: 3,
              child: Container(
                height: 150,
                padding: EdgeInsets.only(right: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20/03/2023",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'عنوان الاشعار',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "هذا مكان تفاصيل الاشعارت",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ]),
              )),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.notifications,
              size: 70,
            ),
          )
        ]),
      ),
    );
  }
}
