import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/Address_Master_Model/PincodeMaster_Model.dart';
import '../../CRM_Models/Address_Master_Model/PostalCode_Model.dart';
import '../../CRM_Models/Address_Master_Model/address_master_model.dart';
import '../../CRM_Repository/AddressConsignee_Repository/Address_Consignee_Repo.dart';
import '../../CRM_View/Account_Master_view/update_account_master.dart';
import '../account_master_vm/accountMasterVM.dart';

class Addressmastervm extends GetxController{
  final _api=AddressConsigneeRepo();
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
  String consignee_code='';
  RxBool designation_dropDown = false.obs;
  RxBool filterIconColor=false.obs;
  String view ="";
  RxBool GstRegistration=false.obs;
  RxString GstStateCode = ''.obs;
  RxString GovtStateCode = ''.obs;
  RxString GstPanNo = ''.obs;

  var account_name_controller = TextEditingController();
  var account_code_controller = TextEditingController();
  var Consignee_controller = TextEditingController().obs;
  var contact_name_controller = TextEditingController();
  var gst_registration_type_controller = TextEditingController().obs;
  var phone_no_controller = TextEditingController();
  var emailId_controller = TextEditingController();
  var alternate_no_controller = TextEditingController();
  var GstNo_Controller = TextEditingController();
  var PanNo_Controller = TextEditingController();
  var IfscCode_Controller = TextEditingController();
  var contact_code_controller = TextEditingController();
  var State_Controller = TextEditingController();
  var Address_controller = TextEditingController();
  var Address2_Controller = TextEditingController();
  var PostCode_Controller = TextEditingController();
  var City_Controller = TextEditingController();
  var District_Controller = TextEditingController();
  var FullAddress_Controller = TextEditingController().obs;

  RxList<AddressMasterModel> address_master_list = <AddressMasterModel>[].obs;
  RxList<PostalCodeModel> geoPostal_Code_list = <PostalCodeModel>[].obs;
  RxList<PincodeMasterModel> StateMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> CityMasterPinCode_list = <PincodeMasterModel>[].obs;
  RxList<PincodeMasterModel> DistrictMasterPinCode_list = <PincodeMasterModel>[].obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    email=await sessionManagement.getEmail() ?? '';
    //getAddressMasterList(pageNumber,account_vm_controller.account_code_controller.value.text);

  }

  Future<void>refreshList() async{
    getAddressMasterList(pageNumber,account_vm_controller.account_code_controller.value.text);

  }

  createNewAddressMstApi(String flag){
    if(account_name_controller.text.isEmpty){
      Utils.sanckBarError('Account Name!', "Please Select Account Name");
      return ;
    }
    if(contact_name_controller.text.isEmpty){
      Utils.sanckBarError('Address Name!', "Please Fill Address Name");
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
    if(gst_registration_type_controller.value.text.isEmpty || gst_registration_type_controller == null){
      Utils.sanckBarError('GST Registration Type!', "Please Enter GST Registration Type");
      return  ;
    }

    if(gst_registration_type_controller.value.text == 'Registered' && GstNo_Controller.text.isEmpty){
      Utils.sanckBarError('GST No.!', "Please Enter A valid GST No.");
      return  ;
    }

    if(GstNo_Controller.text.isNotEmpty && GSTValidator.validate(GstNo_Controller.text) == false){
      Utils.sanckBarError('GST No.!', "Please Enter A valid GST No.");
      return  ;
    }

    if(gst_registration_type_controller.value.text == 'Registered' && PanNo_Controller.value.text != GstPanNo.value){
      print('PanCOnteroller....${PanNo_Controller.value.text}');
      print('GStPan....${GstPanNo.value}');
      Utils.sanckBarError('Pan No!', "Please Enter Valid Pan No");
      return  ;
    }

    if(gst_registration_type_controller.value.text == 'UnRegistered' && PanNo_Controller.value.text.length !=10 && PanNo_Controller.value.text.isNotEmpty){
      Utils.sanckBarError('Pan No!', "Pan No Should be in 10 digits");
      return  ;
    }

    if(IfscCode_Controller.text.isNotEmpty ){
      if(IfscCode_Controller.text.length>10){
      }
      else{
        Utils.sanckBarError('IFSC Code!', "IFSC Code Should be in 11 digits");
        return  ;
      }

    }

    if(State_Controller.text.isEmpty || State_Controller == null){
      Utils.sanckBarError('State!', "Please Enter State");
      return  ;
    }else if(gst_registration_type_controller.value.text == 'Registered' && GovtStateCode.value != GstStateCode.value){
      Utils.sanckBarError('Wrong State!', "Please Enter Valid State");
      return  ;
    }

    try{
      Map<String, dynamic> data={
        "created_by": email,
        "flag": flag,
        "lines":[
          {
            "consignee_id": consignee_code.isEmpty?'':consignee_code,
            "account_code": account_code_controller.value.text.isEmpty?'':account_code_controller.value.text,
            "account_name": account_name_controller.value.text.isEmpty?'':account_name_controller.value.text,
            "contact_name": contact_name_controller.value.text.isEmpty?'':contact_name_controller.value.text,
            "phone_no": phone_no_controller.value.text.isEmpty?'':phone_no_controller.value.text,
            "email_id": emailId_controller.value.text.isEmpty?'':emailId_controller.value.text,
            "address": Address_controller.value.text.isEmpty?'':Address_controller.value.text,
            "address2": Address2_Controller.value.text.isEmpty?'':Address2_Controller.value.text,
            "post_code": PostCode_Controller.value.text.isEmpty?'':PostCode_Controller.value.text,
            "state_code": "",
            "state_name": State_Controller.value.text.isEmpty?'':State_Controller.value.text,
            "city": City_Controller.value.text.isEmpty?'':City_Controller.value.text,
            "district": District_Controller.value.text.isEmpty?'':District_Controller.value.text,
            "pan_no": PanNo_Controller.value.text.isEmpty?'':PanNo_Controller.value.text,
            "gst_type":  gst_registration_type_controller.value.text.isEmpty?'':gst_registration_type_controller.value.text,
            "gst_no": GstNo_Controller.value.text.isEmpty?'':GstNo_Controller.value.text,
            "alternate_no": alternate_no_controller.value.text.isEmpty?'':alternate_no_controller.value.text,
            "ifsc_code": IfscCode_Controller.value.text.isEmpty?'':IfscCode_Controller.value.text
          }
        ]
      };
      print("creative data is ${data}");
      loading.value=true;
      _api.ConsigneeAddMstUploader(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AddressMasterModel> response = jsonResponse.map((e) => AddressMasterModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            print("created data is ${response}");
            loading.value = false;
            address_master_list.value=response;
            clearController();
            Get.toNamed(RoutesName.viewAddress_screen);
            getAddressMasterList(0, account_code_controller.value.text);
           // resetAllContactCreativeField('Icon');
            Utils.showToastification('Error', response[0].message!);
            //Get.offAllNamed(RoutesName.contactMaster_screen);

          }else {
            print("${response[0].message}");
            loading.value = false;
            address_master_list.value=[];
            Utils.showErrorToastification('Error', response[0].message.toString());

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
            if (response != null && response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              geoPostal_Code_list.value=response;
              print('jkshjkashk${geoPostal_Code_list.length}');

            } else {
              loading.value = false;
              geoPostal_Code_list.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Date Found");
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
      geoPostal_Code_list.value = [];
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
              Utils.showErrorToastification(
                  "Error!", "No Date Found");
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
      StateMasterPinCode_list.value = [];
      print(e);
    }
  }


  void getAddressMasterList(int pageNumber, String account_Code) {
    try{
      Map data={
        "consignee_id": Consignee_controller.value.text.isEmpty?"":Consignee_controller.value.text,
        "account_code":account_Code,
        "account_name": account_name_controller.value.text.isEmpty?"":account_name_controller.value.text,
        "contact_name": contact_name_controller.value.text.isEmpty?"":contact_name_controller.value.text,
        "email_id": emailId_controller.value.text.isEmpty?"":emailId_controller.value.text,
        "phone_no": phone_no_controller.value.text.isEmpty?"":phone_no_controller.value.text,
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
            address_master_list.value=[];
            address_master_list.value=response;
            Get.toNamed(RoutesName.viewAddress_screen);

          }else {
            loading.value = false;
            address_master_list.value=[];
            Get.toNamed(RoutesName.viewAddress_screen);
            Utils.showToastification('No Data Found', 'No Data Found');

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

  upDateConsigneeAdd(int index){
    updateContact=true;
    account_code_controller.text = address_master_list[index].accountCode??"";
    account_name_controller.text = address_master_list[index].accountName??"";
    Consignee_controller.value.text = address_master_list[index].consigneeId??"";
    consignee_code = address_master_list[index].consigneeId??"";
    account_code_controller.text = address_master_list[index].accountCode??"";
    contact_name_controller.text = address_master_list[index].contactName??"";
    gst_registration_type_controller.value.text = address_master_list[index].gstType??"";
    if(gst_registration_type_controller.value.text == 'Registered'){
      GstRegistration.value = true;
    }else{
      GstRegistration.value = false;
    }
    phone_no_controller.text = address_master_list[index].phoneNo??"";
    emailId_controller.text = address_master_list[index].emailId??"";
    alternate_no_controller.text = address_master_list[index].alternateNo??"";
    GstNo_Controller.text = address_master_list[index].gstNo??"";
    GstPanNo.value = address_master_list[index].panNo??"";
    PanNo_Controller.text = address_master_list[index].panNo??"";
    IfscCode_Controller.text = address_master_list[index].ifscCode??"";
   // contact_code_controller.text = address_master_list[index].co??"";
    State_Controller.text = address_master_list[index].stateName??"";
    Address_controller.text = address_master_list[index].address??"";
    Address2_Controller.text = address_master_list[index].address2??"";
    PostCode_Controller.text = address_master_list[index].postCode??"";
    City_Controller.text = address_master_list[index].city??"";
    District_Controller.text = address_master_list[index].district??"";
    Get.toNamed(RoutesName.addNewAddress_screen);
  }

  clearController(){
    updateContact=false;
    consignee_code = "";
    Consignee_controller.value.clear();
    contact_name_controller.clear();
    gst_registration_type_controller.value.clear();
    phone_no_controller.clear();
    emailId_controller.clear();
    alternate_no_controller.clear();
    GstNo_Controller.clear();
    PanNo_Controller.clear();
    IfscCode_Controller.clear();
    // contact_code_controller.text = address_master_list[index].co??"";
    State_Controller.clear();
    Address_controller.clear();
    Address2_Controller.clear();
    PostCode_Controller.clear();
    City_Controller.clear();
    District_Controller.clear();
  }

}