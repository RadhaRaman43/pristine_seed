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
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_DSAR_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_Models/TaskMaster_model/task_category_model.dart';
import '../../CRM_Models/TaskMaster_model/task_update_infra_modal.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_update_status_modal.dart';
import '../../CRM_Models/sale_cycle_modal/selectedAlongWithPersonNameModel.dart';
import '../../CRM_Repository/Task_master_Repository/Task_master_repo.dart';

class Taskmastervm extends GetxController{
    final _api = TaskMasterRepo();
    SessionManagement sessionManagement = SessionManagement();
    RxString account_code="".obs;
    RxString account_name="".obs;
    RxString contact_code="".obs;
    RxString contact_code_for_dsar="".obs;
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
    RxString isAdminWritePermission = "".obs;
    RxString isHeadofficePermission = "".obs;
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
    RxString FromPage="".obs;

    int Active = 0;
    String IsSaleCycleActive= '';
    var selectedContact = Rxn<ContactMstGetListModal>();

    var Task_status_controller = TextEditingController();
    var account_code_controller = TextEditingController();
    var account_Name_controller = TextEditingController();
    var filterTask_Id_controller = TextEditingController();
    var Contact_Name_controller = TextEditingController();
    var Type_of_call_controller = TextEditingController().obs;
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
    var filterTaskCreationOn_from_to_date_Controller=TextEditingController().obs;
    var filterAlongWithPersonNameController=TextEditingController().obs;
    var DataOFVisitController=TextEditingController().obs;
    var VisitTime_controller=TextEditingController().obs;

    //todo new controller added by nirupma for filter
    var companyProfileTypeController=TextEditingController().obs;
    var postalCodeController=TextEditingController().obs;
    var district_controller=TextEditingController().obs;
    var approved_by_controller=TextEditingController().obs;
    var created_by_controller=TextEditingController().obs;
    var frontliner_controller=TextEditingController().obs;
    var clusterName_controller=TextEditingController().obs;
    var zone_head_value_controller=TextEditingController().obs;
    var RegionName_controller=TextEditingController().obs;
    var EmailId_Controller=TextEditingController().obs;
    var lastActivityStatus_Controller=TextEditingController().obs;
    var PhoneNo_Controller=TextEditingController().obs;
    var product_category_controller=TextEditingController().obs;
    var product_category_type_Controller = TextEditingController().obs;
    var method_of_call_controller=TextEditingController().obs;
    //var account_owner_controller=TextEditingController().obs;
    var AccountOwner_controller=TextEditingController().obs;
    String accountNameCode='';

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

    String executiveEn ="";
    String assistantEn ="";
    String contactPersonHOD ="";
    String ownerOfContractor ="";
    String siteManager ="";
    String architectUpdate ="";
    String nameofInfradepUpdate ="";
    String customerName ="";
    String agencyContractorUpdate ="";
    String nameOfArchitecfirmUpdate ="";

    RxList<TaskMasterGetModel> Task_Master_list=<TaskMasterGetModel>[].obs;
    RxList<String> TaskStatusListTypeList = <String>[].obs;
    RxList<String> SaleCycleActiveTypeList = <String>[].obs;
    RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;

    RxList<String> approveRejectList = <String>[].obs;
    RxList<AccountMasterModel> Account_Master_list=<AccountMasterModel>[].obs;
    RxList<SalesCycleModal> Sales_Id_list=<SalesCycleModal>[].obs;
    RxList<CallStatusMasterModel> CallStatus_Master_list=<CallStatusMasterModel>[].obs;
    RxList<CallStatusMasterModel> Selection_CallStatus_Master_list=<CallStatusMasterModel>[].obs;
    RxList<CallStatusMasterModel> MethodOfCall_Master_list=<CallStatusMasterModel>[].obs;
    RxList<CallStatusMasterModel> Selection_MethodOfCall_Master_list=<CallStatusMasterModel>[].obs;
    RxList<CallStatusMasterModel> DSARStatus_Master_list=<CallStatusMasterModel>[].obs;
    RxList<ContactMstGetListModal> contact_master_list = <ContactMstGetListModal>[].obs;
    RxList<TaskDSARModel> TaskDSAR_Master_list = <TaskDSARModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_master_list = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_Selected_list = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_Selected_Infra_list = <ItemCategoryMstModel>[].obs;
    RxList<ItemCategoryMstModel> Item_Category_Infra_list = <ItemCategoryMstModel>[].obs;
    RxList<AlongWithPersonModel> AlongPersonWith_list = <AlongWithPersonModel>[].obs;
    RxList<AlongWithPersonModel> SelectedAlongPersonWith_list = <AlongWithPersonModel>[].obs;
    RxList<UserGeoHierarchy> userGeoHierarchyy = <UserGeoHierarchy>[].obs;
    RxList<String> Item_Category_code_list = <String>[].obs;
    RxList<String> isInfraLeadList =["Yes", "No"].obs;
    RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
    RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;

    var AccountOwnerForApi;

    RxList<CompanyTypeModal> company_profile_type_list = <CompanyTypeModal>[].obs;
    RxList<CompanyTypeModal> selected_company_type_list = <CompanyTypeModal>[].obs;
    RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
    RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
    RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
    RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;
    RxList<CallStatusMasterModel> selectedDSARStatusList = <CallStatusMasterModel>[].obs;

    RxList<EmployeeMemberModel> tempSelected = <EmployeeMemberModel>[].obs;
    RxList<EmployeeMemberModel> filtered = <EmployeeMemberModel>[].obs;
    RxBool selectOwner = true.obs;
    RxBool allSelected = false.obs;
    RxBool isSel = false.obs;
    var searchController=TextEditingController().obs;

    @override
    void onInit() async {
      super.onInit();
      try {
        loading.value=true;
        email = await sessionManagement.getEmail() ?? '';
        isAdminWritePermission.value =
            await sessionManagement.getIsAdminPermission() ?? '';
        isHeadofficePermission.value =
            await sessionManagement.getisHeadofficePermission() ?? '';
        print("emais...${email}");
        print(
            "isAdminWritePermission.valueTask....${isAdminWritePermission.value
                .toString()}");
        getMenuList();
        print("List${userGeoHierarchyy.length}");
        TaskStatusListTypeList.value =
        ['All', 'Pending For Approval', 'Approved', 'Rejected'];
        SaleCycleActiveTypeList.value = ['All', 'Yes', 'No'];
        SaleCycleActive_Controller.text = SaleCycleActiveTypeList[0];
        approveRejectList.value = ['Approve', 'Reject'];
        Item_Category_Selected_list.value = [];
        //userGeoHierarchy=await sessionManagement.getUserGeoHierarchy() ?? [];
        //getTaskMaster(pageNumber, is_Active.toString(), '', '', '', date_filter,is_done.value);
        bindFinancialYear();
        product_category_type_Controller.value.text = "Contains";
        getClustersGetByEmail();
        getAccountMaster(pageNumber,"");
        getItemCategoryMstWithoutTaskIdApi();
        getCompanyTypeMasterGet();
        CallStatusMasterApiHit('Call');
        MethodOfCallMasterApiHit();
        CallDSARsMasterApiHit();

        if (this.isAdminWritePermission.value == "1") {
          EmployeeMasterGet('');
        }
        else {
          getEmployeeMemberApi();
        }
      }
      catch(e){

      }
      finally{
        loading.value=false;
      }
    }

    bindFinancialYear(){
      DateTime now = DateTime.now();
      late DateTime startDate;
      late DateTime endDate;
      if (now.month >= 4) {
        startDate = DateTime(now.year, 4, 1);
        endDate = DateTime(now.year + 1, 3, 31);
      } else {
        startDate = DateTime(now.year - 1, 4, 1);
        endDate = DateTime(now.year, 3, 31);
      }
      String srtDate = DateFormat('yyyy-MM-dd').format(startDate);
      String end = DateFormat('yyyy-MM-dd').format(endDate);
      createdOnStartToEnd.value="$srtDate@$end";
      filterTaskDuedateController.value.text = '$srtDate - $end';
    }

    Future<Iterable<EmployeeMemberModel>> EmployeeMasterGet(String query) async {
        // if (query == '') {
        //     return const Iterable<EmployeeMemberModel>.empty();
        // }
        Map data = {
          'filter_name': query,
          'filter_email': "",
          'filter_location_id': '',
          'email_id': email,
          "filter_cluster_name": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
          "filter_region_name": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
          'rowsPerPage': 10,
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
                            loading.value = false;
                            employee_Member_list.value=response;
                            //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

                        } else {
                            loading.value = false;
                            employee_Member_list.value=[];
                            //Utils.sanckBarError("Error!", "No Date Found");
                            //service_installation_details_list.value=[];
                        }
                    } else {
                        loading.value = false;
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
            loading.value = false;
            employee_Member_list.value = [];
            print(e);
        }
    }


    Future<void>refreshList() async{
        getTaskMaster(pageNumber, is_Active.toString(), '', '','',date_filter, is_done.value);

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

    void getClustersGetByEmail() async {
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
                clusterName_controller.value.text =
                    clusterGetByEmailList.value.map((e) => e.geoValue).join('|');
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

    void getRegionsWithClusterFilterGetByEmail() async {
      var selectedCluster="";
      try{
      if(clusterName_controller.value.text.isNotEmpty){
        selectedCluster = clusterName_controller.value.text
            .split('|')
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
              //print('region....${RegionName_controller.value.text}');
              getFilterData();
              //getTaskMaster(pageNumber, is_Active.toString(), '', '', '', date_filter,is_done.value);

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
    
    getTaskMaster(int page_no, String IsActive, String? taskId, String flag, String status, RxString date_filter, int is_done, ) async {
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
                "filter_task_id": taskId!.isNotEmpty?taskId:filterTask_Id_controller.text,
                "filter_account_code": account_code_controller.text.isEmpty?"":account_code_controller.text,
                "filter_account_name": account_Name_controller.text.isEmpty?"":account_Name_controller.text,
                "filter_task_owner_new": AccountOwnerForApi.isEmpty?"":AccountOwnerForApi,
                "filter_task_status": status == 'All'?"":status,
                "filter_product_category": product_category_controller.value.text.isEmpty?"":product_category_controller.value.text,
                "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
                "filter_type_of_call":  Type_of_call_controller.value.text.isEmpty?"":
                Type_of_call_controller.value.text.toLowerCase()=="all"?"":Type_of_call_controller.value.text,
                "filter_method_of_call": method_of_call_controller.value.text.isEmpty?"":method_of_call_controller.value.text,
                "filter_last_activity_status": lastActivityStatus_Controller.value.text.isEmpty?"":lastActivityStatus_Controller.value.text,
                "filter_company_profile_type": companyProfileTypeController.value.text.isEmpty?"":companyProfileTypeController.value.text,
                "filter_is_infra_lead": -1,
                "filter_is_sales_cycle_active": is_Active.toString(),
                "filter_sales_cycle_id": Sale_cycle_Id_controller.value.text.isEmpty?"":Sale_cycle_Id_controller.value.text,
                "filter_created_by":"",
                "filter_approved_by": approved_by_controller.value.text.isEmpty?"":approved_by_controller.value.text,
                "filter_created_on": filterTaskCreationOnController.value.text.isEmpty?"":filterTaskCreationOnController.value.text,
                "filter_due_date": createdOnStartToEnd.value.isEmpty?"":createdOnStartToEnd.value,
                "filter_task_owner":isAdminWritePermission.value=='1' || isHeadofficePermission.value=='1'?"":email,
                "filter_is_closed_completed": is_done,
                "filter_day_flag": date_filter.toString(),
                "filter_postal_code": postalCodeController.value.text.isEmpty?"":postalCodeController.value.text,
                "filter_district": district_controller.value.text.isEmpty?"":district_controller.value.text,
                "filter_frontliner_value": "",
                "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
                "filter_zone_head_value": "",
              "filter_parent_product_category":"",
                "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
                "row_per_page": rowsPerPage.toString(),
                "page_number": page_no.toString()
                //"filter_account_owner": account_owner_controller.value.text.isEmpty?"":account_owner_controller.value.text,
            };
            print("Data Json....${data}");
            loading.value=true;
            var onValue = await _api.TaskMasterGetApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                print("Data Json...}");
                print(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
                        if(page_no==0){
                            Task_Master_list.clear();
                        }
                        Task_Master_list.addAll(response);
                        total_rows=int.parse(Task_Master_list[0].totalRows!);
                      print("gggg...${Task_Master_list[0].isCreateTaskDsar}");

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
                            getTaskPersonMstByTaskIdApi(taskId);
                            Get.toNamed(RoutesName.taskMasterDetails_screen);
                        }
                        if(flag=="task_master_detail"){
                          getItemCategoryMstApi(taskId);

                        }
                        if(FromPage.value=="from_pendingDSARDashboard" || FromPage.value=="from_CallDashboard"){
                          Get.toNamed(RoutesName.taskMasterDetails_screen);
                        }
                        print("from page ${FromPage.value}");
                        getTaskMstDSARList(taskId);


                    }else {
                        Task_Master_list.value=[];

                    }
                }
        }catch(e){
            print("Catch Block...$e");
        }
        finally{
            loading.value = false;
        }
    }

    TaskMasterCreate() async {
      try{
        String todayDate="";
        if(DataOFVisitController.value.text.isNotEmpty && DataOFVisitController.value.text !=null && DataOFVisitController.value.text!=""){
          DateTime selectDate = DateFormat('dd-MM-yyyy').parseStrict(DataOFVisitController.value.text);
          todayDate = DateFormat('yyyy-MM-dd').format(selectDate);
        }

        List<TaskSalesProductCategoryLinesModel> lines = Item_Category_Selected_list.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();
        List<Selectedalongwithpersonnamemodel> personName = SelectedAlongPersonWith_list.map((item) => Selectedalongwithpersonnamemodel(empId: item.empId!)).toList();

        var apiTime = '';
        if(VisitTime_controller.value.text.isNotEmpty) {
          final uiTime = VisitTime_controller.value.text.trim();
          final cleanTime = uiTime.replaceAll(RegExp(r'\s+'), ' ');
          final parsedTime = DateFormat('hh:mm a', 'en_US').parse(cleanTime);
          apiTime = DateFormat('HH:mm').format(parsedTime);
        }

        Map<String, dynamic> data={
                "account_name": account_name.value.isNotEmpty?account_name.value:"",
                "account_code": account_code.value.isNotEmpty?account_code.value:"",
                "contact_name": Contact_Name_controller.text.isEmpty?'':Contact_Name_controller.text,
                "contact_code": contact_code.value.isNotEmpty?contact_code.value:"",
                "created_by": email,
                "method_of_call": Method_of_call_controller.text.isEmpty?'':Method_of_call_controller.text,
                "task_remarks": Task_Remarks_controller.text.isEmpty?'':Task_Remarks_controller.text,
                "purpose_of_visit": PusposeOfVisit_controller.text.isEmpty?'':PusposeOfVisit_controller.text,
                "type_of_call": Type_of_call_controller.value.text.isEmpty?'':Type_of_call_controller.value.text,
                "payment_sale_cycle_id": Sale_cycle_Id_controller.text.isEmpty?'':Sale_cycle_Id_controller.text,
                "date_of_visit": todayDate.isEmpty?"":todayDate,
                "time_of_visit": VisitTime_controller.value.text.isEmpty?"":apiTime,
                //"is_infra_lead": isInfraLeadFilterController.text =='Yes'?1:0,
                "is_infra_lead": 0,
                "lines": lines.map((line) => line.toJson()).toList(),
                "person_name": personName.map((line) => line.toJson()).toList(),
            };
            print('Jason Date....${data}');
            loading.value=true;
            String onValue = await _api.TaskMasterCreateApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                      Type_of_call_controller.value.text="";
                        //Task_Master_list.addAll(response);
                        Utils.sanckBarSuccess('Success!', response[0].message.toString());
                       // Get.offAllNamed(RoutesName.taskMaster_screen);
                        pageNumber=0;
                        clearCreateTaskController();
                        date_filter.value = "Today";
                        is_done.value = 0;
                        getTaskMaster(pageNumber, is_Active.toString(), '', '', '',date_filter, is_done.value);
                        Get.toNamed(RoutesName.taskMaster_screen);

                    }else {
                        Task_Master_list.value=[];
                        Utils.sanckBarError('Error!', response[0].message.toString());
                        print('execption1...${response[0].message.toString()}}');

                    }
                } else {
                    print('execption2...r}');
                }
        }catch(e){
            print('execption4...${e}');
        }
        finally{
          loading.value = false;
        }
    }

    TaskDSARMasterCreate() async {
      try{
        String EstClosureDate = "";
        String NextInterDate ="";
        if(DSARStatus.value && NextInterdate_controller.value.text.isNotEmpty){
          DateTime selectNextInterDate = DateFormat('dd-MM-yyyy').parseStrict(NextInterdate_controller.value.text);
          NextInterDate = DateFormat('yyyy-MM-dd').format(selectNextInterDate);
        }

        if(EstClosuredate_controller.value.text.isNotEmpty){
            DateTime selectEstClosureDate = DateFormat('dd-MM-yyyy').parseStrict(EstClosuredate_controller.value.text);
            EstClosureDate = DateFormat('yyyy-MM-dd').format(selectEstClosureDate);
        }
        int? budgetAmt = int.tryParse(BudgetAmt_controller.text.toString()) ?? 0;
        int? estimatedAmt = int.tryParse(ExpectedAmt_controller.text.toString()) ?? 0;
        var apiTime = '';
        if(NextInterTime_controller.value.text.isNotEmpty) {
          final uiTime = NextInterTime_controller.value.text.trim();
          final cleanTime = uiTime.replaceAll(RegExp(r'\s+'), ' ');
          final parsedTime = DateFormat('hh:mm a', 'en_US').parse(cleanTime);
          apiTime = DateFormat('HH:mm').format(parsedTime);
        }

            Map data={
                "task_id": TaskID,
                // "is_infra_lead": isInfraLead.value.text=="Yes"?1:0,
                "is_infra_lead": 0,
                "dsar_status": DSAR_Status_type_controller.value.text.isEmpty?'':DSAR_Status_type_controller.value.text,
                "type_of_call": Type_of_call_controller.value.text.isEmpty?'':Type_of_call_controller.value.text,
                "next_interaction_date": NextInterDate.isEmpty?'':NextInterDate,
                "next_interaction_time": NextInterTime_controller.text.isEmpty?'':apiTime,
                "remarks": DSAR_Remarks_controller.text.isEmpty?'':DSAR_Remarks_controller.text,
                "est_closure_date": EstClosureDate.isEmpty?'':EstClosureDate,
                "budget_amount": budgetAmt,
                "est_budget_amount": estimatedAmt,
                "created_by": email,
                "purpose_of_visit": PusposeOfVisit_controller.text.isEmpty?'':PusposeOfVisit_controller.text,
                "method_of_call": Method_of_call_controller.text.isEmpty?'':Method_of_call_controller.text,
                "contact_code": contact_code_for_dsar.value,
                "contact_name": Contact_Name_controller.text.isNotEmpty?Contact_Name_controller.text:""
            };

            loading.value=true;
            String onValue = await _api.TaskDSARMstCreateApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                print(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){

                        //Task_Master_list.addAll(response);
                        Utils.sanckBarSuccess('Success!', response[0].message.toString());
                        getTaskMaster(0, 'All', TaskID, "DSAR",'GET FROM TASK ID', date_filter, is_done.value);
                        getTaskMstDSARList(TaskID);
                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                        DSARStatus.value = false;
                        typeOfCall.value = false;
                        ItemCateDropDown.value = false;
                        Type_of_call_controller.value.clear();
                        DSAR_Status_type_controller.value.clear();
                        ItemCat_type_controller.clear();
                        NextInterdate_controller.clear();
                        NextInterTime_controller.clear();
                        DSAR_Remarks_controller.clear();
                        EstClosuredate_controller.clear();
                        BudgetAmt_controller.clear();
                        ExpectedAmt_controller.clear();


                    }else {
                        Utils.sanckBarError('Error!', response[0].message.toString());
                        //Task_Master_list.value=[];

                    }
                }
        }catch(e){
            loading.value = false;
            print(e);
        }
    }

    ApproveRejectApiHit(String? taskId, String from_page) async{
        try{
            Map<String, String> data={
                "task_id": taskId!,
                "task_status": ApproveReject,
                "reject_reason": RejectReason_Controller.text.isEmpty?'':RejectReason_Controller.text,
                "manager_remarks": managerRemarksController.value.text.isEmpty?'':managerRemarksController.value.text,
                "created_by": email,

            };
            loading.value=true;
            String onValue = await _api.TaskMstApproveRejectApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        //Task_Master_list.addAll(response);
                        Utils.sanckBarSuccess('Success!', response[0].message.toString());
                       // Get.offAllNamed(RoutesName.taskMaster_screen);
                        pageNumber=0;
                        getTaskMaster(pageNumber, is_Active.toString(), '', '', '', date_filter, is_done.value);
                        Get.toNamed(RoutesName.taskMaster_screen);

                    }else {
                        Utils.sanckBarError('Error!', response[0].message.toString());
                        print(response[0].message.toString());
                        //Task_Master_list.value=[];

                    }
                } else {
                    print('APi Not hit');

                }
        }catch(e){
            print(e);
        }
        finally{
          loading.value = false;
        }
    }

    taskReopenApiHit(String? taskId) async {
        try{
            Map<String, String> data={
                "task_id": taskId!,
                "created_by": email,
                "reopen_remarks": taskReopenRemarksController.value.text.isEmpty?'':taskReopenRemarksController.value.text,
            };
            loading.value=true;
            String onValue = await _api.TaskMstRejectReopenApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<TaskMasterGetModel> response = jsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){

                        //Task_Master_list.addAll(response);
                        Utils.sanckBarSuccess('Success!', response[0].message.toString());
                        // Get.offAllNamed(RoutesName.taskMaster_screen);
                        pageNumber=0;
                        getTaskMaster(pageNumber, 'All', TaskID, "",'', date_filter, is_done.value);
                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                        loading.value = false;
                    }else {
                        Utils.sanckBarError('Error!', response[0].message.toString());
                        print(response[0].message.toString());
                        //Task_Master_list.value=[];
                        loading.value = false;
                    }
                }

        }catch(e){
            print(e);
        }
       /* finally{
          loading.value = false;
        }*/
    }


    Future<Iterable<ContactMstGetListModal>> getContactMasterList(String accountCode, String accountName) async {
        try{
            Map<String, String> data={
                "filter_contact_name": '',
                "filter_account_code": accountCode,
                "filter_account_name": accountName,
                "filter_department_name": '',
                "row_per_page": rowsPerPage.toString(),
                "page_number": '0'
            };
            loading.value=true;
            print("data is ${data}");
            String onValue = await _api.contactMstGetList(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                print(onValue);
                if(jsonResponse is List){
                    List<ContactMstGetListModal> response = jsonResponse.map((e) => ContactMstGetListModal.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){

                        if(pageNumber==0){
                            contact_master_list.clear();
                        }
                        contact_master_list.addAll(response);
                        total_rows=int.parse(contact_master_list[0].totalRows!);
                        print('Total rows ${total_rows}');

                    }else {
                        contact_master_list.value=[];
                    }
                }

        }catch(e){
            print(e);
        }
        finally{
          loading.value=false;
        }
        return contact_master_list;

    }

    getTaskMstDSARList(String? taskId) async  {
        TaskID = taskId!;
        Map<String, String> data={
          "filter_dsar_status": '',
          "filter_task_id": taskId,
          "row_per_page": rowsPerPage.toString(),
          "page_number": '0'
        };
        loading.value=true;
        print("data is ${data}");
         await _api.TaskDSARMstGetApiHit(data, sessionManagement).then((onValue){
          try {
            List<TaskDSARModel> response = (json.decode(onValue) as List<dynamic>)
                .map((i) => TaskDSARModel.fromJson(i as Map<String, dynamic>))
                .toList();
            if(response!= null && response.length>0 && response[0].condition=="True"){
              TaskDSAR_Master_list.value=response;
            } else {
              TaskDSAR_Master_list.value=[];
            }
          } catch (e) {
            print('catch....${e.toString()}');
          }
        }).whenComplete((){
           loading.value=false;
         });
    }




    Future<Iterable<AccountMasterModel>> getAccountMaster(int page_no, String accont_name) async{
        try{
            Map<String, dynamic> data={
                "filter_account_code": "",
                "filter_account_name": accont_name,
                "filter_account_type": "",
                "filter_email_id": "",
                "filter_phone_no": "",
                "filter_company_profile_type": "",
                "filter_state_name": "",
                "filter_postal_code": "",
                "filter_district": "",
                "filter_created_by": "",
                "filter_account_owner":email,
                "filter_frontliner_value": "",
                "filter_branch_head_value": "",
                "filter_zone_head_value": "",
                "filter_clusture_head_value": "",
                "filter_is_active": "-1",
                "filter_created_on": "",
                "filter_account_owner_new": "",
                "row_per_page": rowsPerPage,
                "page_number": 0
            };
            loading.value = true;
            String onValue = await _api.AccountMasterGetApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<AccountMasterModel> response = jsonResponse.map((e) => AccountMasterModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        Account_Master_list.value=response;

                    }else {
                        Account_Master_list.value=[];
                    }
                }

        }catch(e){

            print(e);
        }
        finally{
          loading.value = false;
        }
        return Account_Master_list;
    }



    CallStatusMasterApiHit(String flag,{String? filter}) async {
        try{
            Map<String, String> data={
                "filter_type_of_call": flag,
            };
            loading.value = true;
            String onValue = await _api.CallStatusMasterGetApiHit(data, sessionManagement);
                print(onValue);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                  loading.value = false;
                    List<CallStatusMasterModel> response = jsonResponse.map((e) => CallStatusMasterModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                      CallStatus_Master_list.value=[];
                      Selection_CallStatus_Master_list.value =[];
                      if(filter=="0"){
                        CallStatus_Master_list.add(CallStatusMasterModel(taskStatus: "All",),);
                        Selection_CallStatus_Master_list.add(CallStatusMasterModel(taskStatus: "All"));
                      }

                      CallStatus_Master_list.addAll(response);
                      if(filter=='0' && flag=="Call"){
                        Type_of_call_controller.value.text=CallStatus_Master_list[0].taskStatus??"";
                      }

                    }else {
                        CallStatus_Master_list.value=[];
                        Selection_CallStatus_Master_list.value=[];
                    }
                }else{
                  loading.value = false;
                }

        }catch(e){
          loading.value = false;
            print(e);
        }

    }

    CallDSARsMasterApiHit() async {
        try{
            Map<String, String> data={
                "filter_type_of_call": "dsar",
            };
            loading.value=true;
            String onValue = await _api.CallStatusMasterGetApiHit(data, sessionManagement);
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
                }
        }catch(e){loading.value = false;

            print(e);
        }
        /*finally{
          loading.value = false;
        }*/
    }

    MethodOfCallMasterApiHit({String? filter})async{
        try{
            Map<String, String> data={
                "filter_type_of_call": "method",
            };
            loading.value=true;
            String onValue = await _api.CallStatusMasterGetApiHit(data, sessionManagement);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<CallStatusMasterModel> response = jsonResponse.map((e) => CallStatusMasterModel.fromJson(e)).toList();
                    if(response != null && response.length>0 && response[0].condition=="True"){
                      MethodOfCall_Master_list.value=[];
                      Selection_MethodOfCall_Master_list.value=[];
                      if(filter=="0"){
                        //MethodOfCall_Master_list.add(CallStatusMasterModel(taskStatus: "All"));
                        Selection_MethodOfCall_Master_list.add(CallStatusMasterModel(taskStatus: "All"));
                      }
                        MethodOfCall_Master_list.addAll(response);
                      loading.value = false;

                    }else {
                        MethodOfCall_Master_list.value=[];
                        Selection_MethodOfCall_Master_list.value=[];
                        loading.value = false;
                    }
                }

        }catch(e){
          loading.value = false;
            print(e);
        }
       /* finally{
          loading.value = false;
        }*/
    }

    TaskMstDelete(int index) async{
      try {
      Map data = {
            "task_id": Task_Master_list[index].taskId,
            "created_by": email
        };
        print(data);
        loading.value = true;
           String value = await _api.TaskMstDelete(data, sessionManagement);
                    print(value);
                    final JsonResponse = json.decode(value);
                    if (JsonResponse is List) {
                        List<SalesCycleUpdateStatusModal> response =
                        JsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
                        if (response != null && response.length > 0 && response[0].condition == "True") {
                            Task_Master_list.removeAt(index);
                            Utils.sanckBarSuccess('Success Message!',response[0].message.toString());
                            loading.value = false;
                        } else {
                            Utils.sanckBarError("False Message !", response[0].message.toString());
                            //Account_Master_list.value=[];
                            loading.value = false;
                        }
                    } else {
                        Utils.sanckBarException("Api Error!", JsonResponse);
                    }

        } catch (e) {
        loading.value = false;
            print(e);
        }
       /* finally{
          loading.value = false;
        }*/

    }
    getItemCategoryMstApi(String? taskId) async {
        try {
        Map<String, String> data = {
            'task_id': taskId! ,
            'filter_category': ""
        };
        this.loading.value = true;
        String value = await _api.getItemCategoryMstApiHit(data, sessionManagement);

                List<ItemCategoryMstModel> Response =
                (json.decode(value) as List<dynamic>)
                    .map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>))
                    .toList();

                if (Response.isNotEmpty && Response[0].condition.toString() == "True") {
                    Item_Category_master_list.value = Response;
                    loading.value = false;
                } else {
                    Item_Category_master_list.value = [];
                    loading.value = false;
                }
            } catch (e) {
                Item_Category_master_list.value = [];
                print('catch....${e.toString()}');
                loading.value = false;
            }
           /* finally{
                loading.value=false;
            }*/

    }

    getItemCategoryMstApiHit(String? taskId, String? InfraId, String saleCycleId) async {
      try {
        Map<String, String> data = {
            'task_id': taskId! ,
            'filter_category': "",
            'sales_cycle_id': saleCycleId,
            'quote_id': "",
            'infra_lead_no': InfraId==null?"":InfraId
        };
        this.loading.value = true;
        String value = await _api.getItemCategoryInfraMstApiHit(data, sessionManagement);
            print(value);
                List<ItemCategoryMstModel> Response = (json.decode(value) as List<dynamic>)
                    .map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();

                if (Response.isNotEmpty && Response[0].condition?.toLowerCase() == "true") {
                    Item_Category_Infra_list.value = Response;

                    Item_Category_Selected_Infra_list.value = [];
                    for (int i = 0; i < Item_Category_Infra_list.length; i++) {
                        if (Item_Category_Infra_list[i].isSelected == 1) {
                            Item_Category_Selected_Infra_list.add(
                                Item_Category_Infra_list[i]);
                        }}
                    print('master list1....${Item_Category_Infra_list.length.toString()}');
                    loading.value = false;
                } else {
                    Item_Category_Infra_list.value = [];
                    Item_Category_Selected_Infra_list.value = [];
                    loading.value = false;
                    //print('master listelsse1....${Item_Category_Selected_list.length.toString()}');
                }
            }
            catch (e) {
              print('catch....${e.toString()}');
              loading.value = false;
            }
            /*finally{
                loading .value=true;
            }*/
    }

    getCompanyTypeMasterGet() async {
      try {
      Map<String, dynamic> data = {
        "filter_description": "",
        "row_per_page": 999,
        "page_number": 0
      };
      this.loading.value = true;
      String value = await _api.getCompanyTypeMasterGet(data, sessionManagement);
        print("company profile...${value}");

          List<CompanyTypeModal> Response = (json.decode(value) as List<dynamic>)
              .map((i) => CompanyTypeModal.fromJson(i as Map<String, dynamic>)).toList();

          if (Response.isNotEmpty && Response[0].condition?.toLowerCase() == "true") {
            company_profile_type_list.value=Response;
            loading.value = false;
          } else {
            company_profile_type_list.value=[];
            loading.value = false;
          }
        } catch (e) {
        loading.value = false;
          print('catch....${e.toString()}');
        }
        /*finally{
          loading.value=true;
        }*/

    }


    getItemCategoryMstWithoutTaskIdApi() async{
      try {
        Map<String, String> data = {

        };
        this.loading.value = true;
        String value = await _api.getItemCategoryMstWithoutTaskIdApiHit(data, sessionManagement);
                List<ItemCategoryMstModel> Response = (json.decode(value) as List<dynamic>).map((i) =>
                    ItemCategoryMstModel.fromJson(i as Map<String, dynamic>)).toList();
                if (Response.isNotEmpty && Response[0]?.condition.toString() == "True") {
                    Item_Category_master_list_without_task.value = Response!;
                    loading.value = false;
                } else {
                    Item_Category_master_list_without_task.value = [];
                    loading.value = false;
                }
            } catch (e) {
                Item_Category_master_list_without_task.value = [];
                print('catch....${e.toString()}');
                loading.value = false;
            }
            /*finally{
                loading.value=true;
            }*/

    }

    TaskSaleCatCreateApiHit(String flag,String from_page) async {
      try {
        List<TaskSalesProductCategoryLinesModel> lines = Item_Category_Selected_list.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();
        Map<String, dynamic> data = {
            "created_by": email,
            "task_id": TaskID,
            "sales_cycle_id": "",
            "lines": lines.map((line) => line.toJson()).toList(),
        };
        print(data);
        loading.value = true;
            final value = await _api.TaskSaleCatCreateApiHit(data, sessionManagement);
            print(value);
            final JsonResponse = json.decode(value);
            if (JsonResponse is List) {
                List<TaskMasterGetModel> response =
                JsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
                if (response != null && response.isNotEmpty && response[0].condition == "True") {
                  loading.value = false;
                    Utils.sanckBarSuccess("Success!", response[0].message.toString());
                    if(flag == 'Details'){
                        if(from_page=="task_master_detail"){
                          getTaskMaster(0, is_Active.toString(), TaskID, 'task_master_detail', 'GET FROM TASK ID', date_filter, is_done.value);
                        }
                        else{
                          getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                          getItemCategoryMstApi(TaskID);
                        }
                        //todo by raman

                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                    } else if(flag == 'DSAR'){
                      TaskDSARMasterCreate();
                    }
                } else {
                  loading.value = false;
                    Utils.sanckBarError("Error!", "${response[0].message}");
                }
            } else {
              loading.value = false;
                Utils.sanckBarException("Api Error!", JsonResponse.toString());
            }
        } catch (error, stackTrace) {
        loading.value = false;
            print(error);
            print(stackTrace);
            print("Exception....");
        }
       /* finally{
          loading.value = false;
        }*/
    }



    Future<void> getMenuList() async {
        print("GetList");
        await sessionManagement.getUserGeoHierarchy().then((userGeoHierarchy) {
            userGeoHierarchyy.value = userGeoHierarchy;

        });
    }

    getSaleIDByAccountCode(int page_no) async {
        try{
            Map<String, String> data={
                "sales_cycle_id": "",
                "account_code": account_code.value,
                "row_per_page": rowsPerPage.toString(),
                "page_number": page_no.toString()
            };
            print('sale id map data${data}');
            loading.value=true;
           String onValue = await _api.SalesCycleMstGetByAccountCodeApiHit(data, sessionManagement);
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
                }
        }catch(e){
          loading.value = false;
            print(e);
        }
        /*finally{
          loading.value = false;
        }*/
    }

    TaskPersonMstCreateAPI(String flag) async {
      try {
        List<Selectedalongwithpersonnamemodel> personName = SelectedAlongPersonWith_list.map((item) => Selectedalongwithpersonnamemodel(empId: item.empId!)).toList();
        Map<String, dynamic> data = {
            "created_by": email,
            "task_id": TaskID,
            "lines": personName.map((line) => line.toJson()).toList(),
        };
        print(data);
        loading.value = true;
            final value = await _api.TaskPersonMstCreate(data, sessionManagement);
            print(value);
            final JsonResponse = json.decode(value);

            if (JsonResponse is List) {
                List<TaskMasterGetModel> response =
                JsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();

                if (response != null && response.isNotEmpty && response[0].condition == "True") {
                    Utils.sanckBarSuccess("Success!", response[0].message.toString());

                    if(flag == 'Details'){
                        getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                        //todo by raman
                        getTaskPersonMstByTaskIdApi(TaskID);
                        loading.value = false;
                        Get.toNamed(RoutesName.taskMasterDetails_screen);
                    } else if(flag == 'DSAR'){
                      loading.value = false;
                        getTaskMaster(0, 'All', TaskID, "",'', date_filter, is_done.value);
                        getTaskPersonMstByTaskIdApi(TaskID);
                    }

                } else {
                  loading.value = false;
                    Utils.sanckBarError("Error!", "Please select at least single product category");
                }
            } else {
              loading.value = false;
                Utils.sanckBarException("Api Error!", JsonResponse.toString());
            }
        } catch (error, stackTrace) {
            print(error);
            print(stackTrace);
            print("Exception....");
            loading.value = false;
        }
        /*finally{
          loading.value = false;
        }*/
    }



    //todo nirupma code
    gettaskMstInfraUpdate(String InfraNo, String flag) async {
      try {
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
            "name_of_infra_department": nameofInfradepUpdateController.text.isEmpty?"":nameofInfradepUpdate,
            "executive_engineer": executiveEngineerUpdateController.text.isEmpty?"":executiveEn,
            "assistant_engineer": assistantEngineerController.text.isEmpty?"":assistantEn,
            "project_name": nameOfProjectController.text.isEmpty?"":nameOfProjectController.text,
            "location": locationController.text.isEmpty?"":locationController.text,
            "time_period_to_complete_civil_work_in_months": timePeriodToCompleteWorkController.text.isEmpty?"0":timePeriodToCompleteWorkController.text,
            "expected_date_of_completion": expDateOfCompletion??"",
            "project_value": projectValueUpdateController.text.isEmpty?"":projectValueUpdateController.text,
            "expected_revenue": expectedRevenueUpdateController.text.isEmpty?"":expectedRevenueUpdateController.text,
            "furniture_included_in_civil_scope": furnitureIncludedInCivilController.text=="Yes"?1:0,
            "customer_name": customerNameController.text.isEmpty?"":customerName,
            "contact_person_decision_maker": contactPersonHODController.text.isEmpty?"":contactPersonHOD,
            "name_of_agency_contrator": agencyContractorUpdateController.text.isEmpty?"":agencyContractorUpdate,
            "owner_of_contrator": ownerOfContractorController.text.isEmpty?"":ownerOfContractor,
            "project_site_manager": siteManagerController.text.isEmpty?"":siteManager,
            "name_of_architect_firm": nameOfArchitecfirmUpdateController.text.isEmpty?"":nameOfArchitecfirmUpdate,
            "architect": architectUpdateController.text.isEmpty?"":architectUpdate,
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
        this.loading.value = true;
                print(data);
               String onValue = await  _api.taskMstInfraUpdateApiHit(data, sessionManagement);
                    final jsonResponse = json.decode(onValue);
                    print(onValue);
                    if (jsonResponse is List) {
                        List<TaskUpdateInfraModal> response = jsonResponse.map((e) => TaskUpdateInfraModal.fromJson(e))
                            .toList();
                        if (response[0].condition == "True") {
                            Utils.sanckBarSuccess("Message !", response[0].message.toString());
                            getTaskMaster(0, is_Active.toString(), Task_Master_list[0].taskId, '', 'GET FROM TASK ID', date_filter, is_done.value);
                            loading.value = false;
                            if(flag == 'FromDSARPage'){
                                isInfraLeadValueSubmit.value = true;
                                Get.toNamed(RoutesName.addNewDSARTask_screen);
                            }else if(flag == 'FromDetailsPage'){
                                Get.toNamed(RoutesName.taskMasterDetails_screen);
                            }

                            clearInfraUpdateController();
                        } else {
                          loading.value = false;
                            Utils.sanckBarError("False Message !", response[0].message.toString());
                        }
                    }
            } catch (e) {
                Utils.sanckBarException("Message !", e.toString());
                print(e);
                loading.value = false;
            }
            /*finally{
                loading.value = false;
            }*/
        }


    getEmpMstEmailByApi() async{
      try{
        Map<String , String> data = {
            "email_id": email
        };
        print(data);
        loading.value = true;
        String value = await _api.EmpMstEmailByGet(data, sessionManagement);
                print(value);
                final JsonResponse = json.decode(value);
                    if (JsonResponse is List) {
                        List<AlongWithPersonModel> response =
                        JsonResponse.map((e) => AlongWithPersonModel.fromJson(e))
                            .toList();
                        if (response != null &&
                            response.length > 0 &&
                            response[0].condition == "True") {
                          loading.value = false;
                            AlongPersonWith_list.value=response;
                        } else {
                          loading.value = false;
                            AlongPersonWith_list.value=[];
                            Utils.sanckBarError("Error!", "No Data Found");
                            //service_installation_details_list.value=[];
                        }
                    } else {
                      loading.value = false;
                        Utils.sanckBarException("Api Error!", JsonResponse);
                    }
                }catch(e){
        loading.value = false;
                    print(e);
                }/*finally{
                    loading.value = false;
                }*/
    }

    getTaskPersonMstByTaskIdApi(String TaskID) async {
        try{
            Map<String, String> data={
                "task_id": TaskID,
                "along_with_person_name": "",
                "email_id": email,
            };
            loading.value=true;
            String onValue = await _api.TaskPersonMstGetByTaskId(data, sessionManagement);
                print(onValue);
                final jsonResponse = json.decode(onValue);
                if(jsonResponse is List){
                    List<AlongWithPersonModel> response = jsonResponse.map((e) => AlongWithPersonModel.fromJson(e)).toList();
                    if(response!= null && response.length>0 && response[0].condition=="True"){
                        AlongPersonWith_list.value = response;
                        print('asjhdgsau1 ${AlongPersonWith_list.length}');
                        loading.value = false;
                    }else {
                        AlongPersonWith_list.value=[];
                        loading.value = false;
                    }
                }

        }catch(e){
          loading.value = false;
            print(e);
        }
        /*finally{
          loading.value = false;
        }*/
    }

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

         executiveEn = "";
         assistantEn = "";
         contactPersonHOD = "";
         ownerOfContractor = "";
         siteManager = "";
         architectUpdate = "";
         nameofInfradepUpdate = "";
         customerName = "";
         agencyContractorUpdate = "";
         nameOfArchitecfirmUpdate = "";

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

        nameofInfradepUpdateController.text=Task_Master_list[0].actualNameOfInfraDepartment ?? "";
        executiveEngineerUpdateController.text=Task_Master_list[0].actualExecutiveEngineer ?? "";
        assistantEngineerController.text=Task_Master_list[0].actualAssistantEngineer??"";

        customerNameController.text=Task_Master_list[0].actualCustomerName??"";
        contactPersonHODController.text=Task_Master_list[0].actualContactPersonDecisionMaker??"";

        agencyContractorUpdateController.text=Task_Master_list[0].actualNameOfAgencyContrator ?? "";
        ownerOfContractorController.text=Task_Master_list[0].actualOwnerOfContractor??"";
        siteManagerController.text=Task_Master_list[0].actualProjectSiteManager??"";

        architectUpdateController.text=Task_Master_list[0].actualArchitect ?? "";
        nameOfArchitecfirmUpdateController.text=Task_Master_list[0].actualNameOfArchitectFirm ?? "";

        expectedRevenueUpdateController.text=Task_Master_list[0].expectedRevenue.toString();
        valueOfQuoteUpdateController.text=Task_Master_list[0].valueOfQuote.toString();
        dateofcompletioneUpdateController.text=expDateOfCompletion??"";

        nameOfProjectController.text=Task_Master_list[0].projectName??"";
        locationController.text=Task_Master_list[0].location??"";
        timePeriodToCompleteWorkController.text=Task_Master_list[0].timePeriodToCompleteCivilWorkInMonths==null?"":Task_Master_list[0].timePeriodToCompleteCivilWorkInMonths.toString();
        furnitureIncludedInCivilController.text=Task_Master_list[0].furnitureIncludedInCivilScope==1 ? "Yes":"No";
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
        Type_of_call_controller.value.clear();
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

    Selection_CallStatus_Master_list.value=[];
    Selection_MethodOfCall_Master_list.value=[];
    selected_company_type_list.value=[];
    Selected_Item_Category_master_list_without_task.value=[];
    selectedDSARStatusList.value=[];
       product_category_type_Controller.value.text="Contains";
       account_code_controller.clear();
       account_Name_controller.clear();
       companyProfileTypeController.value.clear();
       postalCodeController.value.clear();
       district_controller.value.clear();
       approved_by_controller.value.clear();
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
       //account_owner_controller.value.clear();
       Type_of_call_controller.value.clear();
       Method_of_call_controller.clear();
       Sale_cycle_Id_controller.clear();
       filterTask_Id_controller.clear();
       isInfraLeadFilterController.text = "No";
       //Task_status_controller.clear();
       filterTaskDuedateController.value.clear();
       filterTaskCreationOnController.value.clear();
       filterTaskCreationOn_from_to_date_Controller.value.clear();
       createdOnStartToEnd.value = "";
       Task_status_controller.text = "All";
       SaleCycleActive_Controller.text = "All";
       AccountOwnerForApi = '';
       AccountOwner_controller.value.clear();
       accountNameCode='';
       searchController.value.clear();
       if(isAdminWritePermission=="1") {
         EmployeeMasterGet("");
       }
       SelectedEmployee_Member_list.value = [];

      SelectedCluster_list.value=[];
      SelectedRegion_list.value=[];
     filterAlongWithPersonNameController.value.clear();
      SelectedAlongPersonWith_list.value=[];
      //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
      clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');

    getRegionsWithClusterFilterGetByEmail();

  }

    RxString filterDataChecker = ''.obs;

    void SaveFilterData() async{
      await sessionManagement.saveTaskData({
        'Task_status_controller': Task_status_controller.value.text,
        'task_id': filterTask_Id_controller.value.text,
        'customer_name': account_Name_controller.value.text,
        'customer_code': account_code_controller.value.text,
        'Type_of_call_controller': Type_of_call_controller.value.text,
        'method_of_call_controller': method_of_call_controller.value.text,
        'company_Profile_Type_Controller': companyProfileTypeController.value.text,
        'lastActivityStatus_Controller': lastActivityStatus_Controller.value.text,
        'SaleCycleActive_Controller': SaleCycleActive_Controller.value.text,
        'Sale_cycle_Id_controller': Sale_cycle_Id_controller.value.text,
        'filterTaskDuedateController': filterTaskDuedateController.value.text,
        'createdOnStartToEnd': createdOnStartToEnd.value,
        'pin_code': postalCodeController.value.text,
        'district': district_controller.value.text,
        'region_name': RegionName_controller.value.text,
        'cluster_name': clusterName_controller.value.text,
        'account_owner': AccountOwner_controller.value.text,
        'accountNameCode': accountNameCode,
        'filterTaskCreationOnController': filterTaskCreationOnController.value.text,
        'filterTaskCreationOn_from_to_date_Controller': filterTaskCreationOn_from_to_date_Controller.value.text,
        'product_category': product_category_controller.value.text,
        'product_category_type': product_category_type_Controller.value.text,
        'approved_by_controller': approved_by_controller.value.text,
      });
      filterDataChecker.value='';
      print("Cluster data region data ${clusterName_controller.value.text} ${RegionName_controller.value.text}");
      getTaskMaster(pageNumber, is_Active.toString(), '', '', Task_status_controller.text.toString(), date_filter, is_done.value);

    }

    void getFilterData() async{
      Map getFilterData=await sessionManagement.getTaskData();

      if(getFilterData.isNotEmpty){
        filterDataChecker.value='1';
        Task_status_controller.text=getFilterData["Task_status_controller"]??"";
        filterTask_Id_controller.text=getFilterData["task_id"]??"";
        account_Name_controller.text=getFilterData["customer_name"]??"";
        account_code_controller.text=getFilterData["customer_code"]??"";
        Type_of_call_controller.value.text=getFilterData["Type_of_call_controller"]??"";
        method_of_call_controller.value.text=getFilterData["method_of_call_controller"]??"";
        companyProfileTypeController.value.text=getFilterData["company_Profile_Type_Controller"]??"";
        lastActivityStatus_Controller.value.text=getFilterData["lastActivityStatus_Controller"]??"";
        SaleCycleActive_Controller.text=getFilterData["SaleCycleActive_Controller"]??"";
        Sale_cycle_Id_controller.text=getFilterData["Sale_cycle_Id_controller"]??"";
        filterTaskDuedateController.value.text=getFilterData["filterTaskDuedateController"]??"";
        createdOnStartToEnd.value=getFilterData["createdOnStartToEnd"]??"";
        postalCodeController.value.text=getFilterData["pin_code"]??"";
        district_controller.value.text=getFilterData["district"]??"";
        AccountOwner_controller.value.text=getFilterData["account_owner"]??"";
        accountNameCode=getFilterData["accountNameCode"]??"";
        filterTaskCreationOnController.value.text=getFilterData["filterTaskCreationOnController"]??"";
        filterTaskCreationOn_from_to_date_Controller.value.text=getFilterData["filterTaskCreationOn_from_to_date_Controller"]??"";
        product_category_controller.value.text=getFilterData["product_category"]??"";
        product_category_type_Controller.value.text=getFilterData["product_category_type"]??"";
        approved_by_controller.value.text=getFilterData["approved_by_controller"]??"";

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
      getTaskMaster(pageNumber, is_Active.toString(), '', '', Task_status_controller.text.toString(), date_filter, is_done.value);

    }

    void clearFilterData() {
      filterDataChecker.value='';
      sessionManagement.clearTaskData();
    }
}