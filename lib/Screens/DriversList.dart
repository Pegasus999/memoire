import 'package:admins/Models/Kid.dart';
import 'package:admins/Models/User.dart';
import 'package:admins/Services/Api.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriversList extends StatefulWidget {
  const DriversList({super.key, required this.user});
  final User user;
  @override
  State<DriversList> createState() => _DriversListState();
}

// TODO: request the list of kids in the related zone , and figure out how to update their position per click , also remove the place holders
class _DriversListState extends State<DriversList> {
  List<Kid>? kids = [];

  void updateKidsState(List<Kid> loadedKids) {
    setState(() {
      kids = loadedKids;
    });
  }

  Future<void> loadData() async {
    final loadedKids =
        await API.getZoneRelatedKids(updateKidsState, widget.user.zone!.name);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.Background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                        child: Text(
                      "${kids!.length}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                    flex: 1,
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                        "${widget.user.zone!.name}",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      )),
                      flex: 5),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: FaIcon(FontAwesomeIcons.layerGroup),
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future:
                  API.getZoneRelatedKids((e) => null, widget.user.zone!.name),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTile(index);
                    },
                    itemCount: kids!.length,
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Text(
                      "No kids Found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  _handleRoad(int index) {
    List<Kid> updatedKids = List<Kid>.from(kids!);
    if (kids![index].position == "في الطريق") {
      updatedKids[index].position = 'في المنزل';
    } else {
      updatedKids[index].position = "في الطريق";
    }
    setState(() {
      kids = updatedKids;
    });
    _updatedPosition(index);
  }

  _handleDaycare(int index) {
    List<Kid> updatedKids = List<Kid>.from(kids!);
    if (kids![index].position == "في الروضة") {
      updatedKids[index].position = 'في المنزل';
    } else {
      updatedKids[index].position = "في الروضة";
    }
    setState(() {
      kids = updatedKids;
    });
    _updatedPosition(index);
  }

  _updatedPosition(int index) async {
    String message =
        await API.updateSinglePosition(kids![index].position, kids![index].id);
  }

  _buildTile(int index) {
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
              flex: 2,
              child: Container(
                height: 100,
                padding: EdgeInsets.only(right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _handleRoad(index);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.truck,
                              color: kids![index].position == "في الطريق"
                                  ? Colors.red
                                  : null,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              _handleDaycare(index);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: kids![index].position == "في الروضة"
                                  ? Colors.red
                                  : null,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${kids![index].name} ${kids![index].lastname}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.phone,
                                        size: 15,
                                      ),
                                      SizedBox(width: 5),
                                      Text("${kids![index].phone}")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                  child: CircleAvatar(
                radius: 50, // set the radius as per your requirement
                backgroundImage: NetworkImage("${kids![index].picture}"),
              )))
        ]),
      ),
    );
  }
}
