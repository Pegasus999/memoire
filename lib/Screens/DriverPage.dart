import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayto/Models/Kid.dart';
import 'package:rayto/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:rayto/Screens/LoginScreen.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key, required this.user});
  final User user;
  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  List<Kid>? kids;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await API.getZoneRelatedKids(updateKidsState, widget.user.zone!.name);
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const LoginScreen()),
                        ),
                      );
                    },
                    child: FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Constant.Red,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        const Text(
                          "الاطفال",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: () {
                              alert();
                            },
                            child: const FaIcon(FontAwesomeIcons.check)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: FutureBuilder(
                  future: API.getZoneRelatedKids(
                      (p0) => null, widget.user.zone!.name),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.transparent,
                        ),
                        itemBuilder: (context, index) {
                          return _listTile(index);
                        },
                        itemCount: kids!.length,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(
                        child: Text(
                          "لا يوجد الاطفال",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _listTile(int index) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Constant.Green,
      ),
      child: Column(
        children: [
          Text(
            "${kids![index].name} ${kids![index].lastname}",
            style: TextStyle(
                fontSize: 20,
                color: Constant.White,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 30,
                backgroundColor: Constant.Yellow,
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: Constant.White,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _changePosition(index, "HOME");
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Constant.Yellow,
                            child: FaIcon(
                              FontAwesomeIcons.house,
                              color: _handleIconColor(index, "في المنزل"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _changePosition(index, "DAYCARE");
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Constant.Yellow,
                            child: FaIcon(FontAwesomeIcons.child,
                                color: _handleIconColor(index, "في الروضة")),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _changePosition(index, "SCHOOL");
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Constant.Yellow,
                            child: FaIcon(
                              FontAwesomeIcons.schoolFlag,
                              color: _handleIconColor(index, "في الموؤسسة"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _changePosition(index, "ROAD");
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Constant.Yellow,
                            child: FaIcon(
                              FontAwesomeIcons.bus,
                              color: _handleIconColor(index, "في الطريق"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            kids![index].school,
                            style:
                                TextStyle(color: Constant.White, fontSize: 15),
                          ),
                          const SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.school,
                            color: Constant.White,
                            size: 20,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            kids![index].adress,
                            style:
                                TextStyle(color: Constant.White, fontSize: 15),
                          ),
                          const SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.house,
                            color: Constant.White,
                            size: 20,
                          )
                        ],
                      )
                    ]),
              ),
              kids![index].picture.contains("assets/images")
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Constant.Creamy,
                          backgroundImage: AssetImage(kids![index].picture)))
                  : Container(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Constant.Creamy,
                          backgroundImage: NetworkImage(kids![index].picture))),
            ],
          ),
        ],
      ),
    );
  }

  Color _handleIconColor(int index, String icon) {
    if (kids![index].position == icon) {
      return Constant.Red;
    } else {
      return Constant.White;
    }
  }

  _changePosition(int index, String icon) async {
    String newPosition = icon == "HOME"
        ? 'في المنزل'
        : icon == "ROAD"
            ? "في الطريق"
            : icon == "SCHOOL"
                ? "في الموؤسسة"
                : "في الروضة";
    final List<Kid> newList = [...?kids];
    newList[index].position = newPosition;
    setState(() {
      kids = newList;
    });
    final result = await API.updateSinglePosition(newPosition, kids![index].id);
    Fluttertoast.showToast(msg: result);
  }

  alert() {
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
                        const Text(
                          "هل انتهى الدوام",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            _restPresence();
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Constant.Yellow),
                            child: Center(
                                child: Text(
                              "تأكيد",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Constant.White,
                                  fontSize: 20),
                            )),
                          ),
                        )
                      ]),
                )),
          );
        });
  }

  _restPresence() async {
    await API.resetAttendence(widget.user.zone!.name);
  }
}
