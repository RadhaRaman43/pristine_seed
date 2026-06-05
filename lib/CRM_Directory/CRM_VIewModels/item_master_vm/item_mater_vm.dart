import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Repository/item_master_repo/item_master_repo.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../reources/routes/routes_name.dart';
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

  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;

  NonStandardItemDataModal item= NonStandardItemDataModal();
  String checkForExcel = "";
  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    getItemCategoryMstApi();

    itemMstSalesCycleGet(page_no:0,row_Per_Page: rowsPerPage);

  }

  itemMstSalesCycleGet({ required int page_no, required int  row_Per_Page, BuildContext? context }) async{
    try {
      Map data = {

        "sales_cycle_id": sale_cycle_id_Controller.value.text.isNotEmpty? sale_cycle_id_Controller.value.text:"",
        "account_code":  customer_code_Controller.value.text.isNotEmpty? customer_code_Controller.value.text:"",
        "account_name": "",
        "item_code": item_code_Controller.value.text.isNotEmpty? item_code_Controller.value.text:"",
        "name": name_Controller.value.text.isNotEmpty? name_Controller.value.text:"",
        "description": "",
        "category_code": category_Controller.value.text.isEmpty?"":category_Controller.value.text,
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
        "rowsPerPage": row_Per_Page,
        "pageNumber": page_no
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
              total_rows_items = int.parse(nonStandardList[0].totalRows!);
              print('listSize.....${nonStandardList.length} and  total rows ${total_rows_items}');
              if(checkForExcel=="CheckForExcel" && context!= null){
                nonStandardListForExcel.addAll(response);
                exportNonStandardExcelWithProgress(context,'Non Standard Items','non_standard_items');

              }
          }
            else{
              Utils.sanckBarError("False!", "No Data Found");
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
          Item_Category_master_list_without_task.value=Response;
          productCategoryList.value = Response!;
        }
        else{
          Item_Category_master_list_without_task.value=[];
        }
      } catch (e) {
      Item_Category_master_list_without_task.value=[];
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

  updateItemMasterCreateFromCRM(NonStandardItemDataModal nonStandardItem,String updateExcel, List<NonStandardItemDataModal> itemList ) async{
    try {
    List<Map<String,dynamic>> items = [];
    //print("excel file upload ${itemList[0].accountCode??""} and active ${itemList[0].active??""}");
    if(updateExcel!= null && updateExcel=="uploadExcel"){
      if(itemList.length<=0){
        Utils.sanckBarError("Input error!", "Please enter valid values");
      }
      else if(itemList[0].itemCode==null && itemList[0].itemCode!.isEmpty){
        Utils.sanckBarError("Item Code!", "Please enter valid item code");
      }
      else if(itemList[0].categoryName==null && itemList[0].categoryName!.isEmpty){
        Utils.sanckBarError("Item Code!", "Please enter valid item code");
      }
      for(int i=0;i<itemList.length;i++){
        final item = itemList[i];
        String hsn_code = double.parse(item.hsnCode?? "0").toInt().toString();
        String? expired_on = StaticMethod.convertDateFormat(item.expiredOn??"");
        String? rate_contract = StaticMethod.convertDateFormat(item.rateContractValidDate??"");
        items.add({
          "account_code": item.accountCode??"",
          "active": item.active=="0"?0:1,
          "branch_transfer_price":item.branchTransferPrice??"0",
          "brand_name": "",
          "brand_code": "",
          "base_uom": "PCS",
          "color_code": "",
          "cubic_capacity": "",
          "cost_per_unit": 0,
          "color_name": "",
          "category_code":  item.categoryName??"",
          "category_name": item.categoryName??"",
          "component_type":"SIMPLE",
          "description":item.name??"",
          "expired_on": expired_on??"" /*item.expiredOn??""*/,
          "expiry_range": 0,
          "ean_code": "",
          "gst_group_code": item.gstGroupCode??"",
          "hsn_code": /*item.hsnCode*/ hsn_code ??"",
          "height": 0,
          "item_code":item.itemCode??"",
          "is_expiry_mandatory": 0,
          "is_bulky": 0,
          "length": 0,
          "label": "",
          "list_selling_price": item.listSellingPrice??"0",
          "minimal_acceptable_price":item.minimalAcceptablePrice??"0",
          "manufacturer_code": "",
          "manufacturer_name": "",
          "mrp": 0,
          "moq": 0,
          "name": item.name??"",
          "product_type":item.productType??"",
          "product_group_code": "",
          "product_group_name": "",
          "purchase_uom": "PCS",
          "rate_contract_valid_date": rate_contract??"",
          "rsp": 0,
          "specification": item.specification??"",
          "sales_cycle_id": item.salesCycleId??"",
          "standard_cost":item.standardCost??"0",
          "sub_product_group_code": "",
          "sub_sub_product_group_code": "",
          "size_code": "",
          "style_code": "",
          "size_name": "",
          "style_name": "",
          "sale_uom": "PCS",
          "sub_product_group_name": "",
          "sub_sub_product_group_name": "",
          "thikness_gsm": 0,
          "transfer_cost": 0,
          "tolerance": 0,
          "tolerance_mrp": 0,
          "weight_in_kg": 0,
          "width": 0,
        });
      }
    }
    else{
      items.add({
        "account_code": update_customer_code_Controller.value.text.isNotEmpty?update_customer_code_Controller.value.text:"",
        "active": is_active_Controller.value.text=="Yes"?1:0,
        "brand_name": "",
        "brand_code": "",
        "base_uom": "",
        "branch_transfer_price": Btp_Controller.value.text.isNotEmpty?Btp_Controller.value.text:0,
        "category_code":  category_code_Controller.value.text.isNotEmpty?category_code_Controller.value.text:"",
        "category_name": "",
        "color_code": "",
        "cubic_capacity": "",
        "cost_per_unit": 0,
        "color_name": "",
        "component_type":component_type_Controller.value.text.isNotEmpty?component_type_Controller.value.text: "",
        "description": update_name_Controller.value.text.toString().isNotEmpty?update_name_Controller.value.text:"",
        "ean_code": "",
        "expired_on": expiry_date_Controller.value.text.isNotEmpty?expiry_date_Controller.value.text:"",
        "expiry_range": 0,
        "gst_group_code": nonStandardItem.gstGroupCode??"",
        "hsn_code": nonStandardItem.hsnCode??"",
        "is_bulky": 0,
        "is_expiry_mandatory": 0,
        "item_code": nonStandardItem.itemCode??"",
        "list_selling_price": LSP_Controller.value.text.isNotEmpty?LSP_Controller.value.text:0,
        "length": 0,
        "label": "",
        "height": 0,
        "name": update_name_Controller.value.text.isNotEmpty?update_name_Controller.value.text:"",
        "manufacturer_code": "",
        "manufacturer_name": "",
        "mrp": 0,
        "moq": 0,
        "minimal_acceptable_price": Map_Controller.value.text.isNotEmpty?Map_Controller.value.text:0,
        "product_type": product_type_Controller.value.text.isNotEmpty?product_type_Controller.value.text:"",
        "product_group_code": "",
        "product_group_name": "",
        "purchase_uom": "",
        "rate_contract_valid_date":rate_contract_validity_date_Controller.value.text.isNotEmpty?rate_contract_validity_date_Controller.value.text: "",
        "rsp": 0,
        "specification": update_specification_Controller.value.text.isNotEmpty?update_specification_Controller.value.text:"",
        "sales_cycle_id": update_sale_cycle_id_Controller.value.text.isNotEmpty?update_sale_cycle_id_Controller.value.text:"",
        "sub_product_group_code": "",
        "sub_sub_product_group_code": "",
        "size_code": "",
        "style_code": "",
        "size_name": "",
        "style_name": "",
        "sale_uom": "",
        "standard_cost":standard_cost_Controller.value.text.isNotEmpty?standard_cost_Controller.value.text:0,
        "sub_product_group_name": "",
        "sub_sub_product_group_name": "",
        "thikness_gsm": 0,
        "transfer_cost": 0,
        "tolerance": 0,
        "tolerance_mrp": 0,
        "weight_in_kg": 0,
        "width": 0,

      });
    }
      Map data = {
        "items":items,
      };

      print('sale data ${data}');
      loading.value = true;
      String onValue = await _api.ItemMasterCreateFromCRM(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if (jsonResponse is List) {
        List<NonStandardItemDataModal> response = jsonResponse.map((e) => NonStandardItemDataModal.fromJson(e)).toList();
        if (response != null && response.length > 0 && response[0].condition == "True") {
          if(updateExcel=="uploadExcel"){
            Utils.sanckBarSuccess("True!", "Items Update Successfully");
            itemMstSalesCycleGet(page_no:0,row_Per_Page: rowsPerPage);
          }
          else{
            Utils.sanckBarSuccess("True!", "Item Update Successfully");
            Get.offAllNamed(RoutesName.nonStandardItemList);
          }
        }
        else{
          Utils.sanckBarError("False!", response[0].message.toString());
        }
      }
    } catch (e) {
      Utils.sanckBarError("Exception error!", e.toString());
      print('Exception..${e.toString()}');
    }
    finally{
      loading.value = false;
    }
  }

  void updateNonStandardData(NonStandardItemDataModal nonStandardItem) {
    item=nonStandardItem;
    update_name_Controller.value.text = nonStandardItem.name??"";
    category_code_Controller.value.text = nonStandardItem.categoryCode??"";
    product_type_Controller.value.text = nonStandardItem.productType??"";
    update_GST_group_code_Controller.value.text = nonStandardItem.gstGroupCode??"";
    update_HSN_code_Controller.value.text = nonStandardItem.hsnCode??"";
    update_customer_code_Controller.value.text = nonStandardItem.accountCode??"";
    update_sale_cycle_id_Controller.value.text = nonStandardItem.salesCycleId??"";
    component_type_Controller.value.text = nonStandardItem.componentType??"";
    update_specification_Controller.value.text = nonStandardItem.specification??"";
    LSP_Controller.value.text = nonStandardItem.listSellingPrice.toString();
    Btp_Controller.value.text = nonStandardItem.branchTransferPrice.toString() ??"";
    Map_Controller.value.text = nonStandardItem.minimalAcceptablePrice.toString() ??"";
    standard_cost_Controller.value.text = nonStandardItem.standardCost.toString() ??"";
    is_active_Controller.value.text = nonStandardItem.active==1?"Yes":"No";
    rate_contract_validity_date_Controller.value.text = nonStandardItem.rateContractValidDate??"";
    expiry_date_Controller.value.text = nonStandardItem.expiredOn??"";
  }

  clearFilterData(){
    Selected_Item_Category_master_list_without_task.value=[];
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
    itemMstSalesCycleGet(page_no:pageNumber,row_Per_Page: rowsPerPage);


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
      itemMstSalesCycleGet(page_no:pageNumber,row_Per_Page: rowsPerPage);
    }
  }
  void clearSaveFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearitemMasterData();
  }

  void downLoadSample(BuildContext context) {
    print("Sample Non Standard Items");
    exportNonStandardExcelWithProgress(context,'Sample Non Standard Items','sample_non_standard_items');
  }

  /*Future<void> exportNonStandardExcelWithProgress(BuildContext context, String sheetName, String saveFileName) async {
    try {

      excelLoading.value = true;
      excelProgress.value = 0;
      showExcelProgressDialog(context);
      final excel = Excel.createExcel();
      excel.rename('Sheet1', sheetName);
      final sheet = excel[sheetName];

      //final firstRowMap = removeExcelKeys(nonStandardListForExcel.first,sheetName);
      //final headers = firstRowMap.keys.toList();
      List<String> headers = [];

      if (sheetName=='Non Standard Items') {
        final firstRowMap = removeExcelKeys(nonStandardListForExcel.first, sheetName);
        headers = firstRowMap.keys.toList();
      }
      else {
        headers = [
          "category_name",
          "item_code",
          "name",
          "hsn_code",
          "account_code",
          "product_type",
          "list_selling_price",
          "minimal_acceptable_price",
          "branch_transfer_price",
          "standard_cost",
          "active",
          "gst_group_code",
          "specification",
          "sales_cycle_id",
          "rate_contract_valid_date",
          "expired_on",
        ];
      }

      // Write Headers
      for (int col = 0; col < headers.length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
            .value = TextCellValue(headers[col]);
      }

      final totalRows = nonStandardListForExcel.length;

      if(sheetName=='Non Standard Items'){
        for (int row = 0; row < totalRows; row++) {
          final rowMap = removeExcelKeys(nonStandardListForExcel[row],sheetName);
          for (int col = 0; col < headers.length; col++) {
            final value = rowMap[headers[col]];
            sheet.cell(CellIndex.indexByColumnRow(
                columnIndex: col, rowIndex: row + 1)).value = value == null
                ? TextCellValue('') : TextCellValue(value.toString());
          }
          excelProgress.value = ((row + 1) / totalRows) * 100;
          await Future.delayed(const Duration(milliseconds: 5));
        }
      }

      late Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
      } else {
        //dir = await getApplicationDocumentsDirectory();
        dir = await getExternalStorageDirectory();
      }

      //final fileName = "non_standard_items_${DateTime.now().millisecondsSinceEpoch}.xlsx";
      final fileName = "${saveFileName}.xlsx";
      final filePath = "${dir?.path}/$fileName";
      final file = File(filePath);
      // Delete old file if exists
      *//*if (await file.exists()) {
        await file.delete();
      }*//*
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        debugPrint("Delete skipped: $e");
      }
      await file.writeAsBytes(excel.encode()!);
      excelProgress.value = 100;
      excelLoading.value = false;
      Get.back();
      // Open File
      await OpenFilex.open(filePath);
      debugPrint("Excel saved at: $filePath");
    }catch(e){
      excelProgress.value = 100;
      excelLoading.value = false;
      print("Failed to download file! ${e.toString()}");
      Utils.sanckBarError("Failed to download file!", e.toString());
    }
  }
*/

  Future<void> exportNonStandardExcelWithProgress(BuildContext context, String sheetName, String saveFileName,) async {
    try {
      excelLoading.value = true;
      excelProgress.value = 0;
      showExcelProgressDialog(context);
      /// STORAGE PERMISSION
      /*if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        *//*var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          Get.back();
          Utils.sanckBarError(
            "Permission",
            "Storage permission denied",
          );
          return;
        }*//*
      }*/
      /// CREATE EXCEL
      final excel = Excel.createExcel();
      excel.rename('Sheet1', sheetName);
      final sheet = excel[sheetName];
      List<String> headers = [];

      if (sheetName=='Non Standard Items') {
        final firstRowMap = removeExcelKeys(nonStandardListForExcel.first, sheetName);
        headers = firstRowMap.keys.toList();
      }
      else {
        headers = [
          "category_name",
          "item_code",
          "name",
          "hsn_code",
          "account_code",
          "product_type",
          "list_selling_price",
          "minimal_acceptable_price",
          "branch_transfer_price",
          "standard_cost",
          "active",
          "gst_group_code",
          "specification",
          "sales_cycle_id",
          "rate_contract_valid_date",
          "expired_on",
        ];
      }

      // Write Headers
      for (int col = 0; col < headers.length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
            .value = TextCellValue(headers[col]);
      }

      final totalRows = nonStandardListForExcel.length;

      if(sheetName=='Non Standard Items'){
        for (int row = 0; row < totalRows; row++) {
          final rowMap = removeExcelKeys(nonStandardListForExcel[row],sheetName);
          for (int col = 0; col < headers.length; col++) {
            final value = rowMap[headers[col]];
            sheet.cell(CellIndex.indexByColumnRow(
                columnIndex: col, rowIndex: row + 1)).value = value == null
                ? TextCellValue('') : TextCellValue(value.toString());
          }
          excelProgress.value = ((row + 1) / totalRows) * 100;
          await Future.delayed(const Duration(milliseconds: 5));
        }
      }
    /*  /// WRITE HEADERS
      for (int col = 0; col < headers.length; col++) {

        sheet
            .cell(
          CellIndex.indexByColumnRow(
            columnIndex: col,
            rowIndex: 0,
          ),
        )
            .value = TextCellValue(headers[col]);
      }

      final totalRows = nonStandardListForExcel.length;

      /// WRITE DATA
      for (int row = 0; row < totalRows; row++) {
        final rowMap = removeExcelKeys(nonStandardListForExcel[row], sheetName);
        for (int col = 0; col < headers.length; col++) {
          final value = rowMap[headers[col]];

          sheet.cell(
            CellIndex.indexByColumnRow(
              columnIndex: col,
              rowIndex: row + 1,
            ),
          )
              .value = value == null
              ? TextCellValue('')
              : TextCellValue(value.toString());
        }

        excelProgress.value = ((row + 1) / totalRows) * 100;

        await Future.delayed(
          const Duration(milliseconds: 5),
        );
      }*/

      /// DOWNLOAD DIRECTORY
      Directory dir = Directory(
        '/storage/emulated/0/Download',
      );

      /// CREATE DIRECTORY IF NOT EXISTS
      if (!await dir.exists()) {
        await dir.create(
          recursive: true,
        );
      }

      final fileName = "$saveFileName.xlsx";

      final filePath = "${dir.path}/$fileName";

      final file = File(filePath);

      /// DELETE OLD FILE
      if (await file.exists()) {

        await file.delete();
      }

      final bytes = excel.encode();

      if (bytes == null) {

        throw Exception("Excel encode failed");
      }

      /// SAVE FILE
      await file.writeAsBytes(
        bytes,
        flush: true,
      );

      excelProgress.value = 100;

      excelLoading.value = false;

      Get.back();

      debugPrint("Excel saved at: $filePath");

      /// OPEN FILE
      await OpenFilex.open(filePath);

      Utils.sanckBarSuccess(
        "Success",
        "File saved in Downloads",
      );

    } catch (e) {

      excelProgress.value = 100;

      excelLoading.value = false;

      Get.back();

      debugPrint("Export Error: $e");

      Utils.sanckBarError(
        "Failed",
        e.toString(),
      );
    }
  }

  Map<String, dynamic> removeExcelKeys(NonStandardItemDataModal item, String sheetName) {
    final map = Map<String, dynamic>.from(item.toJson());

    if(sheetName=='Non Standard Items') {
      map.remove('condition');
      map.remove('message');
      map.remove('total_rows');
    }else{
      map.remove('condition');
      map.remove('message');
      map.remove('total_rows');
      map.remove('updated_on');
      //map.remove('component_type');
      map.remove('category_code');
    }

    return map;
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


  Future<void> uploadExcelToServer() async {
    try {
      File? file = await pickExcelFile();
      //File? file = await getExcelFile();
      if (file == null){
        return;
      }
      List<Map<String, dynamic>> excelData = await readExcelFile(file);
      if(excelData.length>=1 && excelData!=null) {
        List<NonStandardItemDataModal> modelList = convertToModel(excelData);
        if (modelList[0].accountCode!.isNotEmpty) {
          updateItemMasterCreateFromCRM(item, "uploadExcel", modelList);
        }
        else{
          Utils.sanckBarError("Data Input Error!", "Can't insert null value into column 'account code'");
        }
      }
      else{
        Utils.sanckBarError("Data Input Error!", "Can't insert null value into column");
      }

    }catch(e){
      Utils.sanckBarError("failed to upload file!", e.toString());
      print("fa........${e.toString() }");
    }
  }

  Future<File?> pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }

    return null;
  }
  Future<File?> getExcelFile() async {
    Directory dir = Directory('/storage/emulated/0/Download');
    List<FileSystemEntity> files = dir.listSync();
    List<File> excelFiles = files.whereType<File>().where((file) =>
        file.path.endsWith("sample_non_standard_items.xlsx")).toList();
    if (excelFiles.isEmpty) {
      Utils.sanckBarError("False message!", "Data Not Found");
      return null;
    }
    excelFiles.sort((a, b) =>
        b.lastModifiedSync().compareTo(a.lastModifiedSync()));

    return excelFiles.first;
  }

  Future<List<Map<String, dynamic>>> readExcelFile(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> excelData = [];

    for (var table in excel.tables.keys) {

      var rows = excel.tables[table]!.rows;

      List headers = rows.first;

      for (int i = 1; i < rows.length; i++) {
        Map<String, dynamic> rowMap = {};
        for (int j = 0; j < headers.length; j++) {
            String header = headers[j]?.value?.toString() ?? "";
            String value = rows[i].length > j ? rows[i][j]?.value?.toString() ?? "" : "";
            rowMap[header] = value;

            //rowMap[headers[j]!.value.toString()] = rows[i][j]?.value.toString();
          //debugPrint("value...... ${rows[i][j]?.value.toString()} and ${headers[j]!.value.toString()}");
        }
        excelData.add(rowMap);
      }
    }

    return excelData;
  }
  List<NonStandardItemDataModal> convertToModel(List<Map<String, dynamic>> data) {
    print("excel data ${data}");
    return data.map((e) {
      e['minimal_acceptable_price'] = double.tryParse(e['minimal_acceptable_price']?.toString() ?? '');
      e['standard_cost'] = double.tryParse(e['standard_cost']?.toString() ?? '');
      e['list_selling_price'] = double.tryParse(e['list_selling_price']?.toString() ?? '');
      e['branch_transfer_price'] = double.tryParse(e['branch_transfer_price']?.toString() ?? '');
      e['active'] = int.tryParse(e['active']?.toString() ?? '');
      return NonStandardItemDataModal.fromJson(e);
    }).toList();
  }




}