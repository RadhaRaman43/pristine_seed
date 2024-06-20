import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../reources/routes/routes_name.dart';
import '../SessionManagment/session_managment.dart';

class SplashServices{
  SessionManagement sessionManagement=SessionManagement();
  void isLogin() {
    sessionManagement.getEmail().then((value) {
      if (value != null && value.isNotEmpty) {
        sessionManagement.getMenuList().then((menuList) {
          Timer(const Duration(seconds: 1), () => Get.offAllNamed(RoutesName.homeScreen));
        });
      } else {
        // Timer(const Duration(seconds: 1), () => Get.toNamed(RoutesName.loginScreen));
      }
    }).onError((error, stackTrace) => null);
  }
}