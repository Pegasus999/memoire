import "dart:async";
import 'dart:io';
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:image_picker/image_picker.dart";
import "package:rayto/Models/Kid.dart";
import "package:rayto/Models/User.dart";
import "package:rayto/Screens/ParentPage.dart";
import "package:rayto/Services/Api.dart";
import "package:rayto/constant.dart";

class AddKid extends StatefulWidget {
  const AddKid({super.key, required this.user, required this.parent});
  final User user;
  final User parent;
  @override
  State<AddKid> createState() => _AddKidState();
}

class _AddKidState extends State<AddKid> {
  int page = 0;
  String gender = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  bool _ready = false;
  XFile? picture;

  _createUser() async {
    final kid = Kid.fromJson({
      "id": "",
      "gender": gender,
      "userId": widget.parent.id,
      "school": schoolController.text,
      'name': nameController.text,
      "lastname": widget.parent.lastname,
      "User": {
        "phone": widget.parent.phone,
        "zone": {"name": widget.parent.zone!.name},
        "adress": widget.parent.adress
      },
      "position": "HOME",
      'picture': "",
    });
    await API.addKid(kid, picture);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => ParentPage(
              parent: widget.parent,
              user: widget.user,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.White,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (page == 0) {
                                    Navigator.of(context).pop();
                                  } else {
                                    setState(() {
                                      page--;
                                    });
                                  }
                                },
                                child: const FaIcon(FontAwesomeIcons.arrowLeft),
                              ),
                              const Text(
                                "اضافة",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              page == 2
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const FaIcon(
                                          FontAwesomeIcons.houseChimney),
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 115,
                        child: Image.asset("assets/images/Boy.png")),
                    const SizedBox(height: 10),
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 110,
                        child: Image.asset("assets/images/Girl.png")),
                    const SizedBox(height: 10),
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
                            ? const AssetImage("assets/images/Boy.png")
                            : const AssetImage("assets/images/Girl.png"),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Constant.Creamy,
                        backgroundImage: FileImage(File(picture!.path)),
                      )),
            const SizedBox(height: 20),
            const Center(child: Text("اضافة صورة")),
            const SizedBox(height: 50),
            _input("الاسم", nameController, false),
            const SizedBox(height: 20),
            _input("المؤسسة", schoolController, false),
            const SizedBox(height: 20),
            Opacity(
              opacity: _ready ? 1 : 0.7,
              child: GestureDetector(
                  onTap: () {
                    if (_ready) {
                      _createUser();
                    } else {
                      Fluttertoast.showToast(msg: "الرجاء ادخال معلومات");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Constant.Yellow,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
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
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getAccImage(ImageSource.gallery);
                    },
                    child: const Row(
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
                    child: const Row(
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

  _checkFields() {
    final bool check =
        nameController.text.isNotEmpty && schoolController.text.isNotEmpty;

    setState(() {
      _ready = check;
    });
  }
}
