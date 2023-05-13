import 'package:rayto/Models/Kid.dart';
import 'package:rayto/Models/User.dart';
import 'package:rayto/Screens/EmployeeHomePage.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendenceList extends StatefulWidget {
  const AttendenceList({super.key, required this.user});
  final User user;

  @override
  State<AttendenceList> createState() => _AttendenceListState();
}

class _AttendenceListState extends State<AttendenceList> {
  List<Kid>? kids;

  @override
  void initState() {
    super.initState();
    loadData(updateKidsState);
  }

  Future<void> loadData(Function(List<Kid>) updateState) async {
    final loadedKids = await API.getAttendence(updateState);
    if (loadedKids == []) {}
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              EmployeeHomePage(user: widget.user)),
                        ),
                      );
                    },
                    child: const FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                  const Text(
                    "الغيابات",
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
                        future: loadData((p0) => null),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Constant.Yellow,
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: Constant.White,
                ),
              )),
          Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${kids![index].name} ${kids![index].lastname}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constant.White),
                ),
              ],
            )),
          ),
          kids![index].picture.contains("assets/images")
              ? Container(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Constant.Creamy,
                      backgroundImage: AssetImage(kids![index].picture)))
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Constant.Creamy,
                      backgroundImage:
                          NetworkImage(kids![index].picture))),
        ],
      ),
    );
  }
}
