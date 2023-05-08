import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.Yellow,
        onPressed: () {
          _showDialog();
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
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
                    "الاشعارات",
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
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Constant.Green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("22/03/2023", style: TextStyle(color: Constant.White))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("عنوان الاشعار",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Constant.White)),
                  Text("تفاصيل الاشعار",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(247, 239, 234, 0.5)))
                ],
              ))
            ],
          )),
          SizedBox(width: 10),
          Image.asset(
            "assets/images/Notification.png",
            height: 80,
          ),
        ],
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Constant.White,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اضافة",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              height: 50,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: titleController,
                                  style: TextStyle(color: Constant.Creamy),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      hintText: "العنوان",
                                      hintStyle: TextStyle(
                                          color: Constant.Creamy,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              width: 300,
                              height: 140,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: detailsController,
                                  maxLines: 4,
                                  maxLength: 50,
                                  style: TextStyle(color: Constant.Creamy),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      hintText: "المحتوى",
                                      hintStyle: TextStyle(
                                          color: Constant.Creamy,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (titleController.text.isNotEmpty &&
                                  detailsController.text.isNotEmpty)
                                _showToast(await API.addNotification(
                                    titleController.text,
                                    detailsController.text));
                              Navigator.of(context).pop();
                              titleController.text = "";
                              detailsController.text = '';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Constant.Yellow,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              width: 60,
                              height: 40,
                              child: Center(
                                  child: Text(
                                "اضافة",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constant.White),
                              )),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      )
                    ]),
              ));
        });
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: "${message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
