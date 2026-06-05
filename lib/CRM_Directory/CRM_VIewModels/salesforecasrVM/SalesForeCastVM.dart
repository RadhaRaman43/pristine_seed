import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/SalesForceCastModals/SalesForceCastListModal.dart';
import '../../CRM_Repository/salesforcecastRepository/SalesForeCastRepo.dart';

class SalesForeCastVM extends GetxController{
  final _api = SalesForeCastRepo();
  SessionManagement sessionManagement = SessionManagement();

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  int total_rows_sales_force = 0;
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;
  RxBool loading = false.obs;
  String email = "";
  String filterRouting = "";
  String userType = "";

  RxString foreCastStatus = "Pending".obs;
  RxList<SalesForceCastListModal> sales_force_cast_list  = <SalesForceCastListModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;


  //filter fields
  var salesForceCastId = TextEditingController().obs;
  var createdOnCnontroller = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;

  //
  var month_controller = TextEditingController().obs;
  var year_controller = TextEditingController().obs;


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
    //product_category_type_Controller.value.text = "Contains";
    getSalesForecastListGet(pageNumber);
  }
  Future<void> refreshList() async {
    pageNumber = 0;
    getSalesForecastListGet(pageNumber, );
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