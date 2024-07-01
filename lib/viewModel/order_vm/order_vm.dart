import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:navigation_drawer_flutter/models/order_model/order_item_category_model.dart';
import 'package:navigation_drawer_flutter/repository/order_repository/order_repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/order_model/order_header_create_model.dart';
import '../../models/order_model/order_item_get_model.dart';
import '../../models/order_model/order_list_screen.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class OrderViewModel extends GetxController{
  final _api=OrderRepository();

  SessionManagement sessionManagement=SessionManagement();
   RxBool loading=false.obs;
    String email='';
  int pageNumber=0;
  int rowsPerPage=10;
  int total_rows=0;

  RxBool isShowListView = false.obs;

  int index=0;


  RxList<OrderHeaderGetModel> order_header_list=<OrderHeaderGetModel>[].obs;
  RxList<OrderHeaderCreateModel> order_details_list=<OrderHeaderCreateModel>[].obs;
  RxList<OrderItemCategoryModel> searchResult = <OrderItemCategoryModel>[].obs;
  RxList<OrderItemCategoryModel> order_item_category_list = <OrderItemCategoryModel>[].obs;
  RxList<OrderItemGetModel> order_item_get_list = <OrderItemGetModel>[].obs;
  var search_item_category_crop_controller = TextEditingController();


  @override
  void onInit() async {
    email =await sessionManagement.getEmail()??"";
    orderHeaderApi(pageNumber);
  }

  orderHeaderApi( int page_no){
    Map data={
      "order_no": "",
      "order_date": "",
      "customer_no": "",
      "customer_name": "",
      "consignee_id": "",
      "consignee_name": "",
      "order_status": "",
      "email_id": email,
      "rowsPerPage": rowsPerPage,
      "pageNumber": page_no
    };
    loading.value=true;
    _api.orderHeaderListApiHit(data, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      try{
        if(jsonResponse is List ){
          List<OrderHeaderGetModel>  response = jsonResponse.map((data) => OrderHeaderGetModel.fromJson(data))
              .toList();
          if(response!=null && response.length>0 &&  response[0].condition=="True"){
            order_header_list.value=response;
          }else{
            order_header_list.value=[];
          }
        }else{
          Utils.showErrorToastification("Api Error!", jsonResponse);
        }
      }catch(e){
        print(e);
      }finally{
        loading.value=false;
      }
    },).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);




  }

  //todo for filter list........
  onSearchTextChanged(String text) async {
    try{
      if (text.isEmpty) {
        searchResult.value = await List.from(order_item_category_list);
        update();
        return;
      }
      searchResult.value = await order_item_category_list
          .where((item) => item.categoryCode!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }catch(e){
      print(e);
    }
  }
  orderDetailsApiHit(String order_no,String flag){
    Map data={
      "order_no": order_no,
      "email_id": email
    };
    print(data);
    loading.value=true;
    _api.orderDetailsApiHit(data, sessionManagement).then((value) {
      print(value);
      final jsonResponse = json.decode(value);
      try{
        if(jsonResponse is List ){
          List<OrderHeaderCreateModel>  response = jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data))
              .toList();
          if(response!=null && response.length>0 &&  response[0].condition=="True"){
            order_details_list.value=response;
            if(flag=='CART' || flag=='Shipped Details'){
             // Get.toNamed(RoutesName.viewCartScreen);
            }
            else{
              Get.toNamed(RoutesName.order_item_category_screen);
            getOrderItemCategoryGet(order_details_list[0].orderNo!);
            }



          }else{
            order_details_list.value=[];
          }
        }else{
          Utils.showErrorToastification("Api Error!", jsonResponse);
        }
      }catch(e){
        print(e);
      }finally{
        loading.value=false;
      }
    },).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);

  }



  getOrderItemCategoryGet(String orderNo){
    Map<String, String> data = {
      'order_no':orderNo,
      'email_id':email
    };
    _api.orderItemCategoryApiHit(data, sessionManagement).then((value) {
      try {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemCategoryModel> response =
          jsonResponse.map((data) => OrderItemCategoryModel.fromJson(data)).toList();
          if (response!=null && response.isNotEmpty && response[0].condition == 'True') {
            isShowListView.value=true;
            order_item_category_list.value=response;
            searchResult.value=response;
            print('list length:: ${searchResult.length.toString()}');
          } else {
            order_item_category_list.value = [];
            Utils.showErrorToastification('API Error', 'Item Category Not Found Of This User.');
          }
        } else {
          order_item_category_list.value = [];
          Utils.showErrorToastification(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        order_item_category_list.value = [];
        print(e);
      }
    }).onError((error, stackTrace) {
      order_item_category_list.value = [];
    });
  }


  getOrderItemGet(String orderNo,String category_code){
    Map<String, String> data = {
      "order_no": orderNo,
      "email_id": email,
      "category_code":category_code,
      "group_code": ""
    };
    print(data);
    _api.orderItemApiHit(data, sessionManagement).then((value) {
      try {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemGetModel> response =
          jsonResponse.map((data) => OrderItemGetModel.fromJson(data)).toList();
          if (response!=null && response.isNotEmpty && response[0].condition == 'True') {
            isShowListView.value=true;
            order_item_get_list.value=response;
            Get.toNamed(RoutesName.order_variety_screen);
            print('list length:: ${searchResult.length.toString()}');
          } else {
            order_item_get_list.value = [];
            Utils.showErrorToastification('API Error', 'Item Category Not Found Of This User.');
          }
        } else {
          order_item_get_list.value = [];
          Utils.showErrorToastification(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        order_item_category_list.value = [];
        print(e);
      }
    }).onError((error, stackTrace) {
      order_item_category_list.value = [];
    });
  }




}