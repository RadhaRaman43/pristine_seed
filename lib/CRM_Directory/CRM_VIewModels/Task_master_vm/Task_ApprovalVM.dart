import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/constants/app_font_size.dart';

import '../../../constants/app_colors.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_DSAR_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_Repository/Task_master_Repository/Task_master_repo.dart';

class TaskApprovalvm extends GetxController{

  static String _displayApproveRejectForOption(String option) => option;

  final _api = TaskMasterRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String email="";
  String isAdminWritePermission = "";
  RxString isHeadofficePermission = "".obs;
  int is_Active = -1;
  RxString createdOnStartToEnd="".obs;
  RxList<String> approveRejectList = <String>[].obs;

  var isInfraLeadFilterController=TextEditingController();
  var account_code_controller = TextEditingController().obs;
  var account_Name_controller = TextEditingController().obs;
  var filterTask_Id_controller = TextEditingController().obs;
  var product_category_controller=TextEditingController().obs;
  var product_category_type_Controller = TextEditingController().obs;
  var method_of_call_controller=TextEditingController().obs;
  var postalCodeController=TextEditingController().obs;
  var district_controller=TextEditingController().obs;
  var created_by_controller=TextEditingController().obs;
  var frontliner_controller=TextEditingController().obs;
  var zone_head_value_controller=TextEditingController().obs;
  var RegionName_controller=TextEditingController().obs;
  var clusterName_controller=TextEditingController().obs;
  
  var EmailId_Controller=TextEditingController().obs;
  var lastActivityStatus_Controller=TextEditingController().obs;
  var PhoneNo_Controller=TextEditingController().obs;
  var account_owner_controller=TextEditingController().obs;
  var Type_of_call_controller = TextEditingController().obs;
  var companyProfileTypeController=TextEditingController().obs;
  var Sale_cycle_Id_controller = TextEditingController();
  var filterTaskDuedateController=TextEditingController().obs;
  var filterTaskCreationOnController=TextEditingController().obs;
  var SaleCycleActive_Controller = TextEditingController();

  var ApproveReject_Controller = TextEditingController();
  var RejectReason_Controller = TextEditingController();
  var managerRemarksController=TextEditingController().obs;
  var AccountOwner_controller=TextEditingController().obs;

  RxBool RejectBool=false.obs;
  RxBool ApproveBool=false.obs;
  String ApproveReject = '';

  RxBool isExpandDetails = true.obs;
  RxBool isExpandCrtd = true.obs;
  RxBool isExpandGeoInfo = true.obs;
  RxBool isExpandDSAR = false.obs;
  RxBool isExpandInfraDeatils = true.obs;

  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;

  void toggle() {
    isExpandDetails.value = !isExpandDetails.value;
  }

  void toggleCrtd() {
    isExpandCrtd.value = !isExpandCrtd.value;
  }

  void toggleGeoInfoCrtd() {
    isExpandGeoInfo.value = !isExpandGeoInfo.value;
  }

  void toggleDsar() {
    isExpandDSAR.value = !isExpandDSAR.value;
  }

  void toggleInfraDetails() {
    isExpandInfraDeatils.value = !isExpandInfraDeatils.value;

  }

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  RxList<TaskMasterGetModel> Task_Master_list=<TaskMasterGetModel>[].obs;
  RxList<TaskMasterGetModel> Task_Master_list_line_Wise=<TaskMasterGetModel>[].obs;
  RxList<String> SaleCycleActiveTypeList = <String>[].obs;
  RxList<TaskDSARModel> TaskDSAR_Master_list = <TaskDSARModel>[].obs;
  var AccountOwnerForApi;

  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;
  RxList<CompanyTypeModal> company_profile_type_list = <CompanyTypeModal>[].obs;
  RxList<CompanyTypeModal> selected_company_type_list = <CompanyTypeModal>[].obs;
  RxList<CallStatusMasterModel> CallStatus_Master_list=<CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> Selection_CallStatus_Master_list=<CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> MethodOfCall_Master_list=<CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> Selection_MethodOfCall_Master_list=<CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> DSARStatus_Master_list = <CallStatusMasterModel>[].obs;
  RxList<CallStatusMasterModel> selectedDSARStatusList = <CallStatusMasterModel>[].obs;


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email=await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    SaleCycleActiveTypeList.value = ['All', 'Yes', 'No'];
    approveRejectList.value = ['Approve', 'Reject'];
    product_category_type_Controller.value.text="Contains";
    //getFilterData();
      getCompanyTypeMasterGet();
      getItemCategoryMstWithoutTaskIdApi();
      CallStatusMasterApiHit('Call');
      MethodOfCallMasterApiHit();
      CallDSARsMasterApiHit();
      if(isAdminWritePermission==1){
        EmployeeMasterGet('');
      }
      else{
        getEmployeeMemberApi();
      }
      getClustersGetByEmail();
    //getTaskMasterApprovalList(pageNumber, is_Active.toString(),);

  }

  getCompanyTypeMasterGet() async {
    loading.value = true;
    Map<String, dynamic> data = {
      "filter_description": "",
      "row_per_page": 999,
      "page_number": 0
    };
     await Future.delayed(const Duration(seconds: 5));
    _api.getCompanyTypeMasterGet(data, sessionManagement).then((value) {
      print("company profile...${value}");
      try {
        List<CompanyTypeModal> Response =
        (json.decode(value) as List<dynamic>).map((i) => CompanyTypeModal.fromJson(i as Map<String, dynamic>)).toList();
        if (Response.isNotEmpty && Response[0].condition?.toLowerCase() == "true") {
          company_profile_type_list.value=Response;
        } else {
          company_profile_type_list.value=[];
        }
      } catch (e) {
        print('catch....${e.toString()}');
      }
      finally{
       loading.value = false;
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      loading.value = false;
    });
  }

  getItemCategoryMstWithoutTaskIdApi() {
    loading.value = true;
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

        } else {
          Item_Category_master_list_without_task.value = [];
        }
      } catch (e) {
        Item_Category_master_list_without_task.value = [];
        print('catch....${e.toString()}');
      }
      finally{
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      Item_Category_master_list_without_task.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      loading.value = false;
    });
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
            DSARStatus_Master_list.add(
              CallStatusMasterModel(
                taskStatus: "All",
              ),
            );
            DSARStatus_Master_list.addAll(response);

          }else {
            DSARStatus_Master_list.value=[];

          }
        }
      },
      ).onError((error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  Future<Iterable<EmployeeMemberModel>> EmployeeMasterGet(String query) async {
    if (query == '') {
      return const Iterable<EmployeeMemberModel>.empty();
    }
    Map data = {
      'filter_name': '',
      'filter_email': query,
      'filter_location_id': '',
      'email_id': email,
      'rowsPerPage': 50,
      'pageNumber': 0,
    };
    loading.value = true;
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
    finally{
      loading.value = false;
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

              employee_Member_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {

              employee_Member_list.value=[];
              //Utils.sanckBarError("Error!", "No Date Found");
              //service_installation_details_list.value=[];
            }
          } else {

            // service_indent_header_list.value = [];
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          //service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      employee_Member_list.value = [];
      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  Future<void>refreshList() async{
    getTaskMasterApprovalList(pageNumber, is_Active.toString(),);
  }

  RxInt infraLeadValue=0.obs;
  
  getTaskMaster(int page_no, String IsActive, String? taskId){
    if(isInfraLeadFilterController.text=="All"){
      infraLeadValue.value=-1;
    }
    else if( isInfraLeadFilterController.text=="Yes"){
      infraLeadValue.value=1;
    }
    else if( isInfraLeadFilterController.text=="No"){
      infraLeadValue.value=0;
    }
    else{
      infraLeadValue.value=-1;
    }
    if(IsActive == 'All'){
      is_Active = -1;
    }else if( IsActive == 'Yes'){
      is_Active = 1;
    }else if(IsActive == 'No'){
      is_Active = 0;
    }
    try{
      Map data={
        "filter_account_code": account_code_controller.value.text.isEmpty?"":account_code_controller.value.text,
        "filter_account_name": account_Name_controller.value.text.isEmpty?"":account_Name_controller.value.text,
        "filter_approved_by": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "filter_company_profile_type": companyProfileTypeController.value.text.isEmpty?"":companyProfileTypeController.value.text,
        "filter_contact_name": "",
        "filter_created_by": isAdminWritePermission == "0"?email:"",
        "filter_created_on": createdOnStartToEnd.value.isEmpty?"":createdOnStartToEnd.value,
        "filter_day_flag":"",
        "filter_due_date": filterTaskDuedateController.value.text.isEmpty?"":filterTaskDuedateController.value.text,
        "filter_frontliner_value": "",
        "filter_is_closed_completed": 0,
        "filter_is_infra_lead": -1,
        "filter_is_sales_cycle_active": is_Active.toString(),
        "filter_last_activity_status": "",
        "filter_method_of_call": method_of_call_controller.value.text.isEmpty?"":method_of_call_controller.value.text,
        "filter_postal_code": postalCodeController.value.text.isEmpty?"":postalCodeController.value.text,
        "filter_product_category": product_category_controller.value.text.isEmpty?"":product_category_controller.value.text,
        "filter_sales_cycle_id": Sale_cycle_Id_controller.value.text.isEmpty?"":Sale_cycle_Id_controller.value.text,
        "filter_task_id": taskId!.isNotEmpty?taskId:filterTask_Id_controller.value.text,
        "filter_task_owner": account_owner_controller.value.text.isEmpty?"":account_owner_controller.value.text,
        "filter_task_status": 'GET FROM TASK ID',
        "filter_type_of_call":  Type_of_call_controller.value.text.isEmpty?"":Type_of_call_controller.value.text,
        "filter_zone_head_value": "",
        "filter_district": district_controller.value.text.isEmpty?"":district_controller.value.text,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no.toString()
      };
      print("Data Json....${data}");
      loading.value=true;
      _api.TaskMasterGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print("onValue${onValue}");
        if(jsonResponse is List){
          List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
            Task_Master_list_line_Wise.value=response;
              getTaskMstDSARList(taskId);
              Get.toNamed(RoutesName.taslMasterApprovalDetailsScreen);
          }else {

            Task_Master_list_line_Wise.value=[];

          }
        } else {

        }
      },
      ).onError((error, stackTrace) {
          print(error);

        },
      );
    }catch(e){

      print("task approver list ${e.toString()}");
    }
    finally{
      loading.value = false;
    }
  }

  CallStatusMasterApiHit(String flag){
    try{
      Map<String, String> data={
        "filter_type_of_call": flag,
      };
      loading.value=true;
      _api.CallStatusMasterGetApiHit(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<CallStatusMasterModel> response = jsonResponse.map((e) => CallStatusMasterModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            CallStatus_Master_list.value=[];
            Selection_CallStatus_Master_list.value =[];
            CallStatus_Master_list.add(CallStatusMasterModel(taskStatus: "All",),);
            Selection_CallStatus_Master_list.add(CallStatusMasterModel(taskStatus: "All"));

            CallStatus_Master_list.addAll(response);

          }else {
            CallStatus_Master_list.value=[];
            Selection_CallStatus_Master_list.value=[];
          }
        }
      },).onError((error, stackTrace) {
        print('call list...${error}');
      },
      );
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
    }
  }
  MethodOfCallMasterApiHit(){
    try{
      Map<String, String> data={
        "filter_type_of_call": "method",
      };
      loading.value=true;
      _api.CallStatusMasterGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<CallStatusMasterModel> response = jsonResponse.map((e) => CallStatusMasterModel.fromJson(e)).toList();
          if(response != null && response.length>0 && response[0].condition=="True"){
            MethodOfCall_Master_list.value=[];
            Selection_MethodOfCall_Master_list.value=[];
              MethodOfCall_Master_list.add(CallStatusMasterModel(taskStatus: "All"));
              Selection_MethodOfCall_Master_list.add(CallStatusMasterModel(taskStatus: "All"));

            MethodOfCall_Master_list.addAll(response);


          }else {
            MethodOfCall_Master_list.value=[];
            Selection_MethodOfCall_Master_list.value=[];

          }
        }
      },
      ).onError((error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
    }
  }
  void resetAllFieldOfFilter() {
    Selection_CallStatus_Master_list.value=[];
    Selection_MethodOfCall_Master_list.value=[];
    selected_company_type_list.value=[];
    Selected_Item_Category_master_list_without_task.value=[];
    product_category_type_Controller.value.text="Contains";
    account_code_controller.value.clear();
    account_Name_controller.value.clear();
    companyProfileTypeController.value.clear();
    postalCodeController.value.clear();
    district_controller.value.clear();
    created_by_controller.value.clear();
    frontliner_controller.value.clear();
    //clusterName_controller.value.clear();
    zone_head_value_controller.value.clear();
    //RegionName_controller.value.clear();
    EmailId_Controller.value.clear();
    PhoneNo_Controller.value.clear();
    lastActivityStatus_Controller.value.clear();
    product_category_controller.value.clear();
    method_of_call_controller.value.clear();
    account_owner_controller.value.clear();
    Type_of_call_controller.value.clear();
    method_of_call_controller.value.clear();
    Sale_cycle_Id_controller.clear();
    filterTask_Id_controller.value.clear();
    isInfraLeadFilterController.text = "No";
    filterTaskDuedateController.value.clear();
    filterTaskCreationOnController.value.clear();
    createdOnStartToEnd.value = "";
    is_Active = -1;

    AccountOwnerForApi = '';
    AccountOwner_controller.value.clear();
    SelectedEmployee_Member_list.value = [];
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
      },
      ).onError((error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      print(e);
    }finally{
      loading.value = false;
    }
  }
  void getRegionsWithClusterFilterGetByEmail() {
    var selectedCluster="";
    if(clusterName_controller.value.text.isNotEmpty){
      selectedCluster = clusterName_controller.value.text.split(',').map((e) => e.trim()).join('|');
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
            regionwithclusterGetByEmailList.value=response;
            RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
            print('region....${RegionName_controller.value.text}');
            //getTaskMasterApprovalList(pageNumber, is_Active.toString(),);
            getFilterData();
          }else {
            regionwithclusterGetByEmailList.value=[];
          }
        }
      },
      ).onError((error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      print(e);
    }finally{
      loading.value = false;
    }
  }

  getTaskMasterApprovalList(int page_no, String IsActive){
    if(isInfraLeadFilterController.text=="All"){
      infraLeadValue.value=-1;
    }
    else if( isInfraLeadFilterController.text=="Yes"){
      infraLeadValue.value=1;
    }
    else if( isInfraLeadFilterController.text=="No"){
      infraLeadValue.value=0;
    }
    else{
      infraLeadValue.value=-1;
    }
    if(IsActive == 'All'){
      is_Active = -1;
    }else if( IsActive == 'Yes'){
      is_Active = 1;
    }else if(IsActive == 'No'){
      is_Active = 0;
    }
    AccountOwnerForApi = '';
    if(AccountOwner_controller.value.text.isNotEmpty){
      AccountOwnerForApi = AccountOwner_controller.value.text.split(',').map((e) => e.trim()).join('|');
    }
    try{
      Map data={
        "filter_task_id":filterTask_Id_controller.value.text.isEmpty?"":filterTask_Id_controller.value.text,
        "filter_account_code": account_code_controller.value.text.isEmpty?"":account_code_controller.value.text,
        "filter_account_name": account_Name_controller.value.text.isEmpty?"":account_Name_controller.value.text,
        "filter_task_status": 'PENDING FOR APPROVAL',
        "filter_product_category": product_category_controller.value.text.isEmpty?"":product_category_controller.value.text,
        "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
        "filter_type_of_call":  Type_of_call_controller.value.text.isEmpty?"":Type_of_call_controller.value.text,
        "filter_method_of_call": method_of_call_controller.value.text.isEmpty?"":method_of_call_controller.value.text,
        "filter_last_activity_status": lastActivityStatus_Controller.value.text.isEmpty?"":lastActivityStatus_Controller.value.text,
        "filter_company_profile_type": companyProfileTypeController.value.text.isEmpty?"":companyProfileTypeController.value.text,
        "filter_is_infra_lead": 0,
        "filter_is_sales_cycle_active": is_Active.toString(),
        "filter_sales_cycle_id": Sale_cycle_Id_controller.value.text.isEmpty?"":Sale_cycle_Id_controller.value.text,
        "filter_created_by": "",
        "filter_approved_by": "",
        "filter_created_on": filterTaskCreationOnController.value.text.isEmpty?"":filterTaskCreationOnController.value.text,
        "filter_due_date": filterTaskDuedateController.value.text.isEmpty?"":filterTaskDuedateController.value.text,
        "filter_task_owner":isAdminWritePermission=='1' || isHeadofficePermission.value=="1"?"":email,
        "filter_is_closed_completed": 0,
        "filter_day_flag":'All',
        "filter_postal_code": postalCodeController.value.text.isEmpty?"":postalCodeController.value.text,
        "filter_district": district_controller.value.text.isEmpty?"":district_controller.value.text,
        "filter_frontliner_value": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value": "",
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "filter_task_owner_new":  AccountOwnerForApi.isEmpty?"":AccountOwnerForApi,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no.toString()
      };
      print("Data Json....${data}");
      loading.value=true;
      _api.TaskMstGetApprovalListApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            if(page_no==0){
              Task_Master_list.clear();
            }
            Task_Master_list.addAll(response);
            total_rows=int.parse(Task_Master_list[0].totalRows!);
          }else {
            Task_Master_list.value=[];

          }
        }
      },
      ).onError((error, stackTrace) {
          print(error);

        },
      );
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
    }
  }


  getTaskMstDSARList(String taskId) {
    try{
      Map<String, String> data={
        "filter_dsar_status": '',
        "filter_task_id": taskId,
        "row_per_page": rowsPerPage.toString(),
        "page_number": '0'
      };
      loading.value=true;
      print("data is ${data}");
      _api.TaskDSARMstGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<TaskDSARModel> response = jsonResponse.map((e) => TaskDSARModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            TaskDSAR_Master_list.value=response;
            print("Success...1 ${response.toString()}");
          }else {
            TaskDSAR_Master_list.value=[];
            print("UnSuccess... ${response.toString()}");

          }
        } else {
          print("UnSuccessfull... ");

        }
      },
      ).onError((error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      print("jdsdhud...${e}");
    }
    finally{
      loading.value = false;
    }
  }

  ApproveRejectApiHit(String? taskId){
    try{
      Map<String, String> data={
        "task_id": taskId!,
        "task_status": ApproveReject,
        "reject_reason": RejectReason_Controller.text.isEmpty?'':RejectReason_Controller.text,
        "manager_remarks": managerRemarksController.value.text.isEmpty?'':managerRemarksController.value.text,
        "created_by": email,

      };
      loading.value=true;
      _api.TaskMstApproveRejectApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
            Utils.sanckBarSuccess('Success!', response[0].message.toString());
            pageNumber=0;
            getTaskMasterApprovalList(pageNumber, is_Active.toString(),);
            Get.toNamed(RoutesName.taskApproval_List);
          }else {
            Utils.sanckBarError('Error!', response[0].message.toString());
            print(response[0].message.toString());
            //Task_Master_list.value=[];

          }
        } else {
          print('APi Not hit');

        }
      },
      ).onError((error, stackTrace) {
          print(error);
        },
      );
    }catch(e){
      print(e);
    }
    finally{
      loading.value = false;
    }
  }


  showApprovRejectDialog(context, String TaskId){
    ApproveReject_Controller.clear();
    RejectReason_Controller.clear();
    managerRemarksController.value.clear();
    ApproveBool.value = false;
    RejectBool.value = false;
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
              title:  Text(
                'Update Task',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              content: Wrap(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  bindApprovRejectDropDown(context),
                  SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible: ApproveBool
                          .value,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          controller:
                              managerRemarksController.value,
                          decoration: InputDecoration(
                              hintText: "Manager Remarks",
                              labelText: "Manager Remarks",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten,
                                  horizontal: AllFontSize.ten),

                              /*focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),*/
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible: RejectBool
                          .value,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          controller:
                              RejectReason_Controller,
                          decoration: InputDecoration(
                              hintText: "Reject Reason",
                              labelText: "Reject Reason",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten,
                                  horizontal: AllFontSize.ten),

                              /*focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),*/
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),
                      ),
                    );

                  }),
                  SizedBox(height: 55,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [
                      Obx((){
                        return Visibility(
                          visible: ApproveBool.value,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              if(ApproveReject_Controller.text.isEmpty || ApproveReject_Controller == null) {
                                Utils.sanckBarError(
                                    'Error : ', 'Please select Type.');
                                return;
                              }
                              Navigator.pop(context);
                              ConfirmationDialog(context, TaskId);


                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Approve',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      ),
                      Obx((){
                        return Visibility(
                            visible: RejectBool.value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.lightredColor,
                                ),
                              ),
                              onPressed: ()  {
                                if(ApproveReject_Controller.text== "Reject"){
                                  if(RejectReason_Controller.text.isEmpty || RejectReason_Controller == null){
                                    Utils.sanckBarError('Error : ', 'Please Enter Reject Reason.');
                                  }else{
                                    Navigator.pop(context);
                                    ConfirmationDialog(context, TaskId);
                                    //TaskMaster_page_controller.UpdateTaskStatus(context);
                                  }
                                }


                              },
                              child: Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: Text('Reject',
                                  /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ));
                      })
                      ,
                    ],)
                ],
              )
          );
        });
  }


  ConfirmationDialog(context, String taskId){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to Update this Task?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();
                              RejectReason_Controller.clear();
                              //TaskMaster_page_controller.ApproveReject_Controller.clear();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              ApproveRejectApiHit(taskId);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          );

        });
  }

  Widget bindApprovRejectDropDown(context) {
    Size size=Get.size;
    return Autocomplete<String>(
      displayStringForOption: _displayApproveRejectForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return approveRejectList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return approveRejectList
            .where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        // Update the TextField with the selected
        ApproveReject_Controller.text =
            _displayApproveRejectForOption(selection).toString();
        if(ApproveReject_Controller.text == 'Approve'){
          ApproveReject = "Approved";
          RejectBool.value = false;
          ApproveBool.value = true;
        }else{
          ApproveReject = "Rejected";
          RejectBool.value = true;
          ApproveBool.value = false;
        }
        //print('IsActive.....${accountMaster_page_controller.IsActive_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            onTap: (){
              focusNode.requestFocus();
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = ApproveReject_Controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: (){
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Task Status',
              labelText: 'Task Status',

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width*.5,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }


  RxString filterDataChecker = ''.obs;

  void SaveFilterData() async{
    await sessionManagement.saveTaskApproverData({
      'task_id': filterTask_Id_controller.value.text,
      'customer_name': account_Name_controller.value.text,
      'customer_code': account_code_controller.value.text,
      'Type_of_call_controller': Type_of_call_controller.value.text,
      'method_of_call_controller': method_of_call_controller.value.text,
      'company_Profile_Type_Controller': companyProfileTypeController.value.text,
      'lastActivityStatus_Controller': lastActivityStatus_Controller.value.text,
      'SaleCycleActive_Controller': SaleCycleActive_Controller.value.text,
      'createdOnStartToEnd': createdOnStartToEnd.value,
      'filterTaskDuedateController': filterTaskDuedateController.value.text,
      'pin_code': postalCodeController.value.text,
      'district': district_controller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'account_owner': AccountOwner_controller.value.text,
      'filterTaskCreationOnController': filterTaskCreationOnController.value.text,
      'product_category': product_category_controller.value.text,
      'product_category_type': product_category_type_Controller.value.text,
    });
    filterDataChecker.value='';
    getTaskMasterApprovalList(pageNumber, SaleCycleActive_Controller.text,);
  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getTaskApproverData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      filterTask_Id_controller.value.text=getFilterData["task_id"];
      account_Name_controller.value.text=getFilterData["customer_name"];
      account_code_controller.value.text=getFilterData["customer_code"];
      Type_of_call_controller.value.text=getFilterData["Type_of_call_controller"];
      method_of_call_controller.value.text=getFilterData["method_of_call_controller"];
      companyProfileTypeController.value.text=getFilterData["company_Profile_Type_Controller"];
      lastActivityStatus_Controller.value.text=getFilterData["lastActivityStatus_Controller"];
      SaleCycleActive_Controller.text=getFilterData["SaleCycleActive_Controller"];
      createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"];
      filterTaskDuedateController.value.text=getFilterData["filterTaskDuedateController"];
      postalCodeController.value.text=getFilterData["pin_code"];
      district_controller.value.text=getFilterData["district"];
      AccountOwner_controller.value.text=getFilterData["account_owner"];
      filterTaskCreationOnController.value.text=getFilterData["filterTaskCreationOnController"];
      product_category_controller.value.text=getFilterData["product_category"];
      product_category_type_Controller.value.text=getFilterData["product_category_type"];

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
    getTaskMasterApprovalList(pageNumber, SaleCycleActive_Controller.text,);

  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearTaskApproverData();
  }
}