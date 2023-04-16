import 'dart:convert';
import 'dart:io';

import 'package:admins/Models/Flags.dart';
import 'package:admins/Models/Kid.dart';
import 'package:admins/Models/User.dart';
import 'package:admins/Screens/ResultScreen.dart';
import 'package:admins/Services/Api.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.user});
  final user;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController kidnameController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController flagTitleController = TextEditingController();
  TextEditingController flagDetailsController = TextEditingController();
  bool _ready = false;
  List<Kid> kids = [];
  int page = 0;
  int _page = 0;
  User? account;
  XFile? accountImage;
  XFile? kidImage;
  final ImagePicker picker = ImagePicker();
  String authority = "PARENT";
  final List<Auth> auth = [
    Auth("سائق", "DRIVER"),
    Auth("ولي", "PARENT"),
    Auth("موظف", "EMPLOYEE"),
  ];
  List<Map<String, String>> flags = [];

  _checkFields() {
    if (_page == 1) {
      setState(() {
        _ready = kidnameController.text.isNotEmpty &&
            gradeController.text.isNotEmpty &&
            birthdayController.text.isNotEmpty;
      });
    } else if (page == 0) {
      setState(() {
        _ready = usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            lastnameController.text.isNotEmpty;
      });
    } else if (page == 1) {
      setState(() {
        _ready =
            phoneController.text.isNotEmpty && adressController.text.isNotEmpty;
      });
    }
  }

// TODO: complete get the new account's id after making it , then continue figuring shit out ,
  _createKid() {
    kids.add(Kid.fromJson({
      "id": "",
      "name": kidnameController.text,
      "lastname": "راتن",
      "User": {"phone": phoneController.text},
      "userId": "a64031bd-1aab-46a7-9058-654917333e15",
      "grade": gradeController.text,
      "birthday": _birthdayConvert().toString(),
      "position": "HOME",
      "picture": '',
    }));
  }

  _birthdayConvert() {
    List<String> parts = birthdayController.text.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    DateTime birthday = DateTime(year, month, day);
    return birthday;
  }

  _createUser() async {
    var user = await API.addUser(
        usernameController.text,
        passwordController.text,
        nameController.text,
        lastnameController.text,
        phoneController.text,
        adressController.text,
        zoneController.text,
        authority);
    dynamic decodedJson = jsonDecode(user);
    if (decodedJson is! String) {
      setState(() {
        account = User.fromJson(decodedJson);
      });
    } else {
      print('Request failed with error: $decodedJson');
    }
  }

  _createFlag() {
    if (flagDetailsController.text.isNotEmpty &&
        flagTitleController.text.isNotEmpty) {
      Map<String, String> flag = {
        "title": flagTitleController.text,
        "details": flagDetailsController.text
      };
      flags.add(flag);
      flagDetailsController.text = "";
      flagTitleController.text = "";
    }
    print(flags);
    print(kids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.Background,
        body: SafeArea(
          child: page == 0
              ? _globalPage()
              : page == 1
                  ? _secondPage()
                  : page == 2 && authority != "PARENT"
                      ? ResultScreen(
                          user: widget.user,
                        )
                      : _kidsRegister(),
        ));
  }

  _kidsRegister() {
    return _page == 0
        ? _noKidsScene()
        : _page == 1
            ? _addKid()
            : _page == 2
                ? _addFlag()
                : _listOfKids();
  }

  Column _listOfKids() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Constant.Blue,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("اسم الطفل"),
                        SizedBox(width: 20),
                        CircleAvatar(
                          radius: 50,
                        )
                      ]),
                ),
              ),
            );
          },
          itemCount: 1,
        )),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Center(child: FaIcon(FontAwesomeIcons.plus)),
            ),
          ),
        ),
        Container(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _page = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "< سابق",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RegisterScreen(
                                user: widget.user,
                              ))));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "تاكيد >",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _addFlag() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 80),
                    SizedBox(height: 20),
                    Text("${kidnameController.text} ${lastnameController.text}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Constant.Background,
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _input("عنوان", false, flagTitleController),
                            SizedBox(height: 30),
                            Container(
                              width: 300,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: flagDetailsController,
                                  decoration: InputDecoration(
                                    label: Text("تفاصيل"),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Constant.Blue)),
                                    onPressed: () {
                                      _createFlag();
                                    },
                                    child: Text("تأكيد"),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            )),
            Container(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _page = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "< سابق",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _page = 3;
                      // });

                      API.addKid(kids.last, flags);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "التالي >",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _addKid() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        myAlert(1);
                      },
                      child: CircleAvatar(
                        radius: 80,
                        child: kidImage != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(kidImage!.path),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                  ),
                                ),
                              )
                            : Text(
                                "No Image",
                                style: TextStyle(fontSize: 20),
                              ),
                      ),
                    ),
                    SizedBox(height: 60),
                    _input("الاسم", false, kidnameController),
                    SizedBox(height: 20),
                    _input("المستوى", false, gradeController),
                    SizedBox(height: 20),
                    _input("تاريخ الميلاد", false, birthdayController),
                  ]),
            )),
            Container(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "< سابق",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_ready &&
                          RegExp(r'^\d{2}/\d{2}/\d{4}$')
                              .hasMatch(birthdayController.text)) {
                        setState(() {
                          _page = 2;
                        });
                        _createKid();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "التالي >",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _ready
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _noKidsScene() {
    return Column(
      children: [
        Expanded(
            child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _page = 1;
                    });
                  },
                  child: CircleAvatar(
                    radius: 60,
                    child: FaIcon(FontAwesomeIcons.plus),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "اضافة طفل",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ]),
        )),
        Container(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "< سابق",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _secondPage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: Column(children: [
          SizedBox(height: 50),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  child: kidImage != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              //to show image, you type like this.
                              File(kidImage!.path),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                          ),
                        )
                      : Text(
                          "No Image",
                          style: TextStyle(fontSize: 20),
                        ),
                ),
                SizedBox(height: 20),
                Text("${nameController.text} ${lastnameController.text}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _input("رقم الهاتف", false, phoneController),
                  SizedBox(height: 10),
                  _input("العنوان", false, adressController),
                  SizedBox(height: 10),
                  authority != "EMPLOYEE"
                      ? _input("المنطقة", false, zoneController)
                      : null,
                ],
              )),
          Container(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page = 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "< سابق",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_ready) {
                        setState(() {
                          page = 2;
                          _ready = false;
                        });
                        _createUser();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        authority == "PARENT" ? "التالي >" : "تاكيد >",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _ready
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }

  _globalPage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            SizedBox(height: 40),
            Expanded(
              flex: 2,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    myAlert(0);
                  },
                  child: CircleAvatar(
                    radius: 100,
                    child: accountImage != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                //to show image, you type like this.
                                File(accountImage!.path),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              ),
                            ),
                          )
                        : Text(
                            "No Image",
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _input("الاسم", false, nameController),
                    SizedBox(height: 10),
                    _input("اللقب", false, lastnameController),
                    SizedBox(height: 10),
                    _input("اسم المستخدم", false, usernameController),
                    SizedBox(height: 10),
                    _input("كلمة السر", true, passwordController)
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _ships(auth[0]),
                      SizedBox(width: 20),
                      _ships(auth[1]),
                      SizedBox(width: 20),
                      _ships(auth[2])
                    ])),
            Container(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _ready = false;
                        });
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "< سابق",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_ready) {
                          setState(() {
                            page = 1;
                            _ready = false;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "التالي >",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: _ready
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(0, 0, 0, 0.5)),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _input(String label, bool pass, TextEditingController controller) {
    return Container(
        width: 300,
        height: label == "تاريخ الميلاد" ? 60 : 55,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              onChanged: _checkFields(),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: controller,
              style: TextStyle(color: Colors.black),
              obscureText: pass,
              decoration: InputDecoration(
                  hintText: label == "تاريخ الميلاد" ? 'DD/MM/YYYY' : "",
                  label: Text(label),
                  labelStyle: TextStyle(color: Color.fromARGB(185, 0, 0, 0))),
            )));
  }

  _ships(Auth auth) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            authority = auth.value;
          });
        },
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: authority != auth.value
                ? Constant.Blue
                : Color.fromRGBO(0, 119, 181, 0.5),
          ),
          child: Center(
            child: Text("${auth.label}"),
          ),
        ),
      ),
    );
  }

  Future getAccImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      accountImage = img;
    });
  }

  Future getKidImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      kidImage = img;
    });
  }

  myAlert(int acc) {
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
                      acc == 0
                          ? getAccImage(ImageSource.gallery)
                          : getKidImage(ImageSource.gallery);
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
                      acc == 0
                          ? getAccImage(ImageSource.camera)
                          : getKidImage(ImageSource.camera);
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
}
