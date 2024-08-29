import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:navigation_drawer_flutter/repository/bulk_indent_repository/bulk_indent_repo.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/bulk_indent_model/bulk_header_create_model.dart';
import '../../models/bulk_indent_model/bulk_indent_list_model.dart';
import '../../models/bulk_indent_model/bulk_item_master_model.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class BulkIndentViewModel extends GetxController{

  final _api=BulkIndentRepository();
   RxBool loading=false.obs;

  SessionManagement sessionManagement= SessionManagement();

  String email='';

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool is_indent_type_dropDown=false.obs;
  RxBool is_Showindent=false.obs;
  String item_no = "";

  double unit_price= 0;

  RxDouble damage= 0.0.obs;
  int is_warrenty= 0;

  double item_Qty = 0.0;


  RxBool isCheckBox = false.obs;

  var globle_search_controller = TextEditingController();
  var indent_status_controller = TextEditingController();
  var indent_no_controller = TextEditingController();
  var service_controller = TextEditingController();
  var date_controller = TextEditingController();
  var indent_serviceType_controller = TextEditingController();
  var indent_type_controller=TextEditingController();

  var quantity_controller = TextEditingController();
  var item_no_description_controller = TextEditingController();
  var item_no_controller = TextEditingController();
  var discount_controller = TextEditingController();
  var unit_price_controller=TextEditingController();
  var item_price_controller=TextEditingController();

  var paybal_amount_controller=TextEditingController();


  RxList<String> indent_status_list = <String>["Completed","Approved","Rejected","Ready For Consumption","Received"].obs;
  RxList<String> service_type_list = <String>["Installation","Corrective","Preventive"].obs;
   RxString status="Pending".obs;

  RxList<BulkIndentListModel> bulk_indent_list=<BulkIndentListModel>[].obs;
  RxList<BulkHeaderCreateResponse> bulk_indent_header_create_list = <BulkHeaderCreateResponse>[].obs;

  RxList<String> indent_type_list = <String>["Bulk_Inventory"].obs;

  RxList<BulkItemMasterGetModel> item_no_list = <BulkItemMasterGetModel>[].obs;

  @override
  void onInit() async {
    email=await sessionManagement.getEmail()??"";
    getBulkIndentList(pageNumber,status.value);

  }

  getBulkIndentList(int page_no,String status,{String global_search=""}) {
    Map data;
    if(global_search!=null && global_search.isNotEmpty && global_search!=""){
      data = {
        "indent_type": "Bulk_Inventory",
        "indent_status": "",
        "service_type": "",
        "filter_item_no_or_cust_no_or_service_no": global_search,
        "indent_no": "",
        "service_no": "",
        "indent_date": "",
        "email_id":email,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
    }else{
      data = {
        "indent_type": "Bulk_Inventory",
        "indent_status": indent_status_controller.text.isEmpty?status:indent_status_controller.text,
        "service_type": indent_serviceType_controller.text,
        "filter_item_no_or_cust_no_or_service_no": "",
        "indent_no":indent_no_controller.text,
        "service_no": service_controller.text,
        "indent_date": date_controller.text,
        "email_id":email,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
    }

    print(data);
    loading.value = true;
    try {
      _api.getBulkIndentListApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<BulkIndentListModel> response =
            JsonResponse.map((e) => BulkIndentListModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {

              if(page_no==0){
                bulk_indent_list.clear();
              }
              bulk_indent_list.addAll(response);
              total_rows=bulk_indent_list[0].totalCount!;
            } else {
              bulk_indent_list.value=[];
            }
          } else {
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      ).whenComplete(() {
        loading.value = false;

      },);
    } catch (e) {
      print(e);
    }finally{
      loading.value = false;
    }
  }


  BulkHeaderCreateApi(String indent_no) {
    Map data = {
      "service_id": "",
      "indent_no": indent_no,
      "indent_type": indent_type_controller.text,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentHeaderCreateApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<BulkHeaderCreateResponse> response =
            JsonResponse.map((e) => BulkHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              bulk_indent_header_create_list.value = response;
              indent_type_controller.clear();
              is_Showindent.value=true;
              is_indent_type_dropDown.value=false;
              if(indent_no!="" ){
                is_Showindent.value=true;
                is_indent_type_dropDown.value=false;
              }
              /*else{
                is_Showindent.value=true;
                is_indent_type_dropDown.value=false;
              }*/
              if(response[0].message!=null){
                Utils.showToastification(
                    "Success!", response[0].message.toString());
              }
            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  Future<Iterable<BulkItemMasterGetModel>> getItemNo(String text) async {
    if (text == '') {
      return const Iterable<BulkItemMasterGetModel>.empty();
    }
    Map data = {
      "item_code": "",
      "name": text,
      "description": "",
      "category_code": "",
      "gst_group_code": "",
      "hsn_code": "",
      "location_code": "",
      "active": -1,
      "is_bulky": -1,
      "is_expiry_mandatory": -1,
      "rowsPerPage": 10,
      "pageNumber": 0
    };

    String itemdropdownresp =
    await _api.item_noApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(itemdropdownresp);
      if (jsonResponse is List) {
        print(jsonResponse);
        List<BulkItemMasterGetModel> response = jsonResponse
            .map((data) => BulkItemMasterGetModel.fromJson(data))
            .toList();
        if (response[0].condition == 'True') {
          print(jsonResponse);
          item_no_list.value = response;
        } else {
          // Utils.sanckBarException('False!', response[0].message!);
          item_no_list.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        item_no_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      item_no_list.value= [];
    }
    return   item_no_list.value;
  }
}