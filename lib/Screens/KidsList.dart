import 'package:rayto/Models/Kid.dart';
import 'package:rayto/Models/User.dart';
import 'package:rayto/Screens/ParentsList.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KidsList extends StatefulWidget {
  const KidsList({super.key, required this.user});
  final User user;
  @override
  State<KidsList> createState() => _KidsListState();
}

class _KidsListState extends State<KidsList> {
  bool search = false;
  TextEditingController queryController = TextEditingController();
  List<Kid>? kids = [];
  List<Kid>? untouchedKids;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await API.getKids(updateKidsState);
  }

  void updateKidsState(List<Kid> loadedKids) {
    setState(() {
      kids = loadedKids;
      untouchedKids = loadedKids;
    });
  }

  _filter(String value) {
    if (value == '') {
      setState(() {
        kids = untouchedKids;
      });
    } else {
      setState(() {
        kids = untouchedKids!
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
      floatingActionButton: widget.user.auth == "ADMIN"
          ? FloatingActionButton(
              backgroundColor: Constant.Yellow,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        ParentsList(adding: true, user: widget.user)),
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
                      Navigator.of(context).pop();
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
                            "الاطفال",
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
                        future: API.getKids((p0) => null),
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
                Expanded(
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.house,
                          color: _handleIconColor(index, "في المنزل"),
                        ),
                        FaIcon(FontAwesomeIcons.bus,
                            color: _handleIconColor(index, "في الطريق")),
                        FaIcon(FontAwesomeIcons.child,
                            color: _handleIconColor(index, "في الروضة")),
                        FaIcon(FontAwesomeIcons.school,
                            color: _handleIconColor(index, "في الموؤسسة")),
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Constant.Creamy,
                  backgroundImage: const AssetImage("assets/images/Boy.png"))),
        ],
      ),
    );
  }

  Color _handleIconColor(int index, String icon) {
    if (kids![index].position == icon) {
      return Constant.Yellow;
    } else {
      return Constant.White;
    }
  }
}
