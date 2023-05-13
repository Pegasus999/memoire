
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:rayto/Models/User.dart";
import "package:rayto/Screens/AddKid.dart";
import "package:rayto/Screens/ParentsList.dart";
import "package:rayto/constant.dart";

class ParentPage extends StatefulWidget {
  const ParentPage({super.key, required this.user, required this.parent});
  final User user;
  final User parent;
  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.White,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.Yellow,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => ParentsList(
                    adding: false,
                    user: widget.user,
                  )),
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.arrowLeft),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Column(
          children: [
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Constant.Yellow,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/ex.png"),
                              const SizedBox(height: 30),
                              Text(
                                "انذار",
                                style: TextStyle(
                                    color: Constant.White,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => AddKid(
                                    user: widget.user,
                                    parent: widget.parent,
                                  )),
                            ),
                          );
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Constant.Yellow,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/Notification.png"),
                                const SizedBox(height: 30),
                                Text(
                                  "الاشعارات",
                                  style: TextStyle(
                                      color: Constant.White,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
            Expanded(
                child: widget.parent.kids!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return _listTile(index);
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: widget.parent.kids!.length),
                      )
                    : const Center(
                        child: Text("لا يوجد اطفال"),
                      ))
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
          const SizedBox(
            width: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [FaIcon(FontAwesomeIcons.calendarCheck), Text("20")],
            ),
          ),
          Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${widget.parent.kids![index].name} ${widget.parent.lastname}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constant.White),
                ),
              ],
            )),
          ),
          widget.parent.kids![index].picture.contains("assets/images")
              ? Container(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Constant.Creamy,
                      backgroundImage:
                          AssetImage(widget.parent.kids![index].picture)))
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Constant.Creamy,
                      backgroundImage: NetworkImage(
                          widget.parent.kids![index].picture))),
        ],
      ),
    );
  }
}
