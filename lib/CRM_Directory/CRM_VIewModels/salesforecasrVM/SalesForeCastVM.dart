import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/SalesForceCastModals/ForceCastListModal.dart';
import '../../CRM_Models/SalesForceCastModals/ForeCastQuoteDowExcelModal.dart';
import '../../CRM_Models/SalesForceCastModals/SalesForceCastHeaderModal.dart';
import '../../CRM_Models/SalesForceCastModals/SalesForceCastListModal.dart';
import '../../CRM_Models/SalesForceCastModals/forecastCreateResponseModal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/sale_cycle_modal/Pending_Draft_Quote_model.dart';
import '../../CRM_Repository/salesforcecastRepository/SalesForeCastRepo.dart';

class SalesForeCastVM extends GetxController{
  final _api = SalesForeCastRepo();
  SessionManagement sessionManagement = SessionManagement();

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  int total_Quote_List_rows = 0;
  int total_rows_sales_force = 0;
  int pageNumberForQuote = 0;
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;
  RxBool loading = false.obs;
  RxBool showList = false.obs;
  RxBool showForeCstList = true.obs;
  RxBool selectAllQuoteList = false.obs;
  RxBool selectAllForeCastList = false.obs;
  String email = "";
  String filterRouting = "";
  String userType = "";
  String quoteIds = "";
  String fromPage = "";
  String forceCastId = "";
  String monthNameForApi = "";
  RxBool excelLoading = false.obs;
  RxDouble excelProgress = 0.0.obs;

  RxString foreCastStatus = "Pending".obs;
  RxList<SalesForceCastListModal> sales_force_cast_list  = <SalesForceCastListModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;
  RxList<SalesForceCastHeaderModal> salesForceCastHeader_list = <SalesForceCastHeaderModal>[].obs;
  RxList<ForceCastListModal> ForeCastQuote_list = <ForceCastListModal>[].obs;
  RxList<ForceCastListModal> selectedForeCastQuote_list = <ForceCastListModal>[].obs;

  RxList<Pending_Draft_Quote_Model> QuoteList=<Pending_Draft_Quote_Model>[].obs;
  RxList<Pending_Draft_Quote_Model> SelectedQuoteList=<Pending_Draft_Quote_Model>[].obs;
  RxList<ForecastCreateResponseModal> forcastResponseList=<ForecastCreateResponseModal>[].obs;
  RxList<ForeCastQuoteDowExcelModal> quoteDowExcelList=<ForeCastQuoteDowExcelModal>[].obs;
  ForeCastQuoteDowExcelModal item= ForeCastQuoteDowExcelModal();
  //filter fields
  var salesForceCastId = TextEditingController().obs;
  var createdOnCnontroller = TextEditingController().obs;
  var createdOn_from_to_date_Controller = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;
  var month_year_controller = TextEditingController().obs;
  var AccountOwner_controller=TextEditingController().obs;

  var month_controller = TextEditingController().obs;
  var year_controller = TextEditingController().obs;

  //todo quote filter

  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteSaleCycleController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var accountCodeController=TextEditingController().obs;
  var filterQuoteVersionController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;
  var product_category_type_Controller = TextEditingController().obs;
  var parentProductCategoryController=TextEditingController().obs;


  //todo there is no use these controllers yet now
  var quoteStatusController=TextEditingController().obs;
  var rh_Approval_controller=TextEditingController().obs;
  var cbh_Approval_controller=TextEditingController().obs;
  var category_Approval_controller=TextEditingController().obs;
  var gm_Approval_controller=TextEditingController().obs;
  var createdByCnontroller=TextEditingController().obs;
  var itemCodeController=TextEditingController().obs;
  var itemNameController=TextEditingController().obs;
  var quantityFilterController=TextEditingController().obs;
  var GmDiscountPerController=TextEditingController().obs;
  var BmDiscountPerController=TextEditingController().obs;
  var SalesCreditController=TextEditingController().obs;
  var LSPFilterController=TextEditingController().obs;
  var BTPFilterController=TextEditingController().obs;
  var MAPFilterController=TextEditingController().obs;
  var StandardCostController=TextEditingController().obs;



  //todo download excel filter
  var quoteId_ex_Ctrl = TextEditingController().obs;
  var saleCycleId_ex_Ctrl = TextEditingController().obs;
  var closerMonth_ex_Ctrl = TextEditingController().obs;
  var closerYear_ex_Ctrl = TextEditingController().obs;
  var cluster_name_ex_Ctrl = TextEditingController().obs;
  var region_name_ex_Ctrl = TextEditingController().obs;
  var itemCode_ex_Ctrl = TextEditingController().obs;
  var itemName_ex_Ctrl = TextEditingController().obs;
  var itemVarient_ex_Ctrl = TextEditingController().obs;


  var product_category_ex_Ctrl = TextEditingController().obs;
  var parent_product_category_ex_Ctrl = TextEditingController().obs;
  var item_category_type_ex_Ctrl = TextEditingController().obs;



  var filterQuoteAcceptedController = TextEditingController().obs;
  RxList<String> qouteAcceptedList = ["All", "Open", "Loss", "Won"].obs;
  RxList<ItemCategoryMstModel> parentProductCategoryList = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> parentItemCategorySelectedList = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> item_product_cat_list = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_item_product_cat_list = <ItemCategoryMstModel>[].obs;
  RxList<String> QuoteStatusList = ["All", "DRAFT", "PENDING FOR APPROVAL", ].obs;
  List<String> productCategoryTypeList = ["Contains","Equals To"];
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> years = [];

  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> tempSelected = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> filtered = <EmployeeMemberModel>[].obs;
  RxBool selectOwner = true.obs;
  RxBool allSelected = false.obs;
  RxBool isSel = false.obs;
  var searchController=TextEditingController().obs;
  var AccountOwnerForApi;

  RxString createdOnStartToEnd = "".obs;
  RxString extClosureStartToEnd = "".obs;
  RxString quoteValidityStartToEnd = "".obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    email = await sessionManagement.getEmail() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    getItemCategoryMstWithoutTaskIdApi();
    getParentItemCategoryMstGet();
    getCurrentDate();
    getClustersGetByEmail();
    if (this.isAdminWritePermission == '1') {
      EmployeeMasterGet('');
    }
    else {
      getEmployeeTeamMemberGetByClusterRegionApi();
    }
  }
  Future<void> refreshList() async {
    pageNumber = 0;
    product_category_type_Controller.value.text="Contains";
    getSalesForecastListGet(pageNumber, );
  }
  clearExcelController(){
    quoteId_ex_Ctrl.value.clear();
    saleCycleId_ex_Ctrl.value.clear();
    closerMonth_ex_Ctrl.value.clear();
    closerYear_ex_Ctrl.value.clear();
    cluster_name_ex_Ctrl.value.clear();
    region_name_ex_Ctrl.value.clear();
    itemCode_ex_Ctrl.value.clear();
    itemName_ex_Ctrl.value.clear();
    itemVarient_ex_Ctrl.value.clear();
    product_category_ex_Ctrl.value.clear();
    monthNameForApi = "";
    item_category_type_ex_Ctrl.value.clear();
    parentItemCategorySelectedList.value=[];
    Selected_item_product_cat_list.value=[];
  }


  void toggleSalesCheckbox(int index, BuildContext context) {
    var item = QuoteList[index];
    item.isSelected = item.isSelected == 1 ? 0 : 1;
    if (item.isSelected == 1) {
      QuoteList[index].isSelected=1;
      SelectedQuoteList.add(item);
    } else {
      QuoteList[index].isSelected=0;
      SelectedQuoteList.removeWhere((element) => element.quoteId==item.quoteId);
      //SelectedQuoteList.remove(item);
      debugPrint("length..... ${SelectedQuoteList.length} ${""}");
    }
    showList.value = false;
    showList.value = true;

  }
  void selectAllQuoteCheckbox() {

    selectAllQuoteList.value = selectAllQuoteList.value ? false : true;
    if (selectAllQuoteList.value) {
      for(int i=0;i<QuoteList.length;i++){
        QuoteList[i].isSelected=1;
      }

      SelectedQuoteList.value=[];
      SelectedQuoteList.value=QuoteList;
    }
    else{
      for(int i=0;i<QuoteList.length;i++){
        QuoteList[i].isSelected=0;
      }
      SelectedQuoteList.value=[];
    }
    showList.value = false;
    showList.value = true;

  }

  void toggleForeCastListCheckbox(int index, BuildContext context) {
    var item = ForeCastQuote_list[index];
    item.isSelected = item.isSelected == 1 ? 0 : 1;
    if (item.isSelected == 1) {
      ForeCastQuote_list[index].isSelected=1;
      selectedForeCastQuote_list.add(item);
    } else {
      ForeCastQuote_list[index].isSelected=0;
      //selectedForeCastQuote_list.remove(item);
      selectedForeCastQuote_list.removeWhere((e)=>(e.quoteId==item.quoteId
          && e.itemCode==item.itemCode && e.lineNo==item.lineNo));
    }
    showForeCstList.value = false;
    showForeCstList.value = true;

  }

  void selectAllForeCastCheckbox() {
    selectAllForeCastList.value = selectAllForeCastList.value ? false : true;
    if (selectAllForeCastList.value) {
      for(int i=0;i<ForeCastQuote_list.length;i++){
        ForeCastQuote_list[i].isSelected=1;
      }
      selectedForeCastQuote_list.value=[];
      selectedForeCastQuote_list.value=ForeCastQuote_list;
    } else {
      for(int i=0;i<ForeCastQuote_list.length;i++){
        ForeCastQuote_list[i].isSelected=0;
      }
      selectedForeCastQuote_list.value=[];
      debugPrint("Unselect all... ${selectAllForeCastList.value}");
    }
    showForeCstList.value = false;
    showForeCstList.value = true;

  }

  clearSelectQuoteItemList(){
      for(int i=0;i<QuoteList.length;i++){
        QuoteList[i].isSelected=0;
      }
      SelectedQuoteList.value=[];
      selectAllQuoteList.value =false;
  }

  getCurrentDate(){
    DateTime now = DateTime.now();
    String currentMonthName = months[DateTime.now().month - 1];
    month_controller.value.text=currentMonthName;
    int year = now.year;
    years.add((year-1).toString());
    years.add((year).toString());
    years.add((year+1).toString());
    year_controller.value.text = year.toString();
    print("year and month $currentMonthName $year ${month_controller.value.text} ${year_controller.value.text}");



  }
  String numberFormatWithComma(dynamic number) {
    if (number == null || number.toString().isEmpty) return "0.00";

    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(num.parse(number.toString()));
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

  void getClustersGetByEmail() async{
    try{
      Map<String, String> data={
        "email_id":email
      };
      loading.value=true;
      print("data is ${data}");
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
            getRegionsWithClusterFilterGetByEmail("");
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
  void getRegionsWithClusterFilterGetByEmail(String fromPage) async{
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
      print("data is ${data}");
      String onValue = await _api.RegionsWithClusterFilterGetByEmailApiHit(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<RegionWithClusterFilterModal> response = jsonResponse.map((e) => RegionWithClusterFilterModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          regionwithclusterGetByEmailList.value=response;
          RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
          SelectedRegion_list.assignAll(regionwithclusterGetByEmailList);
          if(fromPage=="SalesForeCastScreen" || fromPage=="CreateSalesForeCastScreen"){
            getSalesForceCastQuoteData();
          }
          else if(fromPage=="ClearSalesForeCast"){
            getFilterData();
          }
          else if(fromPage=="ForeCastItemScreen"){
            /*filterQuoteIdController.value.text = SelectedQuoteList.map((e) => e.quoteId).join(' | ');
            quoteIds = filterQuoteIdController.value.text;*/
            filterQuoteIdController.value.text="";
            getForeCastQuoteList(0,"ALLQuoteLineItemsForSalesForecast");
          }
          else{
            getFilterData();
          }

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
  void getSalesForecastListGet(int page_no) async{
    try{
      AccountOwnerForApi = '';
      if(AccountOwner_controller.value.text.isNotEmpty){
        AccountOwnerForApi = AccountOwner_controller.value.text.split(',').map((e) => e.trim()).join('|');
      }
      Map<String, dynamic> data={
        "filter_sales_forecast_id":salesForceCastId.value.text.isEmpty? "":salesForceCastId.value.text,
        "filter_quote_id": "",
        "filter_sales_cycle_id": "",
        "filter_month_year": ""/*month_year_controller.value.text.isEmpty?"":month_year_controller.value.text*/,
        "filter_sales_forecast_status": foreCastStatus.value,
       "filter_created_by": email,
        "filter_created_on": createdOnCnontroller.value.text.isEmpty?"":createdOnCnontroller.value.text,
        "filter_created_by_new": AccountOwnerForApi,
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
      loading.value=true;
      print("data is ${data}");
      String onValue = await _api.SalesForecastHeaderGet(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<SalesForceCastListModal> response = jsonResponse.map((e) => SalesForceCastListModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          if (page_no == 0) {
            sales_force_cast_list.clear();
          }
          sales_force_cast_list.addAll(response);
          total_rows_sales_force = int.parse(sales_force_cast_list[0].totalRows!);
        }else {
          sales_force_cast_list.value=[];
        }
      }
    }catch(e){
      print(e);
    }finally{
      loading.value = false;
    }
  }

  void getSalesForecastHeaderGetBySalesForecastId(String salesForeCastId) async{
    try{
      Map<String, dynamic> data={
        "sales_forecast_id": salesForeCastId
      };
      loading.value=true;
      print("data is ${data}");
      String onValue = await _api.SalesForecastHeaderGetBySalesForecastId(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<SalesForceCastHeaderModal> response = jsonResponse.map((e) => SalesForceCastHeaderModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          salesForceCastHeader_list.value = response;
          List<String> parts = salesForceCastHeader_list[0].monthYear!.split('-');
          month_controller.value.text = parts[0];
          year_controller.value.text = parts[1];
          forceCastId= salesForceCastHeader_list[0].salesForecastId??"";
          print("cjnge screen .....");
          Get.toNamed(RoutesName.SalesForeCastHeaderDetailsScreen);
        }else {
          salesForceCastHeader_list.value=[];
          Utils.sanckBarError("No data fount", response[0].message.toString());
        }
      }
    }catch(e){
      print(e);
      Utils.sanckBarError("Exception!", e.toString());
    }finally{
      loading.value = false;
    }
  }

  getQuoteList(int pageNumberForQuote,) async{
    try{
      AccountOwnerForApi = '';
      if(AccountOwner_controller.value.text.isNotEmpty){
        AccountOwnerForApi = AccountOwner_controller.value.text.split(',').map((e) => e.trim()).join('|');
      }
      Map data={
        "filter_quote_id": filterQuoteIdController.value.text.isEmpty?"":filterQuoteIdController.value.text,
        "filter_sales_cycle_id": filterQuoteSaleCycleController.value.text.isEmpty?"":filterQuoteSaleCycleController.value.text,
        "filter_account_code": accountCodeController.value.text.isEmpty?"":accountCodeController.value.text,
        "filter_account_name": accountNameController.value.text.isEmpty?"":accountNameController.value.text,
        "filter_rh_approval": rh_Approval_controller.value.text.isEmpty?"":rh_Approval_controller.value.text,
        "filter_cbh_approval": cbh_Approval_controller.value.text.isEmpty?"":cbh_Approval_controller.value.text,
        "filter_category_approval": category_Approval_controller.value.text.isEmpty?"":category_Approval_controller.value.text,
        "filter_gm_approval": gm_Approval_controller.value.text.isEmpty?"":gm_Approval_controller.value.text,
        "filter_quote_version": filterQuoteVersionController.value.text.isEmpty?"-1":filterQuoteVersionController.value.text,
        "filter_quote_validity": quoteValidityStartToEnd.value.isEmpty?"":quoteValidityStartToEnd.value,
        "filter_exp_closure_date": extClosureStartToEnd.value.isEmpty?"":extClosureStartToEnd.value,
        "filter_quote_status": quoteStatusController.value.text.isEmpty || quoteStatusController.value.text == 'All'?"":quoteStatusController.value.text,
        "filter_flag": "All",
        "filter_product_category": productCategoryController.value.text.isEmpty?"":productCategoryController.value.text,
        "filter_parent_product_category": parentProductCategoryController.value.text.isEmpty?"":parentProductCategoryController.value.text,
        "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
        "filter_created_by": isAdminWritePermission == '1'?'':email,
        "filter_created_on": createdOnStartToEnd.value.isNotEmpty?createdOnStartToEnd.value:"",
        "filter_frontliner_value": "",
       "filter_spr_no": "",
        "filter_item_code": itemCodeController.value.text.isEmpty?"":itemCodeController.value.text,
        "filter_item_name": itemNameController.value.text.isEmpty?"":itemNameController.value.text,
        "filter_quantity": quantityFilterController.value.text.isEmpty?"":quantityFilterController.value.text,
        "filter_gm_per": GmDiscountPerController.value.text.isEmpty?"":GmDiscountPerController.value.text,
        "filter_bm_per": BmDiscountPerController.value.text.isEmpty?"":BmDiscountPerController.value.text,
        "filter_sales_credit": SalesCreditController.value.text.isEmpty?"":SalesCreditController.value.text,
        "filter_lsp": LSPFilterController.value.text.isEmpty?"":LSPFilterController.value.text,
        "filter_map": MAPFilterController.value.text.isEmpty?"":MAPFilterController.value.text,
        "filter_btp": BTPFilterController.value.text.isEmpty?"":BTPFilterController.value.text,
        "filter_standard_cost": StandardCostController.value.text.isEmpty?"":StandardCostController.value.text,
        "filter_quote_accepted": "Open|Rate Contract|Won",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value":"",
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "row_per_page": rowsPerPage,
        "page_number": pageNumberForQuote
      };
      loading.value=true;

      String onValue = await _api.QuoteHeaderGetForSalesForecast(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<Pending_Draft_Quote_Model> response = jsonResponse.map((e) => Pending_Draft_Quote_Model.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          if(pageNumberForQuote==0){
            QuoteList.clear();
          }
          QuoteList.addAll(response);
          total_rows=int.parse(QuoteList[0].totalRows!);
          if (selectAllQuoteList.value) {
            for(int i=0;i<QuoteList.length;i++){
              QuoteList[i].isSelected=1;
            }
            SelectedQuoteList.value=[];
            SelectedQuoteList.value=QuoteList;
            showList.value = false;
            showList.value = true;
          }
          else if(SelectedQuoteList.length>0){
            for(var selectedItem in SelectedQuoteList){
              int index = QuoteList.indexWhere((item) => item.quoteId == selectedItem.quoteId,);
              if (index != -1) {
                QuoteList[index].isSelected = 1;
              }
            }
          }
          //QuoteList.refresh();
        }else {
          QuoteList.value=[];
        }
      }
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
    }

  }

  getForeCastQuoteList(int pageNumberForQuote, String flagFilter) async{
    try{
      if(filterQuoteIdController.value.text.isEmpty){
        quoteIds = SelectedQuoteList.map((e) => e.quoteId).join(' | ');
      }
      else{
        quoteIds = filterQuoteIdController.value.text;

      }
      Map data={
        "filter_quote_id": quoteIds.isEmpty?"":quoteIds,
        "filter_sales_cycle_id": filterQuoteSaleCycleController.value.text.isEmpty?"":filterQuoteSaleCycleController.value.text,
        "filter_account_code": accountCodeController.value.text.isEmpty?"":accountCodeController.value.text,
        "filter_account_name": accountNameController.value.text.isEmpty?"":accountNameController.value.text,
        "filter_rh_approval": rh_Approval_controller.value.text.isEmpty?"":rh_Approval_controller.value.text,
        "filter_cbh_approval": cbh_Approval_controller.value.text.isEmpty?"":cbh_Approval_controller.value.text,
        "filter_category_approval": category_Approval_controller.value.text.isEmpty?"":category_Approval_controller.value.text,
        "filter_gm_approval": gm_Approval_controller.value.text.isEmpty?"":gm_Approval_controller.value.text,
        "filter_quote_version": filterQuoteVersionController.value.text.isEmpty?"-1":filterQuoteVersionController.value.text,
        "filter_quote_validity": quoteValidityStartToEnd.value.isEmpty?"":quoteValidityStartToEnd.value,
        "filter_exp_closure_date": extClosureStartToEnd.value.isEmpty?"":extClosureStartToEnd.value,
        "filter_quote_status": quoteStatusController.value.text.isEmpty || quoteStatusController.value.text == 'All'?"":quoteStatusController.value.text,
        "filter_flag": flagFilter,
        "filter_product_category": productCategoryController.value.text.isEmpty?"":productCategoryController.value.text,
        "filter_parent_product_category": parentProductCategoryController.value.text.isEmpty?"":parentProductCategoryController.value.text,
        "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
        "filter_created_by": isAdminWritePermission == '1'?'':email,
        "filter_created_on": createdOnStartToEnd.value.isNotEmpty?createdOnStartToEnd.value:"",
        "filter_frontliner_value": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value":"" ,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "filter_spr_no": "",
        "filter_item_code": itemCodeController.value.text.isEmpty?"":itemCodeController.value.text,
        "filter_item_name": itemNameController.value.text.isEmpty?"":itemNameController.value.text,
        "filter_quantity": quantityFilterController.value.text.isEmpty?"":quantityFilterController.value.text,
        "filter_gm_per": GmDiscountPerController.value.text.isEmpty?"":GmDiscountPerController.value.text,
        "filter_bm_per": BmDiscountPerController.value.text.isEmpty?"":BmDiscountPerController.value.text,
        "filter_sales_credit": SalesCreditController.value.text.isEmpty?"":SalesCreditController.value.text,
        "filter_lsp": LSPFilterController.value.text.isEmpty?"":LSPFilterController.value.text,
        "filter_map": MAPFilterController.value.text.isEmpty?"":MAPFilterController.value.text,
        "filter_btp": BTPFilterController.value.text.isEmpty?"":BTPFilterController.value.text,
        "filter_standard_cost": StandardCostController.value.text.isEmpty?"":StandardCostController.value.text,
        "filter_quote_accepted": filterQuoteAcceptedController.value.text,
        "row_per_page": rowsPerPage,
        "page_number": pageNumberForQuote
      };
      loading.value=true;

      String onValue = await _api.QuoteHeaderGetNewApiHit(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<ForceCastListModal> response = jsonResponse.map((e) => ForceCastListModal.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          if(pageNumberForQuote==0){
            ForeCastQuote_list.clear();
          }
          ForeCastQuote_list.addAll(response);
          total_Quote_List_rows=int.parse(ForeCastQuote_list[0].totalRows!);

          if (selectAllForeCastList.value) {
            for(int i=0;i<QuoteList.length;i++){
              ForeCastQuote_list[i].isSelected=1;
            }
            selectedForeCastQuote_list.value=[];
            selectedForeCastQuote_list.value=ForeCastQuote_list;
            showForeCstList.value = false;
            showForeCstList.value = true;
          }
          else if(selectedForeCastQuote_list.length>0){
            for(var selectedItem in selectedForeCastQuote_list){
              int index = ForeCastQuote_list.indexWhere((item) =>
              (item.quoteId == selectedItem.quoteId && item.itemCode == selectedItem.itemCode && item.lineNo == selectedItem.lineNo ));
              if (index != -1) {
                ForeCastQuote_list[index].isSelected = 1;
              }
            }
          }
          Get.toNamed(RoutesName.ForeCastItemScreen);
        }else {
          ForeCastQuote_list.value=[];
        }
      }
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
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

  getItemCategoryMstWithoutTaskIdApi() async{
    try {
      Map<String, String> data = {

      };
      loading.value = true;
      String value = await _api.getItemCategoryMstWithoutTaskIdApiHit(data, sessionManagement);

      List<ItemCategoryMstModel> Response =
      (json.decode(value) as List<dynamic>).map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();

      if (Response.isNotEmpty && Response[0]?.condition.toString() == "True") {
        item_product_cat_list.value = Response!;
        debugPrint("Product category liust length ${item_product_cat_list.length}");
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
  SalesForecastHeaderCreate() async{
    try{
      List<Map<String,dynamic>> lines = [];
      for(int i=0;i<selectedForeCastQuote_list.length;i++){
        Map<String,dynamic> input = {
          "quote_id": selectedForeCastQuote_list[i].quoteId,
          "quote_line_no": selectedForeCastQuote_list[i].lineNo,
          "item_code": selectedForeCastQuote_list[i].itemCode
        };
        lines.add(input);
      }
      Map data={
        "created_by": email,
        "cluster_name": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "region_name": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "lines": lines
      };
      loading.value=true;

      String onValue = await _api.SalesForecastHeaderCreate(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<ForecastCreateResponseModal> response = jsonResponse.map((e) => ForecastCreateResponseModal.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          forcastResponseList.value = response;
          Utils.sanckBarSuccess("Successfully", response[0].message.toString());
          Get.offAllNamed(RoutesName.SalesForeCastScreen);

        }else {
          Utils.sanckBarError("Data Not Found", response[0].message.toString());
        }
      }
    }catch(e){
      print(e);
      Utils.sanckBarError("Exception!", e.toString());
    }
    finally{
      loading.value = false;
    }

  }

  SalesForecastAddQuoteItems() async{
    try{
      List<Map<String,dynamic>> lines = [];
      for(int i=0;i<selectedForeCastQuote_list.length;i++){
        Map<String,dynamic> input = {
          "quote_id": selectedForeCastQuote_list[i].quoteId,
          "quote_line_no": selectedForeCastQuote_list[i].lineNo,
          "item_code": selectedForeCastQuote_list[i].itemCode
        };
        lines.add(input);
      }
      Map data={
        "sales_forecast_id": forceCastId,
        "created_by": email,
        "lines": lines
      };
      loading.value=true;

      String onValue = await _api.SalesForecastAddQuoteItems(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<ForecastCreateResponseModal> response = jsonResponse.map((e) => ForecastCreateResponseModal.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          forcastResponseList.value = response;
          Utils.sanckBarSuccess("Successfully", response[0].message.toString());
          selectedForeCastQuote_list.value=[];
          SelectedQuoteList.value=[];
          getSalesForecastHeaderGetBySalesForecastId(forceCastId);

        }else {
          Utils.sanckBarError("Data Not Found", response[0].message.toString());
        }
      }
    }catch(e){
      print(e);
      Utils.sanckBarError("Exception!", e.toString());
    }
    finally{
      loading.value = false;
    }

  }

  SalesForecastHeaderCompleted(String foreCastId) async{
    try{

      Map data={
          "sales_forecast_id": foreCastId,
          "created_by": email
      };
      loading.value=true;

      String onValue = await _api.SalesForecastHeaderCompleted(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<ForecastCreateResponseModal> response = jsonResponse.map((e) => ForecastCreateResponseModal.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          forcastResponseList.value = response;
          Utils.sanckBarSuccess("Successfully", response[0].message.toString());
          Get.offAllNamed(RoutesName.SalesForeCastScreen);

        }else {
          Utils.sanckBarError("Data Not Found", response[0].message.toString());
        }
      }
    }catch(e){
      print(e);
      Utils.sanckBarError("Exception!", e.toString());
    }
    finally{
      loading.value = false;
    }

  }

  clearSaleFrrceCastListFilters(String fromPage){
    salesForceCastId.value.clear();
    createdOnCnontroller.value.clear();
    createdOn_from_to_date_Controller.value.clear();
    month_year_controller.value.clear();
    AccountOwner_controller.value.clear();
    searchController.value.clear();
    AccountOwnerForApi='';

    SelectedEmployee_Member_list.value = [];
    SelectedCluster_list.value=[];
    SelectedRegion_list.value=[];
    //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
    getRegionsWithClusterFilterGetByEmail(fromPage);
  }



  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveSaleForeCastData({
      'salesForceCastId': salesForceCastId.value.text,
      'createdOnCnontroller': createdOnCnontroller.value.text,
      'createdOn_from_to_date_Controller': createdOn_from_to_date_Controller.value.text,
      'month_year_controller': month_year_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'AccountOwner_controller': AccountOwner_controller.value.text,

    });
    filterDataChecker.value='';
    getSalesForecastListGet(pageNumber,);

  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getSaleForeCastData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      salesForceCastId.value.text=getFilterData["salesForceCastId"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOnCnontroller"]??"";
      createdOn_from_to_date_Controller.value.text=getFilterData["createdOn_from_to_date_Controller"]??"";
      month_year_controller.value.text=getFilterData["month_year_controller"]??"";
      AccountOwner_controller.value.text=getFilterData["AccountOwner_controller"]??"";


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
    getSalesForecastListGet(pageNumber,);
  }
  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearSaleForeCastData();
  }


  void clearAllFieldOfQuoteFilter(String fromPage) {
    searchController.value.clear();

    product_category_type_Controller.value.text="Contains";
    productCategoryController.value.clear();
    parentProductCategoryController.value.clear();
    Selected_item_product_cat_list.value=[];
    parentItemCategorySelectedList.value=[];

    filterQuoteIdController.value.clear();
    filterQuoteSaleCycleController.value.clear();
    accountNameController.value.clear();
    extClosureStartToEnd.value='';
    filterQuoteValidityController.value.clear();
    quoteValidityStartToEnd.value="";
    createdOnCnontroller.value.clear();
    createdOnStartToEnd.value='';
    accountCodeController.value.clear();
    filterQuoteVersionController.value.clear();
    filterExpectedClosuredateController.value.clear();
    extClosureStartToEnd.value='';

    SelectedCluster_list.value = [];
    SelectedRegion_list.value = [];
    //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join(',');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
    getRegionsWithClusterFilterGetByEmail(fromPage);


  }
  void saveSalesForceCastQuoteData() async{
    await sessionManagement.saveSalesForceCastQuoteData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'customer_name': accountNameController.value.text,
      'filterQuoteValidityController': filterQuoteValidityController.value.text,
      'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'customer_code': accountCodeController.value.text,
      'filterQuoteVersionController': filterQuoteVersionController.value.text,
      'filterExpectedClosuredateController': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
      'parentProductCategoryController': parentProductCategoryController.value.text,

    });
    filterDataChecker.value='';
    pageNumberForQuote = 0;
    getQuoteList(pageNumberForQuote,);

  }

  void getSalesForceCastQuoteData() async{
    Map getFilterData=await sessionManagement.getSalesForceCastQuoteData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      filterQuoteVersionController.value.text=getFilterData["filterQuoteVersionController"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      productCategoryController.value.text=getFilterData["product_category"]??"";
      product_category_type_Controller.value.text=getFilterData["product_category_type"]??"";
      parentProductCategoryController.value.text=getFilterData["parentProductCategoryController"]??"";


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
    else{
      print("else condition");
    }
    pageNumberForQuote=0;
    getQuoteList(pageNumberForQuote,);

  }
  void clearSalesForceCastQuoteData() {
    filterDataChecker.value='';
    sessionManagement.clearSalesForceCastQuoteData();
  }

  void clearAllFieldForecastItemFilter(String fromPage) {
    product_category_type_Controller.value.text="Contains";
    parentProductCategoryController.value.clear();
    Selected_item_product_cat_list.value=[];
    parentItemCategorySelectedList.value=[];
    productCategoryController.value.clear();

    filterQuoteIdController.value.clear();
    filterQuoteSaleCycleController.value.clear();
    itemCodeController.value.clear();

    SelectedCluster_list.value = [];
    SelectedRegion_list.value = [];
    //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join(',');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
    getRegionsWithClusterFilterGetByEmail(fromPage);


  }
  void saveForceCastItemData() async{
    await sessionManagement.saveForceCastItemData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'itemCodeController': itemCodeController.value.text,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
    });

    filterDataChecker.value='';
    pageNumberForQuote = 0;
    getForeCastQuoteList( pageNumberForQuote,"ALLQuoteLineItemsForSalesForecast");


  }
  void getForceCastItemData() async{
    Map getFilterData=await sessionManagement.getForceCastItemData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      itemCodeController.value.text=getFilterData["itemCodeController"]??"";
      productCategoryController.value.text=getFilterData["product_category"]??"";
      product_category_type_Controller.value.text=getFilterData["product_category_type"]??"";

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
    else{
      print("else condition");
    }
    pageNumberForQuote=0;
    getQuoteList(pageNumberForQuote,);

  }
  clearForeCastItemData(){
    filterDataChecker.value='';
    sessionManagement.clearForceCastItemData();
  }

  SalesForecastLinesGetForUpload(BuildContext context) async{
    String productCat = "";
    String parentProductCat = "";
    try{
      debugPrint("length....${parentItemCategorySelectedList.length} and ${Selected_item_product_cat_list.length}");
      if(parentItemCategorySelectedList.length>0 &&parentItemCategorySelectedList.isNotEmpty){
        productCat=parentItemCategorySelectedList.map((item)=>item.parentCategoryCode).join("|");
      }
      if(Selected_item_product_cat_list.length>0 &&Selected_item_product_cat_list.isNotEmpty){
        productCat=Selected_item_product_cat_list.map((item)=>item.categoryCode).join("|");
      }
      Map data={
        "filter_sales_forecast_id": forceCastId,
        "filter_quote_id": quoteId_ex_Ctrl.value.text.isEmpty?"":quoteId_ex_Ctrl.value.text,
        "filter_sales_cycle_id": saleCycleId_ex_Ctrl.value.text.isEmpty?"":saleCycleId_ex_Ctrl.value.text,
        "filter_closure_month": monthNameForApi,
        "filter_closure_year": closerYear_ex_Ctrl.value.text.isEmpty?"":closerYear_ex_Ctrl.value.text,
        "filter_item_code": itemCode_ex_Ctrl.value.text.isEmpty?"":itemCode_ex_Ctrl.value.text,
        "filter_item_name": itemName_ex_Ctrl.value.text.isEmpty?"":itemName_ex_Ctrl.value.text,
        "filter_item_varient": itemVarient_ex_Ctrl.value.text.isEmpty?"":itemVarient_ex_Ctrl.value.text,
        "filter_item_category_type": item_category_type_ex_Ctrl.value.text.isEmpty?"":item_category_type_ex_Ctrl.value.text,
        "filter_item_category_code": productCat,
        "filter_item_parent_category_code": parentProductCat,
        "filter_required_region_name": region_name_ex_Ctrl.value.text.isEmpty?"":region_name_ex_Ctrl.value.text,
        "filter_required_cluster_name": cluster_name_ex_Ctrl.value.text.isEmpty?"":cluster_name_ex_Ctrl.value.text
      };
      loading.value=true;
      debugPrint("print values ${data}");
      String onValue = await _api.SalesForecastLinesGetForUpload(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<ForeCastQuoteDowExcelModal> response = jsonResponse.map((e) => ForeCastQuoteDowExcelModal.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          quoteDowExcelList.value = response;
          downloadForeCastLineDetaisForUploadWithProgress(context,'forcast_line_details_for_upload','Forcast Line Details For Upload');

          //Utils.sanckBarSuccess("Successfully", response[0].message.toString());
        }else {
          // Utils.sanckBarError("Data Not Found", response[0].message.toString());
        }
      }
    }catch(e){
      print(e);
      Utils.sanckBarError("Exception!", e.toString());
    }
    finally{
      loading.value = false;
    }

  }
  Future<void> downloadForeCastLineDetaisForUploadWithProgress(BuildContext context, String sheetName, String saveFileName) async {
    try {
      excelLoading.value = true;
      excelProgress.value = 0;
      showExcelProgressDialog(context);

      final excel = Excel.createExcel();
      excel.rename('Sheet1', sheetName);
      final sheet = excel[sheetName];
      List<String> headers = [];

      final firstRowMap = headerExcelKeys(quoteDowExcelList.first);
      headers = firstRowMap.keys.toList();



      // Write Headers
      for (int col = 0; col < headers.length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0)).value
        = TextCellValue(headers[col]);
      }

      final totalRows = quoteDowExcelList.length;

      //if(sheetName=='Non Standard Items'){
        for (int row = 0; row < totalRows; row++) {
          final rowMap = headerExcelKeys(quoteDowExcelList.first);
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
  Map<String, dynamic> headerExcelKeys(ForeCastQuoteDowExcelModal item) {
    final map = Map<String, dynamic>.from(item.toJson());
    map.remove('condition');
    return map;
  }

  Future<void> downloadQuoteDetailsWithProgress(BuildContext context, String sheetName, String saveFileName) async {
    try {
      excelLoading.value = true;
      excelProgress.value = 0;
      showExcelProgressDialog(context);

      final excel = Excel.createExcel();
      excel.rename('Sheet1', sheetName);
      final sheet = excel[sheetName];
      List<String> headers = [];

      final firstRowMap = detailsExcelKeys(salesForceCastHeader_list[0].lines!.first);
      headers = firstRowMap.keys.toList();



      // Write Headers
      for (int col = 0; col < headers.length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0)).value
        = TextCellValue(headers[col]);
      }

      final totalRows = salesForceCastHeader_list[0].lines!.length;

      //if(sheetName=='Non Standard Items'){
      for (int row = 0; row < totalRows; row++) {
        final rowMap = detailsExcelKeys(salesForceCastHeader_list[0].lines!.first);
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
  Map<String, dynamic> detailsExcelKeys(Lines item) {
   /* final map = Map<String, dynamic>.from(item.toJson());
    map.remove('condition');
    return map;*/
    final originalMap = Map<String, dynamic>.from(item.toJson());

    final Map<String, dynamic> newMap = {};

    originalMap.forEach((key, value) {
      if (key.contains('|')) {
        final parts = key.split('|');
        if (parts.length == 3) {
          // 7|Jul|2026 -> Jul-2026
          newMap['${parts[1]}-${parts[2]}'] = value;
        } else {
          newMap[key] = value;
        }
      } else {
        newMap[key] = value;
      }
    });

    newMap.remove('condition');

    return newMap;
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

  SalesForecastUploadItem(ForeCastQuoteDowExcelModal item, List<ForeCastQuoteDowExcelModal> modelList) async{
    try{
      List<Map<String,dynamic>> lines = [];
      for(int i=0;i<modelList.length;i++){
        Map<String,dynamic> input = {
          "line_no": modelList[i].lineNo==0?"-1":modelList[i].lineNo.toString(),
          "quote_id":  modelList[i].quoteId,
          "quote_line_no":  modelList[i].quoteLineNo.toString(),
          "closure_month":  modelList[i].closureMonth,
          "closure_year":  modelList[i].closureYear,
          "item_code":  modelList[i].itemCode,
          "item_varient":  modelList[i].itemVarient,
          "qty":  modelList[i].qty??0,
          "required_region_name":  modelList[i].requiredRegionName,
          "required_cluster_name":  modelList[i].requiredClusterName
        };
        lines.add(input);
      }
      Map data={
        "sales_forecast_id": forceCastId,
        "created_by": email,
        "lines": lines
      };
      debugPrint("Alll data is ${data}");
      loading.value=true;

      String onValue = await _api.SalesForecastUploadItem(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if(jsonResponse is List){
        List<ForecastCreateResponseModal> response = jsonResponse.map((e) => ForecastCreateResponseModal.fromJson(e)).toList();
        if(response!= null && response.length>0 && response[0].condition=="True"){
          forcastResponseList.value = response;
          Utils.sanckBarSuccess("Successfully", response[0].message.toString());
          getSalesForecastHeaderGetBySalesForecastId(forceCastId);

        }else {
          Utils.sanckBarError("Data Not Found", response[0].message.toString());
        }
      }
    }catch(e){
      print(e);
      Utils.sanckBarError("Exception!", e.toString());
    }
    finally{
      loading.value = false;
    }

  }

  Future<void> uploadExcelToServer() async {
    try {
      File? file = await pickExcelFile();
      if (file == null){
        return;
      }
      debugPrint("read excel file feom step 1");
      List<Map<String, dynamic>> excelData = await readExcelFile(file);
      if(excelData.length>=1 && excelData!=null) {
        List<ForeCastQuoteDowExcelModal> modelList = convertToModel(excelData);
        if (modelList[0].quoteId!.isNotEmpty) {
          SalesForecastUploadItem(item, modelList);
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
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> readExcelFile(File file) async {

    var bytes = file.readAsBytesSync();

    var excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> excelData = [];
    if (excel.tables.isEmpty) {
      debugPrint("No sheets found in excel");
      return excelData;
    }

    String tableName = excel.tables.keys.first;

    debugPrint("Sheet Name: $tableName");

    var sheet = excel.tables[tableName];

    if (sheet == null || sheet.rows.isEmpty) {
      debugPrint("Sheet is empty");
      return excelData;
    }

    var rows = sheet.rows;

    List headers = rows.first;
   /* //for (var table in excel.tables.keys) {
    var table =  excel.tables.keys;
    debugPrint("read excel file feom step 2");
    var rows = excel.tables[table]!.rows;
    debugPrint("read excel file feom step 3");
    List headers = rows.first;*/

    for (int i = 1; i < rows.length; i++) {

      Map<String, dynamic> rowMap = {};
      for (int j = 0; j < headers.length; j++) {
        String header = headers[j]?.value?.toString() ?? "";
        String value = rows[i].length > j ? rows[i][j]?.value?.toString() ?? "" : "";
        rowMap[header] = value;
        //debugPrint("value...... ${rows[i][j]?.value.toString()} and ${headers[j]!.value.toString()}");
      }
      excelData.add(rowMap);
    }
    // }

    return excelData;
  }

  List<ForeCastQuoteDowExcelModal> convertToModel(List<Map<String, dynamic>> data) {
    print("excel data ${data}");
    return data.map((e) {
      e['line_no'] = int.tryParse(e['line_no'])==null?0:int.tryParse(e['line_no']);
      e['quote_line_no'] = int.tryParse(e['quote_line_no'])==null?0:int.tryParse(e['quote_line_no']);
      return ForeCastQuoteDowExcelModal.fromJson(e);
    }).toList();
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


}