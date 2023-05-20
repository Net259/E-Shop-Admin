import 'package:e_shop_admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void errorMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey,
    textColor: Colors.red,
    fontSize: 16,
  );
}

void successMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey,
    textColor: Palette.col,
    fontSize: 16,
  );
}
