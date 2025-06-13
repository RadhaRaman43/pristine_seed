import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import '../../../constants/static_methods.dart';
import '../../../models/employeeDetail/employee_details_model.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_DSAR_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/task_category_model.dart';
import '../../CRM_Models/TaskMaster_model/task_update_infra_modal.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_Models/sale_cycle_modal/selectedAlongWithPersonNameModel.dart';
import '../../CRM_Repository/Task_master_Repository/Task_master_repo.dart';

class Taskmastervm extends GetxController{
    final _api = TaskMasterRepo();
    SessionManagement sessionManagement = SessionManagement();
    RxString account_code="".obs;
    RxString account_name="".obs;
    RxString contact_code="".obs;
    RxBool loading=false.obs;
    RxBool RejectBool=false.obs;
    RxBool ApproveBool=false.obs;
    RxBool DSARStatus=false.obs;
    RxBool typeOfCall=false.obs;
    RxBool ItemCateDropDown=false.obs;
    RxBool PurposeOfVisit=false.obs;
    RxBool PaymentCall=false.obs;
    RxBool IsSalesId=false.obs;
    RxBool IsCatergorySelected=false.obs;
    int pageNumber = 0;
    int rowsPerPage = 10;
    int total_rows = 0;
    String email="";
    int is_Active = -1;
    String ApproveReject = '';
    String TaskID = '', infraFlag='';
    RxBool isExpandDetails = true.obs;
    RxBool isExpandCrtd = true.obs;
    RxBool isExpandGeoInfo = true.obs;
    RxBool isExpandDSAR = false.obs;
    RxBool isExpandInfraDeatils = true.obs;
    RxBool isInfraLeadValue=false.obs;
    RxBool isInfraYes=false.obs;
    RxBool isInfraLeadValueSubmit=false.obs;
    RxString date_filter="Today".obs;
    RxString filter="Running".obs;
    RxString createdOnStartToEnd="".obs;
    RxInt is_done = 0.obs;

    int Active = 0;
    String IsSaleCycleActive= '';

    var Task_status_controller = TextEditingController();
    var account_code_controller = TextEditingController();
    var account_Name_controller = TextEditingController();
    var filterTask_Id_controller = TextEditingController();
    var Contact_Name_controller = TextEditingController();
    var Type_of_call_controller = TextEditingController();
    var Method_of_call_controller = TextEditingController();
    var Task_Remarks_controller = TextEditingController();
    var PusposeOfVisit_controller = TextEditingController();
    var DSAR_Remarks_controller = TextEditingController();
    var SaleCycleActive_Controller = TextEditingController();
    var ApproveReject_Controller = TextEditingController();
    var RejectReason_Controller = TextEditingController();
    var managerRemarksController=TextEditingController().obs;
    var taskReopenRemarksController=TextEditingController().obs;
    var Sale_cycle_Id_controller = TextEditingController();
    var DSAR_Status_type_controller = TextEditingController().obs;
    var ItemCat_type_controller = TextEditingController();
    var AlongPersonWith_controller = TextEditingController();
    var NextInterdate_controller = TextEditingController();
    var EstClosuredate_controller = TextEditingController();
    var NextInterTime_controller = TextEditingController();
    var BudgetAmt_controller = TextEditingController();
    var ExpectedAmt_controller = TextEditingController();
    var isInfraLead = TextEditingController().obs;
    var isInfraLeadFilterController=TextEditingController();
    var isSalesNecessaryController=TextEditingController().obs;
    var filterTaskDuedateController=TextEditingController().obs;
    var filterTaskCreationOnController=TextEditingController().obs;
    var DataOFVisitController=TextEditingController().obs;
    var VisitTime_controller=TextEditingController().obs;

    //todo new controller added by nirupma for filter
    var companyProfileTypeController=TextEditingController().obs;
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
    var product_category_controller=TextEditingController().obs;
    var method_of_call_controller=TextEditingController().obs;
    var account_owner_controller=TextEditingController().obs;

    //todo update task controllers
    var userRegionUpdateController = TextEditingController();
    var userClusterUpdateController = TextEditingController();
    var projectValueUpdateController = TextEditingController();
    var nameOfProjectController = TextEditingController();
    var customerNameController = TextEditingController();
    var locationController = TextEditingController();
    var timePeriodToCompleteWorkController = TextEditingController();
    var isInfraLeadUpdateController = TextEditingController().obs;
    var expectedDateOfOrderUpdateController = TextEditingController();
    var drawingcollectedUpdateController = TextEditingController();
    var proposalSubmittedUpdateController = TextEditingController();
    var inaugrationDateUpdateController = TextEditingController();
    var architectUpdateController = TextEditingController();
    var assistantEngineerController = TextEditingController();
    var executiveEngineerUpdateController = TextEditingController();
    var contactPersonHODController = TextEditingController();
    var nameOfArchitecfirmUpdateController = TextEditingController();
    var nameofInfradepUpdateController = TextEditingController();
    var agencyContractorUpdateController = TextEditingController();
    var ownerOfContractorController = TextEditingController();
    var siteManagerController = TextEditingController();
    var expectedRevenueUpdateController = TextEditingController();
    var furnitureIncludedInCivilController = TextEditingController();
    var valueOfQuoteUpdateController = TextEditingController();
    var dateofcompletioneUpdateController = TextEditingController();
    var dateOfProposalSubmissionController = TextEditingController();
    var dateOfDrawingReceivedController = TextEditingController();
    //var Sale_cycle_Id_controller = TextEditingController();

    RxList<TaskMasterGetModel> Task_Master_list=<TaskMasterGetModel>[].obs;
    RxList<String> TaskStatusListTypeList = <String>[].obs;
    RxList<String> SaleCycleActiveTypeList = <String>[].obs;
    RxList<String> approveRejectList = <String>[].obs;
    RxList<AccountMasterModel> Account_Master_list=<AccountMasterModel>[].obs;
    RxList<SalesCycleModal> Sales_Id_list=<SalesCycleModal>[].obs;
    RxList<CallStatusMasterModel> CallStatus_Master_list=<CallStatusMasterModel>[].obs;
    RxList<CallStatusMasterModel> MethodOfCall_Master_list=<CallStatusMasterModel>[].obs;
    RxList<CallStatusMasterModel> DSARStatus_Master_list=<CallStatusMasterModel>[].obs;
    RxList<ContactMstGetListModal> contact_master_list = <ContactMstGetListModal>[].obs;
    RxList<TaskDSARModel> TaskDSAR_Master_list = <TaskDSARModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_master_list = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_Selected_list = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_Selected_Infra_list = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_Infra_list = <ItemCategoryMstModel>[].obs;
    RxList<AlongWithPersonModel> AlongPersonWith_list = <AlongWithPersonModel>[].obs;
    RxList<AlongWithPersonModel> SelectedAlongPersonWith_list = <AlongWithPersonModel>[].obs;
    RxList<UserGeoHierarchy> userGeoHierarchyy = <UserGeoHierarchy>[].obs;
    RxList<String> Item_Category_code_list = <String>[].obs;
    RxList<String> isInfraLeadList =["Yes", "No"].obs;

    @override
    void onInit() async {
      super.onInit();

        email=await sessionManagement.getEmail() ?? '';
        getMenuList();
        print("List${userGeoHierarchyy.length}");
        //userGeoHierarchy=await sessionManagement.getUserGeoHierarchy() ?? [];
        getTaskMaster(pageNumber, is_Active.toString(), '', '', '', date_filter,is_done.value);
        getAccountMaster(pageNumber);
        CallStatusMasterApiHit('Call');
        MethodOfCallMasterApiHit();
        CallDSARsMasterApiHit();
        TaskStatusListTypeList.value = ['All','Pending For Approval', 'Approved', 'Rejected'];
        SaleCycleActiveTypeList.value = ['All', 'Yes', 'No'];
        approveRejectList.value = ['Approve', 'Reject'];
        Item_Category_Selected_list.value = [];

    }

    Future<void>refreshList() async{
        //getTaskMaster(pageNumber, is_Active.toString(), '', '','',date_filter, is_done.value);


    }

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

    RxInt infraLeadValue=0.obs;
    getTaskMaster(int page_no, String IsActive, String? taskId,
        String flag, String status, RxString date_filter, int is_done, ){
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
                "filter_task_status": status == 'All'?"":status,
                "filter_product_category": product_category_controller.value.text.isEmpty?"":product_category_controller.value.text,
                "filter_type_of_call":  Type_of_call_controller.text.isEmpty?"":Type_of_call_controller.text,
                "filter_method_of_call": method_of_call_controller.value.text.isEmpty?"":method_of_call_controller.value.text,
                "filter_last_activity_status": "",
                "filter_company_profile_type": companyProfileTypeController.value.text.isEmpty?"":companyProfileTypeController.value.text,
                //"filter_is_infra_lead": infraLeadValue.value,
                "filter_is_infra_lead": 0,
                "filter_is_sales_cycle_active": is_Active.toString(),
                "filter_sales_cycle_id": Sale_cycle_Id_controller.value.text.isEmpty?"":Sale_cycle_Id_controller.value.text,
                "filter_created_by": email,
                "filter_approved_by": "",
                "filter_created_on": createdOnStartToEnd.value.isEmpty?"":createdOnStartToEnd.value,
                "filter_due_date": filterTaskDuedateController.value.text.isEmpty?"":filterTaskDuedateController.value.text,
                "filter_account_owner": account_owner_controller.value.text.isEmpty?"":account_owner_controller.value.text,
                "filter_is_closed_completed": is_done,
                "filter_day_flag": date_filter.toString(),
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

                        print('flag data...$flag');
                        if(flag == 'View'){
                            Active = Task_Master_list[0].isSalesCycleActive!;
                            if(Active == 1){
                                IsSaleCycleActive = 'Yes';
                            }else if(Active == 0){
                                IsSaleCycleActive = 'No';
                            }

                            getTaskMstDSARList(taskId);
                            getItemCategoryMstApi(taskId);
                            getTaskPersonMstByTaskIdApi(taskId!);
                            Get.toNamed(RoutesName.taskMasterDetails_screen);

                        }
                        getTaskMstDSARList(taskId);


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

    TaskMasterCreate(){
        DateTime selectDate = DateFormat('dd-MM-yyyy').parseStrict(DataOFVisitController.value.text);
        String todayDate = DateFormat('yyyy-MM-dd').format(selectDate);
        List<TaskSalesProductCategoryLinesModel> lines = Item_Category_Selected_list.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();
        List<Selectedalongwithpersonnamemodel> personName = SelectedAlongPersonWith_list.map((item) => Selectedalongwithpersonnamemodel(empId: item.empId!)).toList();

        try{
            Map<String, dynamic> data={
                "account_name": account_name.value.isNotEmpty?account_name.value:"",
                "account_code": account_code.value.isNotEmpty?account_code.value:"",
                "contact_name": Contact_Name_controller.text.isEmpty?'':Contact_Name_controller.text,
                "contact_code": contact_code.value.isNotEmpty?contact_code.value:"",
                "created_by": email,
                "method_of_call": Method_of_call_controller.text.isEmpty?'':Method_of_call_controller.text,
                "task_remarks": Task_Remarks_controller.text.isEmpty?'':Task_Remarks_controller.text,
                "purpose_of_visit": PusposeOfVisit_controller.text.isEmpty?'':PusposeOfVisit_controller.text,
                "type_of_call": Type_of_call_controller.text.isEmpty?'':Type_of_call_controller.text,
                "payment_sale_cycle_id": Sale_cycle_Id_controller.text.isEmpty?'':Sale_cycle_Id_controller.text,
                "date_of_visit": todayDate.isEmpty?"":todayDate,
                "time_of_visit": VisitTime_controller.value.text.isEmpty?"":VisitTime_controller.value.text,
                //"is_infra_lead": isInfraLeadFilterController.text =='Yes'?1:0,
                "is_infra_lead": 0,
                "lines": lines.map((line) => line.toJson()).toList(),
                "person_name": personName.map((line) => line.toJson()).toList(),
            };
            print('Jason Date....${data}');
            loading.value=true;
            _api.TaskMasterCreateApiHit(data, sessionManagement).then((onValue){
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        //Task_Master_list.addAll(response);
                        Utils.showToastification('Success!', response[0].message.toString());
                       // Get.offAllNamed(RoutesName.taskMaster_screen);
                        pageNumber=0;
                        clearCreateTaskController();
                        date_filter.value = "Today";
                        is_done.value = 0;
                        getTaskMaster(pageNumber, is_Active.toString(), '', '', '',date_filter, is_done.value);
                        Get.toNamed(RoutesName.taskMaster_screen);

                    }else {
                        loading.value = false;
                        Task_Master_list.value=[];
                        Utils.showErrorToastification('Error!', response[0].message.toString());
                        print('execption1...${response[0].message.toString()}}');

                    }
                } else {
                    loading.value = false;
                    print('execption2...r}');

                }
            },
            ).onError(
                    (error, stackTrace) {
                        print('execption3...${error}');
                },
            );
        }catch(e){
            loading.value = false;
            print('execption4...${e}');
        }
    }

    TaskDSARMasterCreate(){
        String EstClosureDate = "";
        DateTime selectNextInterDate = DateFormat('dd-MM-yyyy').parseStrict(NextInterdate_controller.value.text);
        String NextInterDate = DateFormat('yyyy-MM-dd').format(selectNextInterDate);
        if(EstClosuredate_controller.value.text.isNotEmpty){
            DateTime selectEstClosureDate = DateFormat('dd-MM-yyyy').parseStrict(EstClosuredate_controller.value.text);
            EstClosureDate = DateFormat('yyyy-MM-dd').format(selectEstClosureDate);
        }
        int? budgetAmt = int.tryParse(BudgetAmt_controller.text.toString()) ?? 0;
        int? estimatedAmt = int.tryParse(ExpectedAmt_controller.text.toString()) ?? 0;
        try{
            Map data={
                "task_id": TaskID,
               // "is_infra_lead": isInfraLead.value.text=="Yes"?1:0,
                "is_infra_lead": 0,
                "dsar_status": DSAR_Status_type_controller.value.text.isEmpty?'':DSAR_Status_type_controller.value.text,
                "type_of_call": Type_of_call_controller.text.isEmpty?'':Type_of_call_controller.text,
                "next_interaction_date": NextInterDate.isEmpty?'':NextInterDate,
                "next_interaction_time": NextInterTime_controller.text.isEmpty?'':NextInterTime_controller.text,
                "remarks": DSAR_Remarks_controller.text.isEmpty?'':DSAR_Remarks_controller.text,
                "est_closure_date": EstClosureDate.isEmpty?'':EstClosureDate,
                "budget_amount": budgetAmt,
                "est_budget_amount": estimatedAmt,
                "created_by": email,
                "purpose_of_visit": PusposeOfVisit_controller.text.isEmpty?'':PusposeOfVisit_controller.text,
                "method_of_call": Method_of_call_controller.text.isEmpty?'':Method_of_call_controller.text,
            };

            loading.value=true;
            _api.TaskDSARMstCreateApiHit(data, sessionManagement).then((onValue){
                final jsonResponse = json.decode(onValue);
                print(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        //Task_Master_list.addAll(response);
                        Utils.showToastification('Success!', response[0].message.toString());
                        getTaskMaster(0, 'All', TaskID, "DSAR",'GET FROM TASK ID', date_filter, is_done.value);
                        getTaskMstDSARList(TaskID);
                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                        DSARStatus.value = false;
                        typeOfCall.value = false;
                        ItemCateDropDown.value = false;
                        Type_of_call_controller.clear();
                        DSAR_Status_type_controller.value.clear();
                        ItemCat_type_controller.clear();
                        NextInterdate_controller.clear();
                        NextInterTime_controller.clear();
                        DSAR_Remarks_controller.clear();
                        EstClosuredate_controller.clear();
                        BudgetAmt_controller.clear();
                        ExpectedAmt_controller.clear();


                    }else {
                        loading.value = false;
                        Utils.showErrorToastification('Error!', response[0].message.toString());
                        //Task_Master_list.value=[];

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
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        //Task_Master_list.addAll(response);
                        Utils.showToastification('Success!', response[0].message.toString());
                       // Get.offAllNamed(RoutesName.taskMaster_screen);
                        pageNumber=0;
                        getTaskMaster(pageNumber, is_Active.toString(), '', '', '', date_filter, is_done.value);
                        Get.toNamed(RoutesName.taskMaster_screen);

                    }else {
                        loading.value = false;
                        Utils.showErrorToastification('Error!', response[0].message.toString());
                        print(response[0].message.toString());
                        //Task_Master_list.value=[];

                    }
                } else {
                    loading.value = false;
                    print('APi Not hit');

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

    taskReopenApiHit(String? taskId){
        try{
            Map<String, String> data={
                "task_id": taskId!,
                "created_by": email,
                "reopen_remarks": taskReopenRemarksController.value.text.isEmpty?'':taskReopenRemarksController.value.text,

            };
            loading.value=true;
            _api.TaskMstRejectReopenApiHit(data, sessionManagement).then((onValue){
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        //Task_Master_list.addAll(response);
                        Utils.showToastification('Success!', response[0].message.toString());
                        // Get.offAllNamed(RoutesName.taskMaster_screen);
                        pageNumber=0;
                        getTaskMaster(pageNumber, 'All', TaskID, "",'', date_filter, is_done.value);
                        Get.toNamed(RoutesName.taskMasterDetails_screen);

                    }else {
                        loading.value = false;
                        Utils.showErrorToastification('Error!', response[0].message.toString());
                        print(response[0].message.toString());
                        //Task_Master_list.value=[];

                    }
                } else {
                    loading.value = false;
                    print('APi Not hit');

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


    getContactMasterList() {
        try{
            Map<String, String> data={
                "filter_contact_name": '',
                "filter_account_code": account_code.value,
                "filter_account_name": account_name.value,
                "filter_department_name": '',
                "row_per_page": rowsPerPage.toString(),
                "page_number": '0'
            };
            loading.value=true;
            print("data is ${data}");
            _api.contactMstGetList(data, sessionManagement).then((onValue){
                final jsonResponse = json.decode(onValue);
                print(onValue);
                if(jsonResponse is List){
                    List<ContactMstGetListModal> response = jsonResponse.map((e) => ContactMstGetListModal.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        if(pageNumber==0){
                            contact_master_list.clear();
                        }
                        contact_master_list.addAll(response);
                        total_rows=int.parse(contact_master_list[0].totalRows!);
                        print('Total rows ${total_rows}');

                    }else {
                        loading.value = false;
                        contact_master_list.value=[];

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

    getTaskMstDSARList(String? taskId) {
        TaskID = taskId!;
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
                        loading.value = false;
                        TaskDSAR_Master_list.value=response;
                        print("Success...1 ${response.toString()}");

                    }else {
                        loading.value = false;
                        TaskDSAR_Master_list.value=[];
                        print("UnSuccess... ${response.toString()}");

                    }
                } else {
                    loading.value = false;
                    print("UnSuccessfull... ");

                }
            },
            ).onError(
                    (error, stackTrace) {
                    print(error);
                },
            );
        }catch(e){
            loading.value = false;
            print("jdsdhud...${e}");
        }
    }

    getAccountMaster(int page_no){
        try{
            Map<String, String> data={
                "filter_account_name": "",
                "filter_account_owner": "",
                "filter_account_type": "",
                "filter_account_category_type": "",
                "filter_company_profile_type": "",
                "filter_address": "",
                "filter_state_name": "",
                "filter_is_active": "-1",
                "filter_created_by": email,
                "row_per_page": rowsPerPage.toString(),
                "page_number": page_no.toString()
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
                        loading.value = false;
                        CallStatus_Master_list.value = response;

                    }else {
                        loading.value = false;
                        CallStatus_Master_list.value=[];
                    }
                } else {
                    loading.value = false;

                }
            },
            ).onError(
                    (error, stackTrace) {
                        print('call list...${error}');
                },
            );
        }catch(e){
            loading.value = false;
            print(e);
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
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        MethodOfCall_Master_list.addAll(response);

                    }else {
                        loading.value = false;
                        MethodOfCall_Master_list.value=[];

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

    getItemCategoryMstApi(String? taskId) {
        this.loading.value = true;
        Map<String, String> data = {
            'task_id': taskId! ,
            'filter_category': ""
        };

        _api.getItemCategoryMstApiHit(data, sessionManagement).then((value) {
            try {
                List<ItemCategoryMstModel> Response =
                (json.decode(value) as List<dynamic>)
                    .map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>))
                    .toList();

                if (Response.isNotEmpty && Response[0].condition.toString() == "True") {
                    Item_Category_master_list.value = Response;

                    /*Item_Category_Selected_list.value = [];
                    for (int i = 0; i < Item_Category_master_list.length; i++) {
                        if (Item_Category_master_list[i].isSelected == 1) {
                            Item_Category_Selected_list.add(
                                Item_Category_master_list[i]);
                        }}*/
                    print('master list1....${Item_Category_Selected_list.length.toString()}');
                } else {
                    Item_Category_master_list.value = [];
                    //print('master listelsse1....${Item_Category_Selected_list.length.toString()}');
                }
            } catch (e) {
                Item_Category_master_list.value = [];
                print('catch....${e.toString()}');
            }
        }).onError((error, stackTrace) {
            Item_Category_master_list.value = [];
            Utils.sanckBarError('Api Exception onError', error.toString());
            print('catchEx....${error.toString()}');
        }).whenComplete(() {
            this.loading.value = false;
        });
    }

    getItemCategoryMstApiHit(String? taskId, String? InfraId, String saleCycleId) {
        this.loading.value = true;
        Map<String, String> data = {
            'task_id': taskId! ,
            'filter_category': "",
            'sales_cycle_id': saleCycleId,
            'quote_id': "",
            'infra_lead_no': InfraId==null?"":InfraId
        };

        _api.getItemCategoryInfraMstApiHit(data, sessionManagement).then((value) {
            print(value);
            try {
                List<ItemCategoryMstModel> Response =
                (json.decode(value) as List<dynamic>)
                    .map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>))
                    .toList();

                if (Response.isNotEmpty && Response[0].condition?.toLowerCase() == "true") {
                    Item_Category_Infra_list.value = Response;

                    Item_Category_Selected_Infra_list.value = [];
                    for (int i = 0; i < Item_Category_Infra_list.length; i++) {
                        if (Item_Category_Infra_list[i].isSelected == 1) {
                            Item_Category_Selected_Infra_list.add(
                                Item_Category_Infra_list[i]);
                        }}
                    print('master list1....${Item_Category_Infra_list.length.toString()}');
                } else {
                    Item_Category_Infra_list.value = [];
                    Item_Category_Selected_Infra_list.value = [];
                    //print('master listelsse1....${Item_Category_Selected_list.length.toString()}');
                }
            } catch (e) {
                print('catch....${e.toString()}');
            }
        }).onError((error, stackTrace) {
            Item_Category_Infra_list.value = [];
            Item_Category_Selected_Infra_list.value = [];
            Utils.sanckBarError('Api Exception onError', error.toString());
            print('catchEx....${error.toString()}');
        }).whenComplete(() {
            this.loading.value = false;
        });
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

    TaskSaleCatCreateApiHit(String flag) async {
        print('selectlist...${Item_Category_Selected_list.length}');
        List<TaskSalesProductCategoryLinesModel> lines = Item_Category_Selected_list.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();


        Map<String, dynamic> data = {
            "created_by": email,
            "task_id": TaskID,
            "lines": lines.map((line) => line.toJson()).toList(),
        };

        print(data);
        loading.value = true;

        try {
            final value = await _api.TaskSaleCatCreateApiHit(data, sessionManagement);
            print(value);
            final JsonResponse = json.decode(value);

            if (JsonResponse is List) {
                List<TaskMasterGetModel> response =
                JsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();

                if (response != null && response.isNotEmpty && response[0].condition == "True") {
                    loading.value = false;
                    Utils.showToastification("Success!", response[0].message.toString());

                    if(flag == 'Details'){
                        getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                        //todo by raman
                        getItemCategoryMstApi(TaskID);

                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                    } else if(flag == 'DSAR'){
                       // getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                       // getItemCategoryMstApi(TaskID);
                    }

                } else {
                    loading.value = false;
                    Utils.showErrorToastification("Error!", "${response[0].message}");
                }
            } else {
                loading.value = false;
                Utils.showExceptionToastification("Api Error!", JsonResponse.toString());
            }
        } catch (error, stackTrace) {
            print(error);
            print(stackTrace);
            print("Exception....");
        }
    }
    Future<void> getMenuList() async {
        print("GetList");
        await sessionManagement.getUserGeoHierarchy().then((userGeoHierarchy) {
            userGeoHierarchyy.value = userGeoHierarchy;
                print("Ghdf ${userGeoHierarchy[0].geoValue}");
                print("Ghdf ${userGeoHierarchy.length}");

        });
    }

    getSaleIDByAccountCode(int page_no){
        try{
            Map<String, String> data={
                "sales_cycle_id": "",
                "account_code": account_code.value,
                "row_per_page": rowsPerPage.toString(),
                "page_number": page_no.toString()
            };
            print('sale id map data${data}');
            loading.value=true;
            _api.SalesCycleMstGetByAccountCodeApiHit(data, sessionManagement).then((onValue){
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<SalesCycleModal> response = jsonResponse.map((e) => SalesCycleModal.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        if(page_no==0){
                            Sales_Id_list.clear();
                        }
                        Sales_Id_list.addAll(response);
                        total_rows=int.parse(Sales_Id_list[0].totalRows!);

                    }else {
                        loading.value = false;
                        Sales_Id_list.value=[];

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

    TaskPersonMstCreateAPI(String flag) async {

        List<Selectedalongwithpersonnamemodel> personName = SelectedAlongPersonWith_list.map((item) => Selectedalongwithpersonnamemodel(empId: item.empId!)).toList();

        Map<String, dynamic> data = {
            "created_by": email,
            "task_id": TaskID,
            "lines": personName.map((line) => line.toJson()).toList(),
        };

        print(data);
        loading.value = true;

        try {
            final value = await _api.TaskPersonMstCreate(data, sessionManagement);
            print(value);
            final JsonResponse = json.decode(value);

            if (JsonResponse is List) {
                List<TaskMasterGetModel> response =
                JsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();

                if (response != null && response.isNotEmpty && response[0].condition == "True") {
                    loading.value = false;
                    Utils.showToastification("Success!", response[0].message.toString());

                    if(flag == 'Details'){
                        getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                        //todo by raman
                        getTaskPersonMstByTaskIdApi(TaskID);

                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                    } else if(flag == 'DSAR'){
                        getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                        getTaskPersonMstByTaskIdApi(TaskID);
                    }

                } else {
                    loading.value = false;
                    Utils.showErrorToastification("Error!", "Please select at least single product category");
                }
            } else {
                loading.value = false;
                Utils.showExceptionToastification("Api Error!", JsonResponse.toString());
            }
        } catch (error, stackTrace) {
            print(error);
            print(stackTrace);
            print("Exception....");
        }
    }



    //todo nirupma code
    gettaskMstInfraUpdate(String InfraNo, String flag) {
        this.loading.value = true;
        String? expOrderDate=StaticMethod.convertDateFormat(expectedDateOfOrderUpdateController.text);
        String? inaugurationDate=StaticMethod.convertDateFormat(inaugrationDateUpdateController.text);
        String? expDateOfCompletion=StaticMethod.convertDateFormat(dateofcompletioneUpdateController.text);
        String? dateDrawingReceived=StaticMethod.convertDateFormat(dateOfDrawingReceivedController.text);
        String? dateOfProposalSubmission=StaticMethod.convertDateFormat(dateOfProposalSubmissionController.text);

        List<TaskSalesProductCategoryLinesModel> lines = Item_Category_Selected_Infra_list.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();

        Map data = {
            "task_id": TaskID,
            "is_infra_lead": isInfraLeadUpdateController.value.text=="Yes"?1:0,
            "infra_lead_no": InfraNo,
            "user_region": userRegionUpdateController.text.isEmpty?"":userRegionUpdateController.text,
            "user_clusture": userClusterUpdateController.text.isEmpty?"":userClusterUpdateController.text,
            "name_of_infra_department": nameofInfradepUpdateController.text.isEmpty?"":nameofInfradepUpdateController.text,
            "executive_engineer": executiveEngineerUpdateController.text.isEmpty?"":executiveEngineerUpdateController.text,
            "assistant_engineer": assistantEngineerController.text.isEmpty?"":assistantEngineerController.text,
            "project_name": nameOfProjectController.text.isEmpty?"":nameOfProjectController.text,
            "location": locationController.text.isEmpty?"":locationController.text,
            "time_period_to_complete_civil_work_in_months": timePeriodToCompleteWorkController.text.isEmpty?"0":timePeriodToCompleteWorkController.text,
            "expected_date_of_completion": expDateOfCompletion??"",
            "project_value": projectValueUpdateController.text.isEmpty?"":projectValueUpdateController.text,
            "expected_revenue": expectedRevenueUpdateController.text.isEmpty?"":expectedRevenueUpdateController.text,
            "furniture_included_in_civil_scope": furnitureIncludedInCivilController.text=="Yes"?1:0,
            "customer_name": customerNameController.text.isEmpty?"":customerNameController.text,
            "contact_person_decision_maker": contactPersonHODController.text.isEmpty?"":contactPersonHODController.text,
            "name_of_agency_contrator": agencyContractorUpdateController.text.isEmpty?"":agencyContractorUpdateController.text,
            "owner_of_contrator": ownerOfContractorController.text.isEmpty?"":ownerOfContractorController.text,
            "project_site_manager": siteManagerController.text.isEmpty?"":siteManagerController.text,
            "name_of_architect_firm": nameOfArchitecfirmUpdateController.text.isEmpty?"":nameOfArchitecfirmUpdateController.text,
            "architect": architectUpdateController.text.isEmpty?"":architectUpdateController.text,
            "lines": lines.map((line) => line.toJson()).toList(),
            "drawing_collected": drawingcollectedUpdateController.text=="Yes"?1:0,
            "date_drawing_received": dateDrawingReceived??"",
            "proposal_submitted": proposalSubmittedUpdateController.text=="Yes"?1:0,
            "date_of_proposal_submission": dateOfProposalSubmission??"",
            "value_of_quote": valueOfQuoteUpdateController.text.isEmpty?"":valueOfQuoteUpdateController.text,
            "expected_date_of_order": expOrderDate??"",
            "inaugration_date_of_project": inaugurationDate??"",
            "created_by": email
        };
            try {
                print(data);
                _api.taskMstInfraUpdateApiHit(data, sessionManagement).then((
                    onValue) {
                    final jsonResponse = json.decode(onValue);
                    print(onValue);
                    if (jsonResponse is List) {
                        List<TaskUpdateInfraModal> response = jsonResponse.map((e) => TaskUpdateInfraModal.fromJson(e))
                            .toList();
                        if (response[0].condition == "True") {
                            Utils.sanckBarSuccess("Message !", response[0].message.toString());
                            getTaskMaster(0,
                                is_Active.toString(),
                               Task_Master_list[0].taskId,
                                '', 'GET FROM TASK ID', date_filter, is_done.value);

                            if(flag == 'FromDSARPage'){
                                isInfraLeadValueSubmit.value = true;
                                Get.toNamed(RoutesName.addNewDSARTask_screen);
                            }else if(flag == 'FromDetailsPage'){
                                Get.toNamed(RoutesName.taskMasterDetails_screen);
                            }

                            clearInfraUpdateController();
                            loading.value = false;
                        } else {
                            loading.value = false;
                            Utils.sanckBarError("False Message !", response[0].message.toString());
                        }
                    } else {
                        loading.value = false;
                    }
                },
                ).onError(
                        (error, stackTrace) {
                        loading.value = false;
                        print(error);
                    },
                );
            } catch (e) {
                Utils.sanckBarException("Message !", e.toString());
                loading.value = false;
                print(e);
            }
            finally{
                loading.value = false;
            }
        }

    getEmpMstEmailByApi() {
        Map<String , String> data = {
            "email_id": email
        };
        print(data);
        loading.value = true;
        _api.EmpMstEmailByGet(data, sessionManagement).then(
                (value) {
                print(value);
                final JsonResponse = json.decode(value);
                try{
                    if (JsonResponse is List) {
                        List<AlongWithPersonModel> response =
                        JsonResponse.map((e) => AlongWithPersonModel.fromJson(e))
                            .toList();
                        if (response != null &&
                            response.length > 0 &&
                            response[0].condition == "True") {
                            AlongPersonWith_list.value=response;


                        } else {
                            AlongPersonWith_list.value=[];
                            Utils.showErrorToastification(
                                "Error!", "No Data Found");
                            //service_installation_details_list.value=[];
                        }
                    } else {

                        // service_indent_header_list.value = [];
                        Utils.showExceptionToastification("Api Error!", JsonResponse);
                    }
                }catch(e){
                    print(e);
                }finally{
                    loading.value = false;

                }

            },
        ).onError(
                (error, stackTrace) {
                loading.value = false;
                print(error);
                //service_indent_header_list.value = [];
            },
        ).whenComplete(() {
            loading.value = false;
        },);
    }

    getTaskPersonMstByTaskIdApi(String TaskID){
        try{
            Map<String, String> data={
                "task_id": TaskID,
                "along_with_person_name": "",
                "email_id": email,

            };
            loading.value=true;
            _api.TaskPersonMstGetByTaskId(data, sessionManagement).then((onValue){
                print(onValue);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<AlongWithPersonModel> response = jsonResponse.map((e) => AlongWithPersonModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        loading.value = false;
                        AlongPersonWith_list.value = response;
                        print('asjhdgsau1 ${AlongPersonWith_list.length}');

                    }else {
                        loading.value = false;
                        AlongPersonWith_list.value=[];

                    }
                } else {
                    loading.value = false;

                }
            },
            ).onError(
                    (error, stackTrace) {
                        print('asjhdgsau5 ${error}');
                },
            );
        }catch(e){
            loading.value = false;
            print(e);
        }
    }

   /* getTaskPersonMstByTaskIdApi(String TaskID) {
        Map<String , String> data = {
            "task_id": TaskID,
            "along_with_person_name": "",
            "email_id": email,

        };
        print(data);
        loading.value = true;
        _api.TaskPersonMstGetByTaskId(data, sessionManagement).then(
                (value) {
                print(value);
                final JsonResponse = json.decode(value);
                try{
                    if (JsonResponse is List) {
                        List<AlongWithPersonModel> response =
                        JsonResponse.map((e) => AlongWithPersonModel.fromJson(e))
                            .toList();
                        if (response != null &&
                            response.length > 0 &&
                            response[0].condition == "True") {
                            AlongPersonWith_list.value=response;
                            print('asjhdgsau1${AlongPersonWith_list.length}');


                        } else {
                            AlongPersonWith_list.value=[];
                            print('asjhdgsau2${AlongPersonWith_list.length}');
                            Utils.showErrorToastification(
                                "Error!", "No Data Found");
                            //service_installation_details_list.value=[];
                        }
                    } else {

                        // service_indent_header_list.value = [];
                        print('asjhdgsau3 ${JsonResponse}');
                        Utils.showExceptionToastification("Api Error!", JsonResponse);
                    }
                }catch(e){
                    print('asjhdgsau4 ${e}');
                }finally{
                    loading.value = false;

                }

            },
        ).onError(
                (error, stackTrace) {
                loading.value = false;
                print('asjhdgsau5 ${error}');
                //service_indent_header_list.value = [];
            },
        ).whenComplete(() {
            print('asjhdgsau6 when complete');
            loading.value = false;
        },);
    }
*/
    void clearInfraUpdateController(){
         projectValueUpdateController.clear();
         expectedDateOfOrderUpdateController.clear();
         drawingcollectedUpdateController.clear();
         proposalSubmittedUpdateController.clear();
         inaugrationDateUpdateController.clear();
         architectUpdateController.clear();
         executiveEngineerUpdateController.clear();
         nameOfArchitecfirmUpdateController.clear();
         nameofInfradepUpdateController.clear();
         agencyContractorUpdateController.clear();
         expectedRevenueUpdateController.clear();
         valueOfQuoteUpdateController.clear();
         dateofcompletioneUpdateController.clear();
         assistantEngineerController.clear();
         nameOfProjectController.clear();
         locationController.clear();
         furnitureIncludedInCivilController.clear();
         customerNameController.clear();
         contactPersonHODController.clear();
         ownerOfContractorController.clear();
         siteManagerController.clear();
         dateOfDrawingReceivedController.clear();
         dateOfProposalSubmissionController.clear();
         projectValueUpdateController.clear();

    }

    void viewAllDetailsOfTaskUpdateInfra(){
        String? expOrderDate=StaticMethod.convertDateFormat1(Task_Master_list[0].expectedDateOfOrder ?? "");
        String? inaugurationDate=StaticMethod.convertDateFormat1(Task_Master_list[0].inaugrationDateOfProject ?? "");
        String? expDateOfCompletion=StaticMethod.convertDateFormat1(Task_Master_list[0].expectedDateOfCompletion ?? "");
        String? dateDrawingReceived=StaticMethod.convertDateFormat1(Task_Master_list[0].dateDrawingReceived ?? "");
        String? dateOfProposalSubmission=StaticMethod.convertDateFormat1(Task_Master_list[0].dateOfProposalSubmission ?? "");

        isInfraLeadUpdateController.value.text=Task_Master_list[0].isInfraLead==1 ? "Yes":"No";
        expectedDateOfOrderUpdateController.text=expOrderDate ?? "";
        drawingcollectedUpdateController.text=Task_Master_list[0].drawingCollected ==1 ? "Yes":"No";
        proposalSubmittedUpdateController.text=Task_Master_list[0].drawingCollected==1 ? "Yes":"No";
        inaugrationDateUpdateController.text= inaugurationDate??"";
        architectUpdateController.text=Task_Master_list[0].architect ?? "";
        executiveEngineerUpdateController.text=Task_Master_list[0].executiveEngineer ?? "";
        nameOfArchitecfirmUpdateController.text=Task_Master_list[0].nameOfArchitectFirm ?? "";
        nameofInfradepUpdateController.text=Task_Master_list[0].nameOfInfraDepartment ?? "";
        agencyContractorUpdateController.text=Task_Master_list[0].nameOfAgencyContrator ?? "";
        expectedRevenueUpdateController.text=Task_Master_list[0].expectedRevenue.toString();
        valueOfQuoteUpdateController.text=Task_Master_list[0].valueOfQuote.toString();
        dateofcompletioneUpdateController.text=expDateOfCompletion??"";
        assistantEngineerController.text=Task_Master_list[0].assistantEngineer??"";
        nameOfProjectController.text=Task_Master_list[0].projectName??"";
        locationController.text=Task_Master_list[0].location??"";
        timePeriodToCompleteWorkController.text=Task_Master_list[0].timePeriodToCompleteCivilWorkInMonths==null?"":Task_Master_list[0].timePeriodToCompleteCivilWorkInMonths.toString();
        furnitureIncludedInCivilController.text=Task_Master_list[0].furnitureIncludedInCivilScope==1 ? "Yes":"No";
        customerNameController.text=Task_Master_list[0].customerName??"";
        contactPersonHODController.text=Task_Master_list[0].contactPersonDecisionMaker??"";
        ownerOfContractorController.text=Task_Master_list[0].ownerOfContractor??"";
        siteManagerController.text=Task_Master_list[0].projectSiteManager??"";
        dateOfDrawingReceivedController.text=dateDrawingReceived??"";
        dateOfProposalSubmissionController.text=dateOfProposalSubmission??"";
        projectValueUpdateController.text=Task_Master_list[0].projectValue.toString();
    }

    void clearCreateTaskController(){
        filterTask_Id_controller.clear();
        Item_Category_Selected_list.value=[];
        SelectedAlongPersonWith_list.value=[];
        account_name.value = '';
        isInfraLeadFilterController.text = "No";
        account_Name_controller.clear();
        Contact_Name_controller.clear();
        Type_of_call_controller.clear();
        Method_of_call_controller.clear();
        Task_Remarks_controller.clear();
        Sale_cycle_Id_controller.clear();
        //isInfraLeadFilterController.clear();
        String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
        DataOFVisitController.value.text = todayDate;
        VisitTime_controller.value.clear();
        ItemCat_type_controller.clear();
        AlongPersonWith_controller.clear();
        isSalesNecessaryController.value.clear();
        PaymentCall.value = false;
        PurposeOfVisit.value = false;
        IsSalesId.value = false;


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
       Method_of_call_controller.clear();
       Sale_cycle_Id_controller.clear();
       filterTask_Id_controller.clear();
       isInfraLeadFilterController.text = "No";
       //Task_status_controller.clear();
       filterTaskDuedateController.value.clear();
       filterTaskCreationOnController.value.clear();
       createdOnStartToEnd.value = "";
       Task_status_controller.text = "All";
       SaleCycleActive_Controller.text = "All";
  }

}