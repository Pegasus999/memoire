import 'package:rayto/Screens/AddEmployeeAccount.dart';
import 'package:rayto/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({super.key});

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  bool search = false;
  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.Yellow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AddEmployee()),
            ),
          );
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
                  Visibility(
                    visible: !search,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(),
                          Text(
                            "الموظفين",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  search = !search;
                                });
                              },
                              child: FaIcon(FontAwesomeIcons.magnifyingGlass)),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Constant.Green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(16),
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
                  "اسم الموظف",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constant.White),
                ),
                Text(
                  "الوظيفة",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(247, 239, 234, 0.5),
                  ),
                )
              ],
            )),
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Constant.Creamy,
                  backgroundImage:
                      AssetImage("assets/images/MaleEmployee.png"))),
        ],
      ),
    );
  }
}
