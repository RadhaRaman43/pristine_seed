import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:navigation_drawer_flutter/models/return_indent_model/return_indent_header_create_model.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/repository/return_indent_repository/return_indent_repository.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/return_indent_model/location_model.dart';
import '../../models/return_indent_model/return_indent_add_line_model.dart';
import '../../models/return_indent_model/return_indent_list_model.dart';
import '../../models/return_indent_model/return_indent_name_item_model.dart';

class ReturnIndentViewModel extends GetxController {

  final _api = ReturnIndentRepository();
  SessionManagement sessionManagement = new SessionManagement();
  RxBool loading = false.obs;
  RxList<LocationResponse> location_list = <LocationResponse>[].obs;
  RxList<IndentItemResponse> indent_name_list = <IndentItemResponse>[].obs;
  RxList<ReturnIndentAddLineReponse> indent_return_add_line_list = <
      ReturnIndentAddLineReponse>[].obs;

  RxList<ReturnIndentHeaderCreateResponse> return_create_header_list = <
      ReturnIndentHeaderCreateResponse>[].obs;
  RxList<ReturnIndentListResponse> return_indent_list = <
      ReturnIndentListResponse>[].obs;

  final location_code_controller = TextEditingController();
  final global_search_controller = TextEditingController();
  final indent_name_controller = TextEditingController();
  final unused_qty_controller = TextEditingController();
  final bad_qty_controller = TextEditingController();

  RxBool is_show_indent_dropDown = true.obs;

  String location_code = "";

  String email = "";

  RxInt is_done = 0.obs;
  RxBool is_location_dropdown=false.obs;


  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;

  String item_no="";

  String return_no = "";
  String list_location_code = "";

  IndentItemResponse? selected_indent_data = null;

  Rx<IndentItemResponse> selected_model=new IndentItemResponse().obs;

  RxBool selected_item_check = false.obs;


  @override
  void onInit() async {
    email = await sessionManagement.getEmail() ?? "";
    getLocation();
    ReturnIndentList(pageNumber);
  }

  getLocation() {
    loading.value = true;
    Map <String, String> data = {
    };
    print(data);
    try {
      _api.returnIndentLocationApiHit(data, sessionManagement).then((value) {
        print(value);
        final JsonResponse = json.decode(value);
        if (JsonResponse is List) {
          List<LocationResponse> response = JsonResponse.map((e) =>
              LocationResponse.fromJson(e)).toList();
          if (response != null && response.length > 0 &&
              response[0].condition == "True") {
            loading.value = false;
            location_list.value = response;
          } else {
            loading.value = false;
            location_list.value = [];
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification("Api Error!", JsonResponse);
        }
      },);
    } catch (e) {
      loading.value = false;
      print(e);
    } finally {
      loading.value = false;
    }
  }

  ReturnIndentHeaderCreate(String flag) {


    loading.value = true;
    Map data;
    if(flag=="Init"){
      data = {
        "return_no": "",
        "location_code": location_code_controller.text,
        "email_id": email
      };
    }
    else if(flag=="ListView"){
      data = {
        "return_no": return_no,
        "location_code": location_code,
        "email_id": email
      };
    }else if(flag=="back"){
      data = {
        "return_no":return_create_header_list[0].returnNo.toString() ,
        "location_code": location_code_controller.text,
        "email_id": email
      };
    }else{
      return;
    }
   /* data = {
      "return_no": return_no,
      "location_code": location_code,
      "email_id": email
    };*/
    print(data);
    try {
      _api.returnIndentHeaderCreateApiHit(data, sessionManagement).then((
          value) {
        print(value);
        final JsonResponse = json.decode(value);
        if (JsonResponse is List) {
          List<ReturnIndentHeaderCreateResponse> response = JsonResponse.map((
              e) =>
              ReturnIndentHeaderCreateResponse.fromJson(e)).toList();
          if (response != null && response.length > 0 &&
              response[0].condition == "True") {
            return_create_header_list.value = response;
            if(flag!="back"){
              Get.toNamed(RoutesName.returnHeaderDetailsScreen);
            }
          } else {
           // return_create_header_list.value = [];
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification("Api Error!", JsonResponse);
          print(JsonResponse);
        }
      },);
    } catch (e) {
      loading.value = false;
      print(e);
    } finally {
      loading.value = false;
    }
  }


  ReturnIndentList(int page_no, {String global_search_value = ""}) {
    loading.value = true;
    Map data;
    if (global_search_value != null && global_search_value.isNotEmpty &&
        global_search_value != "") {
      data = {
        "return_no": global_search_value,
        "location_code": "",
        "is_done": is_done.value,
        "row_per_page": rowsPerPage,
        "page_number": page_no,
        "email_id": email
      };
    } else {
      data = {
        "return_no": "",
        "location_code": "",
        "is_done": is_done.value,
        "row_per_page": rowsPerPage,
        "page_number": page_no,
        "email_id": email
      };
    }
    print(data);

      _api.returnIndentListApiHit(data, sessionManagement).then((value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<ReturnIndentListResponse> response = JsonResponse.map((e) =>
                ReturnIndentListResponse.fromJson(e)).toList();
            if (response != null && response.length > 0 &&
                response[0].condition == "True") {

              if (page_no == 0) {
                return_indent_list.clear();
              }
              return_indent_list.addAll(response);
              total_rows = return_indent_list[0].totalCount!;
            } else {

              return_indent_list.value = [];
            }
          } else {

            Utils.showErrorToastification("Api Error!", JsonResponse);
            print(JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;
        }

      },).onError((error, stackTrace) {
        loading.value = false;
      },).whenComplete(() {
        loading.value = false;
      },);

  }

  getIndentItemName(String return_no, String item_no){
    loading.value = true;
    Map data = {
      "return_no": return_no,
      "item_no": item_no,
      "email_id": email
    };
    print(data);

      _api.returnIndentItemApiHit(data, sessionManagement).then((value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<IndentItemResponse> response = JsonResponse.map((e) =>
                IndentItemResponse.fromJson(e)).toList();
            if (response != null && response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              indent_name_list.value = response;
              Get.toNamed(RoutesName.returnIndentAddLineScreen);
            } else {
              loading.value = false;
              indent_name_list.value = [];
            }
          } else {

            Utils.showErrorToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;
        }
      },).onError((error, stackTrace) {
        loading.value = false;
      },).whenComplete(() {
        loading.value = false;
      },);

  }
  returnIndentAddLineApiHit(String return_no, String item_no, String flag) {
    loading.value = true;
    Map data;
    if (flag == 'InIt') {
      data = {
        "return_no": return_no,
        "item_no": item_no,
        "email_id": email
      };
    }
    else if (flag == 'Add') {
      data = {
        "return_no": return_no,
        "indent_no": selected_indent_data!.indentNo,
        "indent_line_no": selected_indent_data!.lineNo,
        "item_no": selected_indent_data!.itemNo,
        "return_unused_qty": unused_qty_controller.value.text,
        "return_damage_qty": bad_qty_controller.value.text,
        "email_id": email
      };
    } else {
      return;
    }
      _api.returnIndentAddLineApiHit(data, sessionManagement).then((value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<ReturnIndentAddLineReponse> response = JsonResponse.map((e) =>
                ReturnIndentAddLineReponse.fromJson(e)).toList();
            if (response != null && response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              indent_return_add_line_list.value = response;
              selected_indent_data = null;
              getIndentItemName(return_create_header_list[0].returnNo.toString(),item_no);
              selected_item_check.value = false;
              is_show_indent_dropDown.value=false;
              is_show_indent_dropDown.value=true;
              indent_name_controller.clear();

              unused_qty_controller.clear();
              bad_qty_controller.clear();
            } else {
              loading.value = false;
              if(flag!="InIt"){
                Utils.showErrorToastification("Error!", response[0].message!);
              }
              // indent_return_add_line_list.value = [];
            }
          } else {
            loading.value = false;
            Utils.showErrorToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;
        }
      },).onError((error, stackTrace) {
        loading.value = false;
      },  ).whenComplete(() {
        loading.value = false;
      },);


  }



  returnIndentLineDeleteApiHit(String return_no, String? line_no,String item_no) {
    loading.value = true;
    Map data = {
      "return_no": return_no,
     //"item_no":indent_return_add_line_list[0].itemNo,
      "item_no":item_no,
      "line_no": line_no,
      "email_id": email
    };
    print(data);
    _api.returnIndentLineDeleteApiHit(data, sessionManagement).then((value) {
      print(value);
      try {
        final JsonResponse = json.decode(value);
        if (JsonResponse is List) {
          List<ReturnIndentAddLineReponse> response = JsonResponse.map((
              e) =>
              ReturnIndentAddLineReponse.fromJson(e)).toList();
          if (response != null && response.length > 0 && response[0].condition == "True") {
            loading.value = false;
            if(response[0].itemNo==null){
              Get.back();
              indent_return_add_line_list.value=[];
              is_show_indent_dropDown.value=false;
              is_show_indent_dropDown.value=true;
              indent_name_controller.clear();
              getIndentItemName(return_create_header_list[0].returnNo.toString(),item_no);
            }else{
              Get.back();
              indent_return_add_line_list.value = response;
              is_show_indent_dropDown.value=false;
              is_show_indent_dropDown.value=true;
              indent_name_controller.clear();
            }
          } else {
            loading.value = false;
            //indent_return_add_line_list.value = [];
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification("Api Error!", JsonResponse);
        }
      } catch (e) {
        print(e);
      } finally {
        loading.value = false;
      }
    },).onError((error, stackTrace) {
      loading.value = false;
    },).whenComplete(() {
      loading.value = false;
    },);
  }


  returnIndentHeaderDeleteApiHit(String return_no) {
    loading.value = true;
    Map data = {
      "return_no":return_no ,
      "email_id": email
    };
    print(data);
    _api.returnIndentHeaderDeleteApiHit(data, sessionManagement).then((value) {
      print(value);
      try {
        final JsonResponse = json.decode(value);
        if (JsonResponse is List) {
          List<ReturnIndentHeaderCreateResponse> response = JsonResponse.map((
              e) =>
              ReturnIndentHeaderCreateResponse.fromJson(e)).toList();
          if (response != null && response.length > 0 && response[0].condition == "True") {
            loading.value = false;
            Utils.showToastification("Success!", response[0].message!);
            Get.offAllNamed(RoutesName.returnIndentScreen);
          } else {
            loading.value = false;
            Utils.showErrorToastification("Error!", response[0].message!);
            indent_return_add_line_list.value = [];
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification("Api Error!", JsonResponse);
        }
      } catch (e) {
        print(e);
      } finally {
        loading.value = false;
      }
    },).onError((error, stackTrace) {
      loading.value = false;
    },).whenComplete(() {
      loading.value = false;
    },);
  }


  returnIndentHeaderCompleteApiHit(String return_no) {
    loading.value = true;
    Map data = {
      "return_no":return_no ,
      "email_id": email
    };
    print(data);
    _api.returnIndentHeaderCompleteApiHit(data, sessionManagement).then((value) {
      print(value);
      try {
        final JsonResponse = json.decode(value);
        if (JsonResponse is List) {
          List<ReturnIndentHeaderCreateResponse> response = JsonResponse.map((
              e) =>
              ReturnIndentHeaderCreateResponse.fromJson(e)).toList();
          if (response != null && response.length > 0 && response[0].condition == "True") {
            loading.value = false;
            Utils.showToastification("Success!", response[0].message!);
            Get.offAllNamed(RoutesName.returnIndentScreen);
          } else {
            loading.value = false;
            Utils.showErrorToastification("Error!", response[0].message!);
            indent_return_add_line_list.value = [];
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification("Api Error!", JsonResponse);
        }
      } catch (e) {
        print(e);
      } finally {
        loading.value = false;
      }
    },).onError((error, stackTrace) {
      loading.value = false;
    },).whenComplete(() {
      loading.value = false;
    },);
  }

}