import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  final emailController = TextEditingController();

  String? idR;
  String? toR;
  File? img;
  //++++++++++++
  String? idp;
  String? top;

  getIdUser() async {
    idR = null;
    var check = await FirebaseFirestore.instance.collection('users').where('Email', isEqualTo: emailController.text.trim()).limit(1).get();

    if (check.docs.length == 1) {
      idR = check.docs[0].id;
      toR = check.docs[0].data()['token'];
    } else {
      Fluttertoast.showToast(msg: "no found user");
    }
  }

  //================================================
  File? _qrImage;

  getImg() async {
    img = null;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    img = image != null ? File(image.path) : null;
    if (image != null) {
      setState(() {
        _qrImage = File(image.path);
      });
    }
  }

  bool lod = false;

  sendImage() async {
    try {
      await getIdUser();
      if (idR != null && img != null) {
        setState(() {
          lod = true;
        });
        Reference storageRef = FirebaseStorage.instance.ref().child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");

        await storageRef.putFile(img!);
        String downloadURL = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(idR!).collection('qr').add({"qr": downloadURL, "sender": FirebaseAuth.instance.currentUser!.uid});
        if (toR != null) {
          se('Hellow ', 'new qr', toR!);
        }

        setState(() {
          lod = false;
        });
        Fluttertoast.showToast(msg: "success send image ");
      }

      idR = null;
      img = null;
      toR = null;
      emailController.text = '';
    } catch (e) {
      setState(() {
        lod = false;
      });
      idR = null;
      img = null;
      toR = null;
      emailController.text = '';
      Fluttertoast.showToast(msg: "error send image ");
    }
  }

  void se(String ti, String b, String t) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAA1kxiTjY:APA91bFsRjgKY4uCgYGtAAYUr1SsQQx4SxmU9LYCAY6FdOohCkR3Rh4Nr3-4AK4eE1Mv4i1gR9l7vZEhGSqiIUvg5O-judOJRfejYKYrlrOp9LfsQvSEZz0gSGCCHn664TdsCapxKYab',
        },
        body: json.encode(
          {
            "notification": {"body": b, "title": ti, "sound": "default"},
            "data": {"score": "5x1", "time": "15:10"},
            "to": t,
          },
        ),
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحويل اموال'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //====================================\

              Container(
                margin: const EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    if (_qrImage != null)
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height / 4.1,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Image.file(_qrImage!),
                      ),
                  ],
                ),
              ),

              //=============================================
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              ElevatedButton(
                onPressed: () {
                  getImg();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(200, 10)),
                child: const Text('اختيار صورة'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),

              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),

              //+++++++++++++++++++++++++++++++++++++++++++++++++++++
              ElevatedButton(
                onPressed: () async {
                  sendImage();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(200, 10)),
                child: lod
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('ارسال'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
