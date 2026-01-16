

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesCyclePendingForApprovalVm extends GetxController{

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  String isAdminWritePermission = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;
  RxList<SalesCycleModal> saleCyclePendingForApprovalList = <SalesCycleModal>[].obs;
  RxList<String> SaleCycleStatusList =
      ["All", "Suspect", "Prospect", "Propose"].obs;
  RxList<String> customerNeedIdentityList = ["Yes", "No"].obs;

  var createdOnCnontroller = TextEditingController().obs;
  RxString createdOnStartToEnd = "".obs;
  RxString extClosureStartToEnd = "".obs;
  RxString quoteValidityStartToEnd = "".obs;
  var isCommitController = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;
  var createdByController = TextEditingController().obs;
  var district_controller = TextEditingController().obs;
  var postalCodeController = TextEditingController().obs;
  var companyProfileTypeController = TextEditingController().obs;
  var filterTask_Id_controller = TextEditingController().obs;
  var accountCodeController = TextEditingController().obs;
  var accountNameController = TextEditingController().obs;
  var saleCycleController = TextEditingController().obs;
  var productCategoryController = TextEditingController().obs;
  var purchaseProcessController = TextEditingController().obs;
  var salesCycleOwnerController = TextEditingController().obs;
  var solutionAcceptedController = TextEditingController().obs;
  var proposedSolutionController = TextEditingController().obs;
  var SaleCycleStatusController = TextEditingController().obs;
  var ApprovalStatusController = TextEditingController().obs;
  var filterExpectedClosuredateController = TextEditingController().obs;
  var product_category_type_Controller = TextEditingController().obs;
  //var reporting_manager_Controller = TextEditingController().obs;

  var AccountOwnerForApi;
  var AccountOwner_controller=TextEditingController().obs;

  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;
  RxList<CompanyTypeModal> company_profile_type_list = <CompanyTypeModal>[].obs;
  RxList<CompanyTypeModal> selected_company_type_list = <CompanyTypeModal>[].obs;
  RxList<ItemCategoryMstModel> Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> Selected_Item_Category_master_list_without_task = <ItemCategoryMstModel>[].obs;
  RxList<String> productCategoryTypeList = <String>["Contains","Equals To"].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    product_category_type_Controller.value.text="Contains";
    getItemCategoryMstWithoutTaskIdApi();
    getCompanyTypeMasterGet();
    if(this.isAdminWritePermission==1){
      EmployeeMasterGet('');
    }
    else{
      getEmployeeMemberApi();
    }
    //getsalesCycleData(pageNumber);
    getClustersGetByEmail();

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
  getCompanyTypeMasterGet() {
    this.loading.value = true;
    Map<String, dynamic> data = {
      "filter_description": "",
      "row_per_page": 999,
      "page_number": 0
    };

    _api.getCompanyTypeMasterGet(data, sessionManagement).then((value) {
      print("company profile...${value}");
      try {
        List<CompanyTypeModal> Response =
        (json.decode(value) as List<dynamic>)
            .map((i) => CompanyTypeModal.fromJson(i as Map<String, dynamic>))
            .toList();

        if (Response.isNotEmpty && Response[0].condition?.toLowerCase() == "true") {
          company_profile_type_list.value=Response;
        } else {
          company_profile_type_list.value=[];
        }
      } catch (e) {
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
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
                  clusterGetByEmailList.value.map((e) => e.geoValue).join('|');
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
            getFilterData();
            //getsalesCycleData(pageNumber);

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

  getsalesCycleData(int page_no) {
    try {
      AccountOwnerForApi = '';
      if(AccountOwner_controller.value.text.isNotEmpty){
        AccountOwnerForApi = AccountOwner_controller.value.text.split(',').map((e) => e.trim()).join('|');
      }
      Map data = {
        "filter_sales_cycle_id":saleCycleController.value.text.isEmpty?"" : saleCycleController.value.text,
        "filter_task_id": filterTask_Id_controller.value.text.isEmpty ? "" : filterTask_Id_controller.value.text,
        "filter_account_code": accountCodeController.value.text.isEmpty ? "" : accountCodeController.value.text,
        "filter_account_name": accountNameController.value.text.isEmpty ? "" : accountNameController.value.text,
        "filter_sales_cycle_owner": isAdminWritePermission=="1"?"":email,
        "filter_product_category": productCategoryController.value.text.isEmpty ? "" : productCategoryController.value.text,
        "filter_product_category_type": product_category_type_Controller.value.text.isEmpty?"":product_category_type_Controller.value.text,
        "filter_purchase_process": purchaseProcessController.value.text.isEmpty ? "" : purchaseProcessController.value.text,
        "filter_proposed_solution": proposedSolutionController.value.text.isEmpty ? "" : proposedSolutionController.value.text,
        "filter_expected_closure_date": extClosureStartToEnd.value.isEmpty ? "" : extClosureStartToEnd.value,
        "filter_sales_cycle_status": SaleCycleStatusController.value.text.isEmpty || SaleCycleStatusController.value.text == 'All' ? '' : SaleCycleStatusController.value.text,
        "filter_sales_cycle_approval_status":"PENDING FOR APPROVAL",
        "filter_sales_cycle_quote_accepted":"",
        "is_commit": isCommitController.value.text.isEmpty ? -1 : (isCommitController.value.text == "Yes" ? 1 : 0),
        "filter_solution_accepted": solutionAcceptedController.value.text.isEmpty ? -1 : (solutionAcceptedController.value.text == "Yes" ? 1 : 0),
        "filter_created_by": createdByController.value.text.isEmpty ? "" : createdByController.value.text,
        "filter_approved_by": "",
        "filter_created_on": createdOnCnontroller.value.text.isEmpty ? "" : createdOnCnontroller.value.text,
        "filter_company_profile_type": companyProfileTypeController.value.text.isEmpty ? "" : companyProfileTypeController.value.text,
        "filter_postal_code": postalCodeController.value.text.isEmpty ? "" : postalCodeController.value.text,
        "filter_district": district_controller.value.text.isEmpty ? "" : district_controller.value.text,
        "filter_frontliner_value": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty ? "" : RegionName_controller.value.text,
        "filter_zone_head_value": "",
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty ? "" : clusterName_controller.value.text,
        "item_code_name": "",
        "filter_sales_cycle_owner_new": AccountOwnerForApi.isEmpty?"":AccountOwnerForApi,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
      loading.value = true;
      _api.SalesCycleMstGetApprovalList(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<SalesCycleModal> response =
            jsonResponse.map((e) => SalesCycleModal.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              print('listSize.....${saleCyclePendingForApprovalList.length}');
              loading.value = false;
              if (page_no == 0) {
                saleCyclePendingForApprovalList.clear();
              }
              saleCyclePendingForApprovalList.addAll(response);
              total_rows = int.parse(saleCyclePendingForApprovalList[0].totalRows!);
            } else {
              loading.value = false;
              saleCyclePendingForApprovalList.value = [];
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
  void clearAllFieldOfFilter() {
    print("Clear Filed");
    product_category_type_Controller.value.text="Contains";
    selected_company_type_list.value=[];
    Selected_Item_Category_master_list_without_task.value=[];
    saleCycleController.value.clear();
    salesCycleOwnerController.value.clear();
    filterTask_Id_controller.value.clear();
    accountNameController.value.clear();
    accountCodeController.value.clear();
    salesCycleOwnerController.value.clear();
    productCategoryController.value.clear();
    purchaseProcessController.value.clear();
    companyProfileTypeController.value.clear();
    isCommitController.value.clear();
    solutionAcceptedController.value.clear();
    proposedSolutionController.value.clear();
    postalCodeController.value.clear();
    district_controller.value.clear();
    RegionName_controller.value.clear();
    clusterName_controller.value.clear();
    createdByController.value.clear();
    filterExpectedClosuredateController.value.clear();
    createdOnCnontroller.value.clear();
    createdOnStartToEnd.value = "";
    extClosureStartToEnd.value = "";
    SaleCycleStatusController.value.text = 'All';
    ApprovalStatusController.value.text = 'All';

    AccountOwnerForApi = '';
    AccountOwner_controller.value.clear();
    SelectedEmployee_Member_list.value = [];
  }


  Future<void> refreshList() async {
    pageNumber = 0;
    getsalesCycleData(pageNumber);
  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveSaleCycleApproverData({
      'sale_cycle_stage': SaleCycleStatusController.value.text,
      'sale_cycle_id': saleCycleController.value.text,
      'task_id': filterTask_Id_controller.value.text,
      'customer_name': accountNameController.value.text,
      'customer_code': accountCodeController.value.text,
      'purchase_process': purchaseProcessController.value.text,
      'company_profile_type': companyProfileTypeController.value.text,
      'is_commit': isCommitController.value.text,
      'solution_accepted': solutionAcceptedController.value.text,
      'pin_code': postalCodeController.value.text,
      'district': district_controller.value.text,
      'expected_closure_date': filterExpectedClosuredateController.value.text,
      'extClosureStartToEnd': extClosureStartToEnd.value,
      'createdOn_Controller': createdOnCnontroller.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'account_owner': AccountOwner_controller.value.text,
      'product_category': productCategoryController.value.text,
      'product_category_type': product_category_type_Controller.value.text,

    });
    filterDataChecker.value='';
    getsalesCycleData(pageNumber,);
  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getSaleCycleApproverData();



    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      SaleCycleStatusController.value.text=getFilterData["sale_cycle_stage"];
      saleCycleController.value.text=getFilterData["sale_cycle_id"];
      filterTask_Id_controller.value.text=getFilterData["task_id"];
      accountNameController.value.text=getFilterData["customer_name"];
      accountCodeController.value.text=getFilterData["customer_code"];
      purchaseProcessController.value.text=getFilterData["purchase_process"];
      companyProfileTypeController.value.text=getFilterData["company_profile_type"];
      isCommitController.value.text=getFilterData["is_commit"];
      solutionAcceptedController.value.text=getFilterData["solution_accepted"];
      postalCodeController.value.text=getFilterData["pin_code"];
      district_controller.value.text=getFilterData["district"];
      filterExpectedClosuredateController.value.text=getFilterData["expected_closure_date"];
      extClosureStartToEnd.value=getFilterData["extClosureStartToEnd"];
      createdOnCnontroller.value.text=getFilterData["createdOn_Controller"];
      AccountOwner_controller.value.text=getFilterData["account_owner"];
      productCategoryController.value.text=getFilterData["product_category"];
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
    pageNumber=0;
    getsalesCycleData(pageNumber,);

  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearSaleCycleApproverData();
  }

}