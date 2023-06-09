import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iraq_bank/controller/textstyle.dart';
import 'package:iraq_bank/widget/drawerr.dart';
import 'package:iraq_bank/widget/icon_button_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  //-------------------------------------------------
  CollectionReference usersref = FirebaseFirestore.instance.collection("users"); // Fire Store استدعاء

  //----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الصفحة الشخصية",
          style: CustomTextStyle.f18w,
        ),
        centerTitle: true,
        actions: const [IconButtonn()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 40), //+++++

                  //--------------------------------------------

                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 6,
                    child: FutureBuilder(
                      future: usersref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(), // جلب معلومات اليوزر الذي قام بتسجيل الدخول
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return CircleAvatar(
                                  radius: 60,
                                  child: Image.network(
                                    "${snapshot.data!.docs[index]['imageurl']}", // طريقة كتابة كود
                                    fit: BoxFit.cover,
                                  ));
                            },
                          );
                        }
                        return const Center(child: Text("Loading ..... "));
                      },
                    ),
                  ),

                  //--------------------------------------------------------
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 11,
                    child: FutureBuilder(
                      future: usersref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(), // جلب معلومات اليوزر الذي قام بتسجيل الدخول
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length, //
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.monetization_on),
                                  title: const Text("Balance : ", style: CustomTextStyle.f17b),
                                  trailing: Text(
                                    "${snapshot.data!.docs[index]['Balance']}", // طريقة كتابة كود
                                    style: CustomTextStyle.f17b,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const Center(child: Text("Loading ..... "));
                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 40), //+++++
                ],
              ),
            ),

            //=============================================================
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: usersref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(), // جلب معلومات اليوزر الذي قام بتسجيل الدخول
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error");
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.account_box),
                              title: const Text("Name", style: CustomTextStyle.f15b),
                              trailing: Text("${snapshot.data!.docs[index]['Name']}"), // طريقة كتابة كود
                            ),
                            ListTile(
                              leading: const Icon(Icons.account_balance),
                              title: const Text("BankAccount", style: CustomTextStyle.f15b),
                              trailing: Text("${snapshot.data!.docs[index]['BankAccount']}"), // طريقة كتابة كود
                            ),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text("Email", style: CustomTextStyle.f15b),
                              trailing: Text("${snapshot.data!.docs[index]['Email']}"), // طريقة كتابة كود
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text("Phone", style: CustomTextStyle.f15b),
                              trailing: Text("${snapshot.data!.docs[index]['Phone']}"), // طريقة كتابة كود
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on_outlined),
                              title: const Text("Address", style: CustomTextStyle.f15b),
                              trailing: Text("${snapshot.data!.docs[index]['Address']}"), // طريقة كتابة كود
                            ),
                            const Divider(
                              color: Colors.teal,
                              thickness: 1,
                              height: 100,
                            )
                          ],
                        );
                      },
                    );
                  }
                  return const Center(child: Text("Loading --------- "));
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const Drawerr(),
    );
  }
}
