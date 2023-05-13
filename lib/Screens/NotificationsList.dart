import 'package:rayto/Models/Notification.dart';
import 'package:rayto/Models/User.dart';
import 'package:rayto/Screens/EmployeeHomePage.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key, required this.user});
  final User user;

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  List<Notifications>? notification = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await API.getNotifications(updateNotificationsState);
  }

  void updateNotificationsState(List<Notifications> loadedNotifications) {
    setState(() {
      notification = loadedNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.Yellow,
        onPressed: () {
          _showDialog();
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      backgroundColor: Constant.White,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                EmployeeHomePage(user: widget.user)),
                          ));
                    },
                    child: const FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                  const Text(
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
                    padding: const EdgeInsets.all(16),
                    child: FutureBuilder(
                        future: API.getNotifications((p0) => null),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.transparent,
                              ),
                              itemBuilder: (context, index) {
                                return _listTile(index);
                              },
                              itemCount: notification!.length,
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const Center(
                              child: Text(
                                "لا يوجد اشعارات",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                        })))
          ],
        ),
      ),
    );
  }

  _listTile(int index) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                    Text(notification![index].date,
                        style: TextStyle(color: Constant.White))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(notification![index].title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Constant.White)),
                  Text(notification![index].content,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(247, 239, 234, 0.5)))
                ],
              ))
            ],
          )),
          const SizedBox(width: 10),
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
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "اضافة",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
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
                            const SizedBox(height: 20),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (titleController.text.isNotEmpty &&
                                  detailsController.text.isNotEmpty) {
                                _showToast(await API.addNotification(
                                    titleController.text,
                                    detailsController.text));
                              }
                              Navigator.of(context).pop();
                              titleController.text = "";
                              detailsController.text = '';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Constant.Yellow,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
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
                      )
                    ]),
              ));
        });
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
