import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Repository/item_master_repo/item_master_repo.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/item_master_modal/non_standard_item_data_modal.dart';

class ItemMasterVm extends GetxController{
  final _api = ItemMasterRepo();
  RxBool loading=false.obs;
  SessionManagement sessionManagement = SessionManagement();
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  int total_rows_items = 0;

  String email = "";
  String userType = "";
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;

  var item_code_Controller = TextEditingController().obs;
  var customer_code_Controller = TextEditingController().obs;
  var sale_cycle_id_Controller = TextEditingController().obs;
  var name_Controller = TextEditingController().obs;
  var category_Controller = TextEditingController().obs;
  var HSN_code_Controller = TextEditingController().obs;
  var GST_group_code_Controller = TextEditingController().obs;
  var specification_Controller = TextEditingController().obs;
  var expired_on_Controller = TextEditingController().obs;
  var created_on_Controller = TextEditingController().obs;

  RxList<NonStandardItemDataModal> nonStandardList = <NonStandardItemDataModal>[].obs;

  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';

  }

  itemMstSalesCycleGet(int page_no) async{
    try {
      Map data = {
        "sales_cycle_id": sale_cycle_id_Controller.value.text.isNotEmpty? sale_cycle_id_Controller.value.text:"",
        "account_code":  customer_code_Controller.value.text.isNotEmpty? customer_code_Controller.value.text:"",
        "account_name": "",
        "item_code": item_code_Controller.value.text.isNotEmpty? item_code_Controller.value.text:"",
        "name": name_Controller.value.text.isNotEmpty? name_Controller.value.text:"",
        "description": "",
        "category_code": "",
        "gst_group_code": GST_group_code_Controller.value.text.isNotEmpty? GST_group_code_Controller.value.text:"",
        "hsn_code": HSN_code_Controller.value.text.isNotEmpty? HSN_code_Controller.value.text:"",
        "location_code": "",
        "active": -1,
        "is_bulky": -1  ,
        "is_expiry_mandatory": 0,
        "status": "Approved",
        "create_date_range":created_on_Controller.value.text.isNotEmpty? created_on_Controller.value.text:"",
        "specification": specification_Controller.value.text.isNotEmpty? specification_Controller.value.text:"",
        "expire_date_range": expired_on_Controller.value.text.isNotEmpty? expired_on_Controller.value.text:"",
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
      print('sale data ${data}');
      loading.value = true;
      String onValue = await _api.ItemMstSalesCycleGet(data, sessionManagement);
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<NonStandardItemDataModal> response = jsonResponse.map((e) => NonStandardItemDataModal.fromJson(e)).toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              if (page_no == 0) {
                nonStandardList.clear();
              }
              nonStandardList.addAll(response);
              print('listSize.....${nonStandardList.length}');
              total_rows_items = int.parse(nonStandardList[0].totalRows!);
          }
        }
    } catch (e) {
      Utils.sanckBarError("Exception error!", e.toString());
      print('Exception..$e');
    }
    finally{
      loading.value = false;
    }
  }


  clearFilterData(){
    item_code_Controller.value.clear();
    customer_code_Controller.value.clear();
    sale_cycle_id_Controller.value.clear();
    name_Controller.value.clear();
    category_Controller.value.clear();
    HSN_code_Controller.value.clear();
    GST_group_code_Controller.value.clear();
    specification_Controller.value.clear();
    expired_on_Controller.value.clear();
    created_on_Controller.value.clear();
  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveitemMasterData({
      'item_code_Controller': item_code_Controller.value.text,
      'customer_code_Controller': customer_code_Controller.value.text,
      'sale_cycle_id_Controller': sale_cycle_id_Controller.value.text,
      'name_Controller': name_Controller.value.text,
      'category_Controller': category_Controller.value.text,
      'HSN_code_Controller': HSN_code_Controller.value.text,
      'GST_group_code_Controller': GST_group_code_Controller.value.text,
      'specification_Controller': specification_Controller.value.text,
      'expired_on_Controller': expired_on_Controller.value.text,
      'created_on_Controller': created_on_Controller.value.text,

    });
    filterDataChecker.value='';
    itemMstSalesCycleGet(pageNumber,);

  }

  void getFilterData() async {
    Map getFilterData = await sessionManagement.getitemMasterData();

    if (getFilterData.isNotEmpty) {
      filterDataChecker.value = '1';
      item_code_Controller.value.text = getFilterData["item_code_Controller"] ?? "";
      customer_code_Controller.value.text = getFilterData["customer_code_Controller"] ?? "";
      sale_cycle_id_Controller.value.text = getFilterData["sale_cycle_id_Controller"] ?? "";
      name_Controller.value.text = getFilterData["name_Controller"] ?? "";
      category_Controller.value.text = getFilterData["category_Controller"] ?? "";
      HSN_code_Controller.value.text = getFilterData["HSN_code_Controller"] ?? "";
      GST_group_code_Controller.value.text = getFilterData["GST_group_code_Controller"] ?? "";
      specification_Controller.value.text = getFilterData["specification_Controller"] ?? "";
      expired_on_Controller.value.text = getFilterData["expired_on_Controller"] ?? "";
      created_on_Controller.value.text = getFilterData["created_on_Controller"] ?? "";

      pageNumber = 0;
      itemMstSalesCycleGet(pageNumber,);
    }
  }

  void clearSaveFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearitemMasterData();
  }
  String numberFormatWithComma(dynamic number) {
    if (number == null || number.toString().isEmpty) return "0.00";

    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(num.parse(number.toString()));
  }


}