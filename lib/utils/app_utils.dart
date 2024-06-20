import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toastification/toastification.dart';

import '../constants/app_colors.dart';

class Utils{
  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /* static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER);
  }

  static toastMessageCenter(String message){
    Fluttertoast.showToast(msg: message,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        textColor: AllColors.primaryColor);
  }*/

  static sanckBarSuccess(String title,String message){
    Get.snackbar(
      title,
      message,
      colorText: AllColors.whiteColor,
      backgroundColor: AllColors.primaryDark1,
      barBlur: 2.0,
      duration: const Duration(seconds: 3),

    );
  }
  static sanckBarError(String title,String message){
    Get.snackbar(
      title,
      message,
      colorText: AllColors.whiteColor,
      backgroundColor: AllColors.redColor,
      barBlur: 2.0,
      duration: const Duration(seconds: 2),
    );
  }
  static sanckBarException(String title,String message){
    Get.snackbar(
      title,
      message,
      colorText: AllColors.whiteColor,
      backgroundColor: AllColors.lightredColor,
      barBlur: 2.0,
      duration: const Duration(seconds: 2),
    );
  }


  static showToastification(String title,String message) {
    try {
      Toastification().show(
        context: Get.overlayContext!,
        title: title,
        description: message,

        backgroundColor: AllColors.green,
        autoCloseDuration: const Duration(seconds: 2),
        icon:Icon(Icons.check),
      );
    } catch (e) {
      // Handle the exception as needed
      print("Exception: $e");
    }
  }

  static showErrorToastification(String title,String message) {
    try {
      Toastification().show(
          context: Get.overlayContext!,
          title: title,
          description: message,
          backgroundColor: AllColors.redColor,
          autoCloseDuration: const Duration(seconds: 2),
          icon:Icon(Icons.error)
      );
    } catch (e) {
      // Handle the exception as needed
      print("Exception: $e");
    }
  }


  static showExceptionToastification(String title,String message) {
    try {
      Toastification().show(
          context: Get.overlayContext!,
          title: title,
          description: message,
          backgroundColor: AllColors.lightredColor,
          autoCloseDuration: const Duration(seconds: 2),
          icon:Icon(Icons.error)
      );
    } catch (e) {
      // Handle the exception as needed
      print("Exception: $e");
    }
  }



}