import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:iraq_bank/controller/textstyle.dart';
import 'package:photo_view/photo_view.dart';

class Vimg extends StatelessWidget {
  Vimg({super.key, required this.img});
  String img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("معاملات مستلمة", style: CustomTextStyle.f20b),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: PhotoView(
            imageProvider: NetworkImage(img),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          var response = await Dio().get(img, options: Options(responseType: ResponseType.bytes));
          final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
          );
          Fluttertoast.showToast(msg: "saved image");
        },
        backgroundColor: Colors.teal,
        child: const Text(
          'حفظ',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
