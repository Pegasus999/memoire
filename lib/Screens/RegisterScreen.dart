import 'dart:io';

import 'package:admins/Models/Kid.dart';
import 'package:admins/Screens/ResultScreen.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

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
  TextEditingController flagDetails = TextEditingController();
  List<Kid> kids = [];
  int page = 0;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  String authority = "PARENT";
  final List<Auth> auth = [
    Auth("سائق", "DRIVER"),
    Auth("ولي", "PARENT"),
    Auth("موظف", "EMPLOYEE"),
  ];

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
                      ? ResultScreen()
                      : _kidsRegister(),
        ));
  }

  _kidsRegister() {
    return ResultScreen();
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  ;
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

  Column _addFlag() {
    return Column(
      children: [
        Expanded(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(radius: 80),
                SizedBox(height: 20),
                // Text("${nameController.text} ${lastnameController}",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)
                Text(
                  "ادم زغمار",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Constant.Background,
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Constant.Blue)),
                                onPressed: () {},
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  ;
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
    );
  }

  Column _addKid() {
    return Column(
      children: [
        Expanded(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  child: image != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              //to show image, you type like this.
                              File(image!.path),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  ;
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "التالي >",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
              )
            ],
          ),
        )
      ],
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
                CircleAvatar(
                  radius: 70,
                  child: FaIcon(FontAwesomeIcons.plus),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  ;
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "التالي >",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _secondPage() {
    return Column(children: [
      SizedBox(height: 50),
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              child: image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
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
            // Text("${nameController} ${lastnameController}")
            Text(
              "ادم زغمار",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    page = 2;
                  });
                  ;
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    authority == "PARENT" ? "التالي >" : "تاكيد >",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ))
    ]);
  }

  _globalPage() {
    return Column(
      children: [
        SizedBox(height: 40),
        Expanded(
          flex: 2,
          child: Center(
            child: GestureDetector(
              onTap: () {
                myAlert();
              },
              child: CircleAvatar(
                radius: 100,
                child: image != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            //to show image, you type like this.
                            File(image!.path),
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
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "< سابق",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      page = 1;
                    });
                    ;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "التالي >",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }

  _input(String label, bool pass, TextEditingController controller) {
    return Container(
        width: 300,
        height: 50,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
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
                  label: Text(label),
                  labelStyle: TextStyle(color: Color.fromARGB(185, 0, 0, 0))),
            )));
  }

  _ships(Auth auth) {
    return Center(
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Constant.Blue,
        ),
        child: Center(
          child: Text("${auth.label}"),
        ),
      ),
    );
  }

  Future getAccImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future getKidImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
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
}
