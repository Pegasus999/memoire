import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayto/constant.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  int page = 0;
  String gender = "";
  String auth = "";
  String? zone = "";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  List<SelectedListItem> formats = [
    SelectedListItem(name: "idk"),
    SelectedListItem(name: "kNewYork"),
    SelectedListItem(name: "kLondon"),
    SelectedListItem(name: "kParis"),
    SelectedListItem(name: "kMadrid"),
    SelectedListItem(name: "kDubai"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.White,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (page == 0)
                                    Navigator.of(context).pop();
                                  else
                                    setState(() {
                                      page--;
                                    });
                                },
                                child: FaIcon(FontAwesomeIcons.arrowLeft),
                              ),
                              Text(
                                "اضافة",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              page == 2
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child:
                                          FaIcon(FontAwesomeIcons.houseChimney),
                                    )
                                  : const SizedBox(width: 20)
                            ],
                          ),
                        ),
                      ]),
                ),
                page == 0
                    ? _genderScreen()
                    : page == 1
                        ? _jobScreen()
                        : _informationScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _genderScreen() {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  gender = "MALE";
                  page++;
                });
              },
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 115,
                        child: Image.asset("assets/images/MaleEmployee.png")),
                    SizedBox(height: 10),
                    Text(
                      "ذكر",
                      style: TextStyle(color: Constant.Red, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  gender = "FEMALE";
                  page++;
                });
              },
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 110,
                        child: Image.asset("assets/images/FemaleEmployee.png")),
                    SizedBox(height: 10),
                    Text(
                      "انثى",
                      style: TextStyle(color: Constant.Red, fontSize: 20),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _jobScreen() {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  auth = "WORKER";
                  page++;
                });
              },
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 115,
                        child: Image.asset("assets/images/MaleEmployee.png")),
                    SizedBox(height: 10),
                    Text(
                      "موظف",
                      style: TextStyle(color: Constant.Red, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  auth = "DRIVER";
                  page++;
                });
              },
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 115,
                        child: Image.asset("assets/images/Driver.png")),
                    SizedBox(height: 10),
                    Text(
                      "سائق",
                      style: TextStyle(color: Constant.Red, fontSize: 20),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _informationScreen() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Constant.Creamy,
              child: auth == "WORKER"
                  ? Image.asset("assets/images/MaleEmployee.png")
                  : Image.asset("assets/images/Driver.png"),
            ),
            SizedBox(height: 50),
            _input("الاسم", nameController, false),
            SizedBox(height: 20),
            _input("اللقب", lastNameController, false),
            SizedBox(height: 20),
            _input("اسم المستخدم", usernameController, false),
            SizedBox(height: 20),
            _input("كلمة السر", passwordController, true),
            SizedBox(height: 20),
            _input("رقم الهاتف", phoneController, false),
            SizedBox(height: 20),
            auth == "WORKER"
                ? _input('الوظيفة', jobController, false)
                : _dropDownMenu(),
            SizedBox(height: 50),
            GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Constant.Yellow,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  height: 50,
                  width: 250,
                  child: Center(
                      child: Text(
                    "تاكيد",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Constant.White,
                        fontSize: 20),
                  )),
                ))
          ],
        ))
      ],
    ));
  }

  _dropDownMenu() {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          _onDropDownClick();
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                zone ?? "المنطقة",
                style: TextStyle(color: Constant.Creamy),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }

  void valueChange(String? message) {
    setState(() {
      zone = message;
    });
  }

  _onDropDownClick() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          "المناطق",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        data: formats,
        selectedItems: (List<dynamic> selectedList) {
          String? selected;
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              selected = item.name;
            }
          }

          valueChange(selected);
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }
}

_input(String hint, TextEditingController controller, bool pass) {
  return Container(
    width: 350,
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
        controller: controller,
        style: TextStyle(color: Constant.Creamy),
        obscureText: pass,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            hintText: hint,
            hintStyle: TextStyle(color: Constant.Creamy)),
      ),
    ),
  );
}
