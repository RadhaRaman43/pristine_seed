import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../../reources/routes/routes_name.dart';
import '../../../../viewModel/SessionManagment/session_managment.dart';
import '../../../CRM_Models/AccountMaster_model/AccountMstrGet_Model.dart';
import '../../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../../CRM_Models/Contact_Master_modal/Contact_Master_modal/Department_name_modal.dart';
import '../../../CRM_Models/Contact_Master_modal/Contact_Master_modal/Designation_modal.dart';
import '../../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../../CRM_Repository/Contact_Master_Repo/Contact_Master_Repo/contact_master_repo.dart';
import '../../account_master_vm/accountMasterVM.dart';


class ContactMasterVM extends GetxController{
  final _api=ContactMasterRepo();
  SessionManagement sessionManagement = SessionManagement();
  final account_vm_controller = Get.put(Accountmastervm());
  RxBool loading=false.obs;

  RxString accountName="".obs;
  RxString accountCode="".obs;
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String email="";
  bool updateContact=false;
  bool insideOut=false;
  RxString FromPage="".obs;
  String contact_code='';
  RxBool designation_dropDown = false.obs;
  RxBool filterIconColor=false.obs;
  String view ="";

  var account_name_controller = TextEditingController();
  var account_code_controller = TextEditingController();
  var FullAddress_Controller = TextEditingController().obs;
  var contact_name_controller = TextEditingController();
  var depart_name_controller = TextEditingController();
  var phone_no_controller = TextEditingController();
  var emailId_controller = TextEditingController();
  var alternate_no_controller = TextEditingController();
  var reporting_person_controller = TextEditingController();
  var contact_title_controller = TextEditingController();
  var designation_name_controller = TextEditingController();
  var contact_code_controller = TextEditingController();
  var IsHeDecisionMakerController = TextEditingController().obs;


 // RxList<String> isHeDecisionMakerList =["Yes", "No"].obs;
  RxList<CustomList> isHeDecisionMakerList=<CustomList>[].obs;
  RxList<ContactMstGetListModal> contact_master_list = <ContactMstGetListModal>[].obs;
  RxList<AccountMasterModel> Account_Master_list=<AccountMasterModel>[].obs;
  RxList<AccountMasterGetByCodeModel> AccountMasterGetCode_list = <AccountMasterGetByCodeModel>[].obs;
  RxList<DepartNameModal> department_name_list=<DepartNameModal>[].obs;
  RxList<DesignationModal> designation_name_list=<DesignationModal>[].obs;

  Rx<ContactMstGetListModal> contact_master_update =new ContactMstGetListModal().obs;
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    email=await sessionManagement.getEmail() ?? '';
    getContactMasterList(pageNumber,"","","");
    getDecisionRoleMaster();

  }

  Future<void>refreshList() async{
    getContactMasterList(pageNumber,"","","");

  }

  getDecisionRoleMaster() {
    this.loading.value = true;
    Map<String, String> data = {'flag': "decision_role"};

    _api.getMasterTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          isHeDecisionMakerList.value = emp_masterResponse[0].list!;
          print('RoleList.....${isHeDecisionMakerList.length.toString()}');
        } else {
          isHeDecisionMakerList.value = [];
          print('RoleList2.....${isHeDecisionMakerList.length.toString()}');
        }
      } catch (e) {
        isHeDecisionMakerList.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      isHeDecisionMakerList.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }

  void getContactMasterList(int pageNumber, String account_name, String contact_name, String depart_name) {

      Map<String, String> data={
        "filter_contact_name": contact_name,
        "filter_account_code":account_code_controller.text.isEmpty?"":account_code_controller.value.text,
        "filter_account_name": account_name,
        "filter_department_name": depart_name,
        "email_id": emailId_controller.value.text.isEmpty?"":emailId_controller.value.text,
        "phone_no": phone_no_controller.value.text.isEmpty?"":phone_no_controller.value.text,
        "created_by": email,
        "row_per_page": rowsPerPage.toString(),
        "page_number": pageNumber.toString()
      };
      loading.value=true;
      print("data is ${data}");
      _api.contactMstGetList(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        try{
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
          } else {
            Utils.showErrorToastification("Api Response!", jsonResponse);
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
        },
      ).whenComplete(() {
        loading.value = false;
      },);

  }

  Future<Iterable<AccountMasterModel>> getAccountMaster(String text) async {
    /*if (text == '') {
      return const Iterable<CompanyTypeModel>.empty();
    }*/
    loading.value=true;
    Map data = {
      "filter_account_name": text,
      "filter_account_owner": "",
      "filter_account_type": "",
      "filter_account_category_type": "",
      "filter_company_profile_type": "",
      "filter_address": "",
      "filter_state_name": "",
      "filter_is_active": "-1",
      "filter_created_by": email,
      "row_per_page": 50,
      "page_number": 0,
      "no_of_employees_min": "",
      "no_of_employees_max": "",
      "annual_revenue_min": "",
      "annual_revenue_max": "",
      "filter_email_id": "",
      "filter_phone_no": ""
    };
    print("Complany Data....${data}");
    String customer_response =await  _api.AccountMasterGetApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<AccountMasterModel> response =
        jsonResponse.map((data) => AccountMasterModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print("Complany type....${jsonResponse}");
          Account_Master_list.value = response;

        } else {

          Account_Master_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        Account_Master_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      Account_Master_list.value = [];
    }
    finally{
      loading.value=false;
    }
    return  Account_Master_list.value;
  }

  getAccMasterBuyCodeApi(String? accountCode) {
    Map<String , String> data = {
      "account_code": accountCode.toString()
    };
    print(data);
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
              if(AccountMasterGetCode_list[0].permanentAddress != null){
                FullAddress_Controller.value.text = AccountMasterGetCode_list[0].permanentAddress!.address! + ", "
                    + AccountMasterGetCode_list[0].permanentAddress!.address2! + ", "
                    + AccountMasterGetCode_list[0].permanentAddress!.city! + ", "
                    + AccountMasterGetCode_list[0].permanentAddress!.district! + ", "
                    + AccountMasterGetCode_list[0].permanentAddress!.stateName! + ", "
                    + AccountMasterGetCode_list[0].permanentAddress!.postCode! + ", " ;

              }

            } else {
              AccountMasterGetCode_list.value=[];
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



  getDepartNameList(){
    try{
      Map<String, String> data={
        "flag": "Get",
        "created_by": email
      };
      loading.value=true;
      _api.departmentGetInsert(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<DepartNameModal> response = jsonResponse.map((e) => DepartNameModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            department_name_list.value=response;

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

  resetAllContactCreativeField(String flag){
    updateContact=false;
    pageNumber=0;
    if(flag == 'Card'){
      //print('Account name....${account_vm_controller.view_contract_list[0].accountName??""}');
      account_name_controller.text = account_vm_controller.account_name_controller.text;
    }else if(flag == 'Icon'){
      account_name_controller.clear();
    }
    //account_name_controller.clear();
    FullAddress_Controller.value.clear();
    contact_name_controller.clear();
    depart_name_controller.clear();
    phone_no_controller.clear();
    emailId_controller.clear();
    alternate_no_controller.clear();
    reporting_person_controller.clear();
    contact_title_controller.clear();
    designation_name_controller.clear();
    IsHeDecisionMakerController.value.clear();
  }

  createNewContactMstApi(String flag){
    if(account_name_controller.text.isEmpty){
      Utils.sanckBarError('Account Name!', "Please Select Account Name");
      return ;
    }
    if(contact_name_controller.text.isEmpty){
      Utils.sanckBarError('Contact Name!', "Please Fill Contact Name");
      return ;
    }
    if(phone_no_controller.text.isNotEmpty ){
      if(phone_no_controller.text.length>9){
      }
      else{
        Utils.sanckBarError('Phone No!', "Please Enter 10 Digit Phone No");
        return  ;
      }

    }
    if(emailId_controller.text.isNotEmpty && EmailValidator.validate(emailId_controller.text) == false){
      Utils.sanckBarError('Email ID!', "Please Enter A valid Email ID");
      return  ;
    }

    try{
      Map<String, dynamic> data={
        "created_by": email,
        "flag": flag,
        "lines":[
          {
            "contact_code": contact_code,
            "contact_name": contact_name_controller.text,
            "contact_title": contact_title_controller.text,
            "account_code": accountCode.value.isNotEmpty?accountCode.value:"",
            "account_name": accountName.value.isNotEmpty?accountName.value:account_name_controller.text,
            "full_address": FullAddress_Controller.value.text,
            "phone_no": phone_no_controller.text,
            "email_id": emailId_controller.text,
            "alternate_no": alternate_no_controller.text,
            "department_name": depart_name_controller.text,
            "desingation_name": designation_name_controller.text,
            "reporting_person": reporting_person_controller.text,
            "contact_role": IsHeDecisionMakerController.value.text.isEmpty?"":IsHeDecisionMakerController.value.text,
          }
        ]
      };
      print('fuul add ${FullAddress_Controller.value.text}');
      print("creative data is ${data}");
      loading.value=true;
      _api.ContactMstUploader(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<ContactMstGetListModal> response = jsonResponse.map((e) => ContactMstGetListModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            contact_master_list.value=response;

            resetAllContactCreativeField('Icon');
            if(insideOut == true){
              Get.toNamed(RoutesName.contactMaster_screen);
              pageNumber=0;
              getContactMasterList(pageNumber,"","","");
            }else if(insideOut == false){
              Get.toNamed(RoutesName.viewContacts_screen);
              account_vm_controller.getContactMasterList(0, account_name_controller.text.toString(), '', accountCode.value.toString());
            }

            Utils.showToastification('Success!', response[0].message!);
            //Get.offAllNamed(RoutesName.contactMaster_screen);

          }else {
            print("${response[0].message}");
            loading.value = false;
            contact_master_list.value=[];
            Utils.showErrorToastification('Error', response[0].message.toString());
            pageNumber=0;
            getContactMasterList(pageNumber,"","","");

          }
        } else {
          Utils.sanckBarError('Error!', jsonResponse);
          loading.value = false;

        }
      },
      ).onError(
            (error, stackTrace) {
              loading.value = false;
          print('Api error is ${error}');
          Utils.sanckBarError('Api error!', error.toString());
        },
      );
    }catch(e){
      loading.value = false;
      print(e);
    }
  }
  upDateContact(String flag, int index){
    updateContact=true;
    designation_dropDown.value=true;
    if(flag == 'OutSide'){
      print('Flage...${flag}');
      contact_code=contact_master_list[index].contactCode?? "";
      account_name_controller.text=contact_master_list[index].accountName?? "";
      accountCode.value=contact_master_list[index].accountCode??"";
    contact_name_controller.text=contact_master_list[index].contactName?? "";
    depart_name_controller.text=contact_master_list[index].departmentName?? "";
    phone_no_controller.text=contact_master_list[index].phoneNo?? "";
    emailId_controller.text=contact_master_list[index].emailId?? "";
    alternate_no_controller.text=contact_master_list[index].alternateNo?? "";
    reporting_person_controller.text=contact_master_list[index].reportingPerson?? "";
    contact_title_controller.text=contact_master_list[index].contactTitle?? "";
    designation_name_controller.text=contact_master_list[index].designationname ?? "";
    contact_code_controller.text=contact_master_list[index].contactCode ?? "";
    FullAddress_Controller.value.text=contact_master_list[index].fullAddress ?? "";
    IsHeDecisionMakerController.value.text=contact_master_list[index].contactRole??"";
    }else if(flag == 'Inside'){
      contact_code=account_vm_controller.view_contract_list[index].contactCode?? "";
      account_name_controller.text=account_vm_controller.view_contract_list[index].accountName?? "";
      contact_name_controller.text=account_vm_controller.view_contract_list[index].contactName?? "";
      depart_name_controller.text=account_vm_controller.view_contract_list[index].departmentName?? "";
      phone_no_controller.text=account_vm_controller.view_contract_list[index].phoneNo?? "";
      emailId_controller.text=account_vm_controller.view_contract_list[index].emailId?? "";
      alternate_no_controller.text=account_vm_controller.view_contract_list[index].alternateNo?? "";
      reporting_person_controller.text=account_vm_controller.view_contract_list[index].reportingPerson?? "";
      contact_title_controller.text=account_vm_controller.view_contract_list[index].contactTitle?? "";
      designation_name_controller.text=account_vm_controller.view_contract_list[index].designationname ?? "";
      contact_code_controller.text=account_vm_controller.view_contract_list[index].contactCode ?? "";
      IsHeDecisionMakerController.value.text=account_vm_controller.view_contract_list[index].contactRole??"";
    }

    getAccountMaster("");
    //getDepartNameList();
    //getDesignationList();
    getDecisionRoleMaster();
    Get.toNamed(RoutesName.addNewContactMaster_screen);
  }

  getDesignationList(){
    try{
      Map<String, String> data={
        "dept_name": depart_name_controller.text,

      };
      print('designation payload ${data}');
      loading.value=true;
      _api.DesignationGet(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print('value is ${onValue}');
        if(jsonResponse is List){
          List<DesignationModal> response = jsonResponse.map((e) => DesignationModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            designation_name_list.value=response;

          }else {
            loading.value = false;
            designation_name_list.value=[];

          }
        } else {
          loading.value = false;
          designation_name_list.value=[];
          Utils.showErrorToastification("Error!", jsonResponse);
        }
      },
      ).onError((error, stackTrace) {
        loading.value = false;
          print('Api Error $error');
          Utils.showExceptionToastification("Api Error!", error.toString());
        },
      );
    }catch(e){
      loading.value = false;
      print(e);
    }
  }


}