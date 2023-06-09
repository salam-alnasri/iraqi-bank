import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text("... الرجاء الانتظار"),
        content: SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
