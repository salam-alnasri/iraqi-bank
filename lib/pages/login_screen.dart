import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iraq_bank/widget/bottom_n_b.dart';
import 'package:iraq_bank/widget/drawerr.dart';
import 'package:iraq_bank/widget/loading.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool _passwordvisible = false;
//----------------------------------

//----------------------------------
class _LoginState extends State<Login> {
  //----------------------------------------Firebase
  final auth = FirebaseAuth.instance;
  //-----------------------------------
  late String email, password;
  //------------------------
  final _formKey = GlobalKey<FormState>();
  r() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  t(String i) async {
    var check = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: i)
        .limit(1)
        .get();

    if (check.docs.length == 1) {
      // print('ddddddddd');
      // print(check.docs[0].data()['userid']);
      // print(check.docs[0].data()['Name']);
      String? to = await FirebaseMessaging.instance.getToken();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(check.docs[0].id)
          .update({'token': to});
    }
  }

  @override
  void initState() {
    r();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.8,
                    child: Image.asset(
                        "images/Bank1.jpg"), // صورة ترحيبية توضح طبيعة عمل البنك
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height / 30), //+++++++

                  TextFormField(
                    //================================ حقل ادخال الايميل
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "البريد الالكتروني",
                      suffixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "  قم بادخال البريد الالكتروني الخاص بك";
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height / 40), //+++++++

                  TextFormField(
                    //==================================  حقل ادخال الباسوورد
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: _passwordvisible,
                    decoration: InputDecoration(
                      labelText: " كلمة المرور",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordvisible = !_passwordvisible;
                          });
                        },
                        icon: _passwordvisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ادخل كلمة المرور الخاصة بك";
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),

                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.generalLogin,
                    onPressed: () async {
                      //___________________________________________________
                      try {
                        showLoading(context); //Loading ..........
                        await auth
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then(
                                (value) => {}); // مصادقة الفايربيس FirebaseAuth
                        await t(FirebaseAuth.instance.currentUser!.uid);
                        Get.off(() => const BottomNB());
                      } catch (e) {
                        print(e.toString());
                        print(FirebaseAuth.instance.currentUser!.uid);
                        print('objectiiiiii');
                        print(email);
                        Get.back(); //------------------------- GetX
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Center(
                              child: Text("اعد ادخال المعلومات بشكل صحيح"),
                            ),
                            icon: Icon(Icons.info_outline, size: 50),
                          ),
                        );
                        // Get.snackbar("انتبه", "تم ادخال الايميل والباسورد بشكل خاطئ");
                      }

                      //______________________________________________________
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                  ),
                  TextButton(
                    //=====================  زر مسؤول عن تسجيل الدخول
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height / 20), //+++++++

                  SocialLoginButton(
                    //  زر انشار الحساب بواسطة ايميل كوكل
                    buttonType: SocialLoginButtonType.google,
                    mode: SocialLoginButtonMode.single,
                    text: "Register with Google Account",
                    onPressed: () {}, // دالة مسؤولة عن انشاء الحساب بواسطة كوكل
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const Drawerr(),
    );
  }
}
