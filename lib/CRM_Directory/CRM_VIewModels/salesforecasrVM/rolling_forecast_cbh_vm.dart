import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/SalesForceCastModals/RollingForeCastListModal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Repository/salesforcecastRepository/SalesForeCastRepo.dart';

class RollingForeCastCBHVM extends GetxController{
  final _api = SalesForeCastRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;

  int pageNumber = 0;
  int total_rows = 0;
  int rowsPerPage = 10;

  String email = "";
  String filterRouting = "";
  String userType = "";
  String monthNameForApi = "";
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;
  RxBool excelLoading = false.obs;
  RxDouble excelProgress = 0.0.obs;
  RxString createdOnStartToEnd = "".obs;

  var itemCategoryCodeForApi;
  var ParentProductCategoryForApi;

  RxList<ItemCategoryMstModel> item_product_cat_list = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_item_product_cat_list = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> parentProductCategoryList = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> parentItemCategorySelectedList = <ItemCategoryMstModel>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  RxList<RollingForeCastListModal> rolling_fore_cast_list  = <RollingForeCastListModal>[].obs;
  RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];

  List<String> years = [];

  //todo filter controllers

  var rollingForceCastId = TextEditingController().obs;
  var quoteIdController=TextEditingController().obs;
  var saleCycleController=TextEditingController().obs;
  var customerNameController=TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;
  var AccountOwner_controller=TextEditingController().obs;
  var itemCodeController=TextEditingController().obs;
  var itemNameController=TextEditingController().obs;
  var qtyController=TextEditingController().obs;
  var itemVarient_Ctrl = TextEditingController().obs;
  var itemCategoryCodeController = TextEditingController().obs;
  var parentCategoryCodeController = TextEditingController().obs;
  var item_category_type_controller = TextEditingController().obs;
  var closerMonth_Ctrl = TextEditingController().obs;
  var closerYear_Ctrl = TextEditingController().obs;
  var createdOnController = TextEditingController().obs;
  var requiredRegionNameController = TextEditingController().obs;


  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> tempSelected = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> filtered = <EmployeeMemberModel>[].obs;
  RxBool selectOwner = true.obs;
  RxBool allSelected = false.obs;
  RxBool isSel = false.obs;
  var searchController=TextEditingController().obs;
  var AccountOwnerForApi;
  String accountNameCode='';



  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    email = await sessionManagement.getEmail() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    item_category_type_controller.value.text = "Contains";
    getCurrentDate();
    getItemCategoryMstWithoutTaskIdApi();
    getParentItemCategoryMstGet();
    getClustersGetByEmail();
    if (this.isAdminWritePermission == '1') {
      EmployeeMasterGet('');
    }
    else {
      getEmployeeTeamMemberGetByClusterRegionApi();
    }
  }
  getCurrentDate(){
    DateTime now = DateTime.now();
    String currentMonthName = months[DateTime.now().month - 1];
    //closerMonth_Ctrl.value.text=currentMonthName;
    int year = now.year;
    years.add((year-2).toString());
    years.add((year-1).toString());
    years.add((year).toString());
    years.add((year+1).toString());
    years.add((year+2).toString());
    years.add((year+3).toString());
    //closerYear_Ctrl.value.text = year.toString();
    //debugPrint("year and month $currentMonthName $year ${closerMonth_Ctrl.value.text} ${closerYear_Ctrl.value.text}");



  }

  Future<void> refreshList() async {
    pageNumber = 0;
    SalesForecastLinesGetNew(pageNumber, );
  }

  getItemCategoryMstWithoutTaskIdApi() async{
    try {
      Map<String, String> data = {

      };
      loading.value = true;
      String value = await _api.getItemCategoryMstWithoutTaskIdApiHit(data, sessionManagement);
      List<ItemCategoryMstModel> Response = (json.decode(value) as List<dynamic>).map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();

      if (Response.isNotEmpty && Response[0]?.condition.toString() == "True") {
        item_product_cat_list.value = Response!;
      } else {
        item_product_cat_list.value = [];
      }
    } catch (e) {
      item_product_cat_list.value = [];
      print('catch....${e.toString()}');
    }
    finally{
      loading.value=false;
    }

  }
  getParentItemCategoryMstGet() async{
    Map<String, String> data = {
      'filter_category': "",
    };
    this.loading.value = true;
    print(data);
    String value = await _api.ParentItemCategoryMstGet(data, sessionManagement);
    print(value);
    try {
      List<ItemCategoryMstModel> Response = (json.decode(value)
      as List<dynamic>).map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();
      if (Response.isNotEmpty && Response[0]?.condition.toString() == "True") {
        parentProductCategoryList.value = Response!;
      } else {
        parentProductCategoryList.value = [];
      }
    } catch (e) {
      parentProductCategoryList.value = [];
      print('catch....${e.toString()}');
    }
    finally{
      loading.value=false;
    }

  }
  void getClustersGetByEmail() async{
    try{
      Map<String, String> data={
        "email_id":email
      };
      loading.value=true;
      String onValue = await _api.clustersGetByEmailApiHit(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<ClusterModal> response = jsonResponse.map((e) => ClusterModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          clusterGetByEmailList.value=response;
          if (clusterGetByEmailList.value.isNotEmpty && SelectedCluster_list.isEmpty) {
            SelectedCluster_list.assignAll(clusterGetByEmailList.value);
            clusterName_controller.value.text = clusterGetByEmailList.value.map((e) => e.geoValue).join('|');
            getRegionsWithClusterFilterGetByEmail();
          }
        }else {
          clusterGetByEmailList.value=[];
        }
      }
    }catch(e){
      print(e);
    }finally{
      loading.value = false;
    }
  }

  void getRegionsWithClusterFilterGetByEmail() async{
    var selectedCluster="";
    try{
      if(clusterName_controller.value.text.isNotEmpty){
        selectedCluster = clusterName_controller.value.text
            .split(',')
            .map((e) => e.trim())
            .join('|');
      }

      Map<String, String> data={
        "email_id":email,
        "cluster_filter":selectedCluster.isEmpty?"":selectedCluster
      };
      loading.value=true;
      String onValue = await _api.RegionsWithClusterFilterGetByEmailApiHit(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<RegionWithClusterFilterModal> response = jsonResponse.map((e) => RegionWithClusterFilterModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          regionwithclusterGetByEmailList.value=response;
          RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
          SelectedRegion_list.assignAll(regionwithclusterGetByEmailList);
          getFilterData();

        }else {
          regionwithclusterGetByEmailList.value=[];
        }
      }
    }catch(e){
      print(e);
    }finally{
      loading.value = false;
    }
  }
  Future<Iterable<EmployeeMemberModel>> EmployeeMasterGet(String query) async {
    /*if (query == '') {
      return const Iterable<EmployeeMemberModel>.empty();
    }*/

    Map data = {
      'filter_name': query,
      'filter_email': "",
      'filter_location_id': '',
      'email_id': email,
      "filter_cluster_name": clusterName_controller.value.text.isNotEmpty?clusterName_controller.value.text:"",
      "filter_region_name": RegionName_controller.value.text.isNotEmpty?RegionName_controller.value.text:"",
      'rowsPerPage': 10,
      'pageNumber': 0,
    };
    loading.value = true;
    String employee_response =await _api.EmployeeMatserGetApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(employee_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<EmployeeMemberModel> response =
        jsonResponse.map((data) => EmployeeMemberModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          employee_Member_list.value = response;


        } else {
          // Utils.sanckBarException('False!', response[0].message!);
          employee_Member_list.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        employee_Member_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      employee_Member_list.value = [];
    }
    finally{
      loading.value = false;
    }
    return employee_Member_list.value;
  }
  getEmployeeTeamMemberGetByClusterRegionApi() {
    Map data = {
      "cluster_name": "",
      "email_id": email,
      "region_name": "",
      "flag": "GeoLevelLowerWithClusterRegion"
    };
    print(data);
    loading.value = true;
    try {
      _api.EmployeeTeamMemberGetByClusterRegion(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<EmployeeMemberModel> response =
            JsonResponse.map((e) => EmployeeMemberModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              employee_Member_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              employee_Member_list.value=[];
              //Utils.showErrorToastification("Error!", "No Date Found");
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          //service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      employee_Member_list.value = [];
      print(e);
    }
  }

  void SalesForecastLinesGetNew(int page_no) async{
    try{
      itemCategoryCodeForApi = '';
      if(itemCategoryCodeController.value.text.isNotEmpty){
        itemCategoryCodeForApi = itemCategoryCodeController.value.text
            .split(',')
            .map((e) => e.trim())
            .join('|');
      }
      ParentProductCategoryForApi='';
      if(parentCategoryCodeController.value.text.isNotEmpty){
        ParentProductCategoryForApi = parentCategoryCodeController.value.text
            .split(',')
            .map((e) => e.trim())
            .join('|');
      }
      AccountOwnerForApi = '';
      if(AccountOwner_controller.value.text.isNotEmpty){
        AccountOwnerForApi = AccountOwner_controller.value.text.split(',').map((e) => e.trim()).join('|');
      }
      Map<String, dynamic> data={
        "filter_sales_forecast_id": rollingForceCastId.value.text.isEmpty?"": rollingForceCastId.value.text,
        "filter_quote_id": quoteIdController.value.text.isEmpty?"": quoteIdController.value.text,
        "filter_sales_cycle_id": saleCycleController.value.text.isEmpty?"": saleCycleController.value.text,
        "filter_account_code": "",
        "filter_account_name": customerNameController.value.text.isEmpty?"": customerNameController.value.text,
        "filter_created_by": AccountOwnerForApi,
        "filter_created_on": createdOnStartToEnd.value,
        "filter_item_code": itemCodeController.value.text.isEmpty?"":itemCodeController.value.text,
        "filter_item_name":itemNameController.value.text.isEmpty?"":itemNameController.value.text,
        "filter_item_varient": itemVarient_Ctrl.value.text.isEmpty?"":itemVarient_Ctrl.value.text,
        "filter_item_category_type": item_category_type_controller.value.text.isEmpty?"":item_category_type_controller.value.text,
        "filter_item_category_code": itemCategoryCodeForApi,
        "filter_item_parent_category_code":ParentProductCategoryForApi,
        "filter_closure_month": monthNameForApi,
        "filter_closure_year": closerYear_Ctrl.value.text.isEmpty?"":closerYear_Ctrl.value.text,
        "filter_required_region_name": "",
        "filter_required_cluster_name": "",
        "filter_quote_validity": "",
        "filter_exp_closure_date": "",
        "filter_approved_by": "",
        "filter_approved_on": "",
        "filter_flag": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"": RegionName_controller.value.text,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"": clusterName_controller.value.text,

        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
      loading.value=true;
      print("data is ${data}");
      String onValue = await _api.SalesForecastLinesGetNew(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<RollingForeCastListModal> response = jsonResponse.map((e) => RollingForeCastListModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          if (page_no == 0) {
            rolling_fore_cast_list.clear();
          }
          rolling_fore_cast_list.addAll(response);
          total_rows = int.parse(rolling_fore_cast_list[0].totalRows!);
        }else {
          rolling_fore_cast_list.value=[];
        }
      }
    }catch(e){
      print(e);
    }finally{
      loading.value = false;
    }
  }

  void clearFilterData() {
    filterDataChecker.value='';
    rollingForceCastId.value.clear();
    quoteIdController.value.clear();
    saleCycleController.value.clear();
    customerNameController.value.clear();
    AccountOwner_controller.value.clear();
    accountNameCode='';
    AccountOwnerForApi = '';
    searchController.value.clear();
    itemCodeController.value.clear();
    itemNameController.value.clear();
    qtyController.value.clear();
    itemVarient_Ctrl.value.clear();
    itemCategoryCodeController.value.clear();
    parentCategoryCodeController.value.clear();
    closerMonth_Ctrl.value.clear();
    closerYear_Ctrl.value.clear();
    createdOnController.value.clear();
    createdOnStartToEnd.value='';
    requiredRegionNameController.value.clear();

    item_category_type_controller.value.text = "Contains";
    itemCategoryCodeForApi='';
    ParentProductCategoryForApi='';
    monthNameForApi = "";

    parentItemCategorySelectedList.value=[];
    Selected_item_product_cat_list.value=[];
    SelectedCluster_list.value=[];
    SelectedRegion_list.value=[];
    SelectedEmployee_Member_list.value = [];
    //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
    pageNumber=0;
    getRegionsWithClusterFilterGetByEmail();

  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveSaleForeCastCbhData({
      'rollingForceCastId': rollingForceCastId.value.text,
      'quoteIdController': quoteIdController.value.text,
      'saleCycleController': saleCycleController.value.text,
      'customerNameController': customerNameController.value.text,
      'AccountOwner_controller': AccountOwner_controller.value.text,
      'accountNameCode': accountNameCode,
      'itemCodeController': itemCodeController.value.text,
      'itemNameController': itemNameController.value.text,
      'qtyController': qtyController.value.text,
      'itemVarient_Ctrl': itemVarient_Ctrl.value.text,
      'itemCategoryCodeController': itemCategoryCodeController.value.text,
      'item_category_type_controller': item_category_type_controller.value.text,
      'parentCategoryCodeController': parentCategoryCodeController.value.text,
      'closerMonth_Ctrl': closerMonth_Ctrl.value.text,
      'monthNameForApi': monthNameForApi,
      'closerYear_Ctrl': closerYear_Ctrl.value.text,
      'createdOnController': createdOnController.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'requiredRegionNameController': requiredRegionNameController.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,


    });
    filterDataChecker.value='';
    SalesForecastLinesGetNew(pageNumber,);

  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getSaleForeCastCbhData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      rollingForceCastId.value.text=getFilterData["rollingForceCastId"]??"";
      quoteIdController.value.text=getFilterData["quoteIdController"]??"";
      saleCycleController.value.text=getFilterData["saleCycleController"]??"";
      customerNameController.value.text=getFilterData["customerNameController"]??"";
      AccountOwner_controller.value.text=getFilterData["AccountOwner_controller"]??"";
      accountNameCode=getFilterData["accountNameCode"]??"";
      itemCodeController.value.text=getFilterData["itemCodeController"]??"";
      itemNameController.value.text=getFilterData["itemNameController"]??"";
      qtyController.value.text=getFilterData["qtyController"]??"";
      itemVarient_Ctrl.value.text=getFilterData["itemVarient_Ctrl"]??"";
      itemCategoryCodeController.value.text=getFilterData["itemCategoryCodeController"]??"";
      item_category_type_controller.value.text=getFilterData["item_category_type_controller"]??"";
      parentCategoryCodeController.value.text=getFilterData["parentCategoryCodeController"]??"";
      closerMonth_Ctrl.value.text=getFilterData["closerMonth_Ctrl"]??"";
      monthNameForApi=getFilterData["monthNameForApi"]??"";
      closerYear_Ctrl.value.text=getFilterData["closerYear_Ctrl"]??"";
      createdOnController.value.text=getFilterData["createdOnController"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
      requiredRegionNameController.value.text=getFilterData["requiredRegionNameController"]??"";



      if(getFilterData["region_name"].toString().isNotEmpty && getFilterData["region_name"].toString()!=""){
        RegionName_controller.value.text = "";
        RegionName_controller.value.text = getFilterData["region_name"].toString()??"";
      }
      if(getFilterData["cluster_name"].toString().isNotEmpty && getFilterData["cluster_name"].toString()!=""){
        clusterName_controller.value.text="";
        clusterName_controller.value.text=getFilterData["cluster_name"].toString()??"";
        print("clusterName_controller.value.text.....${clusterName_controller.value.text}");
      }
    }
    SalesForecastLinesGetNew(pageNumber,);
  }

  void clearFilterSessionData() {
    filterDataChecker.value='';
    sessionManagement.clearSaleForeCastCbhData();
  }

  String setMonthNameInShort(String monthName) {
    String month = '';
    if(monthName=="January"){
      month='Jan';
    }
    else if(monthName=='February'){
      month='Feb';
    }
    else if(monthName=='March'){
      month='Mar';
    }
    else if(monthName=='April'){
      month='Apr';
    }
    else if(monthName=='May'){
      month='May';
    }
    else if(monthName=='June'){
      month='Jun';
    }
    else if(monthName=='July'){
      month='Jul';
    }
    else if(monthName=='August'){
      month='Aug';
    }
    else if(monthName=='September'){
      month='Sep';
    }
    else if(monthName=='October'){
      month='Oct';
    }
    else if(monthName=='November'){
      month='Nov';
    }
    else if(monthName=='December'){
      month='Dec';
    }
    return month;

  }

  Future<void> downloadForeCastLineDetaisForUploadWithProgress(BuildContext context, String sheetName, String saveFileName) async {
    try {
      if(rolling_fore_cast_list.length<=0){
        Utils.sanckBarError("Failed to download file!", "No Data Found");
      }
      excelLoading.value = true;
      excelProgress.value = 0;
      showExcelProgressDialog(context);

      final excel = Excel.createExcel();
      excel.rename('Sheet1', sheetName);
      final sheet = excel[sheetName];
      List<String> headers = [];

      final firstRowMap = headerExcelKeys(rolling_fore_cast_list.first);
      headers = firstRowMap.keys.toList();



      // Write Headers
      for (int col = 0; col < headers.length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0)).value
        = TextCellValue(headers[col]);
      }

      final totalRows = rolling_fore_cast_list.length;

      //if(sheetName=='Non Standard Items'){
      for (int row = 0; row < totalRows; row++) {
        final rowMap = headerExcelKeys(rolling_fore_cast_list.first);
        for (int col = 0; col < headers.length; col++) {
          final value = rowMap[headers[col]];
          sheet.cell(CellIndex.indexByColumnRow(
              columnIndex: col, rowIndex: row + 1)).value = value == null
              ? TextCellValue('') : TextCellValue(value.toString());
        }
        excelProgress.value = ((row + 1) / totalRows) * 100;
        await Future.delayed(const Duration(milliseconds: 5));
      }
      //}

      late Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        //dir = await getExternalStorageDirectory();
        //dir = await getTemporaryDirectory();

      } else {
        dir = await getApplicationDocumentsDirectory();
        //dir = await getExternalStorageDirectory();
      }



      // Ensure the directory exists
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      //final fileName = "non_standard_items_${DateTime.now().millisecondsSinceEpoch}.xlsx";
      final fileName = "${saveFileName}.xlsx";
      String filePath = "${dir?.path}/$fileName";
      int counter = 1;

      while (await File(filePath).exists()) {
        filePath = '${dir.path}/($counter)$fileName';
        counter++;
      }
      final file = File(filePath);
      try {
        debugPrint("Excel saved at2: $filePath");
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
      //await OpenFilex.open(filePath);
      if(Platform.isIOS){
        await Share.shareXFiles([XFile(filePath)],
            text: fileName);
      }
      else{
        await OpenFilex.open(filePath);
      }

      debugPrint("Excel saved at4: $filePath");
    }catch(e){
      excelProgress.value = 100;
      excelLoading.value = false;
      //print("Failed to download file! ${e.toString()}");
      Utils.sanckBarError("Failed to download file!", e.toString());
    }
  }
  Map<String, dynamic> headerExcelKeys(RollingForeCastListModal item) {
    final map = Map<String, dynamic>.from(item.toJson());
    map.remove('condition');
    map.remove('total_rows');
    map.remove('line_no');
    map.remove('created_by');
    map.remove('quote_qty');
    map.remove('quote_approved_amount_per_unit');
    map.remove('quote_validity');
    map.remove('approved_by');
    map.remove('approved_on');
    map.remove('est_closure_date');
    map.remove('est_budget_amount');
    map.remove('required_cluster_name');
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

}