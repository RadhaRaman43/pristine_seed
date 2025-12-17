

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
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
 var filterExpectedClosuredateController=TextEditingController().obs;
 var salesAdviseIdController=TextEditingController().obs;
 var filterQuoteValidityController=TextEditingController().obs;
 var salesAdviseStatusController=TextEditingController().obs;
 var accountNameController=TextEditingController().obs;
 var accountCodeController=TextEditingController().obs;
 var RegionName_controller=TextEditingController().obs;
 var clusterName_controller=TextEditingController().obs;
 var productCategoryController=TextEditingController().obs;
 var createdOnCnontroller=TextEditingController().obs;
 var itemCodeController=TextEditingController().obs;
 var itemNameController=TextEditingController().obs;
 var lspController=TextEditingController().obs;
 var salesCreditController=TextEditingController().obs;

 RxString quoteValidityStartToEnd="".obs;
 RxString extClosureStartToEnd="".obs;
 RxString createdOnStartToEnd="".obs;
  RxList<String> salesAdviseStatusList = ["Draft", "Completed"].obs;

  RxList<AllSalesAdviseModal> salesAdviseList=<AllSalesAdviseModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    //getSaleCycleProductByIdList(pageNumber);
    getClustersGetByEmail();
    // TODO: implement onInit
    super.onInit();
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
            getSaleCycleProductByIdList(pageNumber);

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
      "filter_quote_id": "",
      "filter_sales_cycle_id": "",
      "filter_account_code": accountNameController.value.text.isNotEmpty?accountNameController.value.text:"",
      "filter_account_name": accountCodeController.value.text.isNotEmpty?accountCodeController.value.text:"",
      "filter_rh_approval": "",
      "filter_cbh_approval": "",
      "filter_category_approval": "",
      "filter_gm_approval": "",
      "filter_quote_version": -1,
      "filter_quote_validity": quoteValidityStartToEnd.value,
      "filter_exp_closure_date": extClosureStartToEnd.value,
      "filter_sales_advice_status": salesAdviseStatusController.value.text.isNotEmpty?salesAdviseStatusController.value.text:"",
      "filter_flag": filterFlag,
      "filter_product_category": productCategoryController.value.text.isNotEmpty?productCategoryController.value.text:"",
      "filter_created_by": email,
      "filter_created_on": createdOnStartToEnd.value,
      "filter_frontliner_value": "",
      "filter_branch_head_value": RegionName_controller.value.text.isNotEmpty?RegionName_controller.value.text:"",
      "filter_zone_head_value": clusterName_controller.value.text.isNotEmpty?clusterName_controller.value.text:"",
      "filter_clusture_head_value": "",
      "filter_spr_no": "",
      "filter_item_code": itemCodeController.value.text.isNotEmpty?itemCodeController.value.text:"",
      "filter_item_name": itemNameController.value.text.isNotEmpty?itemNameController.value.text:"",
      "filter_quantity": "",
      "filter_gm_per": "",
      "filter_bm_per": "",
      "filter_sales_credit": salesCreditController.value.text.isNotEmpty?salesCreditController.value.text:"",
      "filter_lsp": lspController.value.text.isNotEmpty?lspController.value.text:"",
      "filter_map": "",
      "filter_btp": "",
      "filter_standard_cost": "",
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
     filterExpectedClosuredateController.value.clear();
     salesAdviseIdController.value.clear();
     filterQuoteValidityController.value.clear();
     salesAdviseStatusController.value.clear();
     accountNameController.value.clear();
     accountCodeController.value.clear();
     //RegionName_controller.value.clear();
     //clusterName_controller.value.clear();
     productCategoryController.value.clear();
     createdOnCnontroller.value.clear();
     extClosureStartToEnd.value="";
     quoteValidityStartToEnd.value="";
     createdOnStartToEnd.value="";
     itemCodeController.value.clear();
     itemNameController.value.clear();
     lspController.value.clear();
     salesCreditController.value.clear();

  }
}