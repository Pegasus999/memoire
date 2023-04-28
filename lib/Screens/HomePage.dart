import 'dart:convert';
import 'dart:ui';
import 'package:admins/Models/Kid.dart';
import 'package:admins/Models/Notification.dart';
import 'package:admins/Models/User.dart';
import 'package:admins/Screens/EmployeeScreen.dart';
import 'package:admins/Screens/RegisterScreen.dart';
import 'package:admins/Services/Api.dart';
import 'package:flutter/material.dart';
import 'package:admins/Screens/KidsScreen.dart';
import 'package:admins/Screens/LoginScreen.dart';
import 'package:admins/Screens/NotificationScreen.dart';
import 'package:admins/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<HomePage> createState() => _KidsListScreenState();
}

class _KidsListScreenState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool search = false;
  bool _showPopup = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  String selected = "List";
  List<Kid>? kids;
  List<Notifications>? notifications;
  List<User>? users;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void updateNotificationsState(List<Notifications> loadedNotif) {
    setState(() {
      notifications = loadedNotif;
    });
  }

  void updateUsersState(List<User> loadedUsers) {
    setState(() {
      users = loadedUsers;
    });
  }

  void updateKidsState(List<Kid> loadedKids) {
    setState(() {
      kids = loadedKids;
    });
  }

  Future<void> loadData() async {
    final loadedKids = await API.getKids(updateKidsState);
    final loadedUsers = await API.getUsers(updateUsersState);
    final loadedNotifications =
        await API.getNotifications(updateNotificationsState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: selected == "Notification" && !_showPopup
            ? FloatingActionButton(
                backgroundColor: Constant.Blue,
                onPressed: () {
                  _MyAlert();
                },
                child: FaIcon(FontAwesomeIcons.plus),
              )
            : null,
        key: _scaffoldKey,
        backgroundColor: Constant.Background,
        endDrawer: SafeArea(
          child: Drawer(
            backgroundColor: Colors.white,
            child: _buildDrawer(),
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.09,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 2.0,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: selected == "List" || selected == "Employee",
                    child: Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          search = !search;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          FaIcon(FontAwesomeIcons.magnifyingGlass),
                          SizedBox(width: 10),
                          Visibility(
                              visible: search,
                              child: _buildInputField("اسم", false))
                        ]),
                      ),
                    )),
                  ),
                  Text(
                    selected == "List"
                        ? "قائمة الاطفال"
                        : selected == "Notification"
                            ? "الاشعارات"
                            : "قائمة الموظفين",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      )),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FutureBuilder(
                future: selected == "List"
                    ? API.getKids(updateKidsState)
                    : selected == "Notification"
                        ? API.getNotifications(updateNotificationsState)
                        : API.getUsers(updateUsersState),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return selected == "List"
                            ? KidsScreen(kid: kids![index])
                            : selected == "Notification"
                                ? NotificationScreen(
                                    notification: notifications![index],
                                  )
                                : EmployeeScreen(user: users![index]);
                      },
                      itemCount: selected == "List"
                          ? kids != null
                              ? kids!.length
                              : 0
                          : selected == "Notification"
                              ? notifications != null
                                  ? notifications!.length
                                  : 0
                              : users != null
                                  ? users!.length
                                  : 0,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Text(
                        selected == "List"
                            ? "No kids Found"
                            : selected == "Notification"
                                ? "No Notifications Found"
                                : "No Users Found",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                },
              ),
            )
          ]),
        ));
  }

  _buildDrawer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.35,
          decoration: BoxDecoration(
            color: Constant.Blue,
          ),
          child: Column(children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.user.name} ${widget.user.lastname}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 50, // set the radius as per your requirement
                      backgroundImage:
                          NetworkImage("https://picsum.photos/130"),
                    )
                  ],
                ),
              ),
            ),
            widget.user.auth == "EMPLOYEE"
                ? Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "عدد الاطفال",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => RegisterScreen(
                                          user: widget.user,
                                        ))));
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.user,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "اضافة مستخدم",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ]),
                        )
                      ],
                    ))
          ]),
        ),
        Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.5,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTile('قائمة الاطفال', "List"),
                SizedBox(height: 20),
                _buildTile('قائمة الموظفين', "Employee"),
                SizedBox(height: 20),
                _buildTile("الاشعارات", "Notification")
              ]),
        ),
        Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.15,
          child: Center(
              child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 2))),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
                },

                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.red[400]),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    elevation: MaterialStatePropertyAll(0)),
                icon: Icon(Icons.logout),
                label: Text(
                  'تسحيل الخروج',
                  style: TextStyle(
                      color: Colors.red[400],
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ), // <-- Text
              ),
            ),
          )),
        )
      ],
    );
  }

  _buildTile(String label, String key) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = key;
        });
      },
      child: Container(
        width: 270,
        height: 55,
        padding: EdgeInsets.only(right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${label}',
              style: TextStyle(
                  color: selected == key ? Colors.white : Constant.Blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        decoration: selected == key
            ? BoxDecoration(
                color: Constant.Blue,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(16)))
            : BoxDecoration(
                border: Border.all(color: Constant.Blue),
                borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  }

  _buildInputField(String label, bool pass) {
    return (Container(
        width: 100,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              style: TextStyle(color: Colors.white),
              obscureText: pass,
              decoration: InputDecoration(
                  label: Text(label),
                  labelStyle: TextStyle(color: Colors.black)),
            ))));
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

  _MyAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                        "اضافة اشعار",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                                width: 300,
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: titleController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          label: Text('عنوان الاشعار'),
                                          labelStyle:
                                              TextStyle(color: Colors.black)),
                                    ))),
                            SizedBox(height: 20),
                            Container(
                                width: 300,
                                height: 140,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: detailsController,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      label: Text(
                                        "تفاصيل",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
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
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Constant.Background,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              width: 60,
                              height: 40,
                              child: Center(
                                  child: Text(
                                "تاكيد",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
}
