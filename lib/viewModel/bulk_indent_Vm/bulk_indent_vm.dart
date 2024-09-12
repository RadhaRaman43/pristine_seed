import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
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

  String item_name="";


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

  var indent_date_controller=TextEditingController();

  var bad_quantity_controller=TextEditingController();
  var consumer_quantity_controller=TextEditingController();
  var remain_quantity_controller=TextEditingController();



  RxList<String> indent_status_list = <String>["Completed","Approved","Rejected","Ready For Consumption","Received"].obs;
  RxList<String> service_type_list = <String>["Self","WareHouse","Bulk Inventory"].obs;
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
   var date= StaticMethod.convertDateFormat(date_controller.text);
    Map data;
    if(global_search!=null && global_search.isNotEmpty && global_search!=""){
      data = {
        "indent_type": "Bulk_Inventory",
        "indent_status": "",
        "service_type": "",
        "filter_item_no_or_cust_no_or_service_no": "",
        "indent_no": global_search,
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
        "service_type":"",
        "filter_item_no_or_cust_no_or_service_no": "",
        "indent_no":indent_no_controller.text,
        "service_no":"",
       // "indent_date": date_controller.text,
        "indent_date": date,
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
              indent_no_controller.clear();
              service_controller.clear();
              indent_serviceType_controller.clear();
              date_controller.clear();
              indent_status_controller.clear();
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
     //"indent_type": indent_type_controller.text,
      "indent_type":"Bulk_Inventory",
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentHeaderCreateApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          print("Value...");
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
              Get.toNamed(RoutesName.create_bulk_indent_screen);
              // indent_type_controller.clear();
              // is_Showindent.value=true;
              // is_indent_type_dropDown.value=false;
              // if(indent_no!="" ){
              //   is_Showindent.value=true;
              //   is_indent_type_dropDown.value=false;
              // }
              /*if(indent_no!=""){
                Get.toNamed(RoutesName.create_bulk_indent_screen);
              }*/

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

  bulkIndentLineCreate(String indent_no, BuildContext context) {
    if(item_no_controller.text.isEmpty){
      Utils.showErrorToastification("Message!", "Please Select Item Code");
      return;
    }
    if(quantity_controller.text.isEmpty){
      Utils.showErrorToastification("Message!", "Please Enter Quantity ");
      return;
    }
    if( quantity_controller.text=="0"){
      Utils.showErrorToastification("Message!", "Your Quantity Cannot be Zero");
      return;
    }
    if(discount_controller.text.isEmpty){
      discount_controller.text="0";
    }
    Map data = {
      "indent_no": indent_no,
      "item_no": item_no,
      "qty": quantity_controller.text,
      "is_customer_damage":isCheckBox.value==true?'1':"0",
      "unit_price": unit_price_controller.text,
      "email_id": email,
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentLineCreateApiHit(data, sessionManagement).then(
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
              item_no_controller.clear();
              item_no ="";
              item_Qty = 0;
              is_warrenty =0;
              unit_price = 0;
              bulk_indent_header_create_list.value = response;
              Navigator.pop(context);
              /*IndentHeaderCreateApi(
                  service_indent_header_create_list[0].indentNo!);*/
              Utils.showToastification(
                  "Success!", response[0].message.toString());
            } else {
              print(response[0].message);
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
          Utils.showExceptionToastification("Api Error!", error.toString());
        },
      );
    } catch (e) {
      loading.value = false;
      bulk_indent_header_create_list.value = [];
      print(e);
    }
  }


  IndentHeaderLineDelete(String indent_no, String indent_line_no, String flag) {
    Map data = {
      "flag": flag == "HeaderDiscard" ? "HeaderDiscard" : "LineDiscard",
      "indent_no": indent_no,
      "indent_line_no": flag == "HeaderDiscard" ? -1 : indent_line_no,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentDeleteLineAndHeaderApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<BulkHeaderCreateResponse> response =
            JsonResponse.map((e) => BulkHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              if (flag == "HeaderDiscard") {
                print("if......" + flag);
                Get.toNamed(RoutesName.bulk_indent_screen);
              }
              bulk_indent_header_create_list.value = response;

              /*IndentHeaderCreateApi(
                  service_indent_header_create_list[0].indentNo!);*/
              Utils.showToastification(
                  "Success!", response[0].message.toString());
            } else {
              loading.value = false;
              bulk_indent_header_create_list.value = [];
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            bulk_indent_header_create_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          bulk_indent_header_create_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      bulk_indent_header_create_list.value = [];
      print(e);
    }
  }


  IndentComplete(String indent_no) {
    Map data = {
      "indent_no": indent_no,
      "email_id": email,
      "reschedule_datetime": indent_date_controller.text
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentCompleteApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<BulkHeaderCreateResponse> response =
            JsonResponse.map((e) => BulkHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              indent_date_controller.clear();
              Get.offNamed(RoutesName.bulk_indent_screen);
              Utils.showToastification("Success!", response[0].message.toString());
            } else {
              loading.value = false;
              Utils.showErrorToastification("Error!", response[0].message.toString());
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

  bulkIndentConsumerHeaderMarkApi(String indent_no) {
    Map data = {
      "indent_no": indent_no,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentConsumerHeaderMarkApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<BulkHeaderCreateResponse> response =
            JsonResponse.map((e) => BulkHeaderCreateResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              bulk_indent_header_create_list.value=response;

              Utils.showToastification("Success!", response[0].message!);
            } else {
              loading.value = false;
              print(response);
              Utils.showErrorToastification("Error!", response[0].message!);
            }
          } else {
            loading.value = false;
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          bulk_indent_header_create_list.value=[];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }



  bulkIndentConsumerLineApi(String indent_no,int line_no,) {
    Map data = {
      "indent_no": indent_no,
      "line_no":line_no ,
      "consume_qty":consumer_quantity_controller.text,
      "bad_qty":bad_quantity_controller.text,
    };
    print(data);
    loading.value = true;
    try {
      _api.bulkIndentConsumerLineMarkApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<BulkHeaderCreateResponse> response =
            JsonResponse.map((e) => BulkHeaderCreateResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              bulk_indent_header_create_list.value=response;
              consumer_quantity_controller.clear();
              bad_quantity_controller.clear();

              Utils.showToastification("Success!", response[0].message!);
            } else {
              loading.value = false;
              Utils.showErrorToastification("Error!", response[0].message!);
            }
          } else {
            loading.value = false;
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          bulk_indent_header_create_list.value=[];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

}