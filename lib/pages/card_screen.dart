import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iraq_bank/controller/textstyle.dart';
import 'package:iraq_bank/widget/drawerr.dart';
import 'package:iraq_bank/widget/icon_button_mode.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  //----------------------------------------------------
  bool _showbackside = false;
  void _showback() {
    setState(() {
      _showbackside = !_showbackside;
    });
  }

  //-------------------------------------------------

  //+++++++++++++++++++++++++++++++++++++++++++++++++++
  CollectionReference usersref = FirebaseFirestore.instance.collection("users"); // Fire Store استدعاء

  ///////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("بطاقة الدفع", style: CustomTextStyle.f18w),
          centerTitle: true,
          actions: const [IconButtonn()],
        ),
        body: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: FutureBuilder(
                future: usersref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(), // جلب معلومات اليوزر الذي قام بتسجيل الدخول
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length, //
                      itemBuilder: (context, index) {
                        return CreditCard(
                          bankName: "${snapshot.data!.docs[index]['bankName']}",
                          cardNumber: "${snapshot.data!.docs[index]['cardNumber']}",
                          cardExpiry: "${snapshot.data!.docs[index]['cardExpiry']}",
                          cardHolderName: "${snapshot.data!.docs[index]['Name']}",
                          cvv: "${snapshot.data!.docs[index]['cvv']}",
                          textExpDate: "Exp. Date",
                          cardType: CardType.visa,
                          showBackSide: _showbackside,
                          frontBackground: CardBackgrounds.black,
                          backBackground: CardBackgrounds.white,
                          showShadow: true,
                          backTextColor: Colors.teal,
                          frontTextColor: Colors.amber,
                        );
                      },
                    );
                  }
                  return const Center(child: Text("Loading ..... "));
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _showback,
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                  MediaQuery.of(context).size.width / 1.4,
                  MediaQuery.of(context).size.height / 18,
                )),
                child: Text(
                  _showbackside ? 'الوجه الخلفي للبطاقة' : ' الوجه الأمامي للبطاقة',
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 99),
          ],
        ),
        drawer: const Drawerr());
  }
}
