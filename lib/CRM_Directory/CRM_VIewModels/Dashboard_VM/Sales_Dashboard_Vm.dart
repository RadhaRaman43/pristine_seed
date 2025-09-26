import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/dashboard_models/SalesDashboard_Model/SalesDashboard_Model.dart';
import '../../CRM_Repository/dashboard_repository/dashboard_repo.dart';

class SalesDashboardVm extends GetxController{

  final _api = DashboardRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  String email = "";
  String userType = "";
  var selectedOption = 'Employee'.obs;
  var FilterFunnel = 'All'.obs;
  RxString formattedStartDate = "".obs;
  RxString formattedEndDate = "".obs;
  RxString ClusterName = "".obs;
  RxString RegionName = "".obs;
  RxString SalesPersonName = "".obs;
  RxString SalesPersonERCode = "".obs;
  RxString PeriodFrom = "".obs;
  RxString PeriodTo = "".obs;

  RxBool isExpandCrtd = false.obs;
  RxBool isExpandFunnel = false.obs;
  RxBool isExpandBussiness = false.obs;
  RxBool isExpandCollection = false.obs;

  var ClusterNameForApi;
  var RegionNameForApi;

  var PeriodTo_Controller = TextEditingController().obs;
  var PeriodFrom_Controller = TextEditingController().obs;
  var SalesPersonER_Code_Controller = TextEditingController().obs;
  var SalesPersonName_Controller = TextEditingController().obs;
  var RegionName_Controller = TextEditingController().obs;
  var ClusterName_Controller = TextEditingController().obs;
  var clusterNameFilter_controller=TextEditingController().obs;
  var RegionNameFilter_controller=TextEditingController().obs;


  RxList<SaleDashboardDataModel> salesDashboardList = <SaleDashboardDataModel>[].obs;
  RxList<MonthWiseTotalFunnel> monthWiseTotalFunnelList = <MonthWiseTotalFunnel>[].obs;
  RxList<MonthWiseCommitment> monthWiseCommitmentList = <MonthWiseCommitment>[].obs;
  RxList<MonthWiseAoVsBookingAchive> monthWiseAoVsBookingList = <MonthWiseAoVsBookingAchive>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;


  var filterCustomDateController=TextEditingController().obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    DateRange("financial");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';
    salesDashboardData();
    getClustersGetByEmail();


  }

  void DateRange(String type) {
    DateTime now = DateTime.now();
    late DateTime startDate;
    late DateTime endDate;

    switch (type.toLowerCase()) {
      case 'day':
        startDate = now;
        endDate = now;
        break;

      case 'week':
        int currentWeekday = now.weekday; // 1 (Mon) to 7 (Sun)
        startDate = now.subtract(Duration(days: currentWeekday - 1));
        endDate = now.add(Duration(days: 7 - currentWeekday));
        break;

      case 'month':
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;

      case 'quarterly':
        int currentMonth = now.month;
        if (currentMonth >= 1 && currentMonth <= 3) {
          startDate = DateTime(now.year, 1, 1);
          endDate = DateTime(now.year, 3, 31);
        } else if (currentMonth >= 4 && currentMonth <= 6) {
          startDate = DateTime(now.year, 4, 1);
          endDate = DateTime(now.year, 6, 30);
        } else if (currentMonth >= 7 && currentMonth <= 9) {
          startDate = DateTime(now.year, 7, 1);
          endDate = DateTime(now.year, 9, 30);
        } else {
          startDate = DateTime(now.year, 10, 1);
          endDate = DateTime(now.year, 12, 31);
        }
        break;

      case 'financial':
        if (now.month >= 4) {
          // Current FY: starts from April this year to March next year
          startDate = DateTime(now.year, 4, 1);
          endDate = DateTime(now.year + 1, 3, 31);
        } else {
          // Current FY: starts from April last year to March this year
          startDate = DateTime(now.year - 1, 4, 1);
          endDate = DateTime(now.year, 3, 31);
        }
        break;

      default:
        print("Invalid type passed. Use: day, week, month, or financial");
        return;
    }

    formattedStartDate.value = DateFormat('yyyy-MM-dd').format(startDate);
    formattedEndDate.value = DateFormat('yyyy-MM-dd').format(endDate);

    print("Start Date: $formattedStartDate");
    print("End Date: $formattedEndDate");

  }

  void toggleCrtd() {
    isExpandCrtd.value = !isExpandCrtd.value;
  }

  void toggleFunnelCrtd() {
    isExpandFunnel.value = !isExpandFunnel.value;
  }

  void toggleBussinessCrtd() {
    isExpandBussiness.value = !isExpandBussiness.value;
  }

  void toggleCollectionCrtd() {
    isExpandCollection.value = !isExpandCollection.value;
  }

  Future<void> salesDashboardData() async {
    ClusterNameForApi = '';
    if(clusterNameFilter_controller.value.text.isNotEmpty){
      ClusterNameForApi = clusterNameFilter_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('|');
    }
    RegionNameForApi = '';
    if(RegionNameFilter_controller.value.text.isNotEmpty){
      RegionNameForApi = RegionNameFilter_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('|');
    }

    try {
      Map<String, String> data = {
        "email_id": email,
        "cluster_name": ClusterNameForApi.isEmpty?"All":ClusterNameForApi,
        "region_name": RegionNameForApi.isEmpty?"All":RegionNameForApi,
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
        "funnel_filter": FilterFunnel.value,
        "emp_email_id": "",
        "flag": selectedOption.value
      };

      print(data);
      loading.value = true;

      final onValue = await _api.SalesDashboardApiHit(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if (jsonResponse is List) {
        List<SaleDashboardDataModel> response = jsonResponse
            .map((e) => SaleDashboardDataModel.fromJson(e))
            .toList();

        if (response.isNotEmpty &&
            response[0].condition?.toLowerCase() == "true") {
          salesDashboardList.value = response;
          monthWiseTotalFunnelList.value = response[0].monthWiseTotalFunnel ?? [];
          print('length.....${monthWiseTotalFunnelList.length}');
          monthWiseCommitmentList.value = response[0].monthWiseCommitment ?? [];
          monthWiseAoVsBookingList.value = response[0].monthWiseAoVsBookingAchive ?? [];
          ClusterName_Controller.value.text = response[0].clusterHead??"";
          RegionName_Controller.value.text = response[0].regionHead??"";
          SalesPersonName_Controller.value.text = response[0].salePersonName??"";
          SalesPersonER_Code_Controller.value.text = response[0].salePersonEmpCode??"";
          PeriodFrom_Controller.value.text = response[0].periodFrom??"";
          PeriodTo_Controller.value.text = response[0].periodTo??"";
          print('baisgdiuasgi du${response[0].clusterHead??""}');

        } else {
          Utils.showErrorToastification(
              "False Message !", response[0].message.toString());
          monthWiseTotalFunnelList.value = [];
          monthWiseCommitmentList.value = [];
          monthWiseAoVsBookingList.value = [];
        }
      }

    } catch (e) {
      print("API error: $e");
    } finally {
      loading.value = false;

    }
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
    if(clusterNameFilter_controller.value.text.isNotEmpty){
      selectedCluster = clusterNameFilter_controller.value.text
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

  clearAllFilterController(){
    ClusterNameForApi = '';
    RegionNameForApi = '';
    clusterNameFilter_controller.value.clear();
    RegionNameFilter_controller.value.clear();
    filterCustomDateController.value.clear();
    SelectedCluster_list.value = [];
    SelectedRegion_list.value = [];
    DateRange("financial");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';

  }



}