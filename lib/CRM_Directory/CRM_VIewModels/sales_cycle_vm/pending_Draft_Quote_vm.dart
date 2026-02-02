import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/sale_cycle_modal/Pending_Draft_Quote_model.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class PendingDraftQuoteVm extends GetxController{
  String filterFlag="";
  PendingDraftQuoteVm([String? flag]){
    this.filterFlag = flag??"";
  }
  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  String email="";
  int pageNumberForQuote = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String isAdminWritePermission = "";
  RxString createdOnStartToEnd = "".obs;
  RxString extClosureStartToEnd = "".obs;
  RxString quoteValidityStartToEnd = "".obs;


  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteVersionController=TextEditingController().obs;
  var filterQuoteSaleCycleController=TextEditingController().obs;
  var accountCodeController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;
  var quoteStatusController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  var rh_Approval_controller=TextEditingController().obs;
  var cbh_Approval_controller=TextEditingController().obs;
  var category_Approval_controller=TextEditingController().obs;
  var gm_Approval_controller=TextEditingController().obs;
  var RegionName_controller=TextEditingController().obs;
  var clusterName_controller=TextEditingController().obs;
  var createdOnCnontroller=TextEditingController().obs;
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

  RxList<Pending_Draft_Quote_Model> PendingDraftQuoteList=<Pending_Draft_Quote_Model>[].obs;
  RxList<String> QuoteStatusList = ["All", "DRAFT", "PENDING FOR APPROVAL", ].obs;
  RxList<String> approvedRejectedStatusList = ["All", "APPROVED", "REJECTED", ].obs;
  RxList<String> AllQuoteStatusList = ["All", "DRAFT", "PENDING FOR APPROVAL", "APPROVED", "REJECTED", ].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;
  String filterRouting = "";
  String title="";
  @override
  Future<void> onInit() async {
    title = Get.arguments??"";
    if(title=='Pending Draft Quote'){
      filterFlag="PENDING & PENDING FOR APPROVAL";
    }else if(title=='All Quote'){
      filterFlag="All";
    }else if(title=='All Quote Line Items'){
      filterFlag="ALLQuoteLineItems";
    }
    else if(title=='All SPR Mapping Line Items'){
      filterFlag="ALLSPRMAPPING";
    }
    else if(title=='Approved / Rejected Quote'){
      filterFlag="APPROVED & REJECTED";
    }

    email=await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    //getPendingDraftQuoteList(pageNumberForQuote, filterFlag);
    product_category_type_Controller.value.text="Contains";
    getItemCategoryMstWithoutTaskIdApi();
    getClustersGetByEmail();


    super.onInit();
  }

  Future<void>refreshList() async{
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);
  }
  getItemCategoryMstWithoutTaskIdApi() {
    loading.value = true;
    Map<String, String> data = {

    };

    _api.getItemCategoryMstWithoutTaskIdApiHit(data, sessionManagement).then((value) {
      try {
        List<ItemCategoryMstModel> Response =
        (json.decode(value) as List<dynamic>).map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();

        if (Response.isNotEmpty && Response[0]?.condition.toString() == "True") {
          Item_Category_master_list_without_task.value = Response!;

          // print('master list....${get_Acc_type_list.length.toString()}');
        } else {
          Item_Category_master_list_without_task.value = [];
          //print('master listelsse....${get_Acc_type_list.length.toString()}');
        }
      } catch (e) {
        Item_Category_master_list_without_task.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      Item_Category_master_list_without_task.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      loading.value = false;
    });
  }

  void getClustersGetByEmail() {
    try{
      Map<String, String> data={
        "email_id":email
      };
      loading.value=true;
      print("data is ${data}");
      _api.clustersGetByEmailApiHit(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<ClusterModal> response = jsonResponse.map((e) => ClusterModal.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            clusterGetByEmailList.value=response;
            if (clusterGetByEmailList.value.isNotEmpty && SelectedCluster_list.isEmpty) {
              SelectedCluster_list.assignAll(clusterGetByEmailList.value);
              clusterName_controller.value.text = clusterGetByEmailList.value.map((e) => e.geoValue).join('|');
              getRegionsWithClusterFilterGetByEmail();
            }
          }else {
            loading.value = false;
            clusterGetByEmailList.value=[];
          }
        } else {
          loading.value = false;
        }
      },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      ).whenComplete(() {
        loading.value=false;
      },);
    }catch(e){
      loading.value = false;
      print(e);
    } 
  }
  void getRegionsWithClusterFilterGetByEmail() {
    var selectedCluster="";
    if(clusterName_controller.value.text.isNotEmpty){
      selectedCluster = clusterName_controller.value.text.split(',').map((e) => e.trim()).join('|');
    }
    try{
      Map<String, String> data={
        "email_id":email,
        "cluster_filter":selectedCluster.isEmpty?"":selectedCluster
      };
      loading.value=true;
      print("data is ${data}");
      _api.RegionsWithClusterFilterGetByEmailApiHit(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<RegionWithClusterFilterModal> response = jsonResponse.map((e) => RegionWithClusterFilterModal.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            regionwithclusterGetByEmailList.value=response;
            RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
            print('region....${RegionName_controller.value.text}');
            if(filterRouting =='Pending Draft Quote'){
              getPendingDraftQuoteFilterData();
            }
            else if(filterRouting =='All Quote'){
              getFilterData();
            }
            else if(filterRouting =='Approved / Rejected Quote'){
              getApproveRejectedQuoteFilterData();
            }
            else if(filterRouting =='All Quote Line Items'){
              getQuoteLineItemFilterData();
            }
            else if(filterRouting =='All SPR Mapping Line Items'){
              getAllSPRMapFilterData();
            }


            //getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

          }else {
            loading.value = false;
            regionwithclusterGetByEmailList.value=[];
          }
        } else {
          loading.value = false;
        }
      },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }
  }

  getPendingDraftQuoteList(int pageNumberForQuote,String flagFilter){
    loading.value=true;
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
          "filter_flag": flagFilter,
          "filter_product_category": productCategoryController.value.text.isEmpty?"":productCategoryController.value.text,
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
          "row_per_page": rowsPerPage,
          "page_number": pageNumberForQuote
      };


      _api.QuoteHeaderGetNewApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
       this.filterFlag=flagFilter;
        if(jsonResponse is List){
          List<Pending_Draft_Quote_Model> response = jsonResponse.map((e) => Pending_Draft_Quote_Model.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumberForQuote==0){
              PendingDraftQuoteList.clear();
            }
            PendingDraftQuoteList.addAll(response);
            print("${PendingDraftQuoteList.length}");
            total_rows=int.parse(PendingDraftQuoteList[0].totalRows!);
          }else {
            PendingDraftQuoteList.value=[];
            loading.value = false;
          }
        } else {
          loading.value = false;
        }
      },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      ).whenComplete(() {
        loading.value = false;
      },);
    }catch(e){
      loading.value = false;
      print(e);
    }

  }

  void clearAllFieldOfQuoteFilter() {
    product_category_type_Controller.value.text="Contains";
    Selected_Item_Category_master_list_without_task.value=[];

    filterQuoteIdController.value.clear();
    filterQuoteVersionController.value.clear();
    filterExpectedClosuredateController.value.clear();
    filterQuoteValidityController.value.clear();
    accountNameController.value.clear();
    accountCodeController.value.clear();
    rh_Approval_controller.value.clear();
    cbh_Approval_controller.value.clear();
    category_Approval_controller.value.clear();
    gm_Approval_controller.value.clear();
    productCategoryController.value.clear();
    createdOnCnontroller.value.clear();
    //clusterName_controller.value.clear();
    filterQuoteSaleCycleController.value.clear();
    createdByCnontroller.value.clear();
    //RegionName_controller.value.clear();
    quoteStatusController.value.clear();
    createdOnStartToEnd.value = "";
    extClosureStartToEnd.value = "";
    quoteValidityStartToEnd.value = "";
    itemCodeController.value.clear();
    itemNameController.value.clear();
    quantityFilterController.value.clear();
    GmDiscountPerController.value.clear();
    BmDiscountPerController.value.clear();
    SalesCreditController.value.clear();
    LSPFilterController.value.clear();
    BTPFilterController.value.clear();
    MAPFilterController.value.clear();
    StandardCostController.value.clear();


  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveQuoteData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteVersionController': filterQuoteVersionController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
      'quoteStatusController': quoteStatusController.value.text,
      'filterQuoteValidityController': filterQuoteValidityController.value.text,
      'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
      'filterExpectedClosuredateController': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'rh_Approval_controller': rh_Approval_controller.value.text,
      'cbh_Approval_controller': cbh_Approval_controller.value.text,
      'category_Approval_controller': category_Approval_controller.value.text,
      'gm_Approval_controller': gm_Approval_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'createdByCnontroller': createdByCnontroller.value.text,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
    });
    filterDataChecker.value='';

  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getQuoteData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"]??"";
      filterQuoteVersionController.value.text=getFilterData["filterQuoteVersionController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      quoteStatusController.value.text=getFilterData["quoteStatusController"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"]??"";
      rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"]??"";
      cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"]??"";
      category_Approval_controller.value.text=getFilterData["category_Approval_controller"]??"";
      gm_Approval_controller.value.text=getFilterData["gm_Approval_controller"]??"";
      createdByCnontroller.value.text=getFilterData["createdByCnontroller"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
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
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearQuoteData();
  }

  //todo pending draft quote

  void SavePendingDraftQuoteFilterData() async{
    await sessionManagement.savePendingDraftQuoteData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteVersionController': filterQuoteVersionController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
      'quoteStatusController': quoteStatusController.value.text,
      'filterQuoteValidityController': filterQuoteValidityController.value.text,
      'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
      'filterExpectedClosuredateController': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'rh_Approval_controller': rh_Approval_controller.value.text,
      'cbh_Approval_controller': cbh_Approval_controller.value.text,
      'category_Approval_controller': category_Approval_controller.value.text,
      'gm_Approval_controller': gm_Approval_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'createdByCnontroller': createdByCnontroller.value.text,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
    });
    filterDataChecker.value='';

  }

  void getPendingDraftQuoteFilterData() async{
    Map getFilterData=await sessionManagement.getPendingDraftQuoteData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"]??"";
      filterQuoteVersionController.value.text=getFilterData["filterQuoteVersionController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      quoteStatusController.value.text=getFilterData["quoteStatusController"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"]??"";
      rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"]??"";
      cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"]??"";
      category_Approval_controller.value.text=getFilterData["category_Approval_controller"]??"";
      gm_Approval_controller.value.text=getFilterData["gm_Approval_controller"]??"";
      createdByCnontroller.value.text=getFilterData["createdByCnontroller"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
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
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void clearPendingDraftQuoteFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearPendingDraftQuoteData();
  }

  //todo quote rejected and approve

  void SaveApproveRejectedQuoteFilterData() async{
    await sessionManagement.saveApproveRejectedQuoteData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteVersionController': filterQuoteVersionController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
      'quoteStatusController': quoteStatusController.value.text,
      'filterQuoteValidityController': filterQuoteValidityController.value.text,
      'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
      'filterExpectedClosuredateController': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'rh_Approval_controller': rh_Approval_controller.value.text,
      'cbh_Approval_controller': cbh_Approval_controller.value.text,
      'category_Approval_controller': category_Approval_controller.value.text,
      'gm_Approval_controller': gm_Approval_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'createdByCnontroller': createdByCnontroller.value.text,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
    });
    filterDataChecker.value='';
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void getApproveRejectedQuoteFilterData() async{
    Map getFilterData=await sessionManagement.getApproveRejectedQuoteData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"]??"";
      filterQuoteVersionController.value.text=getFilterData["filterQuoteVersionController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      quoteStatusController.value.text=getFilterData["quoteStatusController"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"]??"";
      rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"]??"";
      cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"]??"";
      category_Approval_controller.value.text=getFilterData["category_Approval_controller"]??"";
      gm_Approval_controller.value.text=getFilterData["gm_Approval_controller"]??"";
      createdByCnontroller.value.text=getFilterData["createdByCnontroller"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
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
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void clearApproveRejectedQuoteFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearApproveRejectedQuoteData();
  }

  //todo quote line item screen

  void SaveQuoteLineItemFilterData() async{
    await sessionManagement.saveQuoteLineItemData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteVersionController': filterQuoteVersionController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
      'quoteStatusController': quoteStatusController.value.text,
      'filterQuoteValidityController': filterQuoteValidityController.value.text,
      'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
      'filterExpectedClosuredateController': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'rh_Approval_controller': rh_Approval_controller.value.text,
      'cbh_Approval_controller': cbh_Approval_controller.value.text,
      'category_Approval_controller': category_Approval_controller.value.text,
      'gm_Approval_controller': gm_Approval_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'itemCodeController': itemCodeController.value.text,
      'itemNameController': itemNameController.value.text,
      'quantityFilterController': quantityFilterController.value.text,
      'GmDiscountPerController': GmDiscountPerController.value.text,
      'BmDiscountPerController': BmDiscountPerController.value.text,
      'SalesCreditController': SalesCreditController.value.text,
      'LSPFilterController': LSPFilterController.value.text,
      'BTPFilterController': BTPFilterController.value.text,
      'MAPFilterController': MAPFilterController.value.text,
      'StandardCostController': MAPFilterController.value.text,
      'createdByCnontroller': createdByCnontroller.value.text,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
    });
    filterDataChecker.value='';
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void getQuoteLineItemFilterData() async{
    Map getFilterData=await sessionManagement.getQuoteLineItemData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"]??"";
      filterQuoteVersionController.value.text=getFilterData["filterQuoteVersionController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      quoteStatusController.value.text=getFilterData["quoteStatusController"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"]??"";
      rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"]??"";
      cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"]??"";
      category_Approval_controller.value.text=getFilterData["category_Approval_controller"]??"";
      gm_Approval_controller.value.text=getFilterData["gm_Approval_controller"]??"";
      itemCodeController.value.text=getFilterData["itemCodeController"]??"";
      itemNameController.value.text=getFilterData["itemNameController"]??"";
      quantityFilterController.value.text=getFilterData["quantityFilterController"]??"";
      BmDiscountPerController.value.text=getFilterData["BmDiscountPerController"]??"";
      GmDiscountPerController.value.text=getFilterData["GmDiscountPerController"]??"";
      SalesCreditController.value.text=getFilterData["SalesCreditController"]??"";
      LSPFilterController.value.text=getFilterData["LSPFilterController"]??"";
      BTPFilterController.value.text=getFilterData["BTPFilterController"]??"";
      MAPFilterController.value.text=getFilterData["MAPFilterController"]??"";
      StandardCostController.value.text=getFilterData["StandardCostController"]??"";
      createdByCnontroller.value.text=getFilterData["createdByCnontroller"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
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
    getPendingDraftQuoteList(pageNumberForQuote,filterFlag);

  }

  void clearQuoteLineItemFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearQuoteLineItemData();
  }

  //todo All SPR Mapping

  void SaveAllSPRMapFilterData() async{
    await sessionManagement.saveQAllSPRMapData({
      'quantityFilterController':quantityFilterController.value.text,
      'LSPFilterController':LSPFilterController.value.text,
      'MAPFilterController':MAPFilterController.value.text,
      'StandardCostController':StandardCostController.value.text,
      'BTPFilterController':BTPFilterController.value.text,
      'BmDiscountPerController':BmDiscountPerController.value.text,
      'GmDiscountPerController':GmDiscountPerController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'quoteStatusController': quoteStatusController.value.text,
      'filterQuoteValidityController': filterQuoteValidityController.value.text,
      'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
      'filterExpectedClosuredateController': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'rh_Approval_controller': rh_Approval_controller.value.text,
      'cbh_Approval_controller': cbh_Approval_controller.value.text,
      'gm_Approval_controller': gm_Approval_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,
    });
    filterDataChecker.value='';
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void getAllSPRMapFilterData() async{
    Map getFilterData=await sessionManagement.getAllSPRMapData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      quantityFilterController.value.text=getFilterData["quantityFilterController"]??"";
      LSPFilterController.value.text=getFilterData["LSPFilterController"]??"";
      MAPFilterController.value.text=getFilterData["MAPFilterController"]??"";
      StandardCostController.value.text=getFilterData["StandardCostController"]??"";
      BTPFilterController.value.text=getFilterData["BTPFilterController"]??"";
      BmDiscountPerController.value.text=getFilterData["BmDiscountPerController"]??"";
      GmDiscountPerController.value.text=getFilterData["GmDiscountPerController"]??"";
      filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"]??"";
      quoteStatusController.value.text=getFilterData["quoteStatusController"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"]??"";
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
      rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"]??"";
      cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"]??"";
      gm_Approval_controller.value.text=getFilterData["gm_Approval_controller"]??"";
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
    getPendingDraftQuoteList(pageNumberForQuote, filterFlag);

  }

  void clearAllSPRMapFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearAllSPRMapData();
  }
  String numberFormatWithComma(dynamic number) {
    if (number == null || number.toString().isEmpty) return "0.00";

    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(num.parse(number.toString()));
  }

}