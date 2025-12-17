import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/dashboard_models/call_DashBoard_Model.dart';
import '../../CRM_Models/dashboard_models/call_dashboard_user_wise_Data_model.dart';
import '../../CRM_Repository/dashboard_repository/dashboard_repo.dart';

class PendingDsarDashboardVm extends GetxController{

  final _api = DashboardRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  RxBool isShimmerLoading = false.obs;
  String email = "";
  String userType = "";
  var selectedOption = 'Employee'.obs;
  RxString formattedStartDate = "".obs;
  RxString formattedEndDate = "".obs;
  RxString character = 'Month'.obs;
  RxString rodName = ''.obs;
  RxString geoValueName = ''.obs;

  int pageNumber = 0;
  int rowsPerPage = 10;
  RxInt total_rows = 0.obs;

  RxList<CallDashboardModel> pendingDSARDashboardList = <CallDashboardModel>[].obs;
  RxList<Records> pendingDSARDashboardRecordList = <Records>[].obs;
  RxList<CallDashboardUserWiseDataModel> pendingDSARDashboardUserWiseDataList = <CallDashboardUserWiseDataModel>[].obs;

  RxList<String> TaskStatusListTypeList = <String>[].obs;
  RxList<String> selectedTaskStatusList = <String>[].obs;
  RxList<CallStatusMasterModel> DSARStatus_Master_list = <CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> selectedDSARStatusList = <CallStatusMasterModel>[].obs;
  RxList<AccountMasterModel> Account_Master_list=<AccountMasterModel>[].obs;
  RxList<AccountMasterModel> SelectedAccount_Master_list=<AccountMasterModel>[].obs;
  RxList<CallStatusMasterModel> TypeCall_Master_list = <CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> selectedTypeCallList = <CallStatusMasterModel>[].obs;
  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> SelectedProductCategory_list = <ItemCategoryMstModel>[].obs;
  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  var filterCustomDateController=TextEditingController().obs;
  var task_Status_controller=TextEditingController().obs;
  var lastActivity_Status_controller=TextEditingController().obs;
  var AccountOwner_controller=TextEditingController().obs;
  var typeOfCall_controller=TextEditingController().obs;
  var ProductCategory_controller=TextEditingController().obs;
  var clusterName_controller=TextEditingController().obs;
  var RegionName_controller=TextEditingController().obs;
  var CustomerName_controller=TextEditingController().obs;


  var TypeOfCallForApi;
  var CustomerNameApi;
  var TaskStatusForApi;
  var lastActivityStatusForApi;
  var ProductCategoryForApi;
  var AccountOwnerForApi;
  var ClusterNameForApi;
  var RegionNameForApi;
  var EmployeeEmailIdForApi = '';

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    TaskStatusListTypeList.value = ['Pending','Pending For Approval', 'Approved', 'Rejected'];
    selectedTaskStatusList.value = ["Approved"];
    selectedTypeCallList.insert(0, CallStatusMasterModel(taskStatus: "All"));
    selectedDSARStatusList.insert(0, CallStatusMasterModel(taskStatus: 'All'));
    DateRange("month");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';
    //getDashboardUserWiseData(pageNumber);
    CallDSARsMasterApiHit();
    CallMasterApiHit();
    getEmployeeMemberApi();
    getItemCategoryMstWithoutTaskIdApi();
    getClustersGetByEmail();
    getAccountMaster(pageNumber);
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

  Future<void> callDashboardData() async {
    TypeOfCallForApi="";
    if(typeOfCall_controller.value.text.isNotEmpty){
      TypeOfCallForApi = typeOfCall_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    CustomerNameApi="";
    if(CustomerName_controller.value.text.isNotEmpty){
      CustomerNameApi = CustomerName_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    lastActivityStatusForApi = '';
    if(lastActivity_Status_controller.value.text.isNotEmpty){
      lastActivityStatusForApi = lastActivity_Status_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    AccountOwnerForApi = '';
    if(AccountOwner_controller.value.text.isNotEmpty){
      AccountOwnerForApi = AccountOwner_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    ClusterNameForApi = '';
    if(clusterName_controller.value.text.isNotEmpty){
      ClusterNameForApi = clusterName_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    RegionNameForApi = '';
    if(RegionName_controller.value.text.isNotEmpty){
      RegionNameForApi = RegionName_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    ProductCategoryForApi = '';
    if(ProductCategory_controller.value.text.isNotEmpty){
      ProductCategoryForApi = ProductCategory_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    TaskStatusForApi="";
    if(task_Status_controller.value.text.isNotEmpty){
      TaskStatusForApi = task_Status_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }

    try {
      Map<String, String> data = {
        "flag": selectedOption.value,
        "email_id": email,
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
        "filter_type_of_call": TypeOfCallForApi.isEmpty?"All":TypeOfCallForApi,
        "filter_owner_name": AccountOwnerForApi.isEmpty?"":AccountOwnerForApi,
        "filter_region_name": RegionNameForApi.isEmpty?"":RegionNameForApi,
        "filter_cluster_name": ClusterNameForApi.isEmpty?"":ClusterNameForApi,
        "filter_product_category": ProductCategoryForApi.isEmpty?"":ProductCategoryForApi,
        "filter_activity_status": lastActivityStatusForApi.isEmpty?"All":lastActivityStatusForApi,
        "filter_customer_name": CustomerNameApi.isEmpty?"":CustomerNameApi,
        "filter_task_approval_status": TaskStatusForApi.isEmpty?"Approved":TaskStatusForApi,
      };

      print(data);
      loading.value = true;
      isShimmerLoading.value = true;

      final onValue = await _api.PendingDSARDashboardApiHit(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if (jsonResponse is List) {
        List<CallDashboardModel> response = jsonResponse
            .map((e) => CallDashboardModel.fromJson(e))
            .toList();

        if (response.isNotEmpty &&
            response[0].condition?.toLowerCase() == "true") {
          pendingDSARDashboardList.value = response;
          pendingDSARDashboardRecordList.value = response[0].records ?? [];
          print('baisgdiuasgi du${response}');

        } else {
          Utils.showErrorToastification(
              "False Message !", response[0].message.toString());
          pendingDSARDashboardRecordList.value = [];
        }
      }

    } catch (e) {
      print("API error: $e");
    } finally {
      loading.value = false;
      isShimmerLoading.value = false;
      getDashboardUserWiseData(pageNumber);
    }
  }

  getDashboardUserWiseData(int pageNumber){
    try{
      loading.value=true;
      Map data={
        "flag": selectedOption.value,
        "email_id": email,
        "emp_email_id": EmployeeEmailIdForApi.isEmpty?"":EmployeeEmailIdForApi,
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
        "filter_type_of_call": TypeOfCallForApi.isEmpty?"All":TypeOfCallForApi,
        "filter_owner_name": AccountOwnerForApi.isEmpty?"":AccountOwnerForApi,
        "filter_region_name": RegionNameForApi.isEmpty?"":RegionNameForApi,
        "filter_cluster_name": ClusterNameForApi.isEmpty?"":ClusterNameForApi,
        "filter_product_category": ProductCategoryForApi.isEmpty?"":ProductCategoryForApi,
        "filter_activity_status": lastActivityStatusForApi.isEmpty?"All":lastActivityStatusForApi,
        "filter_customer_name": CustomerNameApi.isEmpty?"":CustomerNameApi,
        "filter_task_approval_status": TaskStatusForApi.isEmpty?"Approved":TaskStatusForApi,
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };


      _api.pendingDSARDashboardUserWiseDataApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<CallDashboardUserWiseDataModel> response = jsonResponse.map((e) => CallDashboardUserWiseDataModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumber==0){
              pendingDSARDashboardUserWiseDataList.clear();
            }
            pendingDSARDashboardUserWiseDataList.addAll(response);
            print("${pendingDSARDashboardUserWiseDataList.length}");
            total_rows.value=int.parse(pendingDSARDashboardUserWiseDataList[0].totalRows!);
          }else {
            pendingDSARDashboardUserWiseDataList.value=[];
            total_rows.value = 0;
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

  CallDSARsMasterApiHit(){
    try{
      Map<String, String> data={
        "filter_type_of_call": "dsar",
      };
      loading.value=true;
      _api.CallStatusMasterGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<CallStatusMasterModel> response = jsonResponse.map((e) => CallStatusMasterModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            DSARStatus_Master_list.addAll(response);
            DSARStatus_Master_list.insert(0, CallStatusMasterModel(taskStatus: 'All'));


          }else {
            loading.value = false;
            DSARStatus_Master_list.value=[];

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
  }

  CallMasterApiHit(){
    try{
      Map<String, String> data={
        "filter_type_of_call": "Call",
      };
      loading.value=true;
      _api.CallStatusMasterGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<CallStatusMasterModel> response = jsonResponse.map((e) => CallStatusMasterModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            TypeCall_Master_list.addAll(response);
            TypeCall_Master_list.insert(
              0,
              CallStatusMasterModel(taskStatus: "All"),
            );

          }else {
            loading.value = false;
            TypeCall_Master_list.value=[];

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
            callDashboardData();
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

  void getAccountMaster(int page_no){
    try{
      Map<String, String> data={
        "filter_account_code":'',
        "filter_account_name": '',
        "filter_account_type": '',
        "filter_email_id": '',
        "filter_phone_no":  '',
        "filter_company_profile_type": '',
        "filter_state_name": '',
        "filter_postal_code": '',
        "filter_district": '',
        "filter_created_by": '',
        "filter_account_owner": email,
        "filter_frontliner_value": "",
        "filter_branch_head_value": '',
        "filter_zone_head_value": "",
        "filter_clusture_head_value": '',
        "filter_is_active": '-1',
        "row_per_page": '50',
        "page_number": '0'
      };
      loading.value=true;
      _api.AccountMasterGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AccountMasterModel> response = jsonResponse.map((e) => AccountMasterModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(page_no==0){
              Account_Master_list.clear();
            }
            Account_Master_list.addAll(response);

          }else {
            loading.value = false;
            Account_Master_list.value=[];

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
  }


  clearAllFilterController(){
    character.value = 'Month';
    rodName.value = '';
    geoValueName.value = '';
    TypeOfCallForApi = '';
    TaskStatusForApi = '';
    lastActivityStatusForApi = '';
    ProductCategoryForApi = '';
    AccountOwnerForApi = '';
    ClusterNameForApi = '';
    RegionNameForApi = '';
    EmployeeEmailIdForApi = '';
    filterCustomDateController.value.clear();
    task_Status_controller.value.clear();
    lastActivity_Status_controller.value.clear();
    AccountOwner_controller.value.clear();
    typeOfCall_controller.value.clear();
    ProductCategory_controller.value.clear();
    //clusterName_controller.value.clear();
    CustomerName_controller.value.clear();
    //RegionName_controller.value.clear();
    selectedDSARStatusList.value = [];
    SelectedAccount_Master_list.value = [];
    selectedTypeCallList.value = [];
    SelectedEmployee_Member_list.value = [];
    SelectedProductCategory_list.value = [];
    SelectedCluster_list.value = [];
    SelectedRegion_list.value = [];
    selectedTaskStatusList.value = [];
    DateRange("month");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';

  }

}