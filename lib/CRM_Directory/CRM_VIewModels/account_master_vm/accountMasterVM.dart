import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../locat_database/databaseHelper.dart';
import '../../../models/employeeDetail/employee_details_model.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/AccoundDashboardData_Model.dart';
import '../../CRM_Models/AccountMaster_model/AccountDashboardCountModel.dart';
import '../../CRM_Models/AccountMaster_model/AccountDashboardDataSale_models.dart';
import '../../CRM_Models/AccountMaster_model/AccountMstrGet_Model.dart';
import '../../CRM_Models/AccountMaster_model/Account_Draft_model.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/AccountMaster_model/CompanyTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/Company_Prof_Mst_Model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/State_master_model.dart';
import '../../CRM_Models/AccountMaster_model/Tat_Response_model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/Address_Master_Model/PincodeMaster_Model.dart';
import '../../CRM_Models/Address_Master_Model/PostalCode_Model.dart';
import '../../CRM_Models/Address_Master_Model/address_master_model.dart';
import '../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_quote_header_modal.dart';
import '../../CRM_Repository/AccountMaster_Repository/account_master_repo.dart';
import '../../CRM_View/Account_Master_view/AccountTaskHistoryModel.dart';
import '../Task_master_vm/TaskMasterVM.dart';
import '../contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../sales_cycle_vm/sales_cycle_vm.dart';

class Accountmastervm extends GetxController{

  final _api=AccountMasterRepo();
  final salesCycleController=Get.put(SalesCycleVm());

  final TaskMaster_page_controller=Get.put(Taskmastervm());
  DatabaseHelper crmDatabase = DatabaseHelper();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  RxBool UploadImage=false.obs;
  RxBool compProfileRemrk=false.obs;
  RxBool isReferral=false.obs;
  RxBool GstRegistration=false.obs;
  RxString ButtonText = 'Choose files'.obs;
  int is_Active = -1;
  var selectedItem = (-1).obs;
  String consigneeId="";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxString FromPage="".obs;
  RxString isAdminWritePermission = "".obs;
  RxString isHeadofficePermission = "".obs;
  String email="";
  String UserName="";
  String accountName='';
  String AccountOwner = '';
  String tatResponseType = '', SalesRepresentativeEmail = '', RegionalHeadEmail = '';
  String AccountCode = '';
  RxString GstStateCode = ''.obs;
  RxString GovtStateCode = ''.obs;
  RxString GstPanNo = ''.obs;
  String no_of_employees_min = '';
  String no_of_employees_max = '';
  String annual_revenue_min = '';
  String annual_revenue_max = '';
  String flag = '';
  String day_flag = '';
  String WonLoss = '';
  String DraftId = '';
  RxBool isChecked = false.obs;
  RxBool isExpandDetails = true.obs;
  RxBool isExpandSales = true.obs;
  RxBool isExpandQuotation = true.obs;
  RxBool isExpandDSARHistory = true.obs;
  Size size=Get.size;
  Rx<CustomList> custome_selection=new CustomList().obs;

  RxBool ShowState=true.obs;
  RxBool ShowState1=true.obs;

  //String view ="";
  String view ="Account";


  RxString upLoadLocalImages="".obs;
  RxString ImageString=''.obs;
  final ImagePicker _picker = ImagePicker();
  //RxString flag="Update".obs;

  var account_name_controller = TextEditingController();
  var account_code_controller = TextEditingController();
  var AccountOwner_controller=TextEditingController().obs;
  var account_type_controller = TextEditingController();
  var account_cat_type_controller = TextEditingController();
  var gst_registration_type_controller = TextEditingController().obs;
  var comp_prof_type_controller = TextEditingController();
  var comp_prof_sub_type_controller = TextEditingController().obs;
  var comp_prof_remarks_controller = TextEditingController();
  var Address_controller = TextEditingController();
  var IsActive_controller = TextEditingController();
  var UploadImageType_controller = TextEditingController();
  var stateName_controller = TextEditingController();
  var ImageUrl_Controller = TextEditingController();
  var CompProfileDescription_Controller = TextEditingController();
  var EmployeeMember_Controller = TextEditingController();
  var AccountTitle_Controller = TextEditingController();
  var PhoneNo_Controller = TextEditingController();
  var Alternate_PhoneNo_Controller = TextEditingController();
  var EmailId_Controller = TextEditingController();
  var Website_Controller = TextEditingController();
  var ReferralBy_Controller = TextEditingController();
  var ReferralByName_Controller = TextEditingController();
  var GstNo_Controller = TextEditingController();
  var PanNo_Controller = TextEditingController();
  var IfscCode_Controller = TextEditingController();
  var OldCRMAccountNo_Controller = TextEditingController();
  var No_Of_Emp_Controller = TextEditingController();
  var Address2_Controller = TextEditingController();
  var PostCode_Controller = TextEditingController();
  var State_Controller = TextEditingController();
  var City_Controller = TextEditingController();
  var District_Controller = TextEditingController();
  var FullAddress_Controller = TextEditingController().obs;
  var Shipping_FullAddress_Controller = TextEditingController().obs;
  var Annual_Revenue_Controller = TextEditingController();
  var Sale_Representative_Controller = TextEditingController().obs;
  var Regional_service_head_Controller = TextEditingController().obs;
  var TatResponse_Controller = TextEditingController();

  var Frontliner_Controller = TextEditingController();
  var BranchHead_Controller = TextEditingController();
  var ZoneHead_Controller = TextEditingController();
  var ClusterHead_Controller = TextEditingController();


  //todo shipping address
  var Shipping_Address_controller = TextEditingController().obs;
  var Shipping_Address2_Controller = TextEditingController().obs;
  var Shipping_PostCode_Controller = TextEditingController().obs;
  var Shipping_State_Controller = TextEditingController().obs;
  var Shipping_City_Controller = TextEditingController().obs;
  var Shipping_District_Controller = TextEditingController().obs;
  var AddressContactFilter_Controller = TextEditingController().obs;

   int InActive=0;


  RxList<AccountMasterModel> Account_Master_list=<AccountMasterModel>[].obs;
  RxList<AccountMasterGetByCodeModel> Account_Master_Draft_list1=<AccountMasterGetByCodeModel>[].obs;
  List<AccountDraftModel> Account_Master_Draft_list=<AccountDraftModel>[];
  RxList<GetMasterTypeModel> get_Acc_category_list=<GetMasterTypeModel>[].obs;
  RxList<CustomList> get_Acc_type_list=<CustomList>[].obs;
  RxList<CompanyTypeModel > get_Comp_Profile_type_list=<CompanyTypeModel >[].obs;
  RxList<CustomList> get_Gst_Registration_list=<CustomList>[].obs;
  RxList<String> IsActiveTypeList = <String>[].obs;
  RxList<String> NoOfEmpListFilter = <String>[].obs;
  RxList<String> AnnualRevenueListFilter = <String>[].obs;
  RxList<String> UploadImageTypeList = <String>[].obs;
  RxList<String> IsActiveTypeAllList = <String>[].obs;
  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<PostalCodeModel> geoPostal_Code_list = <PostalCodeModel>[].obs;
  RxList<CompanyProfileMstModel> CompanyProfileMst_list = <CompanyProfileMstModel>[].obs;
  RxList<AddressMasterModel> AddressMst_list = <AddressMasterModel>[].obs;
  RxList<StateMasterListModel> StateMaster_list = <StateMasterListModel>[].obs;
  RxList<PincodeMasterModel> StateMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> CityMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> DistrictMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> ShippingStateMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> ShippingCityMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> ShippingDistrictMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<StateMasterListModel> GstStateList = <StateMasterListModel>[].obs;
  RxList<TatResponseModel> TatResponseMaster_list = <TatResponseModel>[].obs;
  RxList<AccountMasterGetByCodeModel> AccountMasterGetCode_list = <AccountMasterGetByCodeModel>[].obs;
  RxList<ContactMstGetListModal> view_contract_list = <ContactMstGetListModal>[].obs;
  RxList<AccountDashboardCountModel> accountDashBoardCount = <AccountDashboardCountModel>[].obs;
  RxList<Task> accountDashBoardTaskCount = <Task>[].obs;
  RxList<Sales> accountDashBoardSalesCount = <Sales>[].obs;
  RxList<Quotation> accountDashBoardQuotationCount = <Quotation>[].obs;
  RxList<AccountTaskHistoryModel> AccountTaskHistoryList = <AccountTaskHistoryModel>[].obs;
  RxList<AccountDashboardDataModel> AccountDashboardDataList = <AccountDashboardDataModel>[].obs;
  RxList<AccountdashboarddatasaleModelsModel> AccountDashboardDataSalesList = <AccountdashboarddatasaleModelsModel>[].obs;
  RxList<SalesCycleQuoteHeaderModal> AccountDashboardDataQuotationList = <SalesCycleQuoteHeaderModal>[].obs;
  RxList<AddressMasterModel> address_master_list = <AddressMasterModel>[].obs;
  List<UserGeoHierarchy> userGeoHierarchyy = <UserGeoHierarchy>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;


  //todo new filter controller
  //var account_code_controller = TextEditingController().obs;
  var postal_code_controller = TextEditingController().obs;
  var district_controller = TextEditingController().obs;
  var created_by_controller = TextEditingController().obs;
  var frontliner_controller = TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var zone_head__value_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;
  var created_on_controller = TextEditingController().obs;


  var AccountOwnerForApi;
  String filterRouting= '';


  @override
  void onInit() async {
    super.onInit();

    email=await sessionManagement.getEmail() ?? '';
    UserName=await sessionManagement.getName() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadofficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    print("isAd.... ${isHeadofficePermission} and ${isAdminWritePermission}");
    getClustersGetByEmail();
    //getAccountMaster(pageNumber ,is_Active.toString());
    //getDraftAccountMaster(pageNumber ,is_Active.toString());
    getAccCategoryApi();
    getAccountTypeApi();
    getCompanyProfileTypeApi("");
    //getCompanyProfileSubTypeApi();
    getGstRegistrationTypeApi();
    //IsActive_controller.text = 'All';
    IsActiveTypeList.value = ['Yes', 'No'];
    AnnualRevenueListFilter.value = ['0-500000', '500000-1000000', '1000000-25000000' ,'2500000-Above'];
    NoOfEmpListFilter.value = ['0-25', '25-50', '50-100' ,'100-Above'];
    IsActiveTypeAllList.value = ['All','Yes', 'No'];
    UploadImageTypeList.value = ['Upload Image','Url'];
    getEmployeeMemberApi();
    getGeoPostalCodeApi();
    getSateListApi();
    getTatResponseMasterApi();
    if(this.isAdminWritePermission==1){
      EmployeeMasterGet('');
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

  AccountMstDelete(String? account_code, int index) {
    Map data = {
      "account_code": account_code,
      "created_by": email
    };
    print(data);
    loading.value = true;
    try {
      _api.AccountMstDelete(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<AccountMasterModel> response =
            JsonResponse.map((e) => AccountMasterModel.fromJson(e)).toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Account_Master_list.removeAt(index);
              Utils.sanckBarSuccess('Success Message!',response[0].message.toString());

            } else {
              loading.value = false;
              Utils.sanckBarError("False Message !", response[0].message.toString());
              //Account_Master_list.value=[];
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
      print(e);
    }
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void toggle() {
    isExpandDetails.value = !isExpandDetails.value;
  }

  void toggleSales() {
    isExpandSales.value = !isExpandSales.value;
  }

  void toggleQuotation() {
    isExpandQuotation.value = !isExpandQuotation.value;
  }
  void toggleDSARHistory() {
    isExpandDSARHistory.value = !isExpandDSARHistory.value;
  }

  void clearAccoundController(){
    account_name_controller.text = '';
    account_type_controller.text = '';
    account_cat_type_controller.text = '';
    PhoneNo_Controller.text = '';
    EmailId_Controller.text = '';
    comp_prof_type_controller.text = '';
    Address_controller.text = '';
    stateName_controller.text = '';
  }
  void clearAccountCreateController(){
    account_name_controller.text = '';
    account_type_controller.text = '';
    account_cat_type_controller.text = '';
    EmailId_Controller.text="";
    AccountTitle_Controller.text="";
    ImageUrl_Controller.text="";
    comp_prof_type_controller.text = '';
    Website_Controller.text="";
    ReferralBy_Controller.text="";
    Address_controller.text = '';
    stateName_controller.text = '';
    PhoneNo_Controller.text="";
    comp_prof_sub_type_controller.value.text="";
    Address2_Controller.text="";
    PostCode_Controller.text="";
    State_Controller.text="";
    City_Controller.text="";
    District_Controller.text="";
    No_Of_Emp_Controller.text="";
    Annual_Revenue_Controller.text="";
    TatResponse_Controller.text="";
    Sale_Representative_Controller.value.text = "";
    Regional_service_head_Controller.value.text ="";

  }

  Future<void>refreshList() async{
    clearAccoundController();
    getAccountMaster(pageNumber ,'All');
  }

  Future<void>refreshDraftList() async{
    clearAccoundController();
    getDraftAccountMaster(pageNumber ,'All');
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
            if(filterRouting=="Account Draft"){
              RegionName_controller.value.text="";
              clusterName_controller.value.text="";
              getdraftFilterData();
            }
            else if(filterRouting=="Accounts Master"){
              getFilterData();
            }
            //getAccountMaster(pageNumber ,is_Active.toString());
            
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

   getAccountMaster(int page_no, String IsActive)  {
    if(IsActive == 'All'){
      is_Active = -1;
    }else if( IsActive == 'Yes'){
      is_Active = 1;
    }else if(IsActive == 'No'){
      is_Active = 0;
    }
    AccountOwnerForApi = '';
    if(AccountOwner_controller.value.text.isNotEmpty){
      AccountOwnerForApi = AccountOwner_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('|');
    }
    print('isActiveInAPi...${is_Active}');
    print('is Admin.....${isAdminWritePermission}');
    try{
      Map<String, String> data={
        "filter_account_code":account_code_controller.value.text.isEmpty?"":account_code_controller.value.text,
        "filter_account_name": account_name_controller.value.text.isEmpty?"":account_name_controller.value.text,
        "filter_account_type": account_type_controller.value.text.isEmpty?"":account_type_controller.value.text,
        "filter_account_owner_new": AccountOwnerForApi.isEmpty?"":AccountOwnerForApi,
        "filter_email_id": EmailId_Controller.value.text.isEmpty?"":EmailId_Controller.value.text,
        "filter_phone_no":  PhoneNo_Controller.value.text.isEmpty?"":PhoneNo_Controller.value.text,
        "filter_company_profile_type": comp_prof_type_controller.value.text.isEmpty?"":comp_prof_type_controller.value.text,
        "filter_state_name": stateName_controller.value.text.isEmpty?"":stateName_controller.value.text,
        "filter_postal_code": postal_code_controller.value.text.isEmpty?"":postal_code_controller.value.text,
        "filter_district": district_controller.value.text.isEmpty?"":district_controller.value.text,
        "filter_created_by": created_by_controller.value.text.isEmpty?"":created_by_controller.value.text,
        "filter_account_owner": isAdminWritePermission == '0'?email:'',
        "filter_frontliner_value": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value": "",
        "filter_created_on": created_on_controller.value.text.isEmpty?"":created_on_controller.value.text,
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "filter_is_active": is_Active.toString(),
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no.toString()
      };
      loading.value=true;
      _api.AccountMasterGetApiHit(data, sessionManagement).then((onValue){
        print(onValue);
         final jsonResponse = json.decode(onValue);
         if(jsonResponse is List){
           List<AccountMasterModel> response = jsonResponse.map((e) => AccountMasterModel.fromJson(e)).toList();
           if(response!= null && response.length>0 && response[0].condition=="True"){
              if(page_no==0){
                Account_Master_list.clear();
              }
             Account_Master_list.addAll(response);
             total_rows=int.parse(Account_Master_list[0].totalRows!);

           }else {
             Account_Master_list.value=[];

           }
         }
      },
      ).onError((error, stackTrace) {
        loading.value=false;
        Utils.sanckBarException("Error!", error.toString());
          print(error);
        },
      );
    }catch(e){
      Utils.sanckBarException("Api Error!",' API error' );
      print(e);
    }
    finally{
      loading.value = false;
    }
   }

  getEmployee(String AccOwnerEmail){
    Map  data=
    {
      "email_id":AccOwnerEmail,
    };
    loading.value=true;
    print(data);
    _api.EmployeeGetDashBoardApiHit(data, sessionManagement).then((value) {
      print(value);
      final JsonResponse=json.decode(value);
      if(JsonResponse is List){
        List<EmployeeDetailsGetResponse> response=JsonResponse.map((e)
        =>EmployeeDetailsGetResponse.fromJson(e)).toList();
        if(response!=null && response.length>0 && response[0].condition=="True"){
          loading.value=false;
          if(response[0].userGeoHierarchy != null){
            userGeoHierarchyy = response[0].userGeoHierarchy!;
            for(int i = 0; i<userGeoHierarchyy.length; i++){
              if(AccOwnerEmail == userGeoHierarchyy[i].approverEmail){
                int pos = i - 1;
                int pos2 = i - 2;
                print("RegionalHead ${pos > -1 ? userGeoHierarchyy[pos].approvedFullName : ""}");
                Regional_service_head_Controller.value.text = pos > -1 ?userGeoHierarchyy[pos].approvedFullName.toString():"";
                RegionalHeadEmail = pos > -1 ?userGeoHierarchyy[pos].approverEmail.toString():"";
                print("SalesRepre.. ${pos2 > -1 ? userGeoHierarchyy[pos2].approvedFullName : ""}");
                Sale_Representative_Controller.value.text = pos2 > -1 ?userGeoHierarchyy[pos2].approvedFullName.toString():"";
                SalesRepresentativeEmail = pos2 > -1 ?userGeoHierarchyy[pos2].approverEmail.toString():"";
              }
            }
          }else{
            Regional_service_head_Controller.value.text = "";
            Sale_Representative_Controller.value.text = "";
          }

        }else {
          loading.value=false;

        }
      }else{
        loading.value=false;
        Utils.sanckBarException("Api Error!", JsonResponse);
      }
    },).onError((error, stackTrace) {
      loading.value=false;
      print(error);
    },);


  }

  getDraftAccountMaster(int page_no, String IsActive){
    if(IsActive == 'All'){
      is_Active = -1;
    }else if( IsActive == 'Yes'){
      is_Active = 1;
    }else if(IsActive == 'No'){
      is_Active = 0;
    }
    print('isActiveInAPi...${is_Active}');
    try{
      Map<String, String> data={
        "filter_account_code": account_code_controller.text.isEmpty?"":account_code_controller.text,
        "filter_account_name": account_name_controller.text.isEmpty?"":account_name_controller.text,
        "filter_account_type": account_type_controller.text.isEmpty?"":account_type_controller.text,
        "filter_email_id": EmailId_Controller.text.isEmpty?"":EmailId_Controller.text,
        "filter_phone_no": PhoneNo_Controller.value.text.isEmpty?"":PhoneNo_Controller.value.text,
        "filter_company_profile_type":comp_prof_type_controller.value.text.isEmpty?"":comp_prof_type_controller.value.text ,
        "filter_state_name": stateName_controller.value.text.isEmpty?"":stateName_controller.value.text,
        "filter_postal_code": postal_code_controller.value.text.isEmpty?"":postal_code_controller.value.text,
        "filter_district": district_controller.value.text.isEmpty?"":district_controller.value.text,
        "filter_created_by": created_by_controller.value.text.isEmpty?"":created_by_controller.value.text,
        "filter_account_owner":isAdminWritePermission == '0'?email:'' ,
        "filter_frontliner_value": "",
        "filter_branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "filter_zone_head_value": "",
        "filter_clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no.toString()
      };
      print("Pro/////////${data}");
      loading.value=true;
      _api.DraftAccountMstGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AccountMasterGetByCodeModel> response = jsonResponse.map((e) => AccountMasterGetByCodeModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            print("last index account master length ${response.length}");
            if(page_no==0){
              Account_Master_Draft_list1.clear();
            }
            Account_Master_Draft_list1.addAll(response);
            print('DraftList...${Account_Master_Draft_list1.length}');
            total_rows=int.parse(Account_Master_Draft_list1[0].totalRows!);

          }else {
            loading.value = false;
            Account_Master_Draft_list1.value=[];

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

  getAccCategoryApi() {
    this.loading.value = true;
    Map<String, String> data = {};

    _api.getAccountCategoryTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0].condition.toString() == "True") {
          get_Acc_category_list.value = emp_masterResponse;
          print('master list....${get_Acc_category_list.length.toString()}');
        } else {
          get_Acc_category_list.value = [];
          print('master listelsse....${get_Acc_category_list.length.toString()}');
        }
      } catch (e) {
        get_Acc_category_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      get_Acc_category_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }

  getAccountTypeApi() {
    this.loading.value = true;
    Map<String, String> data = {'flag': "account_type"};

    print("get account type ${data}");
    _api.getMasterTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          get_Acc_type_list.value = emp_masterResponse[0].list!;
          print('master list....${get_Acc_type_list.length.toString()}');
        } else {
          get_Acc_type_list.value = [];
          print('master listelsse....${get_Acc_type_list.length.toString()}');
        }
      } catch (e) {
        get_Acc_type_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      get_Acc_type_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }

  /*getCompanyProfileTypeApi(){
    this.loading.value = true;
    Map<String, String> data = {'flag': "company"};

    _api.getMasterTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          get_Comp_Profile_type_list.value = emp_masterResponse[0].list!;
          print('master list....${get_Comp_Profile_type_list.length.toString()}');
        } else {
          get_Comp_Profile_type_list.value = [];
          print('master listelsse....${get_Comp_Profile_type_list.length.toString()}');
        }
      } catch (e) {
        get_Comp_Profile_type_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      get_Comp_Profile_type_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }*/

  getGstRegistrationTypeApi() {
    this.loading.value = true;
    Map<String, String> data = {'flag': "gst_type"};

    _api.getMasterTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          get_Gst_Registration_list.value = emp_masterResponse[0].list!;
          //print('master list....${get_Acc_category_list.length.toString()}');
        } else {
          get_Gst_Registration_list.value = [];
          //print('master listelsse....${get_Acc_category_list.length.toString()}');
        }
      } catch (e) {
        get_Gst_Registration_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      get_Gst_Registration_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
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




  getCompanyProfileSubTypeApi() {
    Map data = {
      "filter_code":"",
      "filter_description": "",
      "row_per_page": 1000,
      "page_number": 0
    };
    print(data);
    loading.value = true;
    try {
      _api.CompanyProfileMsGetApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<CompanyProfileMstModel> response =
            JsonResponse.map((e) => CompanyProfileMstModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              CompanyProfileMst_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              CompanyProfileMst_list.value=[];
              Utils.sanckBarError(
                  "Error!", "No Date Found");
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            CompanyProfileMst_list.value = [];
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

  getStateMasterApi(String text, String flag) {
    Map data = {
      "filter_pincode": text,
      "filter_search": "",
      "flag": flag,
    };
    print(data);
    loading.value = true;
    try {
      _api.PincodeMasterGet(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PincodeMasterModel> response =
            JsonResponse.map((e) => PincodeMasterModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              if(flag == 'state'){
                StateMasterPinCode_list.value=response;
              }else if(flag == 'city'){
                CityMasterPinCode_list.value = response;
              }else if(flag == 'district'){
                DistrictMasterPinCode_list.value = response;
              }

            } else {
              loading.value = false;
              StateMasterPinCode_list.value=[];
              Utils.sanckBarError(
                  "Error!", "No Date Found");
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
      StateMasterPinCode_list.value = [];
      print(e);
    }
  }

  getShippingStateMasterApi(String text, String flag) {
    Map data = {
      "filter_pincode": text,
      "filter_search": "",
      "flag": flag,
    };
    print(data);
    loading.value = true;
    try {
      _api.PincodeMasterGet(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PincodeMasterModel> response =
            JsonResponse.map((e) => PincodeMasterModel.fromJson(e))
                .toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              if(flag == 'state'){
                ShippingStateMasterPinCode_list.value=response;
                print('stateList....${ShippingStateMasterPinCode_list[0].stateName}');
              }else if(flag == 'city'){
                ShippingCityMasterPinCode_list.value = response;
                print('cityList....${ShippingCityMasterPinCode_list[0].city}');
              }else if(flag == 'district'){
                ShippingDistrictMasterPinCode_list.value = response;
                print('districtList....${ShippingDistrictMasterPinCode_list[0].district}');
              }

            } else {
              loading.value = false;
              ShippingStateMasterPinCode_list.value=[];
              Utils.sanckBarError(
                  "Error!", "No Date Found");
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
      ShippingStateMasterPinCode_list.value = [];
      print(e);
    }
  }


  Future<Iterable<CompanyTypeModel>> getCompanyProfileTypeApi(String text) async {
    /*if (text == '') {
      return const Iterable<CompanyTypeModel>.empty();
    }*/
    loading.value=true;
    Map data = {
     "filter_description": text,
      "row_per_page":50 ,
      "page_number": 0
    };
    print("Complany Data....${data}");
    String customer_response =await  _api.CompanyTypeMsGetApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CompanyTypeModel> response =
        jsonResponse.map((data) => CompanyTypeModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print("Complany type....${jsonResponse}");
          get_Comp_Profile_type_list.value = response;

        } else {

          get_Comp_Profile_type_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        get_Comp_Profile_type_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      get_Comp_Profile_type_list.value = [];
    }
    finally{
      loading.value=false;
    }
    return  get_Comp_Profile_type_list.value;
  }


  /*getCompanyProfileTypeApi() {
    Map data = {
      "filter_description": "",
      "row_per_page": 1000,
      "page_number": 0
    };
    print(data);
    loading.value = true;
    try {
      _api.CompanyTypeMsGetApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<CompanyTypeModel> response =
            JsonResponse.map((e) => CompanyTypeModel.fromJson(e))
                .toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              get_Comp_Profile_type_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              get_Comp_Profile_type_list.value=[];
              Utils.sanckBarError(
                  "Error!", "No Date Found");
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            get_Comp_Profile_type_list.value = [];
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
      get_Comp_Profile_type_list.value = [];
      print(e);
    }
  }*/

  getGeoPostalCodeApi() {
    Map data = {
      "email_id": email,
      "pincode": ""
    };
    print(data);
    loading.value = true;
    try {
      _api.GeoGetPincodeHierarchy(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PostalCodeModel> response =
            JsonResponse.map((e) => PostalCodeModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              geoPostal_Code_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              geoPostal_Code_list.value=[];
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
      geoPostal_Code_list.value = [];
      print(e);
    }
  }

  Future<void> upLoadImage(BuildContext context) async {
    var image;
    try {
      image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
      if (image != null) {
        upLoadLocalImages.value = image.path.toString();
        await upLoadImageApi(context);
        Navigator.of(context).pop();
        UploadImageType_controller.clear();
        UploadImage.value = false;
        await getAccMasterBuyCodeApi(AccountCode);
        Get.toNamed(RoutesName.update_AccountMaster_screen);
      }
    } catch (e) {
      Utils.sanckBarError("Image Exception!", e.toString());
    }
  }

  Future<void> upLoadImageApi(BuildContext context) async {
    final Uri imageUrl = Uri.parse(ImageUrl_Controller.text.toString());
    final Uri serverUri = Uri.parse(AppUrl.AccountMstImageUpload);
    final http.MultipartRequest clientRequest = http.MultipartRequest('POST', serverUri);

    var fields = <String, String>{
      "account_code": AccountMasterGetCode_list[0].accountCode!,
      "Url": imageUrl.toString(),
    };
    clientRequest.fields.addAll(fields);

    try {
      if (ImageUrl_Controller.text.isEmpty) {
        // Uploading image from gallery
        clientRequest.files.add(await http.MultipartFile.fromPath('imageUrl', upLoadLocalImages.value));
      } else {
        // Uploading image from URL
        final http.Response response = await http.get(imageUrl);
        if (response.statusCode == 200) {
          clientRequest.files.add(http.MultipartFile.fromBytes(
            'Url',
            response.bodyBytes,
            filename: 'image.jpg',
          ));
        } else {
          throw Exception('Failed to load image from URL');
        }
      }
    } catch (e) {
      print("Failed to load image from URL: $e");
      loading.value = false;
      Utils.sanckBarError('Error!', "Failed to load image from URL");
      return;
    }

    loading.value = true;

    try {
      final response = await _api.AccountMstImageUploadApiHit(clientRequest, sessionManagement);
      final jsonResponse = json.decode(response);

      if (jsonResponse is List) {
        List<AccountMasterGetByCodeModel> responseData =
        jsonResponse.map((data) => AccountMasterGetByCodeModel.fromJson(data)).toList();

        if (responseData.isNotEmpty && responseData[0].condition == 'True') {
          loading.value = false;
          Navigator.of(context).pop();
          UploadImageType_controller.clear();
          UploadImage.value = false;
          Utils.sanckBarSuccess('Success!', responseData[0].message.toString());
          await getAccMasterBuyCodeApi(AccountCode);
          Get.toNamed(RoutesName.update_AccountMaster_screen);
        } else {
          loading.value = false;
          Utils.sanckBarError('Failed!', responseData[0].message.toString());
        }
      } else {
        loading.value = false;
        Utils.sanckBarError('API Error', jsonResponse["message"] ?? 'Invalid response format');
      }
    } catch (error) {
      print("API Error: $error");
      loading.value = false;
      Utils.sanckBarError('Error!', "API Response Error");
    }
  }



  getSateListApi() {
    this.loading.value = true;
    Map<String, String> data = {};

    _api.getStateMasterApiHit(data, sessionManagement).then((value) {
      try {
        List<StateMasterListModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => StateMasterListModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          StateMaster_list.value = emp_masterResponse!;
          print('master list....${StateMaster_list.length.toString()}');
        } else {
          StateMaster_list.value = [];
          print('master listelsse....${StateMaster_list.length.toString()}');
        }
      } catch (e) {
        StateMaster_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      StateMaster_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }

  getTatResponseMasterApi() {
    Map data = {};
    print(data);
    loading.value = true;
    try {
      _api.getTatResponseMasterApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<TatResponseModel> response =
            JsonResponse.map((e) => TatResponseModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              TatResponseMaster_list.value=response;
              //Get.toNamed(RoutesName.create_preventive_calender_view_screen);

            } else {
              loading.value = false;
              TatResponseMaster_list.value=[];
              Utils.sanckBarError(
                  "Error!", "No Calender Date Found");
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
      TatResponseMaster_list.value = [];
      print(e);
    }
  }

   getAccMasterBuyCodeApi(String? accountCode) {
    AccountCode = accountCode!;
    Map<String , String> data = {
      "account_code": accountCode.toString()
    };
    print('data: $data');
    loading.value = true;
      _api.getAccountMasterGetByCodeApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          try{
            if (JsonResponse is List) {
              List<AccountMasterGetByCodeModel> response =
              JsonResponse.map((e) => AccountMasterGetByCodeModel.fromJson(e))
                  .toList();
              if (response != null &&
                  response.length > 0 &&
                  response[0].condition == "True") {
                AccountMasterGetCode_list.value=response;
                accountName=AccountMasterGetCode_list[0].accountName.toString();
                print('Api Hit Mster....${AccountMasterGetCode_list[0].profile.toString()}');
                viewRequestDetails(response);
                Get.toNamed(RoutesName.update_AccountMaster_screen);


              } else {
                AccountMasterGetCode_list.value=[];
                Utils.sanckBarError(
                    "Error!", "No Data Found");
                //service_installation_details_list.value=[];
              }
            } else {

              // service_indent_header_list.value = [];
              Utils.sanckBarException("Api Error!", JsonResponse);
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



  AccountMstUploaderApiHit(String flag, String AccountCode, String SaleEmailId, String RegionalEmailId) async {
    if(IsActive_controller.text=="Yes"){
      InActive=1;
    }else if(IsActive_controller.text=="No"){
      InActive=0;
      //print(accountMaster_page_controller.InActive);
    }
    String message = account_cat_type_controller.text;

    String accountCatTypeCode = message.substring(0,1);
    Map<String, dynamic> data = {
      "created_by": email,
      "flag": flag,
      "lines": [
        {
          "account_code": AccountCode.isEmpty?DraftId:AccountCode,
          "account_name": account_name_controller.text.isEmpty?'':account_name_controller.text ,
          "account_owner": AccountOwner,
          "account_title": AccountTitle_Controller.text.isEmpty?'':AccountTitle_Controller.text,
          //"account_type": flag=='Create'?'New Account':'Existing Account',
          "account_type": account_type_controller.value.text.isEmpty?'':account_type_controller.value.text,
          "referral_by": ReferralByName_Controller.text.isEmpty?'':ReferralByName_Controller.text,
          "phone_no": PhoneNo_Controller.text.isEmpty?'':PhoneNo_Controller.text,
          "email_id": EmailId_Controller.text.isEmpty?'':EmailId_Controller.text,
          "account_category_type": accountCatTypeCode,
          "company_profile_type": comp_prof_type_controller.text.isEmpty?'':comp_prof_type_controller.text,
          "company_profile_sub_type": comp_prof_sub_type_controller.value.text.isEmpty?'':comp_prof_sub_type_controller.value.text,
          "company_profile_remark": comp_prof_remarks_controller.text.isEmpty?'':comp_prof_remarks_controller.text,
          "address": Address_controller.text.isEmpty?'':Address_controller.text,
          "address2": Address2_Controller.text.isEmpty?'':Address2_Controller.text,
          "post_code": PostCode_Controller.text.isEmpty?'':PostCode_Controller.text,
          "state_name": State_Controller.text.isEmpty?'':State_Controller.text,
          "city": City_Controller.text.isEmpty?'':City_Controller.text,
          "district": District_Controller.text.isEmpty?'':District_Controller.text,
          "shipping_address": Shipping_Address_controller.value.text.isEmpty?"":Shipping_Address_controller.value.text,
          "shipping_address2": Shipping_Address2_Controller.value.text.isEmpty?"":Shipping_Address2_Controller.value.text,
          "shipping_post_code": Shipping_PostCode_Controller.value.text.isEmpty?"":Shipping_PostCode_Controller.value.text,
          "shipping_state_code": Shipping_State_Controller.value.text.isEmpty?"":Shipping_State_Controller.value.text,
          "shipping_city": Shipping_City_Controller.value.text.isEmpty?"":Shipping_City_Controller.value.text,
          "shipping_district": Shipping_District_Controller.value.text.isEmpty?"":Shipping_District_Controller.value.text,
          "no_of_employees": No_Of_Emp_Controller.text.isEmpty?0:No_Of_Emp_Controller.text,
          "annual_revenue": Annual_Revenue_Controller.text.isEmpty?0:Annual_Revenue_Controller.text,
          "tat_response_type": tatResponseType.isEmpty?'':tatResponseType,
          "sales_representative": SaleEmailId.isEmpty?'':SaleEmailId,
          "regional_service_head": RegionalEmailId.isEmpty?'':RegionalEmailId,
          "profile": ImageUrl_Controller.text.isEmpty?'':ImageUrl_Controller.text,
          "is_active": InActive,
          "website": Website_Controller.text.isEmpty?'':Website_Controller.text,
          "gst_type": gst_registration_type_controller.value.text.isEmpty?'':gst_registration_type_controller.value.text,
          "gst_no": GstNo_Controller.text.isEmpty?'':GstNo_Controller.text,
          "pan_no": PanNo_Controller.text.isEmpty?'':PanNo_Controller.text,
          "alternate_no": Alternate_PhoneNo_Controller.text.isEmpty?'':Alternate_PhoneNo_Controller.text,
          "ifsc_code": IfscCode_Controller.text.isEmpty?'':IfscCode_Controller.text,
          "is_referral": ReferralBy_Controller.text == "Yes"?1:0,
          "is_account_fixed": flag=="Create"?0:AccountMasterGetCode_list[0].isAccountFixed
        }
      ]
    };
    print(data);
    loading.value = true;
    try {
      final value = await _api.AccountMstUploaderApiHit(data, sessionManagement);
      print(value);
      final JsonResponse = json.decode(value);
      if (JsonResponse is List) {
        List<AccountMasterGetByCodeModel> response =
        JsonResponse.map((e) => AccountMasterGetByCodeModel.fromJson(e)).toList();
        if (response != null &&
            response.length > 0 &&
            response[0].condition == "True") {
          loading.value = false;
          //AccountMasterGetCode_list.value=response;

     //     print('Api Hit Mster....${AccountMasterGetCode_list[0].message.toString()}');
          if(flag == 'Create'){
            Utils.sanckBarSuccess("Success!", response[0].message??"Account Create Successful");
            if(FromPage == "Task"){
              clearController();
              TaskMaster_page_controller.clearCreateTaskController();
              TaskMaster_page_controller.getItemCategoryMstWithoutTaskIdApi();
              TaskMaster_page_controller.getEmpMstEmailByApi();
              //TaskMaster_page_controller.getAccountMaster(10);
              Get.toNamed(RoutesName.addNewTaskMaster_screen);
            }else if(FromPage == "Contact"){
              clearController();
              final contact_vm_controller = Get.put(ContactMasterVM());
              contact_vm_controller.resetAllContactCreativeField('Icon');
              contact_vm_controller.insideOut = true;
              contact_vm_controller.getAccountMaster("");
              contact_vm_controller.getDecisionRoleMaster();
              Get.toNamed(RoutesName.addNewContactMaster_screen);
            }else{
              clearAccoundController();
              //deleteAccountData(DraftId);
              IsActive_controller.text = 'All';
              pageNumber=0;
              getAccountMaster(pageNumber ,is_Active.toString());
              getDraftAccountMaster(pageNumber,is_Active.toString());
              Get.toNamed(RoutesName.accountMaster_screen);
            }
          }else if(flag == 'Update'){
            Utils.sanckBarSuccess("Success!", response[0].message??"Account Update Successful");
            viewRequestDetails(response);
            clearAccoundController();
            IsActive_controller.text = 'All';
            pageNumber=0;
            getAccountMaster(pageNumber ,is_Active.toString());
            getDraftAccountMaster(pageNumber,is_Active.toString());
            Get.toNamed(RoutesName.accountMaster_screen);
          }
          //Get.toNamed(RoutesName.update_AccountMaster_screen);
          //viewRequestDetails(response);
        } else {
          loading.value = false;
         // AccountMasterGetCode_list.value = [];
          Utils.sanckBarError("Error!", response[0].message??"");
          //service_installation_details_list.value=[];
        }
      } else {
        loading.value = false;
        // service_indent_header_list.value = [];
        Utils.sanckBarException("Api Error!", JsonResponse);
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      print("Exce3ption....$error");
      //service_indent_header_list.value = [];
      Utils.sanckBarException("catch Api Error!", error.toString());
    }
  }

  DraftAccountMstUploaderApiHit(String flag) async {
    if(IsActive_controller.text=="Yes"){
      InActive=1;
    }else if(IsActive_controller.text=="No"){
      InActive=0;
      //print(accountMaster_page_controller.InActive);
    }
    Map<String, dynamic> data = {
      "created_by": email,
      "flag": flag,
      "lines": [
        {
          "account_code": DraftId.isEmpty?"":DraftId,
          "account_name": account_name_controller.text.isEmpty?'':account_name_controller.text ,
          "account_owner": AccountOwner,
          "account_title": AccountTitle_Controller.text.isEmpty?'':AccountTitle_Controller.text,
          "account_type": account_type_controller.text.isEmpty?'':account_type_controller.text,
          "referral_by": ReferralByName_Controller.text.isEmpty?'':ReferralByName_Controller.text,
          "phone_no": PhoneNo_Controller.text.isEmpty?'':PhoneNo_Controller.text,
          "email_id": EmailId_Controller.text.isEmpty?'':EmailId_Controller.text,
          "account_category_type": account_cat_type_controller.text.isEmpty?'':account_cat_type_controller.text,
          "company_profile_type": comp_prof_type_controller.text.isEmpty?'':comp_prof_type_controller.text,
          "company_profile_sub_type": comp_prof_sub_type_controller.value.text.isEmpty?'':comp_prof_sub_type_controller.value.text,
          "company_profile_remark": comp_prof_remarks_controller.text.isEmpty?'':comp_prof_remarks_controller.text,
          "address": Address_controller.text.isEmpty?'':Address_controller.text,
          "address2": Address2_Controller.text.isEmpty?'':Address2_Controller.text,
          "post_code": PostCode_Controller.text.isEmpty?'':PostCode_Controller.text,
          "state_name": State_Controller.text.isEmpty?'':State_Controller.text,
          "city": City_Controller.text.isEmpty?'':City_Controller.text,
          "district": District_Controller.text.isEmpty?'':District_Controller.text,
          "shipping_address": Shipping_Address_controller.value.text.isEmpty?"":Shipping_Address_controller.value.text,
          "shipping_address2": Shipping_Address2_Controller.value.text.isEmpty?"":Shipping_Address2_Controller.value.text,
          "shipping_post_code": Shipping_PostCode_Controller.value.text.isEmpty?"":Shipping_PostCode_Controller.value.text,
          "shipping_state_code": Shipping_State_Controller.value.text.isEmpty?"":Shipping_State_Controller.value.text,
          "shipping_city": Shipping_City_Controller.value.text.isEmpty?"":Shipping_City_Controller.value.text,
          "shipping_district": Shipping_District_Controller.value.text.isEmpty?"":Shipping_District_Controller.value.text,
          "no_of_employees": No_Of_Emp_Controller.text.isEmpty?0:No_Of_Emp_Controller.text,
          "annual_revenue": Annual_Revenue_Controller.text.isEmpty?0:Annual_Revenue_Controller.text,
          "tat_response_type": tatResponseType.isEmpty?'':tatResponseType,
          "sales_representative": Sale_Representative_Controller.value.text.isEmpty?'':Sale_Representative_Controller.value.text,
          "regional_service_head": Regional_service_head_Controller.value.text.isEmpty?'':Regional_service_head_Controller.value.text,
          "profile": ImageUrl_Controller.text.isEmpty?'':ImageUrl_Controller.text,
          "is_active": InActive,
          "website": Website_Controller.text.isEmpty?'':Website_Controller.text,
          "gst_type": gst_registration_type_controller.value.text.isEmpty?'':gst_registration_type_controller.value.text,
          "gst_no": GstNo_Controller.text.isEmpty?'':GstNo_Controller.text,
          "pan_no": PanNo_Controller.text.isEmpty?'':PanNo_Controller.text,
          "alternate_no": Alternate_PhoneNo_Controller.text.isEmpty?'':Alternate_PhoneNo_Controller.text,
          "ifsc_code": IfscCode_Controller.text.isEmpty?'':IfscCode_Controller.text,
          "is_referral": ReferralBy_Controller.text == "Yes"?1:0
        }
      ]
    };
    print(data);
    loading.value = true;
    try {
      final value = await _api.DraftAccountMstUploaderApiHit(data, sessionManagement);
      print(value);
      final JsonResponse = json.decode(value);
      if (JsonResponse is List) {
        List<AccountMasterGetByCodeModel> response =
        JsonResponse.map((e) => AccountMasterGetByCodeModel.fromJson(e)).toList();
        if (response != null &&
            response.length > 0 &&
            response[0].condition == "True") {
          if(flag == 'Create'){
            print("ttttttttttt");
            Utils.sanckBarSuccess("Success!", "Account is Save In Draft Successful");
            clearAccoundController();
            //deleteAccountData(DraftId);
            pageNumber=0;
            getAccountMaster(pageNumber ,is_Active.toString());
            getDraftAccountMaster(pageNumber,is_Active.toString());
            Get.toNamed(RoutesName.accountMaster_screen);
          }else if(flag == 'Update'){
            print("Update....");
            Utils.sanckBarSuccess("Success!", "Draft Account is Update Successful");
            viewRequestDetails(response);
            clearAccoundController();
            pageNumber=0;
            getAccountMaster(pageNumber ,is_Active.toString());
            getDraftAccountMaster(pageNumber,is_Active.toString());
            Get.toNamed(RoutesName.Draft_item_list);
          }
          //Get.toNamed(RoutesName.update_AccountMaster_screen);
          //viewRequestDetails(response);
        } else {
          Utils.sanckBarError("Error!", response[0].message??"");
        }
      } else {
        Utils.sanckBarException("Response Error!", JsonResponse);
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      print("Exce3ption....${error}");
      Utils.sanckBarException("Api Error!", error.toString());
      //service_indent_header_list.value = [];
    }
    finally{
      loading.value = false;
    }
  }

  viewRequestDetails(List<AccountMasterGetByCodeModel> response){
    try{
      print('valuein...${compProfileRemrk.value}');

      ImageString.value = response[0].profile??"";
      account_code_controller.text = response[0].accountCode??"";
      account_name_controller.text = response[0].accountName??"";
      EmployeeMember_Controller.text = response[0].accountOwnerFullName??"";
      AccountOwner = response[0].accountOwner??"";
      print('AccountOwener.....${AccountOwner}');
      AccountTitle_Controller.text = response[0].accountTitle??"";
      account_type_controller.text = response[0].accountType??"";
      ReferralBy_Controller.text = response[0].isReferral==1?"Yes":"No";
      if(response[0].isReferral==1){
        isReferral.value=true;
      }else{
        isReferral.value=false;
      }
      OldCRMAccountNo_Controller.text = response[0].oldCrmAccountNo??"";
      PhoneNo_Controller.text= response[0].phoneNo??"";
      EmailId_Controller.text = response[0].emailId??"";
      account_cat_type_controller.text = response[0].accountCategoryType??"";
      comp_prof_type_controller.text = response[0].companyProfileType??"";
      comp_prof_sub_type_controller.value.text = response[0].companyProfileSubType??"";
      if(comp_prof_type_controller.value.text == 'Others'){
        print('value...${compProfileRemrk.value}');
        compProfileRemrk.value = true;
      }
      comp_prof_remarks_controller.text = response[0].companyProfileRemark??"";
      if(response[0].isActive == 1){
        IsActive_controller.text = 'Yes';
      }else if(response[0].isActive == 0){
        IsActive_controller.text = 'No';
      }else if(response[0].isActive == -1){
        IsActive_controller.text = 'All';
      }
      gst_registration_type_controller.value.text = response[0].gstType??"";
      if(gst_registration_type_controller.value.text == 'Registered'){
        GstRegistration.value = true;
      }else{
        GstRegistration.value = false;
      }
      GstNo_Controller.text = response[0].gstNo??"";
      PanNo_Controller.text = response[0].panNo??'';
      GstPanNo.value = response[0].panNo??'';
      IfscCode_Controller.text = response[0].ifscCode??'';

      //IsActive_controller.text = response[0].isActive.toString();
      Address_controller.text = response[0].permanentAddress!.address??"";
      print('Adresss....${response[0].permanentAddress!.address??""}');
      Address2_Controller.text = response[0].permanentAddress!.address2??"";
      PostCode_Controller.text = response[0].permanentAddress!.postCode??"";
      State_Controller.text = response[0].permanentAddress!.stateName??"";
      GstStateCode.value = response[0].permanentAddress!.stateCode??"";
      GovtStateCode.value = response[0].permanentAddress!.stateCode??"";
      City_Controller.text = response[0].permanentAddress!.city??"";
      District_Controller.text = response[0].permanentAddress!.district??"";
      //FullAddress_Controller.value.text = Address_controller.text + "," + Address2_Controller.text + "," + City_Controller.text + "," + District_Controller.text + "," + State_Controller.text + "," + PostCode_Controller.text;
      Shipping_Address_controller.value.text = response[0].shippingAddress??"";
      Shipping_Address2_Controller.value.text = response[0].shippingAddress2??"";
      Shipping_PostCode_Controller.value.text = response[0].shippingPostCode??"";
      Shipping_City_Controller.value.text = response[0].shippingCity??"";
      Shipping_District_Controller.value.text = response[0].shippingDistrict??"";
      Shipping_State_Controller.value.text = response[0].shippingStateName??"";
     // Shipping_FullAddress_Controller.value.text = Shipping_Address_controller.value.text + "," + Shipping_Address2_Controller.value.text + "," + Shipping_City_Controller.value.text + "," + Shipping_District_Controller.value.text + "," + Shipping_State_Controller.value.text + "," + Shipping_PostCode_Controller.value.text;
      No_Of_Emp_Controller.text = response[0].noOfEmployees.toString();
      Annual_Revenue_Controller.text = response[0].annualRevenue.toString();
      TatResponse_Controller.text = response[0].tatResponseType??"" + ' (${response[0].tatResponseTime} Hours)';
      tatResponseType = response[0].tatResponseType??"";
      Sale_Representative_Controller.value.text = response[0].salesRepresentative??"";
      SalesRepresentativeEmail = response[0].salesRepresentative??"";
      Regional_service_head_Controller.value.text = response[0].regionalServiceHeadName??"";
      RegionalHeadEmail = response[0].regionalServiceHead??"";

      Frontliner_Controller.text = response[0].frontlinerValue??"";
      BranchHead_Controller.text = response[0].branchHeadValue??"";
      ZoneHead_Controller.text = response[0].zoneHeadValue??"";
      ClusterHead_Controller.text = response[0].clustureHeadValue??"";
      //todo for state , city and district....
      getStateMasterApi(PostCode_Controller.text, 'state');
      getStateMasterApi(PostCode_Controller.text, 'city');
      getStateMasterApi(PostCode_Controller.text, 'district');
      getShippingStateMasterApi(Shipping_PostCode_Controller.value.text,'state');
      getShippingStateMasterApi(Shipping_PostCode_Controller.value.text,'city');
      getShippingStateMasterApi(Shipping_PostCode_Controller.value.text,'district');

      for(int i= 0; i < get_Acc_category_list.length; i++){
        if(response[0].accountCategoryType == get_Acc_category_list[i].code){
          account_cat_type_controller.text = get_Acc_category_list[i].code! + " (" + get_Acc_category_list[i].description! + ")";
         // print('accoutCatType.....${account_cat_type_controller.text}');
        }
      }

      final parts = [
        response[0].permanentAddress!.address??"",
        response[0].permanentAddress!.address2??"",
        response[0].permanentAddress!.city??"",
        response[0].permanentAddress!.district??"",
        response[0].permanentAddress!.stateName??"",
        response[0].permanentAddress!.postCode??"",

      ];

      // Filter out empty strings and join with commas
      final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");
      FullAddress_Controller.value.text = fullAddress;

      final parts2 = [
        response[0].shippingAddress??"",
        response[0].shippingAddress2??"",
        response[0].shippingCity??"",
        response[0].shippingDistrict??"",
        response[0].shippingStateName??"",
        response[0].shippingPostCode??"",

      ];

      // Filter out empty strings and join with commas
      final ShippingFullAddress = parts2.where((part) => part.trim().isNotEmpty).join(", ");
      Shipping_FullAddress_Controller.value.text = ShippingFullAddress;



    }catch(e){
        print("Catch Block...${e}");
    }
  }
  clearAcountMasterFilter(){
    print("reset filter data");
    AccountOwnerForApi = '';
    AccountOwner_controller.value.clear();
    SelectedEmployee_Member_list.value = [];

    created_on_controller.value.clear();
    account_code_controller.clear();
    account_name_controller.clear();
    account_type_controller.clear();
    comp_prof_type_controller.clear();
    stateName_controller.clear();
    IsActive_controller.clear();
    PhoneNo_Controller.clear();
    EmailId_Controller.clear();
    postal_code_controller.value.clear();
    district_controller.value.clear();
    created_by_controller.value.clear();
    frontliner_controller.value.clear();
    //RegionName_controller.value.clear();
    zone_head__value_controller.value.clear();
    //clusterName_controller.value.clear();
    pageNumber=0;
    getAccountMaster(pageNumber,'All');

  }

  clearFilterController(){
    account_code_controller.clear();
    account_name_controller.clear();
    account_type_controller.clear();
    comp_prof_type_controller.clear();
    stateName_controller.clear();
    IsActive_controller.clear();
    PhoneNo_Controller.clear();
    EmailId_Controller.clear();
    postal_code_controller.value.clear();
    district_controller.value.clear();
    created_by_controller.value.clear();
    frontliner_controller.value.clear();
    //RegionName_controller.value.clear();
    zone_head__value_controller.value.clear();
    //clusterName_controller.value.clear();
    created_by_controller.value.clear();
    //accountMaster_page_controller.Address_controller.clear();
    // accountMaster_page_controller.Annual_Revenue_Controller.clear();
    //accountMaster_page_controller.No_Of_Emp_Controller.clear();
    //accountMaster_page_controller.no_of_employees_min = '';
    // accountMaster_page_controller.no_of_employees_max = '';
    // accountMaster_page_controller.annual_revenue_min = '';
    //accountMaster_page_controller.annual_revenue_max = '';
    //accountMaster_page_controller.account_cat_type_controller.clear();
  }

  clearController(){
    try{
      compProfileRemrk.value = false;
      GstRegistration.value = false;
      isChecked.value = false;
      CompanyProfileMst_list.value=[];
      get_Comp_Profile_type_list.value=[];
      geoPostal_Code_list.value=[];
      StateMasterPinCode_list.value=[];
      CityMasterPinCode_list.value=[];
      DistrictMasterPinCode_list.value=[];
      ShippingStateMasterPinCode_list.value=[];
      ShippingCityMasterPinCode_list.value=[];
      ShippingDistrictMasterPinCode_list.value=[];
      ImageString.value == '';

      //todo radha raman
      ImageUrl_Controller.clear();
      Website_Controller.clear();

      account_code_controller.clear();
      account_name_controller.clear();
      EmployeeMember_Controller.clear();
      AccountOwner = '';
      AccountTitle_Controller.clear();
      account_type_controller.clear();
      PhoneNo_Controller.clear();
      Alternate_PhoneNo_Controller.clear();
      EmailId_Controller.clear();
      account_cat_type_controller.clear();
      comp_prof_type_controller.clear();
      comp_prof_sub_type_controller.value.clear();
      comp_prof_remarks_controller.clear();
      gst_registration_type_controller.value.text = 'UnRegistered';
      GstNo_Controller.clear();
      PanNo_Controller.clear();
      IfscCode_Controller.clear();
      IsActive_controller.text = 'All';
      ReferralBy_Controller.text="No";
      Address_controller.clear();
      Address2_Controller.clear();
      PostCode_Controller.clear();
      State_Controller.clear();
      City_Controller.clear();
      District_Controller.clear();
      FullAddress_Controller.value.clear();
      Shipping_FullAddress_Controller.value.clear();
      Shipping_Address_controller.value.clear();
      Shipping_Address2_Controller.value.clear();
      Shipping_PostCode_Controller.value.clear();
      Shipping_City_Controller.value.clear();
      Shipping_District_Controller.value.clear();
      Shipping_State_Controller.value.clear();
      No_Of_Emp_Controller.clear();
      Annual_Revenue_Controller.clear();
      TatResponse_Controller.clear();
      tatResponseType  = '';
      Sale_Representative_Controller.value.clear();
      SalesRepresentativeEmail = "";
      Regional_service_head_Controller.value.clear();
      RegionalHeadEmail = "";
      AddressContactFilter_Controller.value.clear();

    }catch(e){

    }
  }

  void getContactMasterList(int pageNumber, String account_name, String contName, String account_Code) {
    try{
      Map<String, String> data={
        "filter_contact_name": contName,
        "filter_account_code": account_Code,
        "filter_account_name": account_name,
        "filter_department_name": '',
        "row_per_page": rowsPerPage.toString(),
        "page_number": pageNumber.toString()
      };
      loading.value=true;
      print("data is ${data}");
      _api.contactMstGetList(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<ContactMstGetListModal> response = jsonResponse.map((e) => ContactMstGetListModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            if(pageNumber==0){
              view_contract_list.clear();
            }
            view_contract_list.addAll(response);
            print('listSize.....${view_contract_list.length}');
            total_rows=int.parse(view_contract_list[0].totalRows!);
            loading.value = false;
            //todo commented by nirupma
            /*view_contract_list.value=[];
            view_contract_list.value=response;*/
            Get.toNamed(RoutesName.viewContacts_screen);

          }else {
            loading.value = false;
            view_contract_list.value=[];
            Get.toNamed(RoutesName.viewContacts_screen);
           // Utils.sanckBarSuccess('No Data Found', 'No Data Found');

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

  /*void getAddressMasterList(int pageNumber, String account_Code) {
    try{
      Map<String, String> data={
        "consignee_id": '',
        "account_code":account_Code,
        "account_name": '',
        "contact_name": '',
        "email_id": '',
        "phone_no": '',
        "rowsPerPage": rowsPerPage.toString(),
        "pageNumber": pageNumber.toString()
      };
      loading.value=true;
      print("data is ${data}");
      _api.ConsigneeAddMstGet(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AddressMasterModel> response = jsonResponse.map((e) => AddressMasterModel.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            AddressMst_list.value=[];
            AddressMst_list.value=response;
            Get.toNamed(RoutesName.viewAddress_screen);

          }else {
            loading.value = false;
            AddressMst_list.value=[];
            Get.toNamed(RoutesName.viewAddress_screen);
            Utils.sanckBarSuccess('No date', 'No Data Found');

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
  }*/



  void getAccountDashboardCount(int pageNumber, String account_Code) {
    try{
      Map<String, String> data={
        "account_code": account_Code,
        "row_per_page": rowsPerPage.toString(),
        "page_number": pageNumber.toString()
      };
      loading.value=true;
      print("data is ${data}");
      _api.AccountDashboardCount(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AccountDashboardCountModel> response = jsonResponse.map((e) => AccountDashboardCountModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            accountDashBoardCount.value=[];
            accountDashBoardCount.value=response;
            accountDashBoardTaskCount.value=[];
            accountDashBoardSalesCount.value=[];
            accountDashBoardQuotationCount.value=[];
            accountDashBoardTaskCount.add(accountDashBoardCount[0].task!) ;
            accountDashBoardSalesCount.add(accountDashBoardCount[0].sales!) ;
            accountDashBoardQuotationCount.add(accountDashBoardCount[0].quotation!) ;
            getAccountTaskHistory(pageNumber, account_Code);
            ClearSalesFilter();
            Get.toNamed(RoutesName.AccountDashboardCount_Screen);

          }else {
            loading.value = false;
            view_contract_list.value=[];
            Get.toNamed(RoutesName.AccountDashboardCount_Screen);
            Utils.sanckBarSuccess('No Data Found', 'No Data Found');


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


  getAccountTaskHistory(int page_no, String accountCode){
    try{
      Map<String, String> data={
        "account_code": accountCode,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no.toString()
      };
      loading.value=true;
      _api.AccountTaskHistory(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AccountTaskHistoryModel> response = jsonResponse.map((e) => AccountTaskHistoryModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(page_no==0){
              AccountTaskHistoryList.clear();
            }
            AccountTaskHistoryList.addAll(response);
            total_rows=int.parse(AccountTaskHistoryList[0].totalRows!);

          }else {
            loading.value = false;
            AccountTaskHistoryList.value=[];

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

  getAccountDashboardData(int page_no,String IsActive, String accountCode, String flag, String day_flag){
    if(TaskMaster_page_controller.isInfraLeadFilterController.text=="All"){
      TaskMaster_page_controller.infraLeadValue.value=-1;
    }
    else if(TaskMaster_page_controller.isInfraLeadFilterController.text=="Yes"){
      TaskMaster_page_controller.infraLeadValue.value=1;
    }
    else if(TaskMaster_page_controller.isInfraLeadFilterController.text=="No"){
      TaskMaster_page_controller.infraLeadValue.value=0;
    }
    else{
      TaskMaster_page_controller.infraLeadValue.value=-1;
    }

    if(IsActive == 'All'){
      is_Active = -1;
    }else if( IsActive == 'Yes'){
      is_Active = 1;
    }else if(IsActive == 'No'){
      is_Active = 0;
    }
    try{
      Map<String, String> data={
          "filter_flag": flag,
          "filter_task_id": "",
          "filter_contact_name": TaskMaster_page_controller.Contact_Name_controller.value.text.isEmpty?"":TaskMaster_page_controller.Contact_Name_controller.value.text,
          "filter_type_of_call": TaskMaster_page_controller.Type_of_call_controller.value.text.isEmpty?"":TaskMaster_page_controller.Type_of_call_controller.value.text,
          "filter_is_infra_lead": TaskMaster_page_controller.infraLeadValue.value.toString(),
          "filter_is_sales_cycle_active": is_Active.toString(),
          "filter_sales_cycle_id": TaskMaster_page_controller.Sale_cycle_Id_controller.value.text.isEmpty?"":TaskMaster_page_controller.Sale_cycle_Id_controller.value.text,
          "filter_is_closed_completed": "0",
          "filter_sales_cycle_status": "",
          "filter_sales_cycle_approval_status": "",
          "filter_created_by": email,
          "filter_account_code": accountCode,
          "filter_day_flag": day_flag,
          "quote_status": "",
          "filter_quote_id": "",
          "filter_quote_validity": "",
          "filter_exp_closure_date": "",
          "rowsPerPage": rowsPerPage.toString(),
          "pageNumber": page_no.toString()
      };
      loading.value=true;
      _api.AccountDashboardDataGet(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AccountDashboardDataModel> response = jsonResponse.map((e) => AccountDashboardDataModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(page_no==0){
              AccountDashboardDataList.clear();
            }
            AccountDashboardDataList.addAll(response);
            total_rows=int.parse(AccountDashboardDataList[0].totalRows!);
            print('list..Size...${AccountDashboardDataList.length}');
            Get.toNamed(RoutesName.AccountDashboardData_Screen);

          }else {
            loading.value = false;
            AccountDashboardDataList.value=[];
            print('Nodatafound');
            Utils.sanckBarSuccess('No date', 'No Data Found');

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

  getAccountDashboardDataSales(int page_no,String IsActive, String accountCode, String flag, String day_flag, String WonLoss){
    /*if(isInfraLeadFilterController.text=="All"){
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
    }*/
    try{
      Map<String, String> data={
        "filter_flag": flag,
        "filter_task_id": "",
        "filter_contact_name": salesCycleController.contactNameController.value.text.isEmpty?"":salesCycleController.contactNameController.value.text,
        "filter_type_of_call": "",
        "filter_is_infra_lead": "-1",
        "filter_is_sales_cycle_active": "-1",
        "filter_sales_cycle_id": salesCycleController.saleCycleController.value.text.isEmpty?"":salesCycleController.saleCycleController.value.text,
        "filter_is_closed_completed": "0",
        "filter_sales_cycle_status": day_flag,
        "filter_sales_cycle_approval_status": salesCycleController.ApprovalStatusController.value.text.isEmpty?"":salesCycleController.ApprovalStatusController.value.text,
        "filter_created_by": email,
        "filter_account_code": accountCode,
        "filter_day_flag": "",
        "quote_status": WonLoss,
        "filter_quote_id": "",
        "filter_quote_validity": "",
        "filter_exp_closure_date": "",
        "rowsPerPage": rowsPerPage.toString(),
        "pageNumber": page_no.toString()
      };
      loading.value=true;
      _api.AccountDashboardDataGet(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AccountdashboarddatasaleModelsModel> response = jsonResponse.map((e) => AccountdashboarddatasaleModelsModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(page_no==0){
              AccountDashboardDataSalesList.clear();
            }
            AccountDashboardDataSalesList.addAll(response);
            total_rows=int.parse(AccountDashboardDataSalesList[0].totalRows!);
            print('list..Size.Sales..${AccountDashboardDataSalesList.length}');
            Get.toNamed(RoutesName.AccountDashboardDataSales_Screen);

          }else {
            loading.value = false;
            AccountDashboardDataSalesList.value=[];
            print('NodatafoundSales');
            Utils.sanckBarSuccess('No date', 'No Data Found');

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


  getAccountDashboardDataQuotation(int page_no,String IsActive, String accountCode, String flag, String day_flag){
    try{
      Map<String, String> data={
        "filter_flag": flag,
        "filter_task_id": "",
        "filter_contact_name": "",
        "filter_type_of_call": "",
        "filter_is_infra_lead": "-1",
        "filter_is_sales_cycle_active": "-1",
        "filter_sales_cycle_id": "",
        "filter_is_closed_completed": "0",
        "filter_sales_cycle_status": "",
        "filter_sales_cycle_approval_status": "",
        "filter_created_by": email,
        "filter_account_code": accountCode,
        "filter_day_flag": "",
        "quote_status": day_flag,
        "filter_quote_id": salesCycleController.filterQuoteIdController.value.text.isEmpty?"":salesCycleController.filterQuoteIdController.value.text,
        "filter_quote_validity": salesCycleController.filterQuoteValidityController.value.text.isEmpty?"":salesCycleController.filterQuoteValidityController.value.text,
        "filter_exp_closure_date": salesCycleController.filterExpectedClosuredateController.value.text.isEmpty?"":salesCycleController.filterExpectedClosuredateController.value.text,
        "rowsPerPage": rowsPerPage.toString(),
        "pageNumber": page_no.toString()
      };
      loading.value=true;
      _api.AccountDashboardDataGet(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<SalesCycleQuoteHeaderModal> response = jsonResponse.map((e) => SalesCycleQuoteHeaderModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(page_no==0){
              AccountDashboardDataQuotationList.clear();
            }
            AccountDashboardDataQuotationList.addAll(response);
            total_rows=int.parse(AccountDashboardDataQuotationList[0].totalRows!);
            print('list..Size.Sales..${AccountDashboardDataQuotationList.length}');
            Get.toNamed(RoutesName.AccountDashboardDataQuotation_Screen);

          }else {
            loading.value = false;
            AccountDashboardDataQuotationList.value=[];
            print('NodatafoundSales');
            Utils.sanckBarSuccess('No date', 'No Data Found');

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

  void ClearSalesFilter(){
    salesCycleController.accountNameController.value.clear();
    salesCycleController.contactNameController.value.clear();
    salesCycleController.SaleCycleStatusController.value.clear();
    salesCycleController.ApprovalStatusController.value.clear();
    salesCycleController.saleCycleController.value.clear();
    salesCycleController.filterQuoteIdController.value.clear();
    salesCycleController.filterExpectedClosuredateController.value.clear();
    salesCycleController.filterQuoteValidityController.value.clear();
    TaskMaster_page_controller.Contact_Name_controller.clear();
    TaskMaster_page_controller.Type_of_call_controller.value.clear();
    TaskMaster_page_controller.SaleCycleActive_Controller.clear();
    TaskMaster_page_controller.Sale_cycle_Id_controller.clear();
    TaskMaster_page_controller.isInfraLeadFilterController.clear();
  }


  fillDraftDetails(List<AccountMasterGetByCodeModel> response, int position){
    try{
      DraftId = response[position].accountCode.toString();
      ImageString.value = response[position].profile??"";
      account_code_controller.text = response[position].accountCode??"";
      account_name_controller.text = response[position].accountName??"";
      EmployeeMember_Controller.text = response[position].accountOwnerFullName??"";
      AccountOwner = response[position].accountOwner??"";
      print('Onwer...${EmployeeMember_Controller.text}');
     // AccountOwner = employee_Member_list[position].loginEmailId??"";
      AccountTitle_Controller.text = response[position].accountTitle??"";
      account_type_controller.text = response[position].accountType??"";
      PhoneNo_Controller.text= response[position].phoneNo??"";
      EmailId_Controller.text = response[position].emailId??"";
      ReferralBy_Controller.text = response[position].isReferral==1?"Yes":"No";
      print('ISReferral...${ReferralBy_Controller.text}');
      account_cat_type_controller.text = response[position].accountCategoryType??"";
      comp_prof_type_controller.text = response[position].companyProfileType??"";
      comp_prof_sub_type_controller.value.text = response[position].companyProfileSubType??"";
      if(comp_prof_type_controller.value.text == 'Others'){
        print('value...${compProfileRemrk.value}');
        compProfileRemrk.value = true;
      }
      comp_prof_remarks_controller.text = response[position].companyProfileRemark??"";
      if(response[position].isActive == 1){
        IsActive_controller.text = 'Yes';
      }else if(response[position].isActive == 0){
        IsActive_controller.text = 'No';
      }else if(response[position].isActive == -1){
        IsActive_controller.text = 'All';
      }
      gst_registration_type_controller.value.text = response[position].gstType??"";
      if(gst_registration_type_controller.value.text == 'Registered'){
        GstRegistration.value = true;
      }else{
        GstRegistration.value = false;
      }
      GstNo_Controller.text = response[position].gstNo??"";
      if(GstNo_Controller.value.text.isNotEmpty){
        GstPanNo.value = GstNo_Controller.value.text.substring(2, 12);
        print('Next ten digits: ${GstPanNo.value}');
      }
      PanNo_Controller.text = response[position].panNo??'';
      IfscCode_Controller.text = response[position].ifscCode??'';
      Address_controller.text = response[position].permanentAddress!.address??"";
     // print('Adresss....${response[position].address??""}');
      Address2_Controller.text = response[position].permanentAddress!.address2??"";
      PostCode_Controller.text = response[position].permanentAddress!.postCode??"";
      State_Controller.text = response[position].stateName??"";
      City_Controller.text = response[position].permanentAddress!.city??"";
      District_Controller.text = response[position].permanentAddress!.district??"";
      Shipping_Address_controller.value.text = response[position].shippingAddress??"";
      Shipping_Address2_Controller.value.text = response[position].shippingAddress2??"";
      Shipping_PostCode_Controller.value.text = response[position].shippingPostCode??"";
      Shipping_State_Controller.value.text = response[position].shippingStateCode??"";
      Shipping_City_Controller.value.text = response[position].shippingCity??"";
      Shipping_District_Controller.value.text = response[position].shippingDistrict??"";
      No_Of_Emp_Controller.text = response[position].noOfEmployees.toString();
      Annual_Revenue_Controller.text = response[position].annualRevenue.toString();
      TatResponse_Controller.text = response[position].tatResponseType??"" + ' (${response[position].tatResponseTime} Hours)';
      tatResponseType = response[position].tatResponseType??"";
      Sale_Representative_Controller.value.text = response[position].salesRepresentative??"";
      SalesRepresentativeEmail = response[position].salesRepresentative??"";
      Regional_service_head_Controller.value.text = response[position].regionalServiceHeadName??"";
      RegionalHeadEmail = response[position].regionalServiceHead??"";

      //todo billing address
      final parts = [
        Address_controller.text,
        Address2_Controller.text,
        City_Controller.text,
        District_Controller.text,
       State_Controller.text,
        PostCode_Controller.text,
      ];
      final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");
      FullAddress_Controller.value.text = fullAddress;

      //todo sgipping address
      final parts1 = [
        Shipping_Address_controller.value.text,
        Shipping_Address2_Controller.value.text,
        Shipping_City_Controller.value.text,
        Shipping_District_Controller.value.text,
        Shipping_State_Controller.value.text,
        Shipping_PostCode_Controller.value.text,
      ];

      // Filter out empty strings and join with commas
      final fullAddress1 = parts1.where((part) => part.trim().isNotEmpty).join(", ");

      Shipping_FullAddress_Controller.value.text = fullAddress1;


    }catch(e){

    }
  }

  Future<void> deleteAccountData(String draftId) async {
    try {
      // Convert the draftId to an integer
      int? id = int.tryParse(draftId);

      if (id != null) {
        // Assuming `crmDatabase` has a method called `deleteItem`
        // Replace `deleteItem` with the actual method name for deletion in your database helper class
        await crmDatabase.deleteItem(id);
        //Utils.sanckBarSuccess('Account', 'Data deleted successfully');
        print('Data deleted successfully.');
      } else {
        print('Invalid draft ID: $draftId');
      }
    } catch (e) {
      print('Failed to delete data: $e');
    }
  }

  void getAddressMasterList(int pageNumber, String account_Code, String account_name, String contactName) {
    try{
      Map data={
        "consignee_id": "",
        "account_code":account_Code,
        "account_name": account_name,
        "contact_name": contactName,
        "email_id": "",
        "phone_no": "",
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };
      loading.value=true;
      print("data is ${data}");
      _api.ConsigneeAddMstGet(data, sessionManagement).then((onValue){
        print('value...${onValue}');
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AddressMasterModel> response = jsonResponse.map((e) => AddressMasterModel.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;

            if(pageNumber==0){
              address_master_list.clear();
            }
            address_master_list.addAll(response);
            total_rows=int.parse(address_master_list[0].totalRows!);

            address_master_list.value=response;

            // Get.toNamed(RoutesName.viewAddress_screen);

          }else {
            loading.value = false;
            address_master_list.value=[];
            // Get.toNamed(RoutesName.viewAddress_screen);
           // Utils.sanckBarSuccess('No date Found', 'No Data Found');

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

  void showConsigneeAddressList(BuildContext context, RxList<AddressMasterModel> address_master_list) {
    AddressContactFilter_Controller.value.clear();
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Select Address',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
              height: size.height*.6,
              width: size.width*45,
              child: Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: AddressContactFilter_Controller.value,
                      //maxLength: 150,
                      onChanged: (value){
                        pageNumber=0;
                        getAddressMasterList(pageNumber,account_code_controller.text, account_name_controller.text, AddressContactFilter_Controller.value.text);
                      },
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            child: Icon(Icons.search, color: Colors.black),
                          ),
                          hintText: "Search Address",
                          labelText: "Search Address",
                          //suffixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AllFontSize.ten,
                              horizontal: AllFontSize.ten),

                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),
                  ),
                  SizedBox(height: 15,),

                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
                      child: Obx(() {
                        return BindAddressListView(context);
                      }),
                    ),
                  ),

                  Obx((){
                    return Visibility(
                      visible: address_master_list.value.length > 0,
                        child: Row(
                          children: [
                            Expanded(
                              child: DefaultButton(
                                text: 'Discard',
                                press: (){
                                  if(account_code_controller.value.text.isEmpty){
                                    selectedItem.value = -1;
                                    Shipping_Address_controller.value.text="";
                                    Shipping_Address2_Controller.value.text="";
                                    Shipping_PostCode_Controller.value.text="";
                                    Shipping_City_Controller.value.text="" ;
                                    Shipping_State_Controller.value.clear();
                                    ShowState.value=false;
                                    ShowState.value=true;
                                    Shipping_District_Controller.value.text="";
                                    consigneeId = '';
                                    Shipping_FullAddress_Controller.value.text = "";
                                  } else{
                                    ShowState.value=false;
                                    ShowState.value=true;
                                    selectedItem.value = -1;
                                    Shipping_Address_controller.value.text=AccountMasterGetCode_list[0].shippingAddress??"";
                                    Shipping_Address2_Controller.value.text=AccountMasterGetCode_list[0].shippingAddress2??"";
                                    Shipping_PostCode_Controller.value.text=AccountMasterGetCode_list[0].shippingPostCode??"";
                                    Shipping_City_Controller.value.text=AccountMasterGetCode_list[0].shippingCity??"" ;
                                    Shipping_State_Controller.value.text=AccountMasterGetCode_list[0].shippingStateName??"";
                                    Shipping_District_Controller.value.text=AccountMasterGetCode_list[0].shippingDistrict??"";
                                    consigneeId = '';
                                    Shipping_FullAddress_Controller.value.text = "";
                                  }
                                  isChecked.value=false;



                                  // shippingController.value.text=('${saleCycleList[0].shippingAddress??""} ${saleCycleList[0].shippingStateCode??"" } ${saleCycleList[0].shippingPostCode??"" }');
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: DefaultButton(
                                text: 'Save',
                                press: (){
                                  try{
                                    print("selected data..${selectedItem.value}");
                                    if(selectedItem.value>0){
                                      isChecked.value=false;
                                      Shipping_Address_controller.value.text=address_master_list[selectedItem.value].address??"";
                                      Shipping_Address2_Controller.value.text=address_master_list[selectedItem.value].address2??"";
                                      Shipping_PostCode_Controller.value.text=address_master_list[selectedItem.value].postCode??"";
                                      Shipping_City_Controller.value.text=address_master_list[selectedItem.value].city??"" ;
                                      Shipping_State_Controller.value.text=address_master_list[selectedItem.value].stateName??"";
                                      print('StatNane...${Shipping_State_Controller.value.text}');
                                      ShowState.value=false;
                                      ShowState.value=true;
                                      Shipping_District_Controller.value.text=address_master_list[selectedItem.value].district??"";
                                      consigneeId = address_master_list[selectedItem.value].consigneeId??"";
                                      Shipping_FullAddress_Controller.value.text=Shipping_Address_controller.value.text+', '+
                                          Shipping_Address2_Controller.value.text+', '+
                                          Shipping_PostCode_Controller.value.text+', '+
                                          Shipping_City_Controller.value.text+', '+
                                          Shipping_District_Controller.value.text+', '+
                                          Shipping_State_Controller.value.text;
                                    }else{
                                      print("onjghjhg");
                                      Utils.sanckBarError('Error ', "Please select address.");
                                    }
                                  }
                                  catch(e){

                                  }

                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        )
                    );
                  })

                 /* Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [


                      Obx((){
                        return Visibility(
                          visible: address_master_list.value.length > 0 ?true :false,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              if(account_code_controller.value.text.isEmpty){
                                selectedItem.value = -1;
                                Shipping_Address_controller.value.text="";
                                Shipping_Address2_Controller.value.text="";
                                Shipping_PostCode_Controller.value.text="";
                                Shipping_City_Controller.value.text="" ;
                                Shipping_State_Controller.value.clear();
                                ShowState.value=false;
                                ShowState.value=true;
                                Shipping_District_Controller.value.text="";
                                consigneeId = '';
                                Shipping_FullAddress_Controller.value.text = "";
                              } else{
                                ShowState.value=false;
                                ShowState.value=true;
                                selectedItem.value = -1;
                                Shipping_Address_controller.value.text=AccountMasterGetCode_list[0].shippingAddress??"";
                                Shipping_Address2_Controller.value.text=AccountMasterGetCode_list[0].shippingAddress2??"";
                                Shipping_PostCode_Controller.value.text=AccountMasterGetCode_list[0].shippingPostCode??"";
                                Shipping_City_Controller.value.text=AccountMasterGetCode_list[0].shippingCity??"" ;
                                Shipping_State_Controller.value.text=AccountMasterGetCode_list[0].shippingStateName??"";
                                Shipping_District_Controller.value.text=AccountMasterGetCode_list[0].shippingDistrict??"";
                                consigneeId = '';
                                Shipping_FullAddress_Controller.value.text = "";
                              }
                              isChecked.value=false;



                              // shippingController.value.text=('${saleCycleList[0].shippingAddress??""} ${saleCycleList[0].shippingStateCode??"" } ${saleCycleList[0].shippingPostCode??"" }');
                              Get.back();
                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Discard'
                                *//*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*//*,
                                style: GoogleFonts.poppins(
                                  color: AllColors.customDarkerWhite,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      Obx((){
                        return Visibility(
                          visible: address_master_list.value.length > 0 ?true :false,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              try{
                                isChecked.value=false;
                                Shipping_Address_controller.value.text=address_master_list[selectedItem.value].address??"";
                                Shipping_Address2_Controller.value.text=address_master_list[selectedItem.value].address2??"";
                                Shipping_PostCode_Controller.value.text=address_master_list[selectedItem.value].postCode??"";
                                Shipping_City_Controller.value.text=address_master_list[selectedItem.value].city??"" ;
                                Shipping_State_Controller.value.text=address_master_list[selectedItem.value].stateName??"";
                                print('StatNane...${Shipping_State_Controller.value.text}');
                                ShowState.value=false;
                                ShowState.value=true;
                                Shipping_District_Controller.value.text=address_master_list[selectedItem.value].district??"";
                                consigneeId = address_master_list[selectedItem.value].consigneeId??"";
                                Shipping_FullAddress_Controller.value.text=Shipping_Address_controller.value.text+', '+
                                    Shipping_Address2_Controller.value.text+', '+
                                    Shipping_PostCode_Controller.value.text+', '+
                                    Shipping_City_Controller.value.text+', '+
                                    Shipping_District_Controller.value.text+', '+
                                    Shipping_State_Controller.value.text;
                              }
                              catch(e){
                                Utils.sanckBarError('Select ', "Addresss");
                              }

                              Get.back();
                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Save',
                                style: GoogleFonts.poppins(
                                  color: AllColors.customDarkerWhite,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      })

                    ],)*/
                ],
              ),
            ),
          );

        });
  }

  Widget BindAddressListView(context) {
    if (address_master_list.value.isNotEmpty && address_master_list.value.length > 0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (total_rows /
              rowsPerPage).toInt();
          if ((total_rows %
              rowsPerPage) >
              0) total_page += 1;

          //print("last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (pageNumber + 1 < total_page) {
            getAddressMasterList(pageNumber, "", "", "");
            this.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: address_master_list.value.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    return Obx((){
      return  Card(
        margin: EdgeInsets.all(5),
        color: selectedItem.value == position ? AllColors.grayColor : Colors.white,
        child: ListTile(
          onTap: () {
            selectedItem.value = position;

          },
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .25,
                    child: Tooltip(
                      message: address_master_list[position]
                          .contactName?? "",
                      child: Text(
                        address_master_list[position]
                            .contactName?? "",
                        overflow: TextOverflow.ellipsis,
                        style:GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone No. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message: address_master_list[position]
                          .phoneNo?? "",
                      child: Text(
                        address_master_list[position]
                            .phoneNo?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message: address_master_list[position]
                          .emailId?? "",
                      child: Text(
                        address_master_list[position]
                            .emailId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:"${address_master_list[position].address ??""}",
                      child: Text("${address_master_list[position].address ??""} ",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "City : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:address_master_list[position].city??"",
                      child: Text(address_master_list[position].city??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "State : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:address_master_list[position].stateName??"",
                      child: Text(address_master_list[position].stateName??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Post Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .2,
                    child: Tooltip(
                      message:address_master_list[position].postCode??"",
                      child: Text(address_master_list[position].postCode??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),

            ],
          ),



        ),
      );
    });

  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveAccountMasterData({
      "account_code_controller": account_code_controller.text,
      "account_name_controller": account_name_controller.text,
      "account_type_controller": account_type_controller.text,
      "EmailId_Controller": EmailId_Controller.text,
      "PhoneNo_Controller": PhoneNo_Controller.text,
      "comp_prof_type_controller": comp_prof_type_controller.text,
      "stateName_controller": stateName_controller.text,
      "postal_code_controller": postal_code_controller.value.text,
      "district_controller": district_controller.value.text,
      "IsActive_controller": IsActive_controller.text,
      "filter_owner_name": AccountOwner_controller.value.text,
      "filter_region_name":RegionName_controller.value.text,
      "filter_cluster_name": clusterName_controller.value.text,
      "created_on_controller": created_on_controller.value.text,
    });
    pageNumber = 0;
    getAccountMaster(pageNumber, IsActive_controller.text);


  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getAccountMasterData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      account_code_controller.text=getFilterData["account_code_controller"];
      account_name_controller.text=getFilterData["account_name_controller"];
      account_type_controller.text=getFilterData["account_type_controller"];
      EmailId_Controller.text=getFilterData["EmailId_Controller"];
      PhoneNo_Controller.text=getFilterData["PhoneNo_Controller"];
      comp_prof_type_controller.text=getFilterData["comp_prof_type_controller"];
      stateName_controller.text=getFilterData["stateName_controller"];
      postal_code_controller.value.text=getFilterData["postal_code_controller"];
      district_controller.value.text=getFilterData["district_controller"];
      IsActive_controller.text=getFilterData["IsActive_controller"];
      AccountOwner_controller.value.text=getFilterData["filter_owner_name"];
      created_on_controller.value.text=getFilterData["created_on_controller"];
      pageNumber=0;

      if(getFilterData["filter_region_name"].toString().isNotEmpty && getFilterData["filter_region_name"].toString()!=""){
        RegionName_controller.value.text = "";
        RegionName_controller.value.text = getFilterData["filter_region_name"].toString()??"";
      }
      if(getFilterData["filter_cluster_name"].toString().isNotEmpty && getFilterData["filter_cluster_name"].toString()!=""){
        clusterName_controller.value.text="";
        clusterName_controller.value.text=getFilterData["filter_cluster_name"].toString()??"";
        print("clusterName_controller.value.text.....${clusterName_controller.value.text}");
      }
    }
    else{
      //print("else condition");
    }

    print("account master data api");
    getAccountMaster(pageNumber, IsActive_controller.text);

  }

  void clearFilterData() {
    sessionManagement.clearAccountMasterData();
  }
  //todo draft data
  void SavedraftFilterData() async{
    await sessionManagement.saveDraftAccountMasterData({
      "account_code_controller": account_code_controller.text,
      "account_name_controller": account_name_controller.text,
      "account_type_controller": account_type_controller.text,
      "comp_prof_type_controller": comp_prof_type_controller.text,
      "EmailId_Controller": EmailId_Controller.text,
      "PhoneNo_Controller": PhoneNo_Controller.text,
      "stateName_controller": stateName_controller.text,
      "postal_code_controller": postal_code_controller.value.text,
      "district_controller": district_controller.value.text,
      "created_by_controller": created_by_controller.value.text,
    });
    pageNumber = 0;
    getDraftAccountMaster(pageNumber, IsActive_controller.text);


  }

  void getdraftFilterData() async{
    Map getFilterData=await sessionManagement.getDraftAccountMasterData();
    if(getFilterData.isNotEmpty){
      filterDataChecker.value='1';
      account_code_controller.text=getFilterData["account_code_controller"];
      account_name_controller.text=getFilterData["account_name_controller"];
      account_type_controller.text=getFilterData["account_type_controller"];
      EmailId_Controller.text=getFilterData["EmailId_Controller"];
      PhoneNo_Controller.text=getFilterData["PhoneNo_Controller"];
      comp_prof_type_controller.text=getFilterData["comp_prof_type_controller"];
      stateName_controller.text=getFilterData["stateName_controller"];
      postal_code_controller.value.text=getFilterData["postal_code_controller"];
      district_controller.value.text=getFilterData["district_controller"];
      created_by_controller.value.text=getFilterData["created_by_controller"];
      pageNumber=0;

    }
    else{
      //print("else condition");
    }

    getDraftAccountMaster(pageNumber, IsActive_controller.text);

  }

  void cleardraftFilterData() {
    sessionManagement.clearDraftAccountMasterData();
  }

}