import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/SalesForceCastModals/RollingForeCastListModal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Repository/salesforcecastRepository/SalesForeCastRepo.dart';

class RollingForeCastRHVM extends GetxController{
  final _api = SalesForeCastRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;

  int pageNumber = 0;
  int total_rows = 0;
  int rowsPerPage = 10;

  String email = "";
  String filterRouting = "";
  String userType = "";
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;

  RxList<ItemCategoryMstModel> item_product_cat_list = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_item_product_cat_list = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> parentProductCategoryList = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> parentItemCategorySelectedList = <ItemCategoryMstModel>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  RxList<RollingForeCastListModal> rolling_fore_cast_list  = <RollingForeCastListModal>[].obs;

  //todo filter controllers

  var rollingForceCastId = TextEditingController().obs;
  var quoteIdController=TextEditingController().obs;
  var saleCycleController=TextEditingController().obs;
  var customerNameController=TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;
  var createdByCnontroller = TextEditingController().obs;
  var itemCodeController=TextEditingController().obs;
  var itemNameController=TextEditingController().obs;
  var qtyController=TextEditingController().obs;
  var itemVarient_Ctrl = TextEditingController().obs;
  var itemCategoryCodeController = TextEditingController().obs;
  var parentCategoryCodeController = TextEditingController().obs;
  var closerMonth_Ctrl = TextEditingController().obs;
  var closerYear_Ctrl = TextEditingController().obs;
  var createdOnController = TextEditingController().obs;
  var requiredRegionNameController = TextEditingController().obs;


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
    getClustersGetByEmail();
    SalesForecastLinesGetNew(0);
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    //product_category_type_Controller.value.text="Contains";
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
      String onValue = await _api.RegionsWithClusterFilterGetByEmailApiHit(data, sessionManagement);
      print(onValue);
      final jsonResponse = json.decode(onValue);
      if(jsonResponse is List){
        List<RegionWithClusterFilterModal> response = jsonResponse.map((e) => RegionWithClusterFilterModal.fromJson(e)).toList();
        if(response.length>0 && response[0].condition=="True"){
          regionwithclusterGetByEmailList.value=response;
          RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
          SelectedRegion_list.assignAll(regionwithclusterGetByEmailList);

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

  void SalesForecastLinesGetNew(int page_no) async{
    try{
      Map<String, dynamic> data={
        "filter_sales_forecast_id": "",
        "filter_quote_id": "",
        "filter_sales_cycle_id": "",
        "filter_account_code": "",
        "filter_account_name": "",
        "filter_branch_head_value": "",
        "filter_clusture_head_value": "",
        "filter_created_by": "",
        "filter_created_on": "",
        "filter_item_code": "",
        "filter_item_name": "",
        "filter_item_varient": "",
        "filter_item_category_type": "",
        "filter_item_category_code": "",
        "filter_item_parent_category_code": "",
        "filter_closure_month": "",
        "filter_closure_year": "",
        "filter_required_region_name": "",
        "filter_required_cluster_name": "",
        "filter_quote_validity": "",
        "filter_exp_closure_date": "",
        "filter_approved_by": "",
        "filter_approved_on": "",
        "filter_flag": "string",
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
     createdByCnontroller.value.clear();
     itemCodeController.value.clear();
     itemNameController.value.clear();
     qtyController.value.clear();
     itemVarient_Ctrl.value.clear();
     itemCategoryCodeController.value.clear();
     parentCategoryCodeController.value.clear();
     closerMonth_Ctrl.value.clear();
     closerYear_Ctrl.value.clear();
     createdOnController.value.clear();
     requiredRegionNameController.value.clear();

  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveSaleForeCastData({
      'rollingForceCastId': rollingForceCastId.value.text,
      'quoteIdController': quoteIdController.value.text,
      'saleCycleController': saleCycleController.value.text,
      'customerNameController': customerNameController.value.text,
      'createdByCnontroller': createdByCnontroller.value.text,
      'itemCodeController': itemCodeController.value.text,
      'itemNameController': itemNameController.value.text,
      'qtyController': qtyController.value.text,
      'itemVarient_Ctrl': itemVarient_Ctrl.value.text,
      'itemCategoryCodeController': itemCategoryCodeController.value.text,
      'closerMonth_Ctrl': closerMonth_Ctrl.value.text,
      'closerYear_Ctrl': closerYear_Ctrl.value.text,
      'createdOnController': createdOnController.value.text,
      'requiredRegionNameController': requiredRegionNameController.value.text,



    });
    filterDataChecker.value='';
    SalesForecastLinesGetNew(pageNumber,);

  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getSaleForeCastData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      rollingForceCastId.value.text=getFilterData["rollingForceCastId"]??"";
      quoteIdController.value.text=getFilterData["quoteIdController"]??"";
      saleCycleController.value.text=getFilterData["saleCycleController"]??"";
      customerNameController.value.text=getFilterData["customerNameController"]??"";
      createdByCnontroller.value.text=getFilterData["createdByCnontroller"]??"";
      itemCodeController.value.text=getFilterData["itemCodeController"]??"";
      itemNameController.value.text=getFilterData["itemNameController"]??"";
      qtyController.value.text=getFilterData["qtyController"]??"";
      itemVarient_Ctrl.value.text=getFilterData["qtyController"]??"";
      itemCategoryCodeController.value.text=getFilterData["itemCategoryCodeController"]??"";
      parentCategoryCodeController.value.text=getFilterData["parentCategoryCodeController"]??"";
      closerMonth_Ctrl.value.text=getFilterData["closerMonth_Ctrl"]??"";
      closerYear_Ctrl.value.text=getFilterData["closerYear_Ctrl"]??"";
      createdOnController.value.text=getFilterData["createdOnController"]??"";
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

}