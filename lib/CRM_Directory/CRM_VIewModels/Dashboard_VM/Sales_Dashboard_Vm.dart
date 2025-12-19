import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
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
  RxString character = 'Financial Year'.obs;

  RxBool isExpandCrtd = false.obs;
  RxBool isExpandFunnel = false.obs;
  RxBool isExpandBussiness = false.obs;
  RxBool isExpandCollection = false.obs;

  String isAdminWritePermission = "";

  int pageNumber = 0;
  int rowsPerPage = 10;
  RxInt total_rows = 0.obs;

  var ClusterNameForApi;
  var RegionNameForApi;
  var EmployeeNameForApi;

  var PeriodTo_Controller = TextEditingController().obs;
  var PeriodFrom_Controller = TextEditingController().obs;
  var SalesPersonER_Code_Controller = TextEditingController().obs;
  var SalesPersonName_Controller = TextEditingController().obs;
  var RegionName_Controller = TextEditingController().obs;
  var ClusterName_Controller = TextEditingController().obs;
  var clusterNameFilter_controller=TextEditingController().obs;
  var RegionNameFilter_controller=TextEditingController().obs;
  var EmployeeNameFilter_controller=TextEditingController().obs;


  RxList<SaleDashboardDataModel> salesDashboardList = <SaleDashboardDataModel>[].obs;
  RxList<MonthWiseTotalFunnel?> monthWiseTotalFunnelList = <MonthWiseTotalFunnel>[].obs;
  RxList<MonthWiseCommitment?> monthWiseCommitmentList = <MonthWiseCommitment>[].obs;
  RxList<MonthWiseCollectionCommitmentVsActualCollectionAchive?> monthWiseCollectionCommitmentList = <MonthWiseCollectionCommitmentVsActualCollectionAchive>[].obs;
  RxList<MonthWiseAoVsBookingAchive?> monthWiseAoVsBookingList = <MonthWiseAoVsBookingAchive>[].obs;
  RxList<MonthWiseFinalBookingCommitment?> monthWiseFinalBookingList = <MonthWiseFinalBookingCommitment>[].obs;
  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;

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
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    DateRange("financial");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';
    salesDashboardData();
    getClustersGetByEmail();
    if(this.isAdminWritePermission==1){
      EmployeeMasterGet('');
    }
    else{
      getEmployeeTeamMemberGetByClusterRegionApi();
    }


  }

  void DateRange(String type) {
    DateTime now = DateTime.now();
    late DateTime startDate;
    late DateTime endDate;

    switch (type.toLowerCase()) {
      case 'day':
        print('day..........');
        startDate = now;
        endDate = now;
        break;

      case 'week':
        print('week..........');
        int currentWeekday = now.weekday; // 1 (Mon) to 7 (Sun)
        startDate = now.subtract(Duration(days: currentWeekday - 1));
        endDate = now.add(Duration(days: 7 - currentWeekday));
        break;

      case 'month':
        print('month..........');
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;

      case 'quarterly':
        print('quat..........');
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

      case 'previousfinancialyear':
        print('PreviousFinancialYear..........');
        if (now.month >= 4) {
          // Previous FY: April last year → March this year
          startDate = DateTime(now.year - 1, 4, 1);
          endDate = DateTime(now.year, 3, 31);
        } else {
          // Previous FY: April two years ago → March last year
          startDate = DateTime(now.year - 2, 4, 1);
          endDate = DateTime(now.year - 1, 3, 31);
        }
        break;

      case 'financial':
        print('financial..........');
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

      case 'nextfinancialyear':
        print('NextFinancialYear..........');
        if (now.month >= 4) {
          // Next FY: April next year → March year after
          startDate = DateTime(now.year + 1, 4, 1);
          endDate = DateTime(now.year + 2, 3, 31);
        } else {
          // Next FY: April this year → March next year
          startDate = DateTime(now.year, 4, 1);
          endDate = DateTime(now.year + 1, 3, 31);
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
    EmployeeNameForApi = '';
    if(EmployeeNameFilter_controller.value.text.isNotEmpty){
      EmployeeNameForApi = EmployeeNameFilter_controller.value.text
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
        "emp_email_id": EmployeeNameForApi.isEmpty?"":EmployeeNameForApi,
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

        if (response.isNotEmpty && response[0].condition?.toLowerCase() == "true") {
          salesDashboardList.value = response;
          monthWiseTotalFunnelList.value = response[0].monthwisetotalfunnel ?? [];
          print('length.....${monthWiseTotalFunnelList.length}');

          monthWiseCommitmentList.value = response[0].monthwisecommitment ?? [];
          monthWiseCollectionCommitmentList.value = response[0].monthwisecollectioncommitmentvsactualcollectionachive ?? [];
          monthWiseAoVsBookingList.value = response[0].monthwiseaovsbookingachive ?? [];
          monthWiseFinalBookingList.value = response[0].monthwisefinalbookingcommitment ?? [];
          ClusterName_Controller.value.text = response[0].clusterhead??"";
          RegionName_Controller.value.text = response[0].regionhead??"";
          SalesPersonName_Controller.value.text = response[0].salepersonname??"";
          SalesPersonER_Code_Controller.value.text = response[0].salepersonempcode??"";
          PeriodFrom_Controller.value.text = response[0].periodfrom??"";
          PeriodTo_Controller.value.text = response[0].periodto??"";


        } else {
          Utils.showErrorToastification(
              "False Message !", response[0].message.toString());
          monthWiseTotalFunnelList.value = [];
          monthWiseCommitmentList.value = [];
          monthWiseFinalBookingList.value = [];
          monthWiseAoVsBookingList.value = [];
          monthWiseCollectionCommitmentList.value = [];
        }
      }

    } catch (e) {
      print("API error: $e");
    } finally {
      loading.value = false;

    }
  }
  Future<Iterable<EmployeeMemberModel>> EmployeeMasterGet(String query) async {
    if (query == '') {
      return const Iterable<EmployeeMemberModel>.empty();
    }
    Map data = {
      'filter_name': '',
      'filter_email': '',
      'filter_location_id': '',
      'email_id': email,
      'rowsPerPage': 50,
      'pageNumber': 0,
    };
    String employee_response =await _api.EmployeeMatserGetApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(employee_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<EmployeeMemberModel> response =
        jsonResponse.map((data) => EmployeeMemberModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          employee_Member_list.value = response;

        } else {
          // Utils.sanckBarException('False!', response[0].message!);
          employee_Member_list.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        employee_Member_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      employee_Member_list.value = [];
    }
    return employee_Member_list.value;
  }

  getEmployeeMemberApi() {
    Map data = {
      "email_id": email,
      "flag": "GeoLevelLower"
    };
    print(data);
    loading.value = true;
    try {
      _api.EmployeeMamberGetApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<EmployeeMemberModel> response =
            JsonResponse.map((e) => EmployeeMemberModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              employee_Member_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              employee_Member_list.value=[];
              //Utils.showErrorToastification("Error!", "No Date Found");
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          //service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      employee_Member_list.value = [];
      print(e);
    }
  }

  getEmployeeTeamMemberGetByClusterRegionApi() {
    Map data = {
      "cluster_name": "",
      "email_id": email,
      "region_name": "",
      "flag": "GeoLevelLowerWithClusterRegion"
    };
    print(data);
    loading.value = true;
    try {
      _api.EmployeeTeamMemberGetByClusterRegion(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<EmployeeMemberModel> response =
            JsonResponse.map((e) => EmployeeMemberModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              employee_Member_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              employee_Member_list.value=[];
              //Utils.showErrorToastification("Error!", "No Date Found");
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          //service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      employee_Member_list.value = [];
      print(e);
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
            if (clusterGetByEmailList.value.isNotEmpty && SelectedCluster_list.isEmpty) {
              SelectedCluster_list.assignAll(clusterGetByEmailList.value);
              clusterNameFilter_controller.value.text =
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
    character.value = 'Financial Year';
    ClusterNameForApi = '';
    RegionNameForApi = '';
    EmployeeNameForApi = '';
    clusterNameFilter_controller.value.clear();
    RegionNameFilter_controller.value.clear();
    filterCustomDateController.value.clear();
    EmployeeNameFilter_controller.value.clear();
    SelectedCluster_list.value = [];
    SelectedRegion_list.value = [];
    SelectedEmployee_Member_list.value = [];
    DateRange("financial");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';

  }



}