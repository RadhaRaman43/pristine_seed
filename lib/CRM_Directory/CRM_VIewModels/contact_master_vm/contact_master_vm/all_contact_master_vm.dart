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


class AllContactMasterVm extends GetxController{
  final _api=ContactMasterRepo();
  SessionManagement sessionManagement = SessionManagement();
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
  RxList<ContactMstGetListModal> contact_master_list = <ContactMstGetListModal>[].obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    email=await sessionManagement.getEmail() ?? '';
    getContactMasterAllList(pageNumber,);


  }

  Future<void>refreshList() async{
    getContactMasterAllList(pageNumber,);

  }


  void getContactMasterAllList(int pageNumber) {
    Map<String, String> data={
      "filter_contact_name": contact_name_controller.text.isEmpty?"":contact_name_controller.text,
      "filter_account_code": account_code_controller.text.isEmpty?"":account_code_controller.text,
      "filter_account_name": account_name_controller.text.isEmpty?"":account_name_controller.text,
      "filter_department_name": depart_name_controller.text.isEmpty?"":depart_name_controller.text,
      "email_id": emailId_controller.text.isEmpty?"":emailId_controller.text,
      "phone_no": phone_no_controller.text.isEmpty?"":phone_no_controller.text,
      "created_by": email,
      "row_per_page": rowsPerPage.toString(),
      "page_number": pageNumber.toString()
    };
    loading.value=true;
    print("data is ${data}");
    _api.getContactMstGetAllApiHit(data, sessionManagement).then((onValue){
      final jsonResponse = json.decode(onValue);
      print(onValue);
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






}