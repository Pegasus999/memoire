import 'package:rayto/Models/User.dart';
import 'package:rayto/Screens/AddKid.dart';
import 'package:rayto/Screens/AddParentAccount.dart';
import 'package:rayto/Screens/ParentPage.dart';
import 'package:rayto/Screens/SubsPage.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParentsList extends StatefulWidget {
  const ParentsList({super.key, required this.user, required this.adding});
  final User user;
  final bool adding;
  @override
  State<ParentsList> createState() => _ParentsListState();
}

class _ParentsListState extends State<ParentsList> {
  bool search = false;
  TextEditingController queryController = TextEditingController();
  List<User>? users;
  List<User>? untouchedUsers;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await API.getParents(updateParentsState);
  }

  void updateParentsState(List<User> loadedUsers) {
    setState(() {
      users = loadedUsers;
      untouchedUsers = loadedUsers;
    });
  }

  _filter(String value) {
    if (value == '') {
      setState(() {
        users = untouchedUsers;
      });
    } else {
      setState(() {
        users = untouchedUsers!
            .where((user) =>
                user.name.contains(value) || user.lastname.contains(value))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: widget.user.auth == "ADMIN" &&
              widget.adding == false
          ? FloatingActionButton(
              backgroundColor: Constant.Yellow,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => AddParentAccount(user: widget.user)),
                  ),
                );
              },
              child: const FaIcon(FontAwesomeIcons.plus),
            )
          : null,
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
                          builder: ((context) => SubsPage(user: widget.user)),
                        ),
                      );
                    },
                    child: const FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                  Visibility(
                    visible: !search,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(),
                          const Text(
                            "الاولياء",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  search = !search;
                                });
                              },
                              child: const FaIcon(
                                  FontAwesomeIcons.magnifyingGlass)),
                        ],
                      ),
                    ),
                  ),
                  search
                      ? Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(
                              color: Constant.Creamy,
                              width: 1,
                            ),
                          ),
                          height: 50,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                _filter(value);
                              },
                              controller: queryController,
                              style: TextStyle(color: Constant.Creamy),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Constant.Creamy,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  hintText: "اسم",
                                  hintStyle: TextStyle(color: Constant.Creamy)),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    child: FutureBuilder(
                        future: API.getParents((p0) => null),
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
                              itemCount: users!.length,
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const Center(
                              child: Text(
                                "لا يوجد اولياء",
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
    return GestureDetector(
      onTap: () {
        if (widget.user.auth == "ADMIN" && widget.adding == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ParentPage(
                    user: widget.user,
                    parent: users![index],
                  )),
            ),
          );
        } else if (widget.user.auth == "ADMIN" && widget.adding == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AddKid(
                    user: widget.user,
                    parent: users![index],
                  )),
            ),
          );
        }
      },
      child: Container(
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
                    "${users![index].name} ${users![index].lastname}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Constant.White),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "طفل",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(247, 239, 234, 0.5)),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${users![index].kids!.length}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(247, 239, 234, 0.5)),
                      ),
                    ],
                  )
                ],
              )),
            ),
            users![index].picture.contains("assets/images")
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Constant.Creamy,
                        backgroundImage: AssetImage(users![index].picture)))
                : Container(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Constant.Creamy,
                        backgroundImage: NetworkImage(users![index].picture))),
          ],
        ),
      ),
    );
  }
}
