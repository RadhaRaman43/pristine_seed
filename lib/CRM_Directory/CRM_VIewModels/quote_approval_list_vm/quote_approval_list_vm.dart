

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_quote_header_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class QuoteApprovalListVm extends GetxController{

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  String email="";
  int pageNumberForQuote = 0;
  int rowsPerPage = 10;
  int total_rows = 0;

  RxString createdOnStartToEnd = "".obs;
  RxString extClosureStartToEnd = "".obs;
  RxString quoteValidityStartToEnd = "".obs;


  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteVersionController=TextEditingController().obs;
  var filterQuoteAccountNameController=TextEditingController().obs;
  var filterQuoteContactNameController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  var filterQuoteSaleCycleController=TextEditingController().obs;

  var createdOnCnontroller=TextEditingController().obs;
  var RegionName_controller=TextEditingController().obs;
  var zone_head_value_controller=TextEditingController().obs;
  var clusterName_controller=TextEditingController().obs;
  var frontliner_controller=TextEditingController().obs;
  var createdByController=TextEditingController().obs;
  var companyProfileTypeController=TextEditingController().obs;
  var accountCodeController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var rh_Approval_controller=TextEditingController().obs;
  var cbh_Approval_controller=TextEditingController().obs;
  var category_Approval_controller=TextEditingController().obs;
  var gm_Approval_controller=TextEditingController().obs;
  var filterQuoteStatusController=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;
  var product_category_type_Controller = TextEditingController().obs;


  RxList<SalesCycleQuoteHeaderModal> quoteApprovalList=<SalesCycleQuoteHeaderModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;
  RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;

  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;

  @override
  Future<void> onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    //getQuoteHeaderData(pageNumberForQuote);
    product_category_type_Controller.value.text="Contains";
    getItemCategoryMstWithoutTaskIdApi();
    getClustersGetByEmail();
    getFilterData();
    super.onInit();
  }

  Future<void>refreshList() async{
    getQuoteHeaderData(pageNumberForQuote);
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
                  clusterGetByEmailList.value.map((e) => e.geoValue).join(', ');
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
          .join('||');
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
            RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join(', ');
            print('region....${RegionName_controller.value.text}');
            getQuoteHeaderData(pageNumberForQuote);

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
  getQuoteHeaderData(int pageNumberForQuote){
    try{
      Map data={
        "filter_quote_id": filterQuoteIdController.value.text.isNotEmpty? filterQuoteIdController.value.text:"",
        "filter_sales_cycle_id": filterQuoteSaleCycleController.value.text.isEmpty?"":filterQuoteSaleCycleController.value.text,
        "filter_account_code": accountCodeController.value.text.isEmpty?"": accountCodeController.value.text,
        "filter_account_name":  accountNameController.value.text.isEmpty?"": accountNameController.value.text,
        "filter_rh_approval":  rh_Approval_controller.value.text.isEmpty?"": rh_Approval_controller.value.text,
        "filter_cbh_approval":  cbh_Approval_controller.value.text.isEmpty?"": cbh_Approval_controller.value.text,
        "filter_category_approval":  category_Approval_controller.value.text.isEmpty?"": category_Approval_controller.value.text,
        "filter_gm_approval":  gm_Approval_controller.value.text.isEmpty?"": gm_Approval_controller.value.text,
        "filter_quote_version": -1,
        "filter_quote_validity": quoteValidityStartToEnd.value.isNotEmpty?quoteValidityStartToEnd.value:"",
        "filter_exp_closure_date": extClosureStartToEnd.value.isNotEmpty?extClosureStartToEnd.value:"",
        "filter_quote_status":"Under Approval",
        "filter_product_category": productCategoryController.value.text.isEmpty?"":productCategoryController.value.text,
        "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
        "filter_created_by": email,
        "filter_created_on": createdOnStartToEnd.value.isNotEmpty?createdOnStartToEnd.value:"",
        "filter_frontliner_value": frontliner_controller.value.text.isEmpty?"":frontliner_controller.value.text,
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value": zone_head_value_controller.value.text.isEmpty?"":zone_head_value_controller.value.text,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "row_per_page": rowsPerPage,
        "page_number": pageNumberForQuote
      };
      loading.value=true;
      _api.quoteHeaderGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleQuoteHeaderModal> response = jsonResponse.map((e) => SalesCycleQuoteHeaderModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumberForQuote==0){
              quoteApprovalList.clear();
            }
            quoteApprovalList.addAll(response);
            print("${quoteApprovalList.length}");
            total_rows=int.parse(quoteApprovalList[0].totalRows!);
          }else {
            quoteApprovalList.value=[];
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
      );
    }catch(e){
      loading.value = false;
      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  void clearAllFieldOfQuoteFilter() {
    product_category_type_Controller.value.text="Contains";
    filterQuoteVersionController.value.clear();
    Selected_Item_Category_master_list_without_task.value=[];
    filterQuoteIdController.value.clear();
    filterQuoteStatusController.value.clear();
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
    frontliner_controller.value.clear();
    RegionName_controller.value.clear();
    zone_head_value_controller.value.clear();
    clusterName_controller.value.clear();
    filterQuoteSaleCycleController.value.clear();
    createdOnStartToEnd.value = "";
    extClosureStartToEnd.value = "";
    quoteValidityStartToEnd.value = "";

  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveQuoteApproverData({
      'filterQuoteIdController': filterQuoteIdController.value.text,
      'filterQuoteVersionController': filterQuoteVersionController.value.text,
      'filterQuoteSaleCycleController': filterQuoteSaleCycleController.value.text,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
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
      'createdOn_Controller': createdOnCnontroller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,

    });
    filterDataChecker.value='';

  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getQuoteApproverData();

    filterQuoteIdController.value.text=getFilterData["filterQuoteIdController"];
    filterQuoteVersionController.value.text=getFilterData["filterQuoteVersionController"];
    filterQuoteSaleCycleController.value.text=getFilterData["filterQuoteSaleCycleController"];
    accountNameController.value.text=getFilterData["customer_name"];
    accountCodeController.value.text=getFilterData["customer_code"];
    filterQuoteValidityController.value.text=getFilterData["filterQuoteValidityController"];
    quoteValidityStartToEnd.value=getFilterData["quoteValidityStartToEnd"];
    extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"];
    filterExpectedClosuredateController.value.text=getFilterData["filterExpectedClosuredateController"];
    rh_Approval_controller.value.text=getFilterData["rh_Approval_controller"];
    cbh_Approval_controller.value.text=getFilterData["cbh_Approval_controller"];
    category_Approval_controller.value.text=getFilterData["category_Approval_controller"];
    gm_Approval_controller.value.text=getFilterData["gm_Approval_controller"];
    RegionName_controller.value.text=getFilterData["region_name"];
    clusterName_controller.value.text=getFilterData["cluster_name"];
    createdOnCnontroller.value.text=getFilterData["createdOn_Controller"];
    createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"];
    productCategoryController.value.text=getFilterData["product_category"];
    product_category_type_Controller.value.text=getFilterData["product_category_type"];


    pageNumberForQuote=0;
    filterDataChecker.value='1';
    getQuoteHeaderData(pageNumberForQuote,);
  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearQuoteApproverData();
  }
}

