import 'dart:async';
import 'dart:io';

import 'package:rayto/Models/Zone.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayto/Models/User.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:rayto/Screens/AddKid.dart';
import 'package:rayto/Screens/ParentsList.dart';
import 'package:rayto/Services/Api.dart';
import 'package:rayto/constant.dart';

class AddParentAccount extends StatefulWidget {
  const AddParentAccount({super.key, required this.user});
  final User user;
  @override
  State<AddParentAccount> createState() => _AddParentAccountState();
}

class _AddParentAccountState extends State<AddParentAccount> {
  int page = 0;
  String gender = "";
  String? zone;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  bool _ready = false;
  bool loading = false;
  XFile? picture;
  List<SelectedListItem> formats = [];
  _createUser() async {
    final user = User.fromJson({
      "id": "",
      "gender": gender,
      'name': nameController.text,
      'lastname': lastNameController.text,
      'phone': phoneController.text,
      'auth': "PARENT",
      'adress': addressController.text,
      'zone': {"name": zone},
      'picture': "",
    });
    setState(() {
      loading = true;
    });
    final res = await API.addParent(
        user, usernameController.text, passwordController.text, picture);
    setState(() {
      loading = false;
    });
    final parent = User.fromJson(res['result']);
    Fluttertoast.showToast(
      msg: "${res['message']}",
    );
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => AddKid(
              user: widget.user,
              parent: parent,
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
                page == 0 ? _genderScreen() : _informationScreen(),
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
                        child: Image.asset("assets/images/MaleParent.png")),
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
                        child: Image.asset("assets/images/FemaleParent.png")),
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

  _informationScreen() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: SingleChildScrollView(
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
                          backgroundImage: gender == "MALE"
                              ? const AssetImage("assets/images/MaleParent.png")
                              : const AssetImage(
                                  "assets/images/FemaleParent.png"),
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
              _input("العنوان", addressController, false),
              SizedBox(height: 20),
              _dropDownMenu(),
              SizedBox(height: 50),
            ],
          ),
        )),
        SizedBox(height: 20),
        Opacity(
          opacity: _ready ? 1 : 0.7,
          child: GestureDetector(
              onTap: () {
                if (zone == null) {
                  Fluttertoast.showToast(msg: "الرجاء ادخال المنطقة");
                } else if (_ready) {
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
                    child: loading
                        ? CircularProgressIndicator(
                            color: Constant.White,
                          )
                        : Text(
                            "تاكيد",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Constant.White,
                                fontSize: 20),
                          )),
              )),
        ),
        SizedBox(height: 20),
      ],
    ));
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

  Future getAccImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      picture = img;
    });
  }

  _checkFields() {
    final phone = phoneController.text.trim();
    final bool check = usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        phone.length == 10;
    setState(() {
      _ready = check;
    });
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
          keyboardType: hint == "رقم الهاتف" ? TextInputType.number : null,
          controller: controller,
          onChanged: (value) {
            _checkFields();
          },
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
