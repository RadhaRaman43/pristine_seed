import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../../models/service_managment_model_directory/service_inventory_model/service_inventory_get_model.dart';
import '../../../models/service_managment_model_directory/service_inventory_model/service_inventory_view_model.dart';

import '../../../repository/service_managment_repository_directory/service_inventory_repository/service_inventory_repo.dart';
class  ServiceInventoryViewModel extends GetxController{
  final _api=ServiceInventoryRepository();

  SessionManagement sessionManagement= SessionManagement();

  RxBool loading=false.obs;

  String email="";

  RxList<ServiceInventoryGetList> get_service_inventory_list=<ServiceInventoryGetList>[].obs;
  RxList<ServiceInventoryViewListModel> service_inventory_details_list=<ServiceInventoryViewListModel>[].obs;
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;


  @override
  void onInit() async {
    email=await sessionManagement.getEmail()??"";
    print("ritik");
    getServiceInventoryGetList(pageNumber);
  }
  getServiceInventoryGetList(int page_no){
    Map data={
      "created_by":email,
      "rowsPerPage":rowsPerPage,
      "pageNumber": page_no
    };
    loading.value=true;
    _api.serviceInventoryGetApiHit(data, sessionManagement).then((value) {
      print(value);
      final JsonResponse=json.decode(value);
      try{
        if(JsonResponse is List){
          List<ServiceInventoryGetList> response=JsonResponse.map((e) =>
              ServiceInventoryGetList.fromJson(e)).toList();
          if(response !=null && response.length>0 && response[0].condition=="True"){
            if(page_no==0){
              get_service_inventory_list.clear();
            }
            get_service_inventory_list.addAll(response);
            total_rows=int.parse(get_service_inventory_list[0].totalRows.toString());
          }else{
            get_service_inventory_list.value=[];
          }
        }
      }catch(e){
        print(e);
      }finally{
        loading.value=false;
      }
    },).onError((error, stackTrace) {
      print(error);
      loading.value=false;

    },).whenComplete(() {
      loading.value=false;
    },);




  }


  getServiceInventoryListView(String item_no){
    Map data={
      "created_by":email,
      "item_no":item_no
    };

    loading.value=true;
    _api.serviceInventoryListViewApiHit(data, sessionManagement).then((value) {
      print(value);
      final JsonResponse=json.decode(value);
      try{
        if(JsonResponse is List){
          List<ServiceInventoryViewListModel> response=JsonResponse.map((e) =>
              ServiceInventoryViewListModel.fromJson(e)).toList();
          if(response !=null && response.length>0 && response[0].condition=="True"){
            service_inventory_details_list.value=response;
            Get.toNamed(RoutesName.service_inventory_view_screen);

          }else{
            service_inventory_details_list.value=[];
          }
        }
      }catch(e){
        print(e);
      }finally{
        loading.value=false;
      }
    },).onError((error, stackTrace) {
      print(error);

      loading.value=false;

    },).whenComplete(() {
      loading.value=false;
    },);




  }



}