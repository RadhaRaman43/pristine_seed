import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/TaskMaster_model/Task_Master_model.dart';
import '../../CRM_Repository/Task_master_Repository/Task_master_repo.dart';

class TaskApprovalvm extends GetxController{

  final _api = TaskMasterRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String email="";
  String isAdminWritePermission = "";
  int is_Active = -1;
  RxString createdOnStartToEnd="".obs;


  var isInfraLeadFilterController=TextEditingController();
  var account_code_controller = TextEditingController();
  var account_Name_controller = TextEditingController();
  var filterTask_Id_controller = TextEditingController();
  var product_category_controller=TextEditingController().obs;
  var method_of_call_controller=TextEditingController().obs;
  var postalCodeController=TextEditingController().obs;
  var district_controller=TextEditingController().obs;
  var created_by_controller=TextEditingController().obs;
  var frontliner_controller=TextEditingController().obs;
  var cluster_head_value_controller=TextEditingController().obs;
  var zone_head_value_controller=TextEditingController().obs;
  var branch_head_value_controller=TextEditingController().obs;
  var EmailId_Controller=TextEditingController().obs;
  var lastActivityStatus_Controller=TextEditingController().obs;
  var PhoneNo_Controller=TextEditingController().obs;
  var account_owner_controller=TextEditingController().obs;
  var Type_of_call_controller = TextEditingController();
  var companyProfileTypeController=TextEditingController().obs;
  var Sale_cycle_Id_controller = TextEditingController();
  var filterTaskDuedateController=TextEditingController().obs;
  var filterTaskCreationOnController=TextEditingController().obs;
  var SaleCycleActive_Controller = TextEditingController();


  RxList<TaskMasterGetModel> Task_Master_list=<TaskMasterGetModel>[].obs;
  RxList<String> SaleCycleActiveTypeList = <String>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email=await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    SaleCycleActiveTypeList.value = ['All', 'Yes', 'No'];

    getTaskMaster(pageNumber, is_Active.toString(), '',);
  }

  Future<void>refreshList() async{
    getTaskMaster(pageNumber, is_Active.toString(), '',);


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
        "filter_task_id": taskId!.isNotEmpty?taskId:filterTask_Id_controller.text,
        "filter_account_code": account_code_controller.text.isEmpty?"":account_code_controller.text,
        "filter_account_name": account_Name_controller.text.isEmpty?"":account_Name_controller.text,
        "filter_task_status": 'PENDING FOR APPROVAL',
        "filter_product_category": product_category_controller.value.text.isEmpty?"":product_category_controller.value.text,
        "filter_type_of_call":  Type_of_call_controller.text.isEmpty?"":Type_of_call_controller.text,
        "filter_method_of_call": method_of_call_controller.value.text.isEmpty?"":method_of_call_controller.value.text,
        "filter_last_activity_status": "",
        "filter_company_profile_type": companyProfileTypeController.value.text.isEmpty?"":companyProfileTypeController.value.text,
        //"filter_is_infra_lead": infraLeadValue.value,
        "filter_is_infra_lead": 0,
        "filter_is_sales_cycle_active": is_Active.toString(),
        "filter_sales_cycle_id": Sale_cycle_Id_controller.value.text.isEmpty?"":Sale_cycle_Id_controller.value.text,
        "filter_created_by": isAdminWritePermission == "0"?email:"",
        "filter_approved_by": "",
        "filter_created_on": createdOnStartToEnd.value.isEmpty?"":createdOnStartToEnd.value,
        "filter_due_date": filterTaskDuedateController.value.text.isEmpty?"":filterTaskDuedateController.value.text,
        "filter_account_owner": account_owner_controller.value.text.isEmpty?"":account_owner_controller.value.text,
        "filter_is_closed_completed": 0,
        "filter_day_flag": 'All',
        "filter_postal_code": postalCodeController.value.text.isEmpty?"":postalCodeController.value.text,
        "filter_district": district_controller.value.text.isEmpty?"":district_controller.value.text,
        "filter_frontliner_value": "",
        "filter_branch_head_value": branch_head_value_controller.value.text.isEmpty?"":branch_head_value_controller.value.text,
        "filter_zone_head_value": "",
        "filter_clusture_head_value": cluster_head_value_controller.value.text.isEmpty?"":cluster_head_value_controller.value.text,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no.toString()
      };
      print("Data Json....${data}");
      loading.value=true;
      _api.TaskMasterGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(page_no==0){
              Task_Master_list.clear();
            }
            Task_Master_list.addAll(response);
            total_rows=int.parse(Task_Master_list[0].totalRows!);

          }else {
            loading.value = false;
            Task_Master_list.value=[];

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
    }catch(e){
      loading.value = false;
      print(e);
    }
    finally{
      loading.value = false;
    }
  }


  void resetAllFieldOfFilter() {
    account_code_controller.clear();
    account_Name_controller.clear();
    companyProfileTypeController.value.clear();
    postalCodeController.value.clear();
    district_controller.value.clear();
    created_by_controller.value.clear();
    frontliner_controller.value.clear();
    cluster_head_value_controller.value.clear();
    zone_head_value_controller.value.clear();
    branch_head_value_controller.value.clear();
    EmailId_Controller.value.clear();
    PhoneNo_Controller.value.clear();
    lastActivityStatus_Controller.value.clear();
    product_category_controller.value.clear();
    method_of_call_controller.value.clear();
    account_owner_controller.value.clear();
    Type_of_call_controller.clear();
    method_of_call_controller.value.clear();
    Sale_cycle_Id_controller.clear();
    filterTask_Id_controller.clear();
    isInfraLeadFilterController.text = "No";
    filterTaskDuedateController.value.clear();
    filterTaskCreationOnController.value.clear();
    createdOnStartToEnd.value = "";
    is_Active = -1;
  }

}