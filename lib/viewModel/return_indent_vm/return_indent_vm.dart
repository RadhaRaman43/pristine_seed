import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/repository/return_indent_repository/return_indent_repository.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/return_indent_model/location_model.dart';

class ReturnIndentViewModel extends GetxController{

  final _api=ReturnIndentRepository();

  SessionManagement sessionManagement = new SessionManagement();

  RxBool loading =false.obs;


  RxList<LocationResponse> location_list=<LocationResponse>[].obs;

  final location_code_controller=TextEditingController();



  @override
  void onInit() async {

    getLocation();
  }




  getLocation(){
    loading.value=true;
    Map <String, String> data={

    };
    try{
      _api.returnIndentLocationApiHit(data, sessionManagement).then((value) {
        final JsonResponse=json.decode(value);
        if(JsonResponse is List){
          List<LocationResponse> response=JsonResponse.map((e) =>
              LocationResponse.fromJson(e)).toList();
          if(response!=null && response.length>0 && response[0].condition=="True"){
            loading.value=false;
            location_list.value=response;
          }else{
            loading.value=false;
            location_list.value=[];
          }
        }else{
          loading.value=false;
          Utils.showErrorToastification("Api Error!", JsonResponse);
        }
      },);

    }catch(e){
      loading.value=false;
      print(e);
    }finally{
      loading.value=false;
    }
  }






}