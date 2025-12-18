

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
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


  RxList<SalesCycleQuoteHeaderModal> quoteApprovalList=<SalesCycleQuoteHeaderModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  @override
  Future<void> onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    //getQuoteHeaderData(pageNumberForQuote);
    getClustersGetByEmail();
    super.onInit();
  }

  Future<void>refreshList() async{
    getQuoteHeaderData(pageNumberForQuote);
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
        "filter_created_by": email,
        "filter_created_on": createdOnStartToEnd.value.isNotEmpty?createdOnStartToEnd.value:"",
        "filter_frontliner_value": frontliner_controller.value.text.isEmpty?"":frontliner_controller.value.text,
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value": zone_head_value_controller.value.text.isEmpty?"":zone_head_value_controller.value.text,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "row_per_page": rowsPerPage,
        "page_number": pageNumberForQuote
      };
      /* {
        "filter_quote_id": filterQuoteIdController.value.text.isNotEmpty?filterQuoteIdController.value.text:"",
        "filter_sales_cycle_id": filterQuoteSaleCycleController.value.text.isNotEmpty?filterQuoteSaleCycleController.value.text:"" ,
        "filter_account_name": filterQuoteAccountNameController.value.text.isNotEmpty?filterQuoteAccountNameController.value.text:"",
        "filter_contact_name": filterQuoteContactNameController.value.text.isNotEmpty?filterQuoteContactNameController.value.text:"",
        "filter_quote_validity": filterQuoteValidityController.value.text.isNotEmpty?filterQuoteValidityController.value.text:"",
        "filter_contact_person_name": "",
        "filter_exp_closure_date": filterExpectedClosuredateController.value.text.isNotEmpty?filterExpectedClosuredateController.value.text:"",
        "filter_quote_status": "Under Approval",
        "filter_created_by": email,
        "filter_approved_by": "",
        "row_per_page": rowsPerPage,
        "page_number": pageNumberForQuote
      };*/
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
    filterQuoteIdController.value
        .clear();
    filterQuoteStatusController.value
        .clear();
    filterExpectedClosuredateController
        .value.clear();
    filterQuoteValidityController.value
        .clear();
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
}

