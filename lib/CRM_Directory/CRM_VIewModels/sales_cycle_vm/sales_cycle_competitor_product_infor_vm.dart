

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_competitor_product_infor_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesCycleCompetitorProductInforVm extends GetxController{

  RxList<SaleCycleCompetitorProductInformationModal> salesCycleCompetitorProductInformationList =
      <SaleCycleCompetitorProductInformationModal>[].obs;
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String email = "";
  String userType = "";
  String isAdminWritePermission = "";
  RxBool loading = false.obs;

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();

  var clusterName_controller = TextEditingController().obs;
  var createdByController = TextEditingController().obs;
  var district_controller = TextEditingController().obs;
  var postalCodeController = TextEditingController().obs;
  var companyProfileTypeController = TextEditingController().obs;
  var filterTask_Id_controller = TextEditingController().obs;
  var accountCodeController = TextEditingController().obs;
  var category_Approval_controller = TextEditingController().obs;
  var accountNameController = TextEditingController().obs;
  var filterExpectedClosuredateController = TextEditingController().obs;
  var filterQuoteStatusController = TextEditingController().obs;
  var filterQuoteValidityController = TextEditingController().obs;
  var filterQuoteIdController = TextEditingController().obs;
  var productCategoryController = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var createdOnCnontroller = TextEditingController().obs;
  var filterItemCodeController = TextEditingController().obs;
  var filterQuoteAcceptedController = TextEditingController().obs;
  var filterSalesCycleApprovalStatusController = TextEditingController().obs;
  var filterSalesCycleStatusController = TextEditingController().obs;
  var filterSalesCycleIdController = TextEditingController().obs;

  RxList<String> SaleCycleStatusList =
      ["All", "Suspect", "Prospect", "Propose"].obs;
  RxList<String> qouteAcceptedList =
      ["All", "Open", "Loss", "Won"].obs;
  RxList<String> ApprovalStatusList =
      ["All", "PENDING", "PENDING FOR APPROVAL", "APPROVED", "REJECTED"].obs;


  RxString createdOnStartToEnd="".obs;
  RxString extClosureStartToEnd="".obs;
  RxString quoteValidityStartToEnd="".obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;


  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    //getGalesCycleCompetitorProductInformationGet(pageNumber);
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
            getGalesCycleCompetitorProductInformationGet(pageNumber);

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

  getGalesCycleCompetitorProductInformationGet(int pageNumber) {
    Map data = {
      "filter_quote_id": filterQuoteIdController.value.text.isNotEmpty?filterQuoteIdController.value.text:"",
      "filter_sales_cycle_id": filterSalesCycleIdController.value.text.isNotEmpty?filterSalesCycleIdController.value.text:"",
      "filter_account_code": accountCodeController.value.text.isNotEmpty?accountCodeController.value.text:"",
      "filter_account_name": accountNameController.value.text.isNotEmpty?accountNameController.value.text:"",
      "filter_flag": "AllCompetitorLines",
      "filter_product_category": productCategoryController.value.text.isNotEmpty?productCategoryController.value.text:"",
      "filter_created_by": email,
      "filter_created_on": createdOnStartToEnd.value.isNotEmpty?createdOnStartToEnd.value:"",
      "filter_item_code_name": filterItemCodeController.value.text.isNotEmpty?filterItemCodeController.value.text:"",
      "filter_competitor_name": "",
      "filter_loss_reason": "",
      "filter_sales_cycle_status": filterSalesCycleStatusController.value.text.isNotEmpty?filterSalesCycleStatusController.value.text:"",
      "filter_sales_cycle_approval_status": filterSalesCycleApprovalStatusController.value.text.isNotEmpty?filterSalesCycleApprovalStatusController.value.text:"",
      "filter_sales_cycle_quote_accepted":filterQuoteAcceptedController.value.text.isNotEmpty?filterQuoteAcceptedController.value.text:"",
      "filter_expected_closure_date": filterExpectedClosuredateController.value.text.isNotEmpty?filterExpectedClosuredateController.value.text:"",
      "filter_postal_code": "",
      "filter_district": "",
      "filter_frontliner_value": "",
      "filter_branch_head_value": RegionName_controller.value.text.isNotEmpty?RegionName_controller.value.text:"",
      "filter_zone_head_value": "",
      "filter_clusture_head_value": clusterName_controller.value.text.isNotEmpty? clusterName_controller.value.text:"",
      "row_per_page": rowsPerPage,
      "page_number": pageNumber
    };

    loading.value = true;
    _api.salesCycleCompetitorProductInformationGetApiHit(data, sessionManagement).then(
          (onValue) {
        try {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<SaleCycleCompetitorProductInformationModal> response = jsonResponse
                .map((e) => SaleCycleCompetitorProductInformationModal.fromJson(e))
                .toList();
            if (response.isNotEmpty && response.length>0  && response[0].condition?.toLowerCase() == "true") {
              if (pageNumber == 0) {
                salesCycleCompetitorProductInformationList.clear();
              }
              salesCycleCompetitorProductInformationList.addAll(response);
              total_rows = int.parse(salesCycleCompetitorProductInformationList[0].totalRows!);
            } else {
              Utils.sanckBarError("False Message", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        } catch (e) {
          print(e) ;
        } finally {
          loading.value = false;
        }
      },
    ).onError(
          (error, stackTrace) {
      },
    ).whenComplete(() {
      this.loading.value = false;
    });
  }

  void clearAllField() {
    filterSalesCycleApprovalStatusController.value.clear();
    filterQuoteAcceptedController.value.clear();
    filterSalesCycleStatusController.value.clear();
    filterItemCodeController.value.clear();
    accountNameController.value.clear();
    accountCodeController.value.clear();
    filterSalesCycleIdController.value.clear();
    productCategoryController.value.clear();
    filterExpectedClosuredateController.value.clear();
    extClosureStartToEnd.value="";
    createdOnStartToEnd.value="";
    clusterName_controller.value.clear();
    RegionName_controller.value.clear();
  }

}