import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayto/Models/User.dart';
import 'package:rayto/Models/Zone.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayto/Screens/EmployeesList.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key, required this.user});
  final User user;
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  int page = 0;
  String gender = "";
  String auth = "";
  String? zone;
  final ImagePicker picker = ImagePicker();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  List<SelectedListItem> formats = [];
  XFile? picture;
  bool _ready = false;

  _createUser() async {
    final user = User.fromJson({
      "id": "",
      "gender": gender,
      "job": jobController.text.isNotEmpty ? jobController.text : "",
      'name': nameController.text,
      'lastname': lastNameController.text,
      'phone': phoneController.text,
      'auth': auth,
      'picture': "",
    });

    final res = auth == "WORKER"
        ? await API.addWorker(
            user, usernameController.text, passwordController.text, picture)
        : await API.addDriver(user, usernameController.text,
            passwordController.text, zone, picture);

    Fluttertoast.showToast(
      msg: "${res['message']}",
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => EmployeesList(
              user: widget.user,
            )),
      ),
    );
  }

  updateZonesState(List<Zone> loadedZones) {
    for (int i = 0; i < loadedZones.length; i++) {
      formats.add(SelectedListItem(name: loadedZones[i].name));
    }
  }

  void loadData() async {
    final loadedZone = await API.getZones(updateZonesState);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
            GestureDetector(
                onTap: () {
                  myAlert();
                },
                child: picture == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Constant.Creamy,
                        backgroundImage: auth == "WORKER"
                            ? const AssetImage("assets/images/MaleEmployee.png")
                            : const AssetImage("assets/images/Driver.png"),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Constant.Creamy,
                        backgroundImage: FileImage(File(picture!.path)),
                      )),
            SizedBox(height: 20),
            Center(child: Text("اضافة صورة")),
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
            Opacity(
              opacity: _ready ? 1 : 0.7,
              child: GestureDetector(
                  onTap: () {
                    if (_ready) {
                      _createUser();
                    } else if (phoneController.text.length != 10) {
                      Fluttertoast.showToast(msg: "الرجاء تأكد من رقم الهاتف");
                    } else {
                      Fluttertoast.showToast(msg: "الرجاء ادخال معلومات");
                    }
                  },
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
                  )),
            )
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_drop_down),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    zone ?? "المنطقة",
                    style: TextStyle(color: Constant.Creamy),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void valueChange(String? message) {
    setState(() {
      zone = message;
    });
  }

  _onDropDownClick() {
    DropDownState(
      DropDown(
        bottomSheetTitle: Align(
          alignment: Alignment.centerRight,
          child: const Text(
            "المناطق",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
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

  Future getAccImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      picture = img;
    });
  }

  myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getAccImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getAccImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _checkFields() {
    if (auth == "WORKER") {
      setState(() {
        _ready = usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            phoneController.text.length == 10 &&
            jobController.text.isNotEmpty;
      });
    } else {
      setState(() {
        _ready = usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            phoneController.text.length == 10 &&
            zone != null;
      });
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
          onChanged: _checkFields(),
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
}
