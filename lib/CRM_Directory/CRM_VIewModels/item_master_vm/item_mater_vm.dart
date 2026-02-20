import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Repository/item_master_repo/item_master_repo.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/item_master_modal/non_standard_item_data_modal.dart';

class ItemMasterVm extends GetxController{
  final _api = ItemMasterRepo();
  RxBool loading=false.obs;
  RxBool excelLoading = false.obs;
  RxDouble excelProgress = 0.0.obs;


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

  //todo update controller

  var update_name_Controller = TextEditingController().obs;
  var category_code_Controller = TextEditingController().obs;
  var product_type_Controller = TextEditingController().obs;
  var update_GST_group_code_Controller = TextEditingController().obs;
  var update_HSN_code_Controller = TextEditingController().obs;
  var update_customer_code_Controller = TextEditingController().obs;
  var update_sale_cycle_id_Controller = TextEditingController().obs;
  var component_type_Controller = TextEditingController().obs;
  var update_specification_Controller = TextEditingController().obs;
  var LSP_Controller = TextEditingController().obs;
  var Btp_Controller = TextEditingController().obs;
  var Map_Controller = TextEditingController().obs;
  var standard_cost_Controller = TextEditingController().obs;
  var is_active_Controller = TextEditingController().obs;
  var rate_contract_validity_date_Controller = TextEditingController().obs;
  var expiry_date_Controller = TextEditingController().obs;


  RxList<NonStandardItemDataModal> nonStandardList = <NonStandardItemDataModal>[].obs;
  RxList<NonStandardItemDataModal> nonStandardListForExcel = <NonStandardItemDataModal>[].obs;
  RxList<ItemCategoryMstModel> productCategoryList = <ItemCategoryMstModel>[].obs;
  RxList<String> productTypeList = <String>["Non Standard", "Rate Contractor"].obs;
  RxList<String> IsActiveTypeList = <String>["Yes","No"].obs;
  String checkForExcel = "";

  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';

    itemMstSalesCycleGet(page_no:0,rowPerPage: rowsPerPage);

  }

  itemMstSalesCycleGet({ required int page_no, required int  rowPerPage, BuildContext? context }) async{
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
        "rowsPerPage": rowsPerPage,
        "pageNumber": rowPerPage
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
              if(checkForExcel=="CheckForExcel" && context!= null){
                nonStandardListForExcel.addAll(response);
                exportNonStandardExcelWithProgress(context);

              }
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

  ItemMstSalesCycleDelete(int index) async{
    Map data = {
      "sales_cycle_id": nonStandardList[index].salesCycleId,
      "account_code":nonStandardList[index].accountCode ,
      "item_code": nonStandardList[index].itemCode,
    };
    print(data);
    loading.value = true;
    try {
      String value = await _api.ItemMstSalesCycleDelete(data, sessionManagement);
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<NonStandardItemDataModal> response =
            JsonResponse.map((e) => NonStandardItemDataModal.fromJson(e)).toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              nonStandardList.removeAt(index);
              Utils.sanckBarSuccess('Success Message!',response[0].message.toString());

            } else {
              Utils.sanckBarError("False Message !", response[0].message.toString());
            }
          } else {
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
    } catch (e) {
      Utils.sanckBarError("Error!", e.toString());
      print(e);
    }
    finally{
      loading.value = false;
    }
  }


  getItemCategoryMstApi() async{
    try {
    Map<String, String> data = {};
    this.loading.value = true;
    String value = await _api.getItemCategoryMstWithoutTaskIdApiHit(data, sessionManagement);
      print(value);
        List<ItemCategoryMstModel> Response = (json.decode(value)
        as List<dynamic>).map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();
        if (Response.isNotEmpty &&
            Response[0]?.condition.toString() == "True") {
          productCategoryList.value = Response!;
        }
      } catch (e) {
       Utils.sanckBarError("Error!", e.toString());
      }
      finally{
        this.loading.value = false;
      }

  }

  GSTGroupGet(int index) async{
    try {
      Map<String, dynamic> data = {
        "gst_group_code": nonStandardList[index].gstGroupCode ??"",
        "hsn_code": "",
        "flag": "Grouped",
        "rowsPerPage": 100,
        "pageNumber": 0
      };
      this.loading.value = true;
      String value = await _api.GSTGroupGet(data, sessionManagement);
      print(value);
      List<ItemCategoryMstModel> Response = (json.decode(value)
      as List<dynamic>).map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();
      if (Response.isNotEmpty &&
          Response[0]?.condition.toString() == "True") {
        productCategoryList.value = Response!;
      }
    } catch (e) {
      Utils.sanckBarError("Error!", e.toString());
    }
    finally{
      this.loading.value = false;
    }

  }

  ItemMasterCreateFromCRM() async{
    try {
      Map data = {
        "items":[{
          "account_code": update_customer_code_Controller.value.text.isNotEmpty?update_customer_code_Controller.value.text:"",
          "active": is_active_Controller.value.text=="Yes"?1:0,

        }],
      };
      print('sale data ${data}');
      loading.value = true;
      String onValue = await _api.ItemMasterCreateFromCRM(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if (jsonResponse is List) {
        List<NonStandardItemDataModal> response = jsonResponse.map((e) => NonStandardItemDataModal.fromJson(e)).toList();
        if (response != null && response.length > 0 && response[0].condition == "True") {

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

  clearUpdateController(){
    update_name_Controller.value.clear();
    category_code_Controller.value.clear();
    product_type_Controller.value.clear();
    update_GST_group_code_Controller.value.clear();
    update_HSN_code_Controller.value.clear();
    update_customer_code_Controller.value.clear();
    update_sale_cycle_id_Controller.value.clear();
    component_type_Controller.value.clear();
    update_specification_Controller.value.clear();
    LSP_Controller.value.clear();
    Btp_Controller.value.clear();
    Map_Controller.value.clear();
    standard_cost_Controller.value.clear();
    is_active_Controller.value.clear();
    rate_contract_validity_date_Controller.value.clear();
    expiry_date_Controller.value.clear();
  }

  String numberFormatWithComma(dynamic number) {
    if (number == null || number.toString().isEmpty) return "0.00";

    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(num.parse(number.toString()));
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
    itemMstSalesCycleGet(page_no:pageNumber,rowPerPage: rowsPerPage);


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
      itemMstSalesCycleGet(page_no:pageNumber,rowPerPage: rowsPerPage);
    }
  }



  void clearSaveFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearitemMasterData();
  }

  void showExcelProgressDialog(BuildContext context) {
    Get.dialog(
      Obx(() => AlertDialog(
        title: const Text("Generating Excel"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              value: excelProgress.value / 100,
            ),
            const SizedBox(height: 12),
            Text("${excelProgress.value.toStringAsFixed(0)} %"),
          ],
        ),
      )),
      barrierDismissible: false,
    );
  }

  Future<void> exportNonStandardExcelWithProgress(BuildContext context) async {
    if (nonStandardListForExcel.isEmpty) return;

    excelLoading.value = true;
    excelProgress.value = 0;

    showExcelProgressDialog(context);

    final excel = Excel.createExcel();
    final sheet = excel['Non Standard Items'];

    /// Prepare headers
    final firstRowMap =
    removeExcelKeys(nonStandardListForExcel.first);
    final headers = firstRowMap.keys.toList();

    for (int col = 0; col < headers.length; col++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
          .value = headers[col];
    }

    final totalRows = nonStandardListForExcel.length;

    /// Write rows with progress
    for (int row = 0; row < totalRows; row++) {
      final rowMap = removeExcelKeys(nonStandardListForExcel[row]);

      for (int col = 0; col < headers.length; col++) {
        sheet
            .cell(CellIndex.indexByColumnRow(
            columnIndex: col, rowIndex: row + 1))
            .value = rowMap[headers[col]]?.toString() ?? '';
      }

      // ✅ Update progress
      excelProgress.value = ((row + 1) / totalRows) * 100;

      // 👇 allows UI to repaint
      await Future.delayed(const Duration(milliseconds: 5));
    }

    /// Save file
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/non_standard_items.xlsx";

    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    excelProgress.value = 100;
    excelLoading.value = false;

    Get.back(); // close dialog
    await OpenFilex.open(filePath);
  }

  Map<String, dynamic> removeExcelKeys(
      NonStandardItemDataModal item) {
    final map = Map<String, dynamic>.from(item.toJson());

    // ❌ remove unwanted keys
    map.remove('condition');
    map.remove('message');
    map.remove('total_rows');

    return map;
  }



}