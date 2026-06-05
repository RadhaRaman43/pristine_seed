import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/SalesForceCastModals/SalesForceCastListModal.dart';
import '../../CRM_Models/sale_cycle_modal/Pending_Draft_Quote_model.dart';
import '../../CRM_Repository/salesforcecastRepository/SalesForeCastRepo.dart';

class SalesForeCastVM extends GetxController{
  final _api = SalesForeCastRepo();
  SessionManagement sessionManagement = SessionManagement();

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  int total_rows_sales_force = 0;
  int pageNumberForQuote = 0;
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;
  RxBool loading = false.obs;
  RxBool showList = false.obs;
  String email = "";
  String filterRouting = "";
  String userType = "";

  RxString foreCastStatus = "Pending".obs;
  RxList<SalesForceCastListModal> sales_force_cast_list  = <SalesForceCastListModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  RxList<Pending_Draft_Quote_Model> QuoteList=<Pending_Draft_Quote_Model>[].obs;

  //filter fields
  var salesForceCastId = TextEditingController().obs;
  var createdOnCnontroller = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;

  //
  var month_controller = TextEditingController().obs;
  var year_controller = TextEditingController().obs;

  //todo quote filter
  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteVersionController=TextEditingController().obs;
  var filterQuoteSaleCycleController=TextEditingController().obs;
  var accountCodeController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;
  var parentProductCategoryController=TextEditingController().obs;
  var quoteStatusController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
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
  var product_category_type_Controller = TextEditingController().obs;

  var filterQuoteAcceptedController = TextEditingController().obs;
  RxList<String> qouteAcceptedList = ["All", "Open", "Loss", "Won"].obs;

  RxString createdOnStartToEnd = "".obs;
  RxString extClosureStartToEnd = "".obs;
  RxString quoteValidityStartToEnd = "".obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    loading.value=true;
    email = await sessionManagement.getEmail() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    getCurrentDate();
    //product_category_type_Controller.value.text = "Contains";
    getSalesForecastListGet(pageNumber);
  }
  Future<void> refreshList() async {
    pageNumber = 0;
    getSalesForecastListGet(pageNumber, );
  }
  getCurrentDate(){
    DateTime now = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    String currentMonthName = months[DateTime.now().month - 1];
    month_controller.value.text=currentMonthName;
    int year = now.year;
    year_controller.value.text = year.toString();
    print("year and month $currentMonthName $year ${month_controller.value.text} ${year_controller.value.text}");



  }
  String numberFormatWithComma(dynamic number) {
    if (number == null || number.toString().isEmpty) return "0.00";

    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(num.parse(number.toString()));
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
          // print('region....${RegionName_controller.value.text}');
          getFilterData();
          //getsalesCycleData(pageNumber, "", "", '');

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
      Map<String, dynamic> data={
        "filter_sales_forecast_id":salesForceCastId.value.text.isEmpty? "":salesForceCastId.value.text,
        "filter_quote_id": "",
        "filter_sales_cycle_id": "",
        "filter_month_year": "",
        "filter_sales_forecast_status": foreCastStatus.value,
        "filter_branch_head_value": "",
        "filter_clusture_head_value": "",
        "filter_created_by": email,
        "filter_created_on": createdOnCnontroller.value.text.isEmpty?"":createdOnCnontroller.value.text,
        "filter_created_by_new": isAdminWritePermission=="1"?"":email,
        "row_per_page": 10,
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
  getQuoteList(int pageNumberForQuote,) async{
    try{
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
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value":"" /*RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text*/,
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
          print("${QuoteList.length}");
          total_rows=int.parse(QuoteList[0].totalRows!);
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

  clearSaleFrrceCastListFilters(){
    salesForceCastId.value.clear();
    createdOnCnontroller.value.clear();

    SelectedCluster_list.value=[];
    SelectedRegion_list.value=[];
    //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
    getRegionsWithClusterFilterGetByEmail();
  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearSaleForeCastData();
  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveSaleForeCastData({
      'salesForceCastId': salesForceCastId.value.text,
      'createdOnCnontroller': createdOnCnontroller.value.text,

      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,

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

}