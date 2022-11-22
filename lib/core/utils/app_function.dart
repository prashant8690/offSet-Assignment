import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';

void flutterToast(String msg) async {
  await Fluttertoast.cancel();
  await Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: msg.length > 20 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      backgroundColor: AppColor.primaryPurpleColour,
      fontSize: 14);
}

Future<bool> checkConnection() async {
  ConnectivityResult result = await Connectivity().checkConnectivity();
  return (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi);
}

void disposeKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}
