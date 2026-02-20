
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gstvalidator/gstvalidator.dart';
import 'package:navigation_drawer_flutter/component/circular_loading.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/CompanyTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/Company_Prof_Mst_Model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/State_master_model.dart';
import '../../CRM_Models/AccountMaster_model/Tat_Response_model.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_Models/Address_Master_Model/PincodeMaster_Model.dart';
import '../../CRM_Models/Address_Master_Model/PostalCode_Model.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class UpdateAccountMaster extends StatelessWidget{

  UpdateAccountMaster({super.key});

  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  final address_vm_controller = Get.put(Addressmastervm());
  final saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  final _formKey = GlobalKey<FormState>();
  final _formKeyGst = GlobalKey<FormState>();
  final _formKeyPanNo = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();

  static String _displayEmpMemberForOption(EmployeeMemberModel option) =>
      option.fullName!;

  static String _displayAccTypeForOption(CustomList option) =>
      option.value!;

  static String _displayAccCategoryForOption(GetMasterTypeModel option) =>
      option.code! + " (" + option.description! + ")";

  static String _displayCompProfileTypeForOption(CompanyTypeModel option) =>
      option.description!;

  static String _displayGstRegisterTypeForOption(CustomList option) =>
      option.value!;

  static String _displayCompProfSubForOption(CompanyProfileMstModel option) =>
      option.description!;

  static String _displayStateListForOption(PincodeMasterModel option) =>
      option.stateName!;

  static String _displayCityListForOption(PincodeMasterModel option) =>
      option.city!;

  static String _displayDistrictListForOption(PincodeMasterModel option) =>
      option.district!;

  static String _displayPostalCodeListForOption(PostalCodeModel option) =>
      option.pincode!;

  static String _displayTatResponseListForOption(TatResponseModel option) =>
      option.responseType! + " (${option.responseDescription!})";

  static String _displayIsActiveForOption(String option) =>
      option;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("account view...${accountMaster_page_controller.view}");
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.view='';
          Get.toNamed(RoutesName.contactMaster_screen);
        }else if(accountMaster_page_controller.view=='Task'){
          accountMaster_page_controller.view='';
          TaskMaster_page_controller.getTaskMaster(0,
              TaskMaster_page_controller.is_Active
                  .toString(),
              TaskMaster_page_controller.Task_Master_list[0].taskId,
              '', 'GET FROM TASK ID',TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
          Get.toNamed(RoutesName.taskMasterDetails_screen);
        }else if(accountMaster_page_controller.view=='FromTaskMainScreen'){
          TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), '', '', '',TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
          Get.toNamed(RoutesName.taskMaster_screen);
        }else if(accountMaster_page_controller.view=='FromSaleCycleMainScreen'){
          saleCycleController.pageNumber=0;
          saleCycleController.filterQuoteAcceptedFlag.value="";
          saleCycleController.clearAllFieldOfFilter();
          saleCycleController.getsalesCycleData(saleCycleController.pageNumber, "", "",'');
          Get.toNamed(RoutesName.salesCycleScreen);
        }
        else if(accountMaster_page_controller.view=="FromQuoteApproval"){
          print("view..");
          Get.offAllNamed(RoutesName.quoteApprovalListScreen);
        }
        else if(accountMaster_page_controller.view=='FromSaleDetailsScreen'){
          Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
        }
        else if(accountMaster_page_controller.view=='FromquoteInformationScreen'){
          Get.toNamed(RoutesName.quoteInformationScreen);
        }else if(accountMaster_page_controller.view == 'Account'){
          accountMaster_page_controller.clearController();
          accountMaster_page_controller.pageNumber = 0;
          accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber ,accountMaster_page_controller.is_Active.toString());
          Get.toNamed(RoutesName.accountMaster_screen);
        }else if(accountMaster_page_controller.view=="fromtaskapprovaldetailspage"){
          Get.toNamed(RoutesName.taslMasterApprovalDetailsScreen);
        }
        else if(accountMaster_page_controller.view=="ALLContactList"){
          Get.toNamed(RoutesName.allContactMasterScreen);
        }
        else if(accountMaster_page_controller.view=="Sales"){
          Get.toNamed(RoutesName.taskMasterDetails_screen);
        }else if(accountMaster_page_controller.view=="FromQuoteDraftScreen"){
          Get.toNamed(RoutesName.pendingDraftQuoteScreen);
        }
        else if(accountMaster_page_controller.view=="ApprovedRejectedQuotePage"){
          Get.toNamed(RoutesName.approvedRejectedQuoteScreen);
        }else if(accountMaster_page_controller.view=="FromAllQuotePage"){
          Get.toNamed(RoutesName.allQuoteScreenScreen);
        }else if(accountMaster_page_controller.view=="FromALLQuoteLineItems"){
          Get.toNamed(RoutesName.allQuoteLineItemScreen);
        }
        else if(accountMaster_page_controller.view=="FromAllSPRMapping"){
          Get.toNamed(RoutesName.allSPRMappingScreen);
        }

        else{
          /* accountMaster_page_controller.clearController();
           accountMaster_page_controller.pageNumber = 0;
           accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber ,accountMaster_page_controller.IsActive_controller.text);*/
          Get.offAll(RoutesName.accountMaster_screen);
        }
        return false;
      },
      child: Scaffold(
          appBar:  AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title:Row(
              children: [
                Text(accountMaster_page_controller.view=='VIEW'?"Account Details": 'Account',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
              ],
            ),
            actions: [
              PopupMenuButton(itemBuilder: (BuildContext context){
                List<PopupMenuEntry>  items= [];

                items.add( PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.contacts, color: Colors.black,),
                      Text('View Contacts'),
                    ],
                  ),
                  onTap: (){
                    contact_vm_controller.getDecisionRoleMaster();
                    accountMaster_page_controller.pageNumber = 0;
                    contact_vm_controller.accountCode.value = accountMaster_page_controller.account_code_controller.value.text;
                    contact_vm_controller.FromPage.value="AccountUpdate";
                    contact_vm_controller.account_name_controller.text=accountMaster_page_controller.accountName;
                    accountMaster_page_controller.getContactMasterList(accountMaster_page_controller.pageNumber,accountMaster_page_controller.accountName, '', accountMaster_page_controller.account_code_controller.text);

                  },
                ),);
                items.add(PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.home, color: Colors.black,),
                      Text('View Addresses'),
                    ],
                  ),
                  onTap: (){
                    address_vm_controller.clearController();
                    address_vm_controller.account_code_controller = accountMaster_page_controller.account_code_controller;
                    address_vm_controller.account_name_controller = accountMaster_page_controller.account_name_controller;
                    address_vm_controller.pageNumber = 0;
                    address_vm_controller.getAddressMasterList(accountMaster_page_controller.pageNumber,accountMaster_page_controller.account_code_controller.text);

                  },
                ),);
                return items;

              })
            ],


          ),
          drawer: CustomDrawer(),
          floatingActionButton: Obx(()=>Visibility(
            visible:accountMaster_page_controller.view=='Account' && accountMaster_page_controller.isHeadofficePermission!="1"?true:false ,
            child: Container(
              margin: EdgeInsets.only(left: 30),
              child: DefaultButton(
                text: "Update Account",
                loading: accountMaster_page_controller.loading.value,
                press: () {
                  if(accountMaster_page_controller.account_name_controller.text.isEmpty || accountMaster_page_controller.account_name_controller == null){
                    Utils.sanckBarError('Customer Name!', "Please Enter Customer Name");
                    return  ;
                  }
                  if(accountMaster_page_controller.account_owner_Controller.text.isEmpty || accountMaster_page_controller.account_owner_Controller == null){
                    Utils.sanckBarError('Account Owner!', "Please Enter Account Owner");
                    return  ;
                  }
                  if(accountMaster_page_controller.account_type_controller.text.isEmpty || accountMaster_page_controller.account_type_controller == null){
                    Utils.sanckBarError('Account Type!', "Please Enter Account Type");
                    return  ;
                  }
                  if(accountMaster_page_controller.PhoneNo_Controller.text.isNotEmpty){
                    if(accountMaster_page_controller.PhoneNo_Controller.text.length < 10){
                      Utils.sanckBarError('Phone No.!', "Please Enter 10 Digit Phone No");
                      return  ;
                    }
                  }

                  /*if(accountMaster_page_controller.EmailId_Controller.text.isNotEmpty && EmailValidator.validate(accountMaster_page_controller.EmailId_Controller.text) == false){
                    Utils.sanckBarError('Email ID!', "Please Enter A valid Email ID");
                    return  ;
                  }*/

                  /* if(accountMaster_page_controller.account_cat_type_controller.text.isEmpty || accountMaster_page_controller.account_cat_type_controller == null){
                    Utils.sanckBarError('Account Category Type!', "Please Enter Account Category Type");
                    return  ;
                  }*/
                  if(accountMaster_page_controller.comp_prof_type_controller.value.text.isEmpty || accountMaster_page_controller.comp_prof_type_controller.value.text == null){
                    Utils.sanckBarError('Company profile Type!', "Please Enter Company profile Type");
                    return  ;
                  }
                  /* if(accountMaster_page_controller.comp_prof_sub_type_controller.value.text.isEmpty || accountMaster_page_controller.comp_prof_sub_type_controller == null){
                    Utils.sanckBarError('Company profile sub Type!', "Please Enter Company profile sub Type");
                    return  ;
                  }*/
                  if(accountMaster_page_controller.gst_registration_type_controller.value.text.isEmpty || accountMaster_page_controller.gst_registration_type_controller == null){
                    Utils.sanckBarError('GST Registration Type!', "Please Enter GST Registration Type");
                    return  ;
                  }
                  if(accountMaster_page_controller.GstNo_Controller.text.isNotEmpty && GSTValidator.validate(accountMaster_page_controller.GstNo_Controller.text) == false){
                    Utils.sanckBarError('GST No.!', "Please Enter A valid GST No.");
                    return  ;
                  }
                  if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.PanNo_Controller.value.text != accountMaster_page_controller.GstPanNo.value){
                    //print('GstPan${accountMaster_page_controller.GstPanNo.value}  PanNo...${accountMaster_page_controller.PanNo_Controller.value.text}');
                    Utils.sanckBarError('Pan No!', "Please Enter Valid Pan No");
                    return  ;
                  }
                  if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'UnRegistered' && accountMaster_page_controller.PanNo_Controller.value.text.length !=10 && accountMaster_page_controller.PanNo_Controller.value.text.isNotEmpty){
                    Utils.sanckBarError('Pan No!', "Pan No Should be in 10 digits");
                    return  ;
                  }

                  if(accountMaster_page_controller.IfscCode_Controller.text.isNotEmpty){
                    if(accountMaster_page_controller.IfscCode_Controller.text.length < 11){
                      Utils.sanckBarError('IFSC Code!', "IFSC Code Should be in 11 digits");
                      return  ;
                    }
                  }
                  if(accountMaster_page_controller.Account_Master_list[0].isManager == 1 && accountMaster_page_controller.IsActive_controller.text.isEmpty || accountMaster_page_controller.IsActive_controller == null){
                    Utils.sanckBarError('Active!', "Please Enter Active Type");
                    return  ;
                  }
                  if(accountMaster_page_controller.Account_Master_list[0].isManager == 1 && accountMaster_page_controller.IsActive_controller.text.isEmpty || accountMaster_page_controller.IsActive_controller == null){
                    Utils.sanckBarError('Active!', "Please Enter Active Type");
                    return  ;
                  }
                  if(accountMaster_page_controller.PostCode_Controller.text.isEmpty || accountMaster_page_controller.PostCode_Controller == null){
                    Utils.sanckBarError('Pin Code!', "Please Enter Pin Code");
                    return  ;
                  }

                  if(accountMaster_page_controller.State_Controller.text.isEmpty || accountMaster_page_controller.State_Controller == null){
                    Utils.sanckBarError('State!', "Please Enter State");
                    return  ;
                  }else if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.GovtStateCode.value != accountMaster_page_controller.GstStateCode.value){
                    Utils.sanckBarError('Wrong State!', "Please Enter Valid State");
                    return  ;
                  }

                  if(accountMaster_page_controller.City_Controller.text.isEmpty || accountMaster_page_controller.City_Controller == null){
                    Utils.sanckBarError('City!', "Please Enter City");
                    return  ;
                  }

                  if(accountMaster_page_controller.District_Controller.text.isEmpty || accountMaster_page_controller.District_Controller == null){
                    Utils.sanckBarError('District!', "Please Enter District");
                    return  ;
                  }


                  accountMaster_page_controller.AccountMstUploaderApiHit('Update',accountMaster_page_controller.AccountMasterGetCode_list[0].accountCode! , accountMaster_page_controller.SalesRepresentativeEmail, accountMaster_page_controller.RegionalHeadEmail);
                  //preventive_page_controller.createPreventiveCalenderCallApi();

                },
              ),
            ),
          ),),

          body: Container(
            //padding: EdgeInsets.only(bottom: 70),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Obx((){
                return  IgnorePointer(
                  ignoring: accountMaster_page_controller.isHeadofficePermission.value=="1"?true:false,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      DottedBorder(
                        color: Colors.blue,
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8),
                        dashPattern: [20, 10, 20, 10],
                        child: Container(
                            width: size.height * 0.4,
                            height: size.height * 0.2,
                            child: accountMaster_page_controller.AccountMasterGetCode_list.length>0?BindImage(context):Container()

                        ),
                      ),
                      SizedBox(height: 15,),
                      bindInputData("Customer Code",accountMaster_page_controller.account_code_controller,true,context),
                      SizedBox(height: 15,),
                      bindInputData("Customer Name*",accountMaster_page_controller.account_name_controller,accountMaster_page_controller.view=='Account'?false:true,context),

                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindAccountOwnerDropDown(context),
                      ),

                      SizedBox(height: 15,),
                      bindInputData("Branch Name",accountMaster_page_controller.AccountTitle_Controller,
                          accountMaster_page_controller.view=='Account'?false:true,context),

                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AllColors.grayColor, width: 1.0,),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'General Information',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.sisxteen),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(

                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 15,),
                              bindInputData("Old Crm Customer No.",
                                  accountMaster_page_controller.OldCRMAccountNo_Controller,
                                  true,context),

                              SizedBox(height: 15,),

                              bindAccountTypeDropDown(context),
                              SizedBox(height: 15,),
                              Form(
                                key: _formKey,
                                child:  bindInputData("Phone No.*",
                                    accountMaster_page_controller.PhoneNo_Controller,
                                    accountMaster_page_controller.view=='Account'?false:true,context),
                              ),

                              SizedBox(height: 15,),
                              bindInputData("Alternate Phone No.",
                                  accountMaster_page_controller.Alternate_PhoneNo_Controller,
                                  accountMaster_page_controller.view=='Account'?false:true,context),

                              SizedBox(height: 15,),

                              Form(
                                key: _formKeyEmail,
                                child:  bindInputData("Email Id",
                                    accountMaster_page_controller.EmailId_Controller,
                                    accountMaster_page_controller.view=='Account'?false:true,context),

                              ),

                              SizedBox(height: 15,),
                              bindAccCatogeryTypeDropDown(context),
                              SizedBox(height: 15,),

                              bindComProfTypeDropDown(context),
                              SizedBox(height: 15,),

                              Obx((){
                                return Visibility(
                                  visible: accountMaster_page_controller.compProfileRemrk.isFalse ? true : false,
                                  child:bindComProfSubTypeDropDown(context), );
                              }),

                              SizedBox(height: 15,),

                              Obx((){
                                return Visibility(
                                  visible:  accountMaster_page_controller.compProfileRemrk.value,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          readOnly:  accountMaster_page_controller.view=='Account'?false:true,
                                          controller: accountMaster_page_controller.comp_prof_remarks_controller,
                                          decoration: InputDecoration(
                                              hintText: "Company Profile Remarks",
                                              labelText: "Company Profile Remarks",
                                              //suffixIcon: Icon(Icons.email),
                                              contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),

                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue)
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),

                                        ),
                                      ),
                                      SizedBox(height: 15,),

                                    ],
                                  ),
                                );
                              }),

                              bindGstRegistrationTypeDropDown(context),

                              SizedBox(height: 15,),

                              Obx(() {
                                return
                                  Visibility(
                                    visible: accountMaster_page_controller.GstRegistration.value,
                                    child: Column(
                                      children: [
                                        Form(
                                          key: _formKeyGst,
                                          child:  bindInputData("GST No.",
                                              accountMaster_page_controller.GstNo_Controller,
                                              accountMaster_page_controller.view=='Account'?false:true,context),

                                        ),
                                        SizedBox(height: 15,),
                                      ],
                                    ),
                                  );
                              } ),

                              Form(
                                key: _formKeyPanNo,
                                child:  bindInputData("Customer PAN No.",
                                    accountMaster_page_controller.PanNo_Controller,
                                    accountMaster_page_controller.view=='Account'?false:true,context),

                              ),

                              SizedBox(height: 15,),
                              bindInputData("Customer IFSC Code",
                                  accountMaster_page_controller.IfscCode_Controller,
                                  accountMaster_page_controller.view=='Account'?false:true,context),


                              SizedBox(height: 15,),

                              bindInputData("Website",
                                  accountMaster_page_controller.Website_Controller,
                                  accountMaster_page_controller.view=='Account'?false:true,context),

                              SizedBox(height: 15,),

                              bindIsReferralDropDown(context),

                              Obx(() {
                                return Visibility(
                                  visible: accountMaster_page_controller
                                      .isReferral.value,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15,),
                                      bindInputData("Referral By",
                                          accountMaster_page_controller.ReferralByName_Controller,
                                          accountMaster_page_controller.view=='Account'?false:true,context),

                                    ],
                                  ),
                                );
                              }),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AllColors.grayColor, width: 1.0,),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Billing Address',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.sisxteen),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(

                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              bindInputData("Address",
                                  accountMaster_page_controller.Address_controller,
                                  accountMaster_page_controller.view=='Account'?false:true,context),

                              SizedBox(height: 15,),
                              bindInputData("Address2",
                                  accountMaster_page_controller.Address2_Controller,
                                  accountMaster_page_controller.view=='Account'?false:true,context),
                              SizedBox(height: 15,),
                              Obx((){
                                return Visibility(
                                  visible:accountMaster_page_controller.ShowState1.value,
                                  child: Container(
                                      child: bindPostalCodeDropDown(context)
                                  ),
                                );
                              }),
                              SizedBox(height: 15,),
                              Obx((){
                                return Visibility(
                                  visible:accountMaster_page_controller.ShowState1.value,
                                  child: Container(
                                      child: bindStateDropDown(context)
                                  ),
                                );
                              }),
                              SizedBox(height: 15,),
                              Obx((){
                                return Visibility(
                                  visible:accountMaster_page_controller.ShowState1.value,
                                  child: Container(
                                      child: bindCityDropDown(context)
                                  ),
                                );
                              }),
                              SizedBox(height: 15,),
                              Obx((){
                                return Visibility(
                                  visible:accountMaster_page_controller.ShowState1.value,
                                  child: Container(
                                      child: bindDistrictDropDown(context)
                                  ),
                                );
                              }),
                              SizedBox(height: 15,),

                              Obx(() {
                                return  bindInputData("Full Address", accountMaster_page_controller.FullAddress_Controller.value, true,context);

                              },)

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AllColors.grayColor, // Set the border color here
                            width: 1.0, // Adjust the border width if necessary
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Shipping Address',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.sisxteen),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(

                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: DropdownButtonFormField<String>(
                                      value: accountMaster_page_controller.yesNoValue.value,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,   // 👈 top & bottom padding (increase/decrease)
                                          horizontal: 6,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      items: ["Yes", "No"].map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        accountMaster_page_controller.yesNoValue.value = value!;
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Obx(() => CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text(
                                        "Same as Billing",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: AllFontSize.twelve,
                                        ),
                                      ),
                                      value: accountMaster_page_controller.isChecked.value,
                                      onChanged: (bool? value) {

                                        accountMaster_page_controller.toggleCheckbox();
                                        if(value == true){
                                          accountMaster_page_controller.Shipping_Address_controller.value.text=accountMaster_page_controller.Address_controller.value.text;
                                          accountMaster_page_controller.Shipping_Address2_Controller.value.text=accountMaster_page_controller.Address2_Controller.value.text;
                                          accountMaster_page_controller.Shipping_PostCode_Controller.value.text=accountMaster_page_controller.PostCode_Controller.value.text;
                                          accountMaster_page_controller.Shipping_City_Controller.value.text=accountMaster_page_controller.City_Controller.value.text ;
                                          accountMaster_page_controller.Shipping_State_Controller.value.text = accountMaster_page_controller.State_Controller.value.text;
                                          accountMaster_page_controller.Shipping_District_Controller.value.text = accountMaster_page_controller.District_Controller.value.text;
                                          accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = accountMaster_page_controller.FullAddress_Controller.value.text;
                                          accountMaster_page_controller.ShowState.value=false;
                                          accountMaster_page_controller.ShowState.value=true;
                                        }else{
                                          accountMaster_page_controller.Shipping_Address_controller.value.clear();
                                          accountMaster_page_controller.Shipping_Address2_Controller.value.clear();
                                          accountMaster_page_controller.Shipping_PostCode_Controller.value.clear();
                                          accountMaster_page_controller.Shipping_City_Controller.value.clear();
                                          accountMaster_page_controller.Shipping_State_Controller.value.clear();
                                          accountMaster_page_controller.Shipping_District_Controller.value.clear();
                                          accountMaster_page_controller.Shipping_FullAddress_Controller.value.clear();
                                          accountMaster_page_controller.ShowState.value=false;
                                          accountMaster_page_controller.ShowState.value=true;
                                        }
                                      },
                                    )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: Icon(Icons.add),
                                        onTap: (){
                                          accountMaster_page_controller.pageNumber = 0;
                                          accountMaster_page_controller.getAddressMasterList(accountMaster_page_controller.pageNumber,"","", "");
                                          accountMaster_page_controller.showConsigneeAddressList(context, accountMaster_page_controller.address_master_list);

                                        },
                                      ),

                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: (){
                                          accountMaster_page_controller.selectedItem.value = -1;
                                          accountMaster_page_controller.Shipping_Address_controller.value.text="";
                                          accountMaster_page_controller.Shipping_Address2_Controller.value.text="";
                                          accountMaster_page_controller.Shipping_PostCode_Controller.value.text="";
                                          accountMaster_page_controller.Shipping_City_Controller.value.text="" ;
                                          accountMaster_page_controller.Shipping_State_Controller.value.clear();
                                          accountMaster_page_controller.ShowState.value=false;
                                          accountMaster_page_controller.ShowState.value=true;
                                          accountMaster_page_controller.Shipping_District_Controller.value.text="";
                                          accountMaster_page_controller.consigneeId = '';
                                          accountMaster_page_controller.isChecked.value=false;
                                          accountMaster_page_controller.Shipping_FullAddress_Controller.value.clear();

                                        },
                                        child: Icon(Icons.update),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Obx((){
                                if(accountMaster_page_controller.Shipping_FullAddress_Controller.value.text.isNotEmpty ||
                                    accountMaster_page_controller.Shipping_FullAddress_Controller.value.text == null){
                                  accountMaster_page_controller.yesNoValue.value="Yes";
                                }
                                return Visibility(
                                  visible:accountMaster_page_controller.yesNoValue.value=="Yes",
                                  child:  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          controller: accountMaster_page_controller.Shipping_Address_controller.value,
                                          //maxLength: 150,
                                          onChanged: (value){
                                            print('valus....$value');
                                            final parts = [
                                              value,
                                              accountMaster_page_controller.Shipping_Address2_Controller.value.text,
                                              accountMaster_page_controller.Shipping_City_Controller.value.text,
                                              accountMaster_page_controller.Shipping_District_Controller.value.text,
                                              accountMaster_page_controller.Shipping_State_Controller.value.text,
                                              accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
                                            ];

                                            // Filter out empty strings and join with commas
                                            final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                                            accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
                                          },
                                          maxLength: 500,
                                          decoration: InputDecoration(
                                              hintText: "Address",
                                              labelText: "Address",
                                              //suffixIcon: Icon(Icons.email),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: AllFontSize.ten,
                                                  horizontal: AllFontSize.ten),

                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue)
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),

                                        ),
                                      ),

                                      SizedBox(height: 15,),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                        child: TextFormField(
                                          controller: accountMaster_page_controller.Shipping_Address2_Controller.value,
                                          //maxLength: 150,
                                          onChanged: (value){
                                            final parts = [
                                              accountMaster_page_controller.Shipping_Address_controller.value.text,
                                              value,
                                              accountMaster_page_controller.Shipping_City_Controller.value.text,
                                              accountMaster_page_controller.Shipping_District_Controller.value.text,
                                              accountMaster_page_controller.Shipping_State_Controller.value.text,
                                              accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
                                            ];

                                            // Filter out empty strings and join with commas
                                            final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                                            accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
                                          },
                                          maxLength: 500,
                                          decoration: InputDecoration(
                                              hintText: "Address2",
                                              labelText: "Address2",
                                              //suffixIcon: Icon(Icons.email),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: AllFontSize.ten,
                                                  horizontal: AllFontSize.ten),

                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue)
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),

                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                      Obx((){
                                        return Visibility(
                                          visible:accountMaster_page_controller.ShowState.value,
                                          child: Container(
                                              child: bindShippingPostalCodeDropDown(context)
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 15,),
                                      Obx(() {
                                        return Visibility(
                                          visible:accountMaster_page_controller.ShowState.value,
                                          child: Container(
                                            //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                            child: bindShippingStateDropDown(context),
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 15,),
                                      Obx(() {
                                        return Visibility(
                                          visible:accountMaster_page_controller.ShowState.value,
                                          child: Container(
                                              child: bindShippingCityDropDown(context)
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 15,),
                                      Obx(() {
                                        return Visibility(
                                          visible:accountMaster_page_controller.ShowState.value,
                                          child: Container(
                                              child: bindShippingDistrictDropDown(context)
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 15,),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: TextFormField(
                                          readOnly: true,
                                          maxLines: 3,
                                          controller: accountMaster_page_controller.Shipping_FullAddress_Controller.value,
                                          decoration: InputDecoration(
                                              hintText: "Full Address",
                                              labelText: "Full Address",
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: AllFontSize.ten,
                                                  horizontal: AllFontSize.ten),

                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue)
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),);
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AllColors.grayColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Company Information',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.sisxteen),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(

                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [

                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextFormField(
                                  readOnly:  accountMaster_page_controller.view=='Account'?false:true,
                                  keyboardType: TextInputType.number,
                                  controller: accountMaster_page_controller.No_Of_Emp_Controller,
                                  decoration: InputDecoration(
                                      hintText: "No. Of Employees",
                                      labelText: "No. Of Employees",
                                      contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),

                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),

                                ),
                              ),

                              SizedBox(height: 15,),

                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  readOnly:  accountMaster_page_controller.view=='Account'?false:true,
                                  keyboardType: TextInputType.number,
                                  controller: accountMaster_page_controller.Annual_Revenue_Controller,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(r',')), // Block commas
                                    FilteringTextInputFormatter.deny(RegExp(r',')), // Block commas
                                  ],
                                  decoration: InputDecoration(
                                      hintText: "Customer Annual Turnover",
                                      labelText: "Customer Annual Turnover",
                                      contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),

                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),

                                ),
                              ),

                              SizedBox(height: 15,),

                              bindTatResponseTypeDropDown(context),

                              SizedBox(height: 15,),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AllColors.grayColor,
                            width: 1.0, // Adjust the border width if necessary
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Geo Information',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.sisxteen),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(

                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [

                              /*Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                           child: TextFormField(
                             readOnly: true,
                             keyboardType: TextInputType.number,
                             controller: accountMaster_page_controller
                                 .Frontliner_Controller,
                             decoration: InputDecoration(
                                 hintText: "Frontliner",
                                 labelText: "Frontliner",
                                 //suffixIcon: Icon(Icons.email),
                                 contentPadding: EdgeInsets.symmetric(
                                     vertical: AllFontSize.ten,
                                     horizontal: AllFontSize.ten),

                                 focusedBorder: OutlineInputBorder(
                                     borderSide: BorderSide(color: Colors.blue)
                                 ),
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),

                           ),
                         ),

                         SizedBox(height: 15,),*/

                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  controller: accountMaster_page_controller
                                      .BranchHead_Controller,
                                  decoration: InputDecoration(
                                      hintText: "Region Name",
                                      labelText: "Region Name",
                                      //suffixIcon: Icon(Icons.email),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: AllFontSize.ten,
                                          horizontal: AllFontSize.ten),

                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),

                                ),
                              ),


                              SizedBox(height: 15,),

                              /*Container(
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                     child: TextFormField(
                       readOnly: true,
                       controller: accountMaster_page_controller
                           .ZoneHead_Controller,
                       decoration: InputDecoration(
                           hintText: "Zone Head",
                           labelText: "Zone Head",
                           //suffixIcon: Icon(Icons.email),
                           contentPadding: EdgeInsets.symmetric(
                               vertical: AllFontSize.ten,
                               horizontal: AllFontSize.ten),

                           focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue)
                           ),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10)
                           )
                       ),

                     ),
                   ),

                         SizedBox(height: 15,),*/

                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: accountMaster_page_controller
                                      .ClusterHead_Controller,
                                  decoration: InputDecoration(
                                      hintText: "Cluster Name",
                                      labelText: "Cluster Name",
                                      //suffixIcon: Icon(Icons.email),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: AllFontSize.ten,
                                          horizontal: AllFontSize.ten),

                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),

                                ),
                              ),



                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100,),

                    ],
                  ),
                );
              }),

            ),
          )

      ),
    );
  }


  Widget bindInputData(String hintData, TextEditingController controller,bool readOnly, BuildContext context,){
    int? maxLength;
    int maxLines = 1;
    double left =0;


    if (hintData == "Branch Name") {
      maxLength = 500;
      maxLines = 2;
    }
    else if (hintData == "Full address") {
      maxLines = 3;
    }
    else if(hintData == "Phone No.*"){
      maxLength = 10;
    }
    else if(hintData == "GST No."){
      maxLength = 15;
    }
    else if(hintData == "Customer IFSC Code"){
      maxLength = 11;
    }
   /* else if(hintData == "Address" || hintData == "Address2"){
      maxLength = 500;
    }*/
    else if(hintData == "Full Address" /*|| hintData == "Address2"*/){
      maxLines = 3;
    }

    if(hintData=="Customer Name*" || hintData== "Image Url" ||
        hintData== "Branch Name"|| hintData== "Customer Code"){
      left=15;
    }

    return Padding(
      padding: EdgeInsets.only(left: left, right: left),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly,
        keyboardType:hintData == "Phone No.*" || hintData == "Alternate Phone No."?TextInputType.phone: TextInputType.text,
        inputFormatters: (hintData == "Phone No.*" || hintData == "Alternate Phone No.")
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          else if (hintData == "Phone No.*" && value.length != 10) {
            return 'Phone No. should be exactly 10 digits';
          }
          else if (hintData == "Email Id" && !EmailValidator.validate(value)) {
            return 'Please Enter A Valid Email Id';
          }
          else if(hintData == "GST No."){
            if (!GSTValidator.validate(value)) {
              return 'Invalid GST No.';
            }
            else if(value.length != 15){
              return 'GST No. Should be exactly 15 digit';
            }
          }
          else if(hintData == "Customer PAN No.") {
            if (accountMaster_page_controller.gst_registration_type_controller
                .value.text == 'Registered' && value != accountMaster_page_controller.GstPanNo.value) {
              return 'Please Enter Valid Pan No.';
            }
          }
          return null;
        },
        onChanged: (value) {
          if(hintData == "Phone No.*"){
            _formKey.currentState?.validate();
          }
          else if(hintData == "Email Id"){
            _formKeyEmail.currentState?.validate();
          }
          else if(hintData == "GST No."){
            _formKeyGst.currentState?.validate();
            if(value.length >= 2){
              accountMaster_page_controller.GstStateCode.value = value.substring(0, 2);
            }
            if (value.length >= 12) {
              accountMaster_page_controller.GstPanNo.value = value.substring(2, 12);
            }
          }
          else if(hintData == "Customer PAN No."){
            _formKeyPanNo.currentState?.validate();
          }
          else if(hintData == "Address"){
            final parts = [
              value,
              accountMaster_page_controller.Address2_Controller.text,
              accountMaster_page_controller.City_Controller.text,
              accountMaster_page_controller.District_Controller.text,
              accountMaster_page_controller.State_Controller.text,
              accountMaster_page_controller.PostCode_Controller.text,
            ];
            final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

            accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;

          }
          else if(hintData == "Address2") {
            final parts = [
              accountMaster_page_controller.Address_controller.text,
              value,
              accountMaster_page_controller.City_Controller.text,
              accountMaster_page_controller.District_Controller.text,
              accountMaster_page_controller.State_Controller.text,
              accountMaster_page_controller.PostCode_Controller.text,
            ];
            final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

            accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;

          }


        },
        decoration: InputDecoration(
            hintText: hintData,
            labelText: hintData,
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten,
                horizontal: AllFontSize.ten),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
      ),
    ) ;
  }


  Widget BindImage(BuildContext context){
    if(accountMaster_page_controller.AccountMasterGetCode_list[0].profile != null && accountMaster_page_controller.AccountMasterGetCode_list[0].profile != ''){
      return Container(
        child: Center(
            child: InkWell(
                onTap: (){
                  accountMaster_page_controller.UploadImageType_controller.text= "Upload Image";
                  accountMaster_page_controller.view=='Account'?UploadImageDailog(context):"";
                },
                child: Obx((){
                  return
                    Image.network(accountMaster_page_controller.AccountMasterGetCode_list[0].profile??"");}))),
      );
    }
    else
      return Container(
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset("assests/images/no_image_placeholder.png")
          /*CircleAvatar(
             backgroundColor: AllColors.grayColor,
             backgroundImage: AssetImage("assets/images/no_file.png"),
           ),*/
        ),
      );
  }

  UploadImageDailog(BuildContext context){
    accountMaster_page_controller.ImageUrl_Controller.clear();
    accountMaster_page_controller.UploadImage.value = false;
    accountMaster_page_controller.ButtonText.value = 'Choose files';
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title:  Text(
              'Upload Image',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Wrap(
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Type',
                        style: GoogleFonts.poppins(
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w400,
                          color: AllColors.primaryDark1,
                        ),),

                      SizedBox(height: 15,),

                      bindTypeDropDown(context),

                      SizedBox(height: 15,),

                      Obx(() {
                        return Visibility(
                          visible: accountMaster_page_controller.UploadImage
                              .value,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),

                            child: TextFormField(
                              controller: accountMaster_page_controller
                                  .ImageUrl_Controller,
                              decoration: InputDecoration(
                                  hintText: "Url",
                                  labelText: "Url",
                                  //suffixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: AllFontSize.ten,
                                      horizontal: AllFontSize.ten),

                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue)
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),

                            ),
                          ),
                        );

                      }),

                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              if(accountMaster_page_controller.UploadImageType_controller.text.isEmpty || accountMaster_page_controller.UploadImageType_controller == null){
                                Utils.sanckBarError('Error : Image', 'Please Upload Image Type.');
                                return;

                              }
                              //accountMaster_page_controller.upLoadImage(context);

                              if(accountMaster_page_controller.UploadImageType_controller.text== "Upload Image"){
                                accountMaster_page_controller.upLoadImage(context);
                              }else if(accountMaster_page_controller.UploadImageType_controller.text== "Url"){
                                if(accountMaster_page_controller.ImageUrl_Controller.text.isEmpty || accountMaster_page_controller.ImageUrl_Controller == null){
                                  Utils.sanckBarError('Error : Image', 'Please Enter Image Url.');
                                }else{
                                  accountMaster_page_controller.upLoadImageApi(context);
                                }
                              }

                            },
                            child: Container(
                              //width: 120,
                              alignment: Alignment.center,
                              child: Obx((){
                                return Text(
                                  accountMaster_page_controller.ButtonText.value.toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.customDarkerWhite,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );},
                              ),
                            ),
                          ),


                        ],)

                    ],
                  ),
                ]),
          );
        }
    );
  }

  Widget bindTypeDropDown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      //padding: EdgeInsets.symmetric(horizontal: AllFontSize.ten),
      child: DropdownMenu<String>(
        initialSelection: accountMaster_page_controller.UploadImageType_controller.text.isNotEmpty
            ? accountMaster_page_controller.UploadImageType_controller.text : null,
        width: MediaQuery.of(context).size.width * 0.6,
        menuHeight: 200,
        hintText: 'Select Type',
        label: Text('Select Type'),
        trailingIcon: Icon(Icons.arrow_drop_down),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.ten,
            horizontal: AllFontSize.ten,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSelected: (String? value) {
          if (value == null) return;

          accountMaster_page_controller.UploadImageType_controller.text = value;
          accountMaster_page_controller.ImageUrl_Controller.clear();

          if (value == 'Url') {
            accountMaster_page_controller.UploadImage.value = true;
            accountMaster_page_controller.ButtonText.value = 'Upload Url';
          } else {
            accountMaster_page_controller.UploadImage.value = false;
            accountMaster_page_controller.ButtonText.value = 'Choose files';
          }
        },
        dropdownMenuEntries: accountMaster_page_controller.UploadImageTypeList.map<DropdownMenuEntry<String>>(
              (String item) => DropdownMenuEntry<String>(
            value: item,
            label: item,
            labelWidget: Text(item,
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.sisxteen,
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }



  Widget bindAccountOwnerDropDown(context){
    return IgnorePointer(
      ignoring:  accountMaster_page_controller.Account_Master_list != null &&
          accountMaster_page_controller.Account_Master_list.isNotEmpty && accountMaster_page_controller.Account_Master_list[0].isManager == 1 &&
          accountMaster_page_controller.view=='Account'?false:true,
      child: Autocomplete<EmployeeMemberModel>(
        displayStringForOption: _displayEmpMemberForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if(accountMaster_page_controller.view=='VIEW'){
            accountMaster_page_controller.employee_Member_list.value=[];
            return accountMaster_page_controller.employee_Member_list;
          }
          if (textEditingValue.text.isEmpty) {
            return accountMaster_page_controller.employee_Member_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return accountMaster_page_controller.employee_Member_list
              .where((EmployeeMemberModel option) {
            return option.fullName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (EmployeeMemberModel selection) {
          print(selection.loginEmailId);
          // Update the TextField with the selected
          accountMaster_page_controller.account_owner_Controller.text =
              _displayEmpMemberForOption(selection).toString();
          accountMaster_page_controller.AccountOwner = selection.loginEmailId!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            accountMaster_page_controller.getEmployee(accountMaster_page_controller.AccountOwner);
          });
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            /*readOnly: accountMaster_page_controller.Account_Master_list != null &&
                accountMaster_page_controller.Account_Master_list.isNotEmpty && accountMaster_page_controller.Account_Master_list[0].isManager == 1 &&
                accountMaster_page_controller.view=='Account'?false:true,*/
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.account_owner_Controller.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Account Owner*',
              labelText: 'Account Owner*',

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<EmployeeMemberModel> onSelected,
            Iterable<EmployeeMemberModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.9,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final EmployeeMemberModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.fullName.toString(),
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
      ),
    );
  }

  Widget bindAccountTypeDropDown(context) {
    return Container(
      //margin: const EdgeInsets.only(right: 15.0),
      width: double.infinity,
      child: DropdownMenu<CustomList>(
        width: size.width-55,
        controller:  accountMaster_page_controller.account_type_controller,
        label: Text(
          "Account Type*",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
        enabled: accountMaster_page_controller.view=='Account'?true:false,
        //initialSelection:accountMaster_page_controller.get_Acc_type_list.length>0?accountMaster_page_controller.get_Acc_type_list[1]:null,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (CustomList? selection) {
          print(selection);
          accountMaster_page_controller.account_type_controller.text =
              _displayAccTypeForOption(selection!).toString();


        },

        dropdownMenuEntries: accountMaster_page_controller.get_Acc_type_list.map<DropdownMenuEntry<CustomList>>((CustomList e) {
          return DropdownMenuEntry<CustomList>(value: e, label: e.value!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  /*Widget bindAccountTypeDropDown(context){
    return Autocomplete<CustomList>(
      displayStringForOption: _displayAccTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.get_Acc_type_list.value=[];
          return accountMaster_page_controller.get_Acc_type_list;
        }
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Acc_type_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.get_Acc_type_list
            .where((CustomList option) {
          return option.value
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CustomList selection) {
        print(selection.value);
        // Update the TextField with the selected
        accountMaster_page_controller.account_type_controller.text =
            _displayAccTypeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            readOnly: accountMaster_page_controller.view=='Account'?false:true,
           *//* readOnly: accountMaster_page_controller.view=='FromTaskMainScreen'
                || accountMaster_page_controller.view=='VIEW' ||
                accountMaster_page_controller.view=='Task'||
                accountMaster_page_controller.view=='FromSaleCycleMainScreen' ||
                accountMaster_page_controller.view=="FromQuoteApproval"?true:false,*//*
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.account_type_controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: (){
                    focusNode.requestFocus();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Account Type*',
              labelText: 'Account Type*',
              *//*hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten
              ),*//*
              *//*labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen),*//*
              *//*focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AllColors.primaryDark1), // Change the color to green
              ),*//*
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CustomList> onSelected,
          Iterable<CustomList> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
                width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final CustomList option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.value.toString(),
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
  }*/

  Widget bindAccCatogeryTypeDropDown(context){
    return IgnorePointer(
      ignoring: accountMaster_page_controller.view=='Account'?false:true,
      child: Autocomplete<GetMasterTypeModel>(
        displayStringForOption: _displayAccCategoryForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if(accountMaster_page_controller.view=='VIEW'){
            accountMaster_page_controller.get_Acc_category_list.value=[];
            return accountMaster_page_controller.get_Acc_category_list;
          }
          if (textEditingValue.text.isEmpty) {
            return accountMaster_page_controller.get_Acc_category_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return accountMaster_page_controller.get_Acc_category_list
              .where((GetMasterTypeModel option) {
            return option.code
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (GetMasterTypeModel selection) {
          print(selection.code);
          // Update the TextField with the selected
          accountMaster_page_controller.account_cat_type_controller.text =
              _displayAccCategoryForOption(selection).toString();
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
                controller.clear();
              },
              readOnly: accountMaster_page_controller.view=='Account'?false:true,
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.account_cat_type_controller
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Account Category Type',
                labelText: 'Account Category Type',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<GetMasterTypeModel> onSelected,
            Iterable<GetMasterTypeModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.85,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final GetMasterTypeModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:  option.code!,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                                TextSpan(
                                  text: " (${option.description!})",
                                  style: GoogleFonts.poppins(
                                      color: AllColors.redColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                              ],
                            ),
                            softWrap: true,
                          )
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bindComProfTypeDropDown(context){
    return IgnorePointer(
      ignoring: accountMaster_page_controller.view=='Account'?false:true,
      child: Autocomplete<CompanyTypeModel>(
        initialValue: TextEditingValue(
          text: accountMaster_page_controller.comp_prof_type_controller.value.text,
        ),
        displayStringForOption: _displayCompProfileTypeForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if(accountMaster_page_controller.view=='VIEW'){
            accountMaster_page_controller.get_Comp_Profile_type_list.value=[];
            return accountMaster_page_controller.get_Comp_Profile_type_list;
          }
          if (textEditingValue.text.isEmpty) {
            return await accountMaster_page_controller.getCompanyProfileTypeApi(textEditingValue.text);
            //return accountMaster_page_controller.get_Comp_Profile_type_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          /*return accountMaster_page_controller.get_Comp_Profile_type_list
              .where((CompanyTypeModel option) {
            return option.description
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();*/

          return await accountMaster_page_controller.getCompanyProfileTypeApi(textEditingValue.text);
        },
        onSelected: (CompanyTypeModel selection) {
          print(selection.description);
          // Update the TextField with the selected
          accountMaster_page_controller.comp_prof_type_controller.value.text =
              _displayCompProfileTypeForOption(selection).toString();
          if(accountMaster_page_controller.comp_prof_type_controller.value.text == 'Others'){
            accountMaster_page_controller.compProfileRemrk.value = true;
          }else{
            accountMaster_page_controller.compProfileRemrk.value = false;
            //accountMaster_page_controller.getCompanyProfileSubTypeApi(/*accountMaster_page_controller.comp_prof_type_controller.value.text*/);

          }
          //accountMaster_page_controller.getCompanyProfileSubTypeApi();
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              cursorColor: AllColors.primaryDark1,
              controller: controller,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Company Profile Type*',
                labelText: 'Company Profile Type*',

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<CompanyTypeModel> onSelected,
            Iterable<CompanyTypeModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.75,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final CompanyTypeModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.description.toString(),
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
      ),
    );
  }

  Widget bindComProfSubTypeDropDown(context){
    return Autocomplete<CompanyProfileMstModel>(
      displayStringForOption: _displayCompProfSubForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.CompanyProfileMst_list.value=[];
          return accountMaster_page_controller.CompanyProfileMst_list;
        }
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.CompanyProfileMst_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.CompanyProfileMst_list
            .where((CompanyProfileMstModel option) {
          return option.description
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CompanyProfileMstModel selection) {
        print(selection.description);
        // Update the TextField with the selected
        accountMaster_page_controller.comp_prof_sub_type_controller.value.text =
            _displayCompProfSubForOption(selection).toString();
        //accountMaster_page_controller.getCompanyProfileTypeApi();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Obx(() {
            return
              TextField(
                readOnly: accountMaster_page_controller.view == 'Account'
                    ? false
                    : true,
                /*  readOnly: accountMaster_page_controller.view=='FromTaskMainScreen'
                  || accountMaster_page_controller.view=='VIEW' ||
                  accountMaster_page_controller.view=='Task'
                  ||accountMaster_page_controller.view=='FromSaleCycleMainScreen'
                  || accountMaster_page_controller.view=="FromQuoteApproval"?true:false,*/
                cursorColor: AllColors.primaryDark1,
                controller: controller
                  ..text = accountMaster_page_controller
                      .comp_prof_sub_type_controller.value
                      .text,
                focusNode: focusNode,
                //onSubmitted: onFieldSubmitted,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: AllColors.primaryDark1,
                    onPressed: (){
                      if(focusNode.hasFocus){
                        focusNode.unfocus();
                      }else{
                        focusNode.requestFocus();
                      }
                    },
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Company Profile Sub Type',
                  labelText: 'Company Profile Sub Type',
                  /*hintStyle: GoogleFonts.poppins(
                    color: AllColors.lightblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.ten
                ),*/
                  /*labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                    fontSize: AllFontSize.sisxteen)*/
                  /*focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AllColors.primaryDark1), // Change the color to green
                ),*/
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              );
          }),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CompanyProfileMstModel> onSelected,
          Iterable<CompanyProfileMstModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),

              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final CompanyProfileMstModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),

                      child: Text(
                        option.description.toString(),
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


  /*Widget bindGstRegistrationTypeDropDown(context){
    return Autocomplete<CustomList>(
      displayStringForOption: _displayGstRegisterTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.get_Gst_Registration_list.value=[];
          return accountMaster_page_controller.get_Gst_Registration_list;
        }
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Gst_Registration_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.get_Gst_Registration_list
            .where((CustomList option) {
          return option.value
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CustomList selection) {
        print(selection.value);
        // Update the TextField with the selected
        accountMaster_page_controller.gst_registration_type_controller.value.text =
            _displayGstRegisterTypeForOption(selection).toString();
        if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered'){
          accountMaster_page_controller.GstRegistration.value = true;
        }else{
         // accountMaster_page_controller.GstStateList.addAll(accountMaster_page_controller.StateMaster_list);
          accountMaster_page_controller.GstRegistration.value = false;
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            readOnly: accountMaster_page_controller.view=='Account'?false:true,
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.gst_registration_type_controller.value
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'GST Registration Type*',
              labelText: 'GST Registration Type*',
              *//*hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten
              ),*//*
              *//*labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen),*//*
              *//*focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AllColors.primaryDark1), // Change the color to green
              ),*//*
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CustomList> onSelected,
          Iterable<CustomList> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final CustomList option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.value.toString(),
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
  }*/

  Widget bindGstRegistrationTypeDropDown(context) {
    return Container(
      //margin: const EdgeInsets.only(right: 15.0),
      width: double.infinity,
      child: DropdownMenu<CustomList>(
        width: size.width-55,
        controller:  accountMaster_page_controller.gst_registration_type_controller.value,
        label: Text(
          "GST Type*",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w300),
        ),
        enabled: accountMaster_page_controller.view=='Account'?true:false,
        //initialSelection: accountMaster_page_controller.get_Gst_Registration_list[1],
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (CustomList? selection) {
          print(selection);
          accountMaster_page_controller.gst_registration_type_controller.value.text =
              _displayGstRegisterTypeForOption(selection!).toString();
          if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered'){
            accountMaster_page_controller.GstRegistration.value = true;
          }else{
            // accountMaster_page_controller.GstStateList.addAll(accountMaster_page_controller.StateMaster_list);
            accountMaster_page_controller.GstRegistration.value = false;
          }

        },

        dropdownMenuEntries: accountMaster_page_controller.get_Gst_Registration_list.map<DropdownMenuEntry<CustomList>>((CustomList e) {
          return DropdownMenuEntry<CustomList>(value: e, label: e.value!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  Widget bindIsActiveDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIsActiveForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.IsActiveTypeList.value=[];
          return accountMaster_page_controller.IsActiveTypeList;
        }
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.IsActiveTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.IsActiveTypeList
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
        accountMaster_page_controller.IsActive_controller.text =
            _displayIsActiveForOption(selection).toString();
        if(accountMaster_page_controller.IsActive_controller.text=="Yes"){
          accountMaster_page_controller.InActive=1;
          print(accountMaster_page_controller.InActive);
        }else if(accountMaster_page_controller.IsActive_controller.text=="No"){
          accountMaster_page_controller.InActive=0;
          print(accountMaster_page_controller.InActive);
        }
        print('IsActive.....${accountMaster_page_controller.IsActive_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            readOnly: accountMaster_page_controller.view=='Account'?false:true,
            /* readOnly: accountMaster_page_controller.view=='FromTaskMainScreen'
                || accountMaster_page_controller.view=='VIEW' ||
                accountMaster_page_controller.view=='Task'||
                accountMaster_page_controller.view=='FromSaleCycleMainScreen'
                || accountMaster_page_controller.view=="FromQuoteApproval"?true:false,*/
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.IsActive_controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Active',
              labelText: 'Active',
              /*hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten
              ),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AllColors.primaryDark1), // Change the color to green
              ),*/

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
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
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

  /*Widget bindIsReferralDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIsActiveForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.IsActiveTypeList.value=[];
          return accountMaster_page_controller.IsActiveTypeList;
        }
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.IsActiveTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.IsActiveTypeList
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
        accountMaster_page_controller.ReferralBy_Controller.text =
            _displayIsActiveForOption(selection).toString();
        if(accountMaster_page_controller.ReferralBy_Controller.text == 'Yes'){
          accountMaster_page_controller.isReferral.value = true;
        }else{
          accountMaster_page_controller.isReferral.value = false;
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            readOnly: accountMaster_page_controller.view=='Account'?false:true,
            *//* readOnly: accountMaster_page_controller.view=='FromTaskMainScreen'
                || accountMaster_page_controller.view=='VIEW' ||
                accountMaster_page_controller.view=='Task'||
                accountMaster_page_controller.view=='FromSaleCycleMainScreen'
                || accountMaster_page_controller.view=="FromQuoteApproval"?true:false,*//*
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.ReferralBy_Controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Is Referral',
              labelText: 'Is Referral',


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
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
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
  }*/

  Widget bindIsReferralDropDown(context) {
    return Container(
      // margin: const EdgeInsets.only(left: 15.0),
      width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width-55,
        controller:  accountMaster_page_controller.ReferralBy_Controller,
        label: Text(
          "Is Referral",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w300),
        ),
        //initialSelection: "No",
        enabled: accountMaster_page_controller.view=='Account'?true:false,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (String? selection) {
          print(selection);
          accountMaster_page_controller.ReferralBy_Controller.text =
              _displayIsActiveForOption(selection!).toString();
          if(accountMaster_page_controller.ReferralBy_Controller.text == 'Yes'){
            accountMaster_page_controller.isReferral.value = true;
          }else{
            accountMaster_page_controller.isReferral.value = false;
          }

        },

        dropdownMenuEntries: accountMaster_page_controller.IsActiveTypeList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  Widget bindStateDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayStateListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if(accountMaster_page_controller.view=='VIEW'){
          accountMaster_page_controller.StateMaster_list.value=[];
          return accountMaster_page_controller.StateMasterPinCode_list;
        }
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.StateMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return accountMaster_page_controller.StateMasterPinCode_list
            .where((PincodeMasterModel option) {
          return option.stateName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();

      },
      onSelected: (PincodeMasterModel selection) {
        print(selection.stateName);
        // Update the TextField with the selected
        accountMaster_page_controller.State_Controller.text =
            _displayStateListForOption(selection).toString();
        accountMaster_page_controller.GovtStateCode.value = accountMaster_page_controller.State_Controller.text.substring(0, 2);
        // print('GstCOde...: ${accountMaster_page_controller.GovtStateCode}');
        /* if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.GstStateCode.value != selection.governmentStateCode){
          Utils.sanckBarError("Wrong State", "Please Select Valid State");
        }*/

        //accountMaster_page_controller.getCompanyProfileTypeApi();

        final parts = [
          accountMaster_page_controller.Address_controller.text,
          accountMaster_page_controller.Address2_Controller.text,
          accountMaster_page_controller.City_Controller.text,
          accountMaster_page_controller.District_Controller.text,
          accountMaster_page_controller.State_Controller.text,
          accountMaster_page_controller.PostCode_Controller.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(
            readOnly: accountMaster_page_controller.view=='Account'?false:true,
            //maxLength: 50,
            /*validator: (value){
              if(value == null || value.isEmpty){
                return null;
              }
              else if(value != accountMaster_page_controller.GstStateCode){
                return 'Please select valid state';
              }else{
                return null;
              }
            },*/
            onChanged: (value) {
              /*for(int i = 0; i< accountMaster_page_controller.StateMaster_list.length; i++){
                if(accountMaster_page_controller.GstStateCode == selection.governmentStateCode){
                  accountMaster_page_controller.GovtStateCode = selection.governmentStateCode!;
                  //accountMaster_page_controller.GstStateList.clear();
                  //accountMaster_page_controller.GstStateList.add(accountMaster_page_controller.StateMaster_list[i]);
                  print('GstStae....${accountMaster_page_controller.GovtStateCode}');
                }
              }
              if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.GstStateCode != selection.governmentStateCode){
                Utils.sanckBarError("Wrong State", "Please Select Valid State");
              }*/

              final parts = [
                accountMaster_page_controller.Address_controller.text,
                accountMaster_page_controller.Address2_Controller.text,
                accountMaster_page_controller.City_Controller.text,
                accountMaster_page_controller.District_Controller.text,
                value,
                accountMaster_page_controller.PostCode_Controller.text,
              ];

              // Filter out empty strings and join with commas
              final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

              accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.State_Controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'State*',
              labelText: 'State*',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PincodeMasterModel> onSelected,
          Iterable<PincodeMasterModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PincodeMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.stateName.toString(),
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

  Widget bindPostalCodeDropDown(context){
    return Autocomplete<PostalCodeModel>(
      displayStringForOption: _displayPostalCodeListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.geoPostal_Code_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.geoPostal_Code_list
            .where((PostalCodeModel option) {
          return option.pincode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PostalCodeModel selection) {
        print(selection.pincode);
        // Update the TextField with the selected
        accountMaster_page_controller.PostCode_Controller.text =
            _displayPostalCodeListForOption(selection).toString();
        accountMaster_page_controller.getStateMasterApi(accountMaster_page_controller.PostCode_Controller.text, 'state');
        accountMaster_page_controller.getStateMasterApi(accountMaster_page_controller.PostCode_Controller.text, 'city');
        accountMaster_page_controller.getStateMasterApi(accountMaster_page_controller.PostCode_Controller.text, 'district');
        accountMaster_page_controller.City_Controller.text = '';
        accountMaster_page_controller.District_Controller.text = '';
        accountMaster_page_controller.State_Controller.text = '';
        accountMaster_page_controller.ShowState1.value = false;
        accountMaster_page_controller.ShowState1.value = true;
        final parts = [
          accountMaster_page_controller.Address_controller.text,
          accountMaster_page_controller.Address2_Controller.text,
          accountMaster_page_controller.City_Controller.text,
          accountMaster_page_controller.District_Controller.text,
          accountMaster_page_controller.State_Controller.text,
          accountMaster_page_controller.PostCode_Controller.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(
            readOnly:  accountMaster_page_controller.view=='Account'?false:true,
            //maxLength: 50,
            onChanged: (value){
              final parts = [
                accountMaster_page_controller.Address_controller.text,
                accountMaster_page_controller.Address2_Controller.text,
                accountMaster_page_controller.City_Controller.text,
                accountMaster_page_controller.District_Controller.text,
                accountMaster_page_controller.State_Controller.text,
                value,
              ];

              // Filter out empty strings and join with commas
              final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

              accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.PostCode_Controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Pin Code*',
              labelText: 'Pin Code*',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PostalCodeModel> onSelected,
          Iterable<PostalCodeModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PostalCodeModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.pincode.toString(),
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

  Widget bindShippingPostalCodeDropDown(context){
    return Autocomplete<PostalCodeModel>(
      displayStringForOption: _displayPostalCodeListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.geoPostal_Code_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.geoPostal_Code_list
            .where((PostalCodeModel option) {
          return option.pincode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PostalCodeModel selection) {
        print(selection.pincode);
        // Update the TextField with the selected
        accountMaster_page_controller.Shipping_PostCode_Controller.value.text =
            _displayPostalCodeListForOption(selection).toString();
        accountMaster_page_controller.getShippingStateMasterApi(accountMaster_page_controller.Shipping_PostCode_Controller.value.text,'state');
        accountMaster_page_controller.getShippingStateMasterApi(accountMaster_page_controller.Shipping_PostCode_Controller.value.text,'city');
        accountMaster_page_controller.getShippingStateMasterApi(accountMaster_page_controller.Shipping_PostCode_Controller.value.text,'district');
        accountMaster_page_controller.Shipping_City_Controller.value.text = '';
        accountMaster_page_controller.Shipping_District_Controller.value.text = '';
        accountMaster_page_controller.Shipping_State_Controller.value.text = '';
        accountMaster_page_controller.ShowState.value = false;
        accountMaster_page_controller.ShowState.value = true;
        final parts = [
          accountMaster_page_controller.Shipping_Address_controller.value.text,
          accountMaster_page_controller.Shipping_Address2_Controller.value.text,
          accountMaster_page_controller.Shipping_City_Controller.value.text,
          accountMaster_page_controller.Shipping_District_Controller.value.text,
          accountMaster_page_controller.Shipping_State_Controller.value.text,
          accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(
            readOnly:  accountMaster_page_controller.view=='Account'?false:true,
            // maxLength: 50,
            onChanged: (value){
              final parts = [
                accountMaster_page_controller.Shipping_Address_controller.value.text,
                accountMaster_page_controller.Shipping_Address2_Controller.value.text,
                accountMaster_page_controller.Shipping_City_Controller.value.text,
                accountMaster_page_controller.Shipping_District_Controller.value.text,
                accountMaster_page_controller.Shipping_State_Controller.value.text,
                value,
              ];

              // Filter out empty strings and join with commas
              final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

              accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.Shipping_PostCode_Controller.value
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Pin Code',
              labelText: 'Pin Code',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PostalCodeModel> onSelected,
          Iterable<PostalCodeModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PostalCodeModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.pincode.toString(),
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

  Widget bindShippingStateDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayStateListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.ShippingStateMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return accountMaster_page_controller.ShippingStateMasterPinCode_list
            .where((PincodeMasterModel option) {
          return option.stateName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();

      },
      onSelected: (PincodeMasterModel selection) {
        print(selection.stateName);
        // Update the TextField with the selected
        accountMaster_page_controller.Shipping_State_Controller.value.text =
            _displayStateListForOption(selection).toString();
        FocusNode().unfocus();
        final parts = [
          accountMaster_page_controller.Shipping_Address_controller.value.text,
          accountMaster_page_controller.Shipping_Address2_Controller.value.text,
          accountMaster_page_controller.Shipping_City_Controller.value.text,
          accountMaster_page_controller.Shipping_District_Controller.value.text,
          accountMaster_page_controller.Shipping_State_Controller.value.text,
          accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              readOnly:  accountMaster_page_controller.view=='Account'?false:true,
              //maxLength: 50,
              onChanged: (value){
                final parts = [
                  accountMaster_page_controller.Shipping_Address_controller.value.text,
                  accountMaster_page_controller.Shipping_Address2_Controller.value.text,
                  accountMaster_page_controller.Shipping_City_Controller.value.text,
                  accountMaster_page_controller.Shipping_District_Controller.value.text,
                  value,
                  accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
                ];

                // Filter out empty strings and join with commas
                final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.Shipping_State_Controller.value
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'State',
                labelText: 'State',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            )
        );

      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PincodeMasterModel> onSelected,
          Iterable<PincodeMasterModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PincodeMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.stateName.toString(),
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

  Widget bindCityDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayCityListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.CityMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return accountMaster_page_controller.CityMasterPinCode_list
            .where((PincodeMasterModel option) {
          return option.city
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PincodeMasterModel selection) {
        print(selection.city);
        // Update the TextField with the selected
        accountMaster_page_controller.City_Controller.text =
            _displayCityListForOption(selection).toString();
        FocusNode().unfocus();
        final parts = [
          accountMaster_page_controller.Address_controller.text,
          accountMaster_page_controller.Address2_Controller.text,
          accountMaster_page_controller.City_Controller.text,
          accountMaster_page_controller.District_Controller.text,
          accountMaster_page_controller.State_Controller.text,
          accountMaster_page_controller.PostCode_Controller.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              readOnly:  accountMaster_page_controller.view=='Account'?false:true,
              //maxLength: 50,
              onChanged: (value){
                final parts = [
                  accountMaster_page_controller.Address_controller.text,
                  accountMaster_page_controller.Address2_Controller.text,
                  value,
                  accountMaster_page_controller.District_Controller.text,
                  accountMaster_page_controller.State_Controller.text,
                  accountMaster_page_controller.PostCode_Controller.text,
                ];

                // Filter out empty strings and join with commas
                final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.City_Controller
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'City*',
                labelText: 'City*',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            )
        );

      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PincodeMasterModel> onSelected,
          Iterable<PincodeMasterModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PincodeMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.city.toString(),
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

  Widget bindShippingCityDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayCityListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.ShippingCityMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return accountMaster_page_controller.ShippingCityMasterPinCode_list
            .where((PincodeMasterModel option) {
          return option.city
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();

      },
      onSelected: (PincodeMasterModel selection) {
        print(selection.city);
        // Update the TextField with the selected
        accountMaster_page_controller.Shipping_City_Controller.value.text =
            _displayCityListForOption(selection).toString();
        FocusNode().unfocus();
        final parts = [
          accountMaster_page_controller.Shipping_Address_controller.value.text,
          accountMaster_page_controller.Shipping_Address2_Controller.value.text,
          accountMaster_page_controller.Shipping_City_Controller.value.text,
          accountMaster_page_controller.Shipping_District_Controller.value.text,
          accountMaster_page_controller.Shipping_State_Controller.value.text,
          accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              readOnly:  accountMaster_page_controller.view=='Account'?false:true,
              //maxLength: 50,
              onChanged: (value){
                final parts = [
                  accountMaster_page_controller.Shipping_Address_controller.value.text,
                  accountMaster_page_controller.Shipping_Address2_Controller.value.text,
                  value,
                  accountMaster_page_controller.Shipping_District_Controller.value.text,
                  accountMaster_page_controller.Shipping_State_Controller.value.text,
                  accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
                ];

                // Filter out empty strings and join with commas
                final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.Shipping_City_Controller.value
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'City',
                labelText: 'City',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            )
        );

      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PincodeMasterModel> onSelected,
          Iterable<PincodeMasterModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PincodeMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.city.toString(),
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

  Widget bindDistrictDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayDistrictListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.DistrictMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return accountMaster_page_controller.DistrictMasterPinCode_list
            .where((PincodeMasterModel option) {
          return option.district
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PincodeMasterModel selection) {
        print(selection.district);
        // Update the TextField with the selected
        accountMaster_page_controller.District_Controller.text =
            _displayDistrictListForOption(selection).toString();
        FocusNode().unfocus();
        final parts = [
          accountMaster_page_controller.Address_controller.text,
          accountMaster_page_controller.Address2_Controller.text,
          accountMaster_page_controller.City_Controller.text,
          accountMaster_page_controller.District_Controller.text,
          accountMaster_page_controller.State_Controller.text,
          accountMaster_page_controller.PostCode_Controller.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              readOnly:  accountMaster_page_controller.view=='Account'?false:true,
              //maxLength: 150,
              onChanged: (value){
                final parts = [
                  accountMaster_page_controller.Address_controller.text,
                  accountMaster_page_controller.Address2_Controller.text,
                  accountMaster_page_controller.City_Controller.text,
                  value,
                  accountMaster_page_controller.State_Controller.text,
                  accountMaster_page_controller.PostCode_Controller.text,
                ];

                // Filter out empty strings and join with commas
                final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.District_Controller
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'District*',
                labelText: 'District*',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            )
        );

      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PincodeMasterModel> onSelected,
          Iterable<PincodeMasterModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PincodeMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.district.toString(),
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

  Widget bindShippingDistrictDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayDistrictListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.ShippingDistrictMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return accountMaster_page_controller.ShippingDistrictMasterPinCode_list
            .where((PincodeMasterModel option) {
          return option.district
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PincodeMasterModel selection) {
        print(selection.district);
        // Update the TextField with the selected
        accountMaster_page_controller.Shipping_District_Controller.value.text =
            _displayDistrictListForOption(selection).toString();
        FocusNode().unfocus();
        final parts = [
          accountMaster_page_controller.Shipping_Address_controller.value.text,
          accountMaster_page_controller.Shipping_Address2_Controller.value.text,
          accountMaster_page_controller.Shipping_City_Controller.value.text,
          accountMaster_page_controller.Shipping_District_Controller.value.text,
          accountMaster_page_controller.Shipping_State_Controller.value.text,
          accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
        ];

        // Filter out empty strings and join with commas
        final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

        accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              readOnly:  accountMaster_page_controller.view=='Account'?false:true,
              //maxLength: 50,
              onChanged: (value){
                final parts = [
                  accountMaster_page_controller.Shipping_Address_controller.value.text,
                  accountMaster_page_controller.Shipping_Address2_Controller.value.text,
                  accountMaster_page_controller.Shipping_City_Controller.value.text,
                  value,
                  accountMaster_page_controller.Shipping_State_Controller.value.text,
                  accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
                ];

                // Filter out empty strings and join with commas
                final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                accountMaster_page_controller.Shipping_FullAddress_Controller.value.text = fullAddress;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.Shipping_District_Controller.value
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'District',
                labelText: 'District',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            )
        );

      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<PincodeMasterModel> onSelected,
          Iterable<PincodeMasterModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.85,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final PincodeMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.district.toString(),
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

  Widget bindTatResponseTypeDropDown(context){
    return IgnorePointer(
      ignoring: accountMaster_page_controller.view=='Account'?false:true,
      child: Autocomplete<TatResponseModel>(
        displayStringForOption: _displayTatResponseListForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if(accountMaster_page_controller.view=='VIEW'){
            accountMaster_page_controller.TatResponseMaster_list.value=[];
            return accountMaster_page_controller.TatResponseMaster_list;
          }
          if (textEditingValue.text.isEmpty) {
            return accountMaster_page_controller.TatResponseMaster_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return accountMaster_page_controller.TatResponseMaster_list
              .where((TatResponseModel option) {
            return option.responseType
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (TatResponseModel selection) {
          print(selection.responseType);
          // Update the TextField with the selected
          accountMaster_page_controller.TatResponse_Controller.text =
              _displayTatResponseListForOption(selection).toString();
          //accountMaster_page_controller.getCompanyProfileTypeApi();
          accountMaster_page_controller.tatResponseType = selection.responseType!;
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              readOnly: accountMaster_page_controller.view=='Account'?false:true,
              /* readOnly: accountMaster_page_controller.view=='FromTaskMainScreen'
                  || accountMaster_page_controller.view=='VIEW' ||
                  accountMaster_page_controller.view=='Task'||
                  accountMaster_page_controller.view=='FromSaleCycleMainScreen'
                  || accountMaster_page_controller.view=="FromQuoteApproval"?true:false,*/
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = accountMaster_page_controller.TatResponse_Controller
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: (){
                    if(focusNode.hasFocus){
                      focusNode.unfocus();
                    }else{
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Tat Response Type',
                labelText: 'Tat Response Type',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<TatResponseModel> onSelected,
            Iterable<TatResponseModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.85,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final TatResponseModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          child:
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:  option.responseType!,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                                TextSpan(
                                  text: " (${option.responseDescription!})",
                                  style: GoogleFonts.poppins(
                                      color: AllColors.redColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                              ],
                            ),
                            softWrap: true,
                          )

                        /* Text(
                          option.responseType.toString() + ' (${option.responseDescription.toString()})',
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize
                                  .sisxteen // Change the text color here
                          ),
                        ),*/
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}

class GSTValidator {
  static bool validate(String gstNumber) {
    if (gstNumber.length != 15) return false;

    final regex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[A-Z0-9]{1}Z[A-Z0-9]{1}$');
    //final regex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9Z]{3}$');
    if (!regex.hasMatch(gstNumber)) return false;

    // Add checksum validation logic here if needed.
    return true;
  }
}