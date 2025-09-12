import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';
import 'dart:io';
import '../../models/profile_upload_model/profile_upload_model.dart';

class ProfileViewModel extends GetxController{
  SessionManagement sessionManagement= SessionManagement();

  RxBool loading=false.obs;
  String email='';
  String name='';
  String company_id='';
  String userRole='';


  Rx<Uint8List> webImagef = Rx<Uint8List>(Uint8List(8));
  Rx<File?> pickedImagef = Rx<File?>(null);
  List<ProfileUploadModel> profile_list = [];
  @override
  void onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    name=await sessionManagement.getName() ?? '';
    company_id=await sessionManagement.getCompanyId() ?? '';



    print(email);


  }





}