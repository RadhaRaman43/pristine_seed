import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessTourApprovalModel.dart';
import '../../CRM_Repository/BusinessTourPlan_Repository/business_tour_plan_repo.dart';

class BusinessTourApprovalVm extends GetxController{

  final _api = BusinessTourPlanRepo();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  String isAdminWritePermission = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;
  RxString filterStatusFlag = 'Approved'.obs;

  RxList<BusinessTourApprovalModel> BusinessTourApprovalList = <BusinessTourApprovalModel>[].obs;
  RxList<BusinessTourApprovalModel> BusinessTourApproveRejectList = <BusinessTourApprovalModel>[].obs;

  var filterTourIdController = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;
  final StartDate_filter_controller=TextEditingController().obs;
  final EndDate_filter_controller=TextEditingController().obs;
  final createdOn_filter_controller=TextEditingController().obs;
  var filterCreatedByController = TextEditingController().obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  @override
  Future<void> onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    clearAllFieldOfFilter();
    getClustersGetByEmail();
    super.onInit();
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    getBusinessTourApprovalListData(pageNumber);
  }

  Future<void> refreshApproveRejectList() async {
    pageNumber = 0;
    getBusinessTourApprovalListData(pageNumber);
    //getBusinessTourApproveRejectListData(pageNumber, filterStatusFlag.value);
  }

  void clearAllFieldOfFilter() {
    print("Clear Filed");
    filterTourIdController.value.clear();
    StartDate_filter_controller.value.clear();
    EndDate_filter_controller.value.clear();
    filterCreatedByController.value.clear();
    createdOn_filter_controller.value.clear();


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
            //getBusinessTourApprovalListData(pageNumber);
            getApproveFilterData();



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

  getBusinessTourApprovalListData(int page_no) {
    try {
      Map data = {
        "filter_tour_id": filterTourIdController.value.text.isEmpty?"":filterTourIdController.value.text,
        "filter_created_by": filterCreatedByController.value.text.isEmpty?"":filterCreatedByController.value.text,
        "email_id": email,
        "approve_status": "PENDING FOR APPROVAL",
        "branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "start_date": StartDate_filter_controller.value.text.isEmpty?"":StartDate_filter_controller.value.text,
        "end_date": EndDate_filter_controller.value.text.isEmpty?"":EndDate_filter_controller.value.text,
        "filter_created_on": createdOn_filter_controller.value.text.isEmpty?"":createdOn_filter_controller.value.text,
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no,

      };
      loading.value = true;
      _api.BusinessTourPlanApprovalGet(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BusinessTourApprovalModel> response =
            jsonResponse.map((e) => BusinessTourApprovalModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              if (page_no == 0) {
                BusinessTourApprovalList.clear();
              }
              BusinessTourApprovalList.addAll(response);
              print('listSize.....${BusinessTourApprovalList.length}');
              total_rows = int.parse(BusinessTourApprovalList[0].totalRows!.toString());

            } else {
              loading.value = false;
              BusinessTourApprovalList.value = [];
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }


  RxString filterDataChecker = ''.obs;


  void SaveApprovFilterData() async{
    await sessionManagement.saveBusinessApproveTourPlanData({

      'filterTourIdController': filterTourIdController.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      //'filterTouringRegionController': filterTouringRegionController.value.text,
      'StartDate_filter_controller': StartDate_filter_controller.value.text,
      'EndDate_filter_controller': EndDate_filter_controller.value.text,
      'filterCreatedByController': filterCreatedByController.value.text,
      'createdOn_filter_controller': createdOn_filter_controller.value.text,

    });
    filterDataChecker.value='';
    getBusinessTourApprovalListData(pageNumber);

  }

  void getApproveFilterData() async{
    Map getFilterData=await sessionManagement.getBusinessApproveTourPlanData();

    if(getFilterData.isNotEmpty){
      filterTourIdController.value.text=getFilterData["filterTourIdController"]??"";
      StartDate_filter_controller.value.text=getFilterData["StartDate_filter_controller"]??"";
      EndDate_filter_controller.value.text=getFilterData["EndDate_filter_controller"]??"";
      filterCreatedByController.value.text=getFilterData["filterCreatedByController"]??"";
      createdOn_filter_controller.value.text=getFilterData["createdOn_filter_controller"]??"";
      filterDataChecker.value='1';


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
    getBusinessTourApprovalListData(pageNumber);

  }

  void clearApproveFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearBusinessApproveTourPlanData();
  }
}