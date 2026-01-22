

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/sales_advise_modal/all_sales_advise_list_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesAdviseAllListVm extends GetxController{
  String filterFlag="";
  SalesAdviseAllListVm([String? flag]){
    this.filterFlag = flag??"";
  }

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  String email = "";
  String userType = "";
  String isAdminWritePermission = "";
  int rowsPerPage = 10;
  int total_rows = 0;
  int pageNumber = 0;

  var salesAdviseStatusController=TextEditingController().obs;
  var salesAdviseIdController=TextEditingController().obs;
  var quoteIdController=TextEditingController().obs;
  var quoteVersionController=TextEditingController().obs;
  var saleCycleIdController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var accountCodeController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  var createdOnCnontroller=TextEditingController().obs;
  var RegionName_controller=TextEditingController().obs;
  var clusterName_controller=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;
  var product_category_type_Controller = TextEditingController().obs;
  var rh_Approval_controller=TextEditingController().obs;
  var cbh_Approval_controller=TextEditingController().obs;
  var Gm_Approval_Controller=TextEditingController().obs;
  var itemCodeController=TextEditingController().obs;
  var itemNameController=TextEditingController().obs;
  var quantityFilterController=TextEditingController().obs;
  var LSPFilterController=TextEditingController().obs;
  var MAPFilterController=TextEditingController().obs;
  var BTPFilterController=TextEditingController().obs;
  var BM_per_ilterController=TextEditingController().obs;
  var GM_per_ilterController=TextEditingController().obs;
  var StandardCostController=TextEditingController().obs;
  var SalesCreditController=TextEditingController().obs;


  RxString quoteValidityStartToEnd="".obs;
  RxString extClosureStartToEnd="".obs;
  RxString createdOnStartToEnd="".obs;
  RxList<String> salesAdviseStatusList = ["Draft", "Completed"].obs;

  RxList<AllSalesAdviseModal> salesAdviseList=<AllSalesAdviseModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;
  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;

  String filterRouting = "";

  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    product_category_type_Controller.value.text="Contains";
    getItemCategoryMstWithoutTaskIdApi();
    //getSaleCycleProductByIdList(pageNumber);
    getClustersGetByEmail();
    // TODO: implement onInit
    super.onInit();
  }

  getItemCategoryMstWithoutTaskIdApi() {
    this.loading.value = true;
    Map<String, String> data = {

    };

    _api.getItemCategoryMstWithoutTaskIdApiHit(data, sessionManagement).then((value) {
      try {
        List<ItemCategoryMstModel> Response =
        (json.decode(value) as List<dynamic>)
            .map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>))
            .toList();

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
      this.loading.value = false;
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
              clusterName_controller.value.text =
                  clusterGetByEmailList.value.map((e) => e.geoValue).join('|');
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
      );
    }catch(e){
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }
  }
  void getRegionsWithClusterFilterGetByEmail() {
    var selectedCluster="";
    if(clusterName_controller.value.text.isNotEmpty){
      selectedCluster = clusterName_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('|');
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
            if(filterRouting=='All Sales Advice Line Items'){
              getAllSaleAdviseLineFilterData();

            }
            else if(filterRouting=='All Sales Advice List'){
              getFilterData();
            }

            //getSaleCycleProductByIdList(pageNumber);

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

  getSaleCycleProductByIdList(int pageNumber) {
    Map data = {
      "filter_sales_advice_id": salesAdviseIdController.value.text.isNotEmpty?salesAdviseIdController.value.text:"",
      "filter_quote_id": quoteIdController.value.text.isNotEmpty?quoteIdController.value.text:"",
      "filter_sales_cycle_id": saleCycleIdController.value.text.isNotEmpty?saleCycleIdController.value.text:"",
      "filter_account_code": accountNameController.value.text.isNotEmpty?accountNameController.value.text:"",
      "filter_account_name": accountCodeController.value.text.isNotEmpty?accountCodeController.value.text:"",
      "filter_rh_approval": rh_Approval_controller.value.text.isNotEmpty?rh_Approval_controller.value.text:"",
      "filter_cbh_approval": cbh_Approval_controller.value.text.isNotEmpty?cbh_Approval_controller.value.text:"",
      "filter_category_approval": "",
      "filter_gm_approval": Gm_Approval_Controller.value.text.isNotEmpty?Gm_Approval_Controller.value.text:"",
      "filter_quote_version": quoteVersionController.value.text.isNotEmpty?quoteVersionController.value.text:"-1",
      "filter_quote_validity": quoteValidityStartToEnd.value,
      "filter_exp_closure_date": extClosureStartToEnd.value,
      "filter_sales_advice_status": salesAdviseStatusController.value.text.isNotEmpty?salesAdviseStatusController.value.text:"",
      "filter_flag": filterFlag,
      "filter_product_category": productCategoryController.value.text.isNotEmpty?productCategoryController.value.text:"",
      "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
      "filter_created_by": email,
      "filter_created_on": createdOnStartToEnd.value,
      "filter_frontliner_value": "",
      "filter_branch_head_value": RegionName_controller.value.text.isNotEmpty?RegionName_controller.value.text:"",
      "filter_zone_head_value": clusterName_controller.value.text.isNotEmpty?clusterName_controller.value.text:"",
      "filter_clusture_head_value": "",
      "filter_spr_no": "",
      "filter_item_code": itemCodeController.value.text.isNotEmpty?itemCodeController.value.text:"",
      "filter_item_name": itemNameController.value.text.isNotEmpty?itemNameController.value.text:"",
      "filter_quantity": quantityFilterController.value.text.isNotEmpty?quantityFilterController.value.text:"",
      "filter_gm_per": GM_per_ilterController.value.text.isNotEmpty?GM_per_ilterController.value.text: "",
      "filter_bm_per": BM_per_ilterController.value.text.isNotEmpty?BM_per_ilterController.value.text: "",
      "filter_sales_credit": SalesCreditController.value.text.isNotEmpty?SalesCreditController.value.text:"",
      "filter_lsp": LSPFilterController.value.text.isNotEmpty?LSPFilterController.value.text:"",
      "filter_map": MAPFilterController.value.text.isNotEmpty?MAPFilterController.value.text:"",
      "filter_btp": BTPFilterController.value.text.isNotEmpty?BTPFilterController.value.text:"",
      "filter_standard_cost": StandardCostController.value.text.isNotEmpty?StandardCostController.value.text:"",
      "row_per_page": rowsPerPage,
      "page_number": pageNumber
    };
    loading.value = true;
    _api.salesAdviceHeaderGetNewApiHit(data, sessionManagement).then(
          (onValue) {
        try {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<AllSalesAdviseModal> response = jsonResponse
                .map((e) => AllSalesAdviseModal.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition?.toLowerCase() == "true") {
              if (pageNumber == 0) {
                salesAdviseList.clear();
              }
              salesAdviseList.addAll(response);
              total_rows = int.parse(salesAdviseList[0].totalRows!);
            } else {
              salesAdviseList.value = [];
            }
          }
        } catch (e) {
          print(e);
        } finally {
          loading.value = false;
        }
      },
    ).onError(
          (error, stackTrace) {
        print('sjdbbsidbi${error}');
      },
    ).whenComplete(() {
      this.loading.value = false;
    });
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    getSaleCycleProductByIdList(pageNumber);
  }

  void clearAllField() {
    product_category_type_Controller.value.text="Contains";
    Selected_Item_Category_master_list_without_task.value=[];

    salesAdviseStatusController.value.clear();
    filterExpectedClosuredateController.value.clear();
    salesAdviseIdController.value.clear();
    quoteIdController.value.clear();
    quoteVersionController.value.clear();
    saleCycleIdController.value.clear();
    accountNameController.value.clear();
    accountCodeController.value.clear();
    filterQuoteValidityController.value.clear();
    quoteValidityStartToEnd.value="";
    extClosureStartToEnd.value="";
    rh_Approval_controller.value.clear();
    cbh_Approval_controller.value.clear();
    Gm_Approval_Controller.value.clear();
    itemCodeController.value.clear();
    itemNameController.value.clear();
    quantityFilterController.value.clear();
    LSPFilterController.value.clear();
    MAPFilterController.value.clear();
    BTPFilterController.value.clear();
    BM_per_ilterController.value.clear();
    GM_per_ilterController.value.clear();
    StandardCostController.value.clear();
    SalesCreditController.value.clear();

    createdOnStartToEnd.value="";
    //RegionName_controller.value.clear();
    //clusterName_controller.value.clear();
    productCategoryController.value.clear();
    createdOnCnontroller.value.clear();



  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    try{
      await sessionManagement.saveSaleAdviseListData({

        'salesAdviseStatusController': salesAdviseStatusController.value.text,
        'salesAdviseIdController': salesAdviseIdController.value.text,
        'quoteIdController': quoteIdController.value.text,
        'quoteVersionController': quoteVersionController.value.text,
        'saleCycleIdController': saleCycleIdController.value.text,
        'customer_name': accountNameController.value.text,
        'customer_code': accountCodeController.value.text,
        'filterQuoteValidityController': filterQuoteValidityController.value.text,
        'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
        'expected_closure_date': filterExpectedClosuredateController.value.text,
        'extClosureStartToEnd': extClosureStartToEnd.value,
        'createdOn_Controller': createdOnCnontroller.value.text,
        'createdOnStartToEnd': createdOnStartToEnd.value,
        'region_name': RegionName_controller.value.text,
        'cluster_name': clusterName_controller.value.text,
        'product_category': productCategoryController.value.text,
        'product_category_type': product_category_type_Controller.value.text,
      });
    }
    catch(e){
      print("Exception ${e.toString()}");
    }
    filterDataChecker.value='';
    getSaleCycleProductByIdList(pageNumber);

  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getSaleAdviseListData();

    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';

      salesAdviseStatusController.value.text=getFilterData["salesAdviseStatusController"]??"";
      salesAdviseIdController.value.text=getFilterData["salesAdviseIdController"]??"";
      quoteIdController.value.text=getFilterData["quoteIdController"]??"";
      quoteVersionController.value.text=getFilterData["quoteVersionController"]??"";
      saleCycleIdController.value.text=getFilterData["saleCycleIdController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["expected_closure_date"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
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

    pageNumber=0;
    getSaleCycleProductByIdList(pageNumber);

  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearSaleAdviseListData();
  }

  void SaveAllSaleAdviseLineFilterData() async{
    try{
      await sessionManagement.saveAllSaleAdviseLineData({

        'salesAdviseStatusController': salesAdviseStatusController.value.text,
        'salesAdviseIdController': salesAdviseIdController.value.text,
        'quoteIdController': quoteIdController.value.text,
        'quoteVersionController': quoteVersionController.value.text,
        'saleCycleIdController': saleCycleIdController.value.text,
        'customer_name': accountNameController.value.text,
        'customer_code': accountCodeController.value.text,
        'filterQuoteValidityController': filterQuoteValidityController.value.text,
        'quoteValidityStartToEnd': quoteValidityStartToEnd.value,
        'expected_closure_date': filterExpectedClosuredateController.value.text,
        'extClosureStartToEnd': extClosureStartToEnd.value,
        'rh_Approval_controller':rh_Approval_controller.value.text,
        'cbh_Approval_controller':cbh_Approval_controller.value.text,
        'Gm_Approval_Controller':Gm_Approval_Controller.value.text,
        'itemCodeController':itemCodeController.value.text,
        'itemNameController':itemNameController.value.text,
        'quantityFilterController':quantityFilterController.value.text,
        'LSPFilterController':LSPFilterController.value.text,
        'MAPFilterController':MAPFilterController.value.text,
        'BTPFilterController':BTPFilterController.value.text,
        'BM_per_ilterController':BM_per_ilterController.value.text,
        'GM_per_ilterController':GM_per_ilterController.value.text,
        'StandardCostController':StandardCostController.value.text,
        'SalesCreditController':SalesCreditController.value.text,
        'createdOn_Controller': createdOnCnontroller.value.text,
        'createdOnStartToEnd': createdOnStartToEnd.value,
        'region_name': RegionName_controller.value.text,
        'cluster_name': clusterName_controller.value.text,
        'product_category': productCategoryController.value.text,
        'product_category_type': product_category_type_Controller.value.text,
      });
    }
    catch(e){
      print("Exception ${e.toString()}");
    }
    filterDataChecker.value='';
    getSaleCycleProductByIdList(pageNumber);

  }

  void getAllSaleAdviseLineFilterData() async{
    Map getFilterData=await sessionManagement.getAllSaleAdviseLineData();

    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';

      salesAdviseStatusController.value.text=getFilterData["salesAdviseStatusController"]??"";
      salesAdviseIdController.value.text=getFilterData["salesAdviseIdController"]??"";
      quoteIdController.value.text=getFilterData["quoteIdController"]??"";
      quoteVersionController.value.text=getFilterData["quoteVersionController"]??"";
      saleCycleIdController.value.text=getFilterData["saleCycleIdController"]??"";
      accountNameController.value.text=getFilterData["customer_name"]??"";
      accountCodeController.value.text=getFilterData["customer_code"]??"";
      filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"]??"";
      quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"]??"";
      filterExpectedClosuredateController.value.text=getFilterData["expected_closure_date"]??"";
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"]??"";
      rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"]??"";
      cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"]??"";
      Gm_Approval_Controller.value.text=getFilterData["Gm_Approval_Controller"]??"";
      itemCodeController.value.text=getFilterData["itemCodeController"]??"";
      itemNameController.value.text=getFilterData["itemNameController"]??"";
      quantityFilterController.value.text=getFilterData["quantityFilterController"]??"";
      LSPFilterController.value.text=getFilterData["LSPFilterController"]??"";
      MAPFilterController.value.text=getFilterData["MAPFilterController"]??"";
      BTPFilterController.value.text=getFilterData["BTPFilterController"]??"";
      BM_per_ilterController.value.text=getFilterData["BM_per_ilterController"]??"";
      GM_per_ilterController.value.text=getFilterData["GM_per_ilterController"]??"";
      StandardCostController.value.text=getFilterData["StandardCostController"]??"";
      SalesCreditController.value.text=getFilterData["SalesCreditController"]??"";
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

    pageNumber=0;
    getSaleCycleProductByIdList(pageNumber);

  }

  void clearAllSaleAdviseLineFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearAllSaleAdviseLineData();
  }
}