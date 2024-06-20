import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/models/logoutModel/logout_model.dart';
import 'package:navigation_drawer_flutter/repository/home_repository/home_repository.dart';
import '../../models/recently_open_menu_model.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../SessionManagment/session_managment.dart';

class HomeViewModel extends GetxController{
  final _api=HomeRepository();
  RxBool loading=false.obs;
  SessionManagement sessionManagement=SessionManagement();
  String email='';
  String name='';
  String title='';
  RxBool isDrawerOpen = false.obs;


  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
  RxString selectedMenu = ''.obs;

  var recentlyOpenedMenus_list = <String>[].obs;


  @override
  Future<void> onInit() async {
    email= await sessionManagement.getEmail() ?? '';
    name= await sessionManagement.getName() ?? '';
    print("1 ");
    String recent_menu_json=await sessionManagement.getRecentMenuList() ?? '';
    List<String> recent_list=  json.decode(recent_menu_json).cast<String>().toList();
    recentlyOpenedMenus_list.value=recent_list;
  }

  void openMenu(String menuName,IconData icon) {
    selectedMenu.value = menuName;
    var check_list=recentlyOpenedMenus_list.where((element) => element.toLowerCase()!.contains(menuName.toLowerCase()) || menuName.toLowerCase().contains(element.toLowerCase()!)).toList();
    if(check_list==null || check_list.isEmpty){
      recentlyOpenedMenus_list.add(menuName);
      if(recentlyOpenedMenus_list.length>4){
        recentlyOpenedMenus_list.removeAt(0);
      }
    }
     print(recentlyOpenedMenus_list);
    sessionManagement.setRecentMenuList(jsonEncode(recentlyOpenedMenus_list));
  }


  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }





  Future<void> logOut() async{
    loading.value=true;
    Map data={
      'email':email,
    };
    await _api.loginApiHit(data,sessionManagement).then((value){
      try{
        loading.value=false;
        List<LogoutResponse> loginResponse=(json.decode(value) as List).map((i) =>
            LogoutResponse.fromJson(i)).toList();
        if (loginResponse[0].condition.toString() == "True") {
          Utils.showToastification('Message', loginResponse[0].action.toString());
          sessionManagement.clearSession();
          Get.offAllNamed(RoutesName.splashscreen);
          print("Success");

        } else {
          print("false");
          Utils.showErrorToastification('Message', loginResponse[0].action.toString());

        }
      }catch(e){
        print("Exception"+e.toString());

      }
    }).onError((error, stackTrace) {
      loading.value=false;
      print("FAil");

    });
  }


}