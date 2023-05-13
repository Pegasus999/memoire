import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:rayto/Models/Kid.dart";
import "package:rayto/Models/User.dart";
import "package:rayto/Screens/LoginScreen.dart";
import "package:rayto/Screens/NotificationsList.dart";
import "package:rayto/Services/Api.dart";
import "package:rayto/constant.dart";

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key, required this.parent});
  final User parent;
  @override
  State<ParentHomePage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentHomePage> {
  List<Kid>? kids = [];
  List<Kid>? abscentKids = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final kids = await API.getMine(updateKidsState, widget.parent.id);
    final now = DateTime.now();

// Check if it's morning or evening
    final isMorning = now.hour < 12;
    for (var kid in kids!) {
      if (isMorning) {
        if (!kid.morningPresent) {
          setState(() {
            abscentKids!.add(kid);
          });
        }
      } else {
        if (!kid.eveningPresent) {
          setState(() {
            abscentKids!.add(kid);
          });
        }
      }
    }
  }

  void updateKidsState(List<Kid> loadedKids) {
    setState(() {
      kids = loadedKids;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.White,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const LoginScreen()),
                        ),
                      );
                    },
                    child: FaIcon(FontAwesomeIcons.rightFromBracket,
                        color: Constant.Red, size: 30),
                  )
                ],
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                const SizedBox(height: 50),
                widget.parent.picture.contains("assets/images")
                    ? CircleAvatar(
                        radius: 60,
                        backgroundColor: Constant.Background,
                        backgroundImage: AssetImage(widget.parent.picture),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(widget.parent.picture),
                      ),
                const SizedBox(height: 30),
                Text(
                  "${widget.parent.name} ${widget.parent.lastname}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (abscentKids != null &&
                                  abscentKids!.isNotEmpty) _alert();
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      child: Image.asset(
                                        "assets/images/ex.png",
                                      ),
                                    ),
                                    Text(
                                      "انذار",
                                      style: TextStyle(
                                          color: Constant.Red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => NotificationsList(
                                        user: widget.parent,
                                      )),
                                ),
                              );
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 100,
                                        child: Image.asset(
                                            "assets/images/Notification.png")),
                                    SizedBox(height: 10),
                                    Text(
                                      "الاشعارات",
                                      style: TextStyle(
                                          color: Constant.Red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10)
                                  ]),
                            ),
                          )
                        ],
                      ),
                      abscentKids != null && abscentKids!.isNotEmpty
                          ? Positioned(
                              top: 0,
                              left: 150,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${abscentKids!.length}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          : Container(),
                    ],
                  ),
                )
              ]),
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    child: FutureBuilder(
                        future: API.getMine((p0) => null, widget.parent.id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData && kids!.isNotEmpty) {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.transparent,
                              ),
                              itemBuilder: (context, index) {
                                return _listTile(index);
                              },
                              itemCount: kids!.length,
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const Center(
                              child: Text(
                                "لا يوجد اطفال",
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

  int daysUntil(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    return difference;
  }

  _listTile(int index) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Constant.Green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            margin: EdgeInsets.only(left: 16),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.calendarCheck),
                SizedBox(
                  height: 10,
                ),
                Text("${daysUntil(kids![index].subscription)}")
              ],
            ),
          ),
          Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${kids![index].name} ${widget.parent.lastname}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constant.White),
                ),
                _iconHandler(index),
              ],
            )),
          ),
          kids![index].picture.contains("assets/images")
              ? Container(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Constant.Creamy,
                      backgroundImage: AssetImage(kids![index].picture)))
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Constant.Creamy,
                      backgroundImage: NetworkImage(kids![index].picture))),
        ],
      ),
    );
  }

  _iconHandler(int index) {
    Widget icon = kids![index].position == 'في المنزل'
        ? FaIcon(
            FontAwesomeIcons.house,
            size: 35,
            color: Constant.Yellow,
          )
        : kids![index].position == "في الطريق"
            ? FaIcon(
                FontAwesomeIcons.bus,
                size: 35,
                color: Constant.Yellow,
              )
            : kids![index].position == "في الموؤسسة"
                ? FaIcon(
                    FontAwesomeIcons.school,
                    size: 35,
                    color: Constant.Yellow,
                  )
                : FaIcon(
                    FontAwesomeIcons.child,
                    size: 35,
                    color: Constant.Yellow,
                  );
    return icon;
  }

  _alert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constant.Background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('اختر', textAlign: TextAlign.center),
            content: SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                child: Container(
                  color: Constant.Background,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "لم يتم توصيل *${abscentKids!.first.name}* اين هو/هي؟",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _changePosition(0, "HOME");
                              },
                              child: FaIcon(
                                FontAwesomeIcons.house,
                                size: 35,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  _changePosition(0, "ROAD");
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.bus,
                                  size: 35,
                                  color: Colors.black,
                                )),
                            GestureDetector(
                                onTap: () {
                                  _changePosition(0, "DAYCARE");
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.child,
                                  size: 35,
                                  color: Colors.black,
                                )),
                            GestureDetector(
                              onTap: () {
                                _changePosition(0, "SCHOOL");
                              },
                              child: FaIcon(
                                FontAwesomeIcons.school,
                                size: 35,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ]),
                )),
          );
        });
  }

  _changePosition(int index, String icon) async {
    String newPosition = icon == "HOME"
        ? 'في المنزل'
        : icon == "ROAD"
            ? "في الطريق"
            : icon == "SCHOOL"
                ? "في الموؤسسة"
                : "في الروضة";

    final result = await API.updateSinglePosition(newPosition, kids![index].id);
    Fluttertoast.showToast(msg: result);
    setState(() {
      abscentKids!.removeLast();
    });
    Navigator.pop(context);
  }
}
