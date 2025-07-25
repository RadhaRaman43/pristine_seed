import 'package:dotted_border/dotted_border.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/Account_Master_view/update_account_master.dart';
import 'package:navigation_drawer_flutter/models/employeeDetail/employee_details_model.dart';
import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../locat_database/databaseHelper.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/Account_Draft_model.dart';
import '../../CRM_Models/AccountMaster_model/CompanyTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/Company_Prof_Mst_Model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/State_master_model.dart';
import '../../CRM_Models/AccountMaster_model/Tat_Response_model.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_Models/Address_Master_Model/PincodeMaster_Model.dart';
import '../../CRM_Models/Address_Master_Model/PostalCode_Model.dart';
import '../../CRM_Models/Address_Master_Model/address_master_model.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class AddNewAccountMaster extends StatelessWidget{
  AddNewAccountMaster({super.key});

  final accountMaster_page_controller=Get.put(Accountmastervm());
  final saleCycleController=Get.put(SalesCycleVm());
  SessionManagement sessionManagement= SessionManagement();
  DatabaseHelper crmDatabase = DatabaseHelper();
  Size size=Get.size;
  String defaultFullName = '';
  final _formKey = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyGst = GlobalKey<FormState>();
  final _formKeyPanNo = GlobalKey<FormState>();


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
      option.code??"";

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
          if(accountMaster_page_controller.view == 'FromDraft'){
            accountMaster_page_controller.clearFilterController();
            accountMaster_page_controller.pageNumber = 0;
            accountMaster_page_controller.getDraftAccountMaster(accountMaster_page_controller.pageNumber ,accountMaster_page_controller.is_Active.toString());
            Get.toNamed(RoutesName.Draft_item_list);
          }else if(accountMaster_page_controller.FromPage == "Task"){
            print('FromPage....${accountMaster_page_controller.FromPage == "Task"}');
            accountMaster_page_controller.clearController();
            Get.back();
          }else if(accountMaster_page_controller.FromPage == "Contact"){
            print('FromPage....${accountMaster_page_controller.FromPage == "Contact"}');
            accountMaster_page_controller.clearController();
            Get.back();
          }
          else if(accountMaster_page_controller.FromPage == "AccountUpdate"){
            Get.back();
          }
          else{
            accountMaster_page_controller.clearController();
            Get.toNamed(RoutesName.accountMaster_screen);
          }

      return false;
    }, child: Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            children: [
              Text(
                'Create Account',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Visibility(
                visible: accountMaster_page_controller.isAdminWritePermission=='0'?true:false,
                child: ActionChip(
                  elevation: 2,
                  padding: EdgeInsets.all(5),
                  backgroundColor: AllColors.primaryDark1,
                  shadowColor: Colors.black,
                  shape: StadiumBorder(
                      side: BorderSide(color: AllColors.whiteColor)),
                  //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                  //CircleAvatar
                  label: Row(
                    children: [
                      Icon(Icons.save_as),
                      SizedBox(width: 5,),
                      Tooltip(
                        message: "Create Account ",
                        child: Text('Draft',
                            style: GoogleFonts.poppins(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ],
                  ),
                  onPressed: () async {

                    if(accountMaster_page_controller.account_name_controller.value.text.isNotEmpty || accountMaster_page_controller.account_name_controller.value.text != ''){
                      if(accountMaster_page_controller.DraftId.isEmpty || accountMaster_page_controller.DraftId == ''){
                       // await insertAccountData();
                        accountMaster_page_controller.DraftAccountMstUploaderApiHit('Create');
                        accountMaster_page_controller.clearController();
                        Get.toNamed(RoutesName.accountMaster_screen);
                      }else{
                       // await updateAccountData(accountMaster_page_controller.DraftId);
                        accountMaster_page_controller.DraftAccountMstUploaderApiHit('Update');
                        accountMaster_page_controller.clearController();
                        Get.toNamed(RoutesName.Draft_item_list);
                      }
                      try {
                       // accountMaster_page_controller.Account_Master_Draft_list  = await crmDatabase.getItems();
                        print('Retrieved items: ${accountMaster_page_controller.Account_Master_Draft_list1[0].accountName}');
                      } catch (e) {
                        print('Failed to retrieve items: $e');
                      }
                    } else{
                      Utils.showErrorToastification('Error!', "Please Enter Customer Name!");
                    }

                  }, //Text
                ),
              ),

            ],
          ),

      ),
      drawer: CustomDrawer(),
      floatingActionButton:  Visibility(
        visible: accountMaster_page_controller.isAdminWritePermission=='0'?true:false,
        child: Container(
          margin: EdgeInsets.only(left: 30),
          child: DefaultButton(
            press: (){
              if(accountMaster_page_controller.account_name_controller.text.isEmpty || accountMaster_page_controller.account_name_controller == null){
                Utils.sanckBarError('Customer Name!', "Please Enter Customer Name");
                return  ;
              }
              if(defaultFullName == "" && accountMaster_page_controller.EmployeeMember_Controller.text.isEmpty){
                Utils.sanckBarError('Customer Owner!', "Please Enter Customer Owner");
                return  ;
              }
              /*if(accountMaster_page_controller.account_type_controller.text.isEmpty || accountMaster_page_controller.account_type_controller == null){
                Utils.sanckBarError('Account Type!', "Please Enter Account Type");
                return  ;
              }*/
              if(accountMaster_page_controller.PhoneNo_Controller.text.isNotEmpty){
                if(accountMaster_page_controller.PhoneNo_Controller.text.length < 10){
                  Utils.sanckBarError('Phone No.!', "Please Enter 10 Digit Phone No");
                  return  ;
                }
              }

              if(accountMaster_page_controller.EmailId_Controller.text.isNotEmpty && EmailValidator.validate(accountMaster_page_controller.EmailId_Controller.text) == false){
                Utils.sanckBarError('Email ID!', "Please Enter A valid Email ID");
                return  ;
              }

              if(accountMaster_page_controller.account_cat_type_controller.text.isEmpty || accountMaster_page_controller.account_cat_type_controller == null){
                Utils.sanckBarError('Customer Category Type!', "Please Enter Customer Category Type");
                return  ;
              }
              if(accountMaster_page_controller.comp_prof_type_controller.text.isEmpty || accountMaster_page_controller.comp_prof_type_controller == null){
                Utils.sanckBarError('Company profile Type!', "Please Enter Company profile Type");
                return  ;
              }
              if(accountMaster_page_controller.comp_prof_sub_type_controller.value.text.isEmpty || accountMaster_page_controller.comp_prof_sub_type_controller == null){
                Utils.sanckBarError('Company profile sub Type!', "Please Enter Company profile sub Type");
                return  ;
              }
              if(accountMaster_page_controller.gst_registration_type_controller.value.text.isEmpty || accountMaster_page_controller.gst_registration_type_controller == null){
                Utils.sanckBarError('GST Registration Type!', "Please Enter GST Registration Type");
                return  ;
              }

              if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.GstNo_Controller.text.isEmpty){
                Utils.sanckBarError('GST No.!', "Please Enter A valid GST No.");
                return  ;
              }

              if(accountMaster_page_controller.GstNo_Controller.text.isNotEmpty && GSTValidator.validate(accountMaster_page_controller.GstNo_Controller.text) == false){
                Utils.sanckBarError('GST No.!', "Please Enter A valid GST No.");
                return  ;
              }

              if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.PanNo_Controller.value.text != accountMaster_page_controller.GstPanNo.value){
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

              if(accountMaster_page_controller.Account_Master_list != null &&
                  accountMaster_page_controller.Account_Master_list.isNotEmpty && accountMaster_page_controller.Account_Master_list[0].isManager == 1 && accountMaster_page_controller.IsActive_controller.text.isEmpty || accountMaster_page_controller.IsActive_controller == null){
                Utils.sanckBarError('Active!', "Please Enter Active Type");
                return  ;
              }
              if(accountMaster_page_controller.State_Controller.text.isEmpty || accountMaster_page_controller.State_Controller == null){
                Utils.sanckBarError('Billing State!', "Please Enter Billing State");
                return  ;
              }else if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.GovtStateCode.value != accountMaster_page_controller.GstStateCode.value){
                Utils.sanckBarError('Wrong State!', "Please Enter Valid State");
                return  ;
              }
             /* if(accountMaster_page_controller.TatResponse_Controller.text.isEmpty || accountMaster_page_controller.TatResponse_Controller == null){
                Utils.sanckBarError('Tat Response!', "Please Enter Tat Response Type");
                return  ;
              }*/

              accountMaster_page_controller.AccountMstUploaderApiHit('Create', "", accountMaster_page_controller.SalesRepresentativeEmail, accountMaster_page_controller.RegionalHeadEmail);
            },
            text: "Create Account",
          ),
        ),
      ),
      body: Obx(() {
        return
          Container(
            padding: EdgeInsets.only(bottom: 70),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: IgnorePointer(
                ignoring: accountMaster_page_controller.isAdminWritePermission=='1'?true:false,
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
                        child: Container(
                            padding: EdgeInsets.all(50),
                            child: Image.asset("assests/images/imageupload.png",)),
                        /*Icon(Icons.image,color: AllColors.primaryDark1,size: size.height * 0.1,)*/
                      ),
                    ),
                    SizedBox(height: 15,),
                    /*Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      ],
                    ),
                  ),*/
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextFormField(
                        controller: accountMaster_page_controller
                            .ImageUrl_Controller,
                        decoration: InputDecoration(
                            hintText: "Image Url",
                            labelText: "Image Url",
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextFormField(
                        controller: accountMaster_page_controller
                            .account_name_controller,
                        decoration: InputDecoration(
                            hintText: "Customer Name*",
                            labelText: "Customer Name*",
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: bindAccountOwnerDropDown(context),
                    ),

                    SizedBox(height: 15,),

                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextFormField(
                        maxLength: 500,
                        maxLines: 2,
                        controller: accountMaster_page_controller.AccountTitle_Controller,
                        decoration: InputDecoration(
                            hintText: "Branch Name",
                            labelText: "Branch Name",
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
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      //color: AllColors.Card1Color,
                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        //color: AllColors.Card1Color, // Set the inside color here
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
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
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TextFormField(
                                readOnly: true,
                                controller: accountMaster_page_controller
                                    .OldCRMAccountNo_Controller,
                                decoration: InputDecoration(
                                    hintText: "Old Crm Customer No.",
                                    labelText: "Old Crm Customer No.",
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

                            bindAccountTypeDropDown(context),

                            SizedBox(height: 15,),

                            Form(
                              key: _formKey,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  maxLength: 10,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null; // No error when the field is empty
                                    } else if (value.length != 10) {
                                      return 'Phone No. should be exactly 10 digits';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    // Trigger validation when the value changes
                                    _formKey.currentState?.validate();
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: accountMaster_page_controller
                                      .PhoneNo_Controller,
                                  decoration: InputDecoration(
                                      hintText: "Phone No.",
                                      labelText: "Phone No.",
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
                            ),

                            SizedBox(height: 15,),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: accountMaster_page_controller
                                    .Alternate_PhoneNo_Controller,
                                decoration: InputDecoration(
                                    hintText: "Alternate Phone No.",
                                    labelText: "Alternate Phone No.",
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

                            Form(
                              key: _formKeyEmail,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    // If the field is empty, no error is shown
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    // If the email is invalid, show an error
                                    else if (!EmailValidator.validate(value)) {
                                      return 'Please Enter A Valid Email Id';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    // Trigger validation when the value changes
                                    _formKeyEmail.currentState?.validate();
                                  },
                                  controller: accountMaster_page_controller
                                      .EmailId_Controller,
                                  decoration: InputDecoration(
                                      hintText: "Email Id**",
                                      labelText: "Email Id*",
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
                            ),

                            SizedBox(height: 15,),

                            bindAccCatogeryTypeDropDown(context),

                            SizedBox(height: 15,),

                            bindComProfTypeDropDown(context),
                            SizedBox(height: 15,),

                            Obx((){
                              return Visibility(
                                  visible:accountMaster_page_controller
                                      .compProfileRemrk.isFalse ? true : false ,
                                  child: bindComProfSubTypeDropDown(context)
                              );
                            }),



                     /*       Obx(() {
                              return
                                Visibility(
                                  visible: accountMaster_page_controller
                                      .compProfileRemrk.isFalse ? true : false,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15,),
                                      Container(
                                          height: 50,
                                          width: size.width ,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  //color: AllColors.whiteColor,
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                ),
                                                //height: size.height*10,
                                                width: size.width * .65,
                                                child: bindComProfSubTypeDropDown(context),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AllColors.whiteColor,
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                  border: Border.all(
                                                    color: AllColors
                                                        .lightblackColor,
                                                    // Set the border color to black
                                                    width: 1.0, // You can adjust the width of the border as needed
                                                  ),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      AddCompSubProTypeDailog(
                                                          context);
                                                    }, icon: Icon(Icons.add)),
                                              )
                                            ],
                                          )

                                      ),
                                    ],
                                  ),
                                );
                            }),*/


                            Visibility(
                              visible: (accountMaster_page_controller.Account_Master_list != null &&
                                  accountMaster_page_controller.Account_Master_list.isNotEmpty &&
                                  accountMaster_page_controller.Account_Master_list[0].isManager == 1)
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  SizedBox(height: 15,),
                                  bindIsActiveDropDown(context),
                                ],
                              ),
                            ),

                            SizedBox(height: 15,),

                            Obx(() {
                              return Visibility(
                                visible: accountMaster_page_controller
                                    .compProfileRemrk.value,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                      child: TextFormField(
                                        controller: accountMaster_page_controller
                                            .comp_prof_remarks_controller,
                                        decoration: InputDecoration(
                                            hintText: "Company Profile Remarks",
                                            labelText: "Company Profile Remarks",
                                            //suffixIcon: Icon(Icons.email),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: AllFontSize.ten,
                                                horizontal: AllFontSize.ten),

                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue)
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)
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
                                  visible: accountMaster_page_controller
                                      .GstRegistration.value,
                                  child: Column(
                                    children: [
                                      Form(
                                        key: _formKeyGst,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                  10)
                                          ),
                                          //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            maxLength: 15,
                                            validator: (value){
                                              if(value == null || value.isEmpty){
                                                return null;
                                              }else if (!GSTValidator.validate(value)) {
                                                return 'Invalid GST No.';
                                              }
                                              else if(value.length != 15){
                                                return 'GST No. Should be exactly 15 digit';
                                              }else {
                                                return null;
                                              }
                                            },
                                            onChanged: (value) {
                                              // Clear the error when the user enters a value
                                                _formKeyGst.currentState?.validate();

                                              if(value.length >= 2){
                                              accountMaster_page_controller.GstStateCode.value = value.substring(0, 2);
                                              print('First two digits: ${accountMaster_page_controller.GstStateCode}');

                                              print('List...${accountMaster_page_controller.StateMaster_list.length}');

                                              /*for(int i = 0; i< accountMaster_page_controller.StateMaster_list.length; i++){
                                                if(accountMaster_page_controller.GstStateCode == accountMaster_page_controller.StateMaster_list[i].governmentStateCode){
                                                  accountMaster_page_controller.GstStateList.clear();
                                                  accountMaster_page_controller.GstStateList.add(accountMaster_page_controller.StateMaster_list[i]);
                                                  print('GstStae....${accountMaster_page_controller.GstStateList[0].governmentStateCode}');
                                                }
                                              }*/

                                              }
                                              if (value.length >= 12) {
                                                accountMaster_page_controller.GstPanNo.value = value.substring(2, 12);
                                                print('Next ten digits: ${accountMaster_page_controller.GstPanNo}');
                                                // You can save nextTenDigits to a variable or perform other operations
                                              }
                                            },
                                            controller: accountMaster_page_controller
                                                .GstNo_Controller,
                                            decoration: InputDecoration(
                                                hintText: "GST No.*",
                                                labelText: "GST No.*",
                                                //suffixIcon: Icon(Icons.email),
                                                contentPadding: EdgeInsets
                                                    .symmetric(
                                                    vertical: AllFontSize.ten,
                                                    horizontal: AllFontSize.ten),

                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue)
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                )
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                                );
                            }),


                            Form(
                              key: _formKeyPanNo,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return null;
                                    }
                                    else if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && value != accountMaster_page_controller.GstPanNo.value){
                                      return 'Please Enter Valid Pan No.';
                                    }else {
                                      return null;
                                    }
                                  },

                                  onChanged: (value) {
                                    // Clear the error when the user enters a value
                                      _formKeyPanNo.currentState?.validate();

                                  },
                                  controller: accountMaster_page_controller
                                      .PanNo_Controller,
                                  decoration: InputDecoration(
                                      hintText: "Customer PAN No.",
                                      labelText: "Customer PAN No.",
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
                            ),

                            SizedBox(height: 15,),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TextFormField(
                                maxLength: 11,
                                controller: accountMaster_page_controller
                                    .IfscCode_Controller,
                                decoration: InputDecoration(
                                    hintText: "Customer IFSC Code",
                                    labelText: "Customer IFSC Code",
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
                                controller: accountMaster_page_controller
                                    .Website_Controller,
                                decoration: InputDecoration(
                                    hintText: "Website",
                                    labelText: "Website",
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


                            bindIsReferralDropDown(context),

                            Obx(() {
                              return Visibility(
                                visible: accountMaster_page_controller
                                    .isReferral.value,
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                      child: TextFormField(
                                        controller: accountMaster_page_controller
                                            .ReferralByName_Controller,
                                        decoration: InputDecoration(
                                            hintText: "Referral By",
                                            labelText: "Referral By",
                                            //suffixIcon: Icon(Icons.email),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: AllFontSize.ten,
                                                horizontal: AllFontSize.ten),

                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue)
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            )
                                        ),

                                      ),
                                    ),


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
                      //color: AllColors.Card1Color,
                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        //color: AllColors.Card2Color, // Set the inside color here
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
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
                        child: Column (
                          children: [

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TextFormField(
                                //maxLength: 150,
                                controller: accountMaster_page_controller
                                    .Address_controller,
                                onChanged: (value) {
                                  final parts = [
                                    value,
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
                                //maxLength: 150,
                                controller: accountMaster_page_controller.Address2_Controller,
                                onChanged: (value) {
                                  final parts = [
                                    accountMaster_page_controller.Address_controller.text,
                                    value,
                                    accountMaster_page_controller.City_Controller.text,
                                    accountMaster_page_controller.District_Controller.text,
                                    accountMaster_page_controller.State_Controller.text,
                                    accountMaster_page_controller.PostCode_Controller.text,
                                  ];

                                  // Filter out empty strings and join with commas
                                  final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

                                  accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
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

                            Obx((){
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  readOnly: true,
                                  //maxLength: 500,
                                  maxLines: 3,
                                  controller: accountMaster_page_controller.FullAddress_Controller.value,
                                  decoration: InputDecoration(
                                      hintText: "Full Address",
                                      labelText: "Full Address",
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
                              );
                            }),


                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),
                    Obx(() => CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Shipping address same as billing address",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w400,
                            fontSize: AllFontSize.twelve,
                          )
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

                    Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      //color: AllColors.Card1Color,
                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        //color: AllColors.Card2Color, // Set the inside color here
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
                                SizedBox(width: 15,),
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

                            SizedBox(height: 15,),
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
                            }

                            ),


                            SizedBox(height: 15,),

                            Obx(() {
                              return Visibility(
                                visible:accountMaster_page_controller.ShowState.value,
                                child: Container(
                                    child: bindShippingCityDropDown(context)
                                ),
                              );
                            }

                            ),


                            SizedBox(height: 15,),

                            Obx(() {
                              return Visibility(
                                visible:accountMaster_page_controller.ShowState.value,
                                child: Container(
                                    child: bindShippingDistrictDropDown(context)
                                ),
                              );
                            }

                            ),

                            SizedBox(height: 15,),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TextFormField(
                                readOnly: true,
                                //maxLength: 500,
                                maxLines: 3,
                                controller: accountMaster_page_controller.Shipping_FullAddress_Controller.value,
                                decoration: InputDecoration(
                                    hintText: "Full Address",
                                    labelText: "Full Address",
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

                    SizedBox(height: 15,),


                    Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      //color: AllColors.Card1Color,
                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        //color: AllColors.Card3Color, // Set the inside color here
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
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
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: accountMaster_page_controller
                                    .No_Of_Emp_Controller,
                                decoration: InputDecoration(
                                    hintText: "No. Of Employees",
                                    labelText: "No. Of Employees",
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
                                keyboardType: TextInputType.number,
                                controller: accountMaster_page_controller
                                    .Annual_Revenue_Controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp(r',')), // Block commas
                                  FilteringTextInputFormatter.deny(RegExp(r',')), // Block commas
                                ],
                                decoration: InputDecoration(
                                    hintText: "Customer Annual Turnover",
                                    labelText: "Customer Annual Turnover",
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
                              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: bindTatResponseTypeDropDown(context),
                            ),


                            SizedBox(height: 15,),

                            /*Obx((){
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: accountMaster_page_controller
                                      .Sale_Representative_Controller.value,
                                  decoration: InputDecoration(
                                      hintText: "Sale Representative",
                                      labelText: "Sale Representative",
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
                              );
                            }),*/



                            SizedBox(height: 15,),

                            Obx((){
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: accountMaster_page_controller
                                      .Regional_service_head_Controller.value,
                                  decoration: InputDecoration(
                                      hintText: "Reporting Manager",
                                      labelText: "Reporting Manager",
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
                              );
                            })




                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );

      }),
      )
    );
  }

 /* Future<void> getMenuList() async {
    print("GetList");
    await sessionManagement.getUserGeoHierarchy().then((userGeoHierarchy) {
      userGeoHierarchyy.value = userGeoHierarchy;
      if(userGeoHierarchyy.isNotEmpty){
        for(int i = 0; i<userGeoHierarchyy.length; i++){
          if(accountMaster_page_controller.AccountOwner == userGeoHierarchyy[i].approverEmail){
            int pos = i - 1;
            int pos2 = i - 2;
            print("RegionalHead ${userGeoHierarchy[pos].approverEmail}");
            accountMaster_page_controller.Sale_Representative_Controller.text = userGeoHierarchy[pos2].approverEmail.toString();
            accountMaster_page_controller.Regional_service_head_Controller.text = userGeoHierarchy[pos].approverEmail.toString();
            print("SalesRepre.. ${userGeoHierarchy[pos2].approverEmail}");
          }
        }
      }else{

      }

    });
  }
*/
  Widget bindAccountOwnerDropDown(context){
    return Autocomplete<EmployeeMemberModel>(
      displayStringForOption: _displayEmpMemberForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
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
        accountMaster_page_controller.EmployeeMember_Controller.text =
            _displayEmpMemberForOption(selection).toString();
        accountMaster_page_controller.AccountOwner = selection.loginEmailId!;
        print("accountOu...${selection.loginEmailId!}");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          accountMaster_page_controller.getEmployee(accountMaster_page_controller.AccountOwner);
        });
       // accountMaster_page_controller.getEmployee(selection.loginEmailId??"");
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {

        for(int i=0; i<accountMaster_page_controller.employee_Member_list.length; i++){
          if(accountMaster_page_controller.employee_Member_list[i].loginEmailId == accountMaster_page_controller.email){
            defaultFullName = accountMaster_page_controller.employee_Member_list[i].fullName??"";
            accountMaster_page_controller.AccountOwner = accountMaster_page_controller.employee_Member_list[i].loginEmailId??"";
          }
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          accountMaster_page_controller.getEmployee(accountMaster_page_controller.AccountOwner);
        });
       // accountMaster_page_controller.getEmployee(accountMaster_page_controller.AccountOwner);

        return TextField(
          readOnly: accountMaster_page_controller.Account_Master_list != null &&
              accountMaster_page_controller.Account_Master_list.isNotEmpty && accountMaster_page_controller.Account_Master_list[0].isManager == 1?true :false,
          cursorColor: AllColors.primaryDark1,
          /*controller: controller
            ..text = accountMaster_page_controller.EmployeeMember_Controller
                .text.isEmpty ?accountMaster_page_controller.employee_Member_list[0].fullName??"" :accountMaster_page_controller.EmployeeMember_Controller
                .text,*/
          controller: controller..text = accountMaster_page_controller.EmployeeMember_Controller
              .text.isEmpty ?defaultFullName:accountMaster_page_controller.EmployeeMember_Controller
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
            hintText: 'Customer Owner',
            labelText: 'Customer Owner',
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
    );
  }

  /*Widget bindAccountTypeDropDown(context){
    return Autocomplete<CustomList>(
      displayStringForOption: _displayAccTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
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
       // print(selection.value);
        // Update the TextField with the selected
        accountMaster_page_controller.account_type_controller.text =
            _displayAccTypeForOption(selection).toString();
        print("AccType....${accountMaster_page_controller.account_type_controller.text}");
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
            controller: controller
              ..text = accountMaster_page_controller.account_type_controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down),
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

  Widget bindAccountTypeDropDown(context) {
    return Container(
      //margin: const EdgeInsets.only(right: 15.0),
      width: double.infinity,
      child: DropdownMenu<CustomList>(
        width: size.width-55,
        controller:  accountMaster_page_controller.account_type_controller,
        label: Text(
          "Customer Type",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
         initialSelection:accountMaster_page_controller.get_Acc_type_list.length>0?accountMaster_page_controller.get_Acc_type_list[1]:null,
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

  Widget bindAccCatogeryTypeDropDown(context){
    return Autocomplete<GetMasterTypeModel>(
      displayStringForOption: _displayAccCategoryForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
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
              hintText: 'Customer Category Type*',
              labelText: 'Customer Category Type*',
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
    );
  }

  Widget bindComProfTypeDropDown(context){
    return Autocomplete<CompanyTypeModel>(
      displayStringForOption: _displayCompProfileTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Comp_Profile_type_list;
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
        accountMaster_page_controller.comp_prof_type_controller.text =
            _displayCompProfileTypeForOption(selection).toString();
        if(accountMaster_page_controller.comp_prof_type_controller.value.text == 'Others'){
          accountMaster_page_controller.compProfileRemrk.value = true;
        }else{
          accountMaster_page_controller.compProfileRemrk.value = false;
         // accountMaster_page_controller.getCompanyProfileSubTypeApi(accountMaster_page_controller.comp_prof_type_controller.value.text);

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
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.comp_prof_type_controller
                  .text,
            focusNode: focusNode,
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
              hintText: 'Company Profile Type',
              labelText: 'Company Profile Type',

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
              width: size.width*.86,
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
    );
  }

   Widget bindComProfSubTypeDropDown(context){
     return Autocomplete<CompanyProfileMstModel>(
       displayStringForOption: _displayCompProfSubForOption,
       optionsBuilder: (TextEditingValue textEditingValue) {
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
                 cursorColor: AllColors.primaryDark1,
                 controller: controller
                   ..text = accountMaster_page_controller
                       .comp_prof_sub_type_controller.value
                       .text,
                 focusNode:  focusNode,

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
               width: size.width*.9,
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
                         option.code.toString(),
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


  Widget bindGstRegistrationTypeDropDown(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(right: 15.0),
      width: double.infinity,
      child: DropdownMenu<CustomList>(
        width: size.width-55,
        controller:  accountMaster_page_controller.gst_registration_type_controller.value,
        label: Text(
          "GST Registration Type*",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w300),
        ),
        initialSelection:accountMaster_page_controller.get_Gst_Registration_list.length>0?accountMaster_page_controller.get_Gst_Registration_list[1]:null,
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

  AddCompSubProTypeDailog(context){
    accountMaster_page_controller.CompProfileDescription_Controller.clear;
    showDialog(
        context: context,
        builder: (context){
           return StatefulBuilder(
             builder: (context, setState) {
               return
                 AlertDialog(
                   title: Text(
                     'Create Company Profile',
                     style: GoogleFonts.poppins(
                       fontSize: AllFontSize.sisxteen,
                       fontWeight: FontWeight.w700,
                       color: AllColors.primaryDark1,
                     ),
                   ),
                   content: Container(
                     /*height: size.height*.25,
                 width: size.width*4,*/
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Divider(
                           height: 1,
                           thickness: 1,
                         ),
                         SizedBox(height: 15,),
                         bindComProfTypeDropDown(context),
                         SizedBox(height: 15,),
                         Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           //padding: EdgeInsets.only(left: 10.0, right: 10.0),
                           child: TextFormField(
                             controller: accountMaster_page_controller
                                 .CompProfileDescription_Controller,
                             decoration: InputDecoration(
                                 hintText: "Description",
                                 labelText: "Description",
                                 //suffixIcon: Icon(Icons.email),
                                 contentPadding: EdgeInsets.symmetric(
                                     vertical: AllFontSize.ten,
                                     horizontal: AllFontSize.ten),

                                 /* focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.blue)
                             ),*/
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),

                           ),
                         ),
                         SizedBox(height: 15,),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             ElevatedButton(
                               style: ButtonStyle(
                                 backgroundColor: MaterialStateProperty.all<
                                     Color>(
                                   AllColors.primaryDark1,
                                 ),
                               ),
                               onPressed: () {
                                 if (accountMaster_page_controller
                                     .comp_prof_type_controller.text.isEmpty ||
                                     accountMaster_page_controller
                                         .comp_prof_type_controller == null) {
                                   Utils.sanckBarError('Error : ',
                                       'Please select company Type.');
                                   return;
                                 }
                                 if (accountMaster_page_controller
                                     .CompProfileDescription_Controller.text
                                     .isEmpty || accountMaster_page_controller
                                     .CompProfileDescription_Controller ==
                                     null) {
                                   Utils.sanckBarError(
                                       'Error : ', 'Please Enter Description');
                                   return;
                                 }

                                 accountMaster_page_controller
                                     .CompanyProfileMasterUploaderApiHit(
                                     'Create', "New");

                                 Get.back();

                                 // accountMaster_page_controller.getCompanyProfileSubTypeApi(accountMaster_page_controller.comp_prof_type_controller.value.text);
                                 /*accountMaster_page_controller.comp_prof_sub_type_controller.value.text = accountMaster_page_controller.CompProfileDescription_Controller.value.text;
                             print('compSubType.....${accountMaster_page_controller.comp_prof_sub_type_controller.value.text}');
                             accountMaster_page_controller.CompProfileDescription_Controller.clear();*/

                               },
                               child: Container(
                                 width: 80,
                                 alignment: Alignment.center,
                                 child: Text('Save'
                                   /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                                   style: GoogleFonts.poppins(
                                     color: AllColors.customDarkerWhite,
                                     fontSize: AllFontSize.fourtine,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                               ),
                             ),
                             /* ElevatedButton(
                             style: ButtonStyle(
                               backgroundColor: MaterialStateProperty.all<Color>(
                                 AllColors.primaryDark1,
                               ),
                             ),
                             onPressed: () {
                               Navigator.pop(context);
                             },
                             child: Container(
                               width: 60,
                               alignment: Alignment.center,
                               child: Text(
                                 'Cancel',
                                 style: GoogleFonts.poppins(
                                   color: AllColors.customDarkerWhite,
                                   fontSize: AllFontSize.fourtine,
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                             ),
                           ),*/
                           ],)
                       ],
                     ),
                   ),
                 );

             });
        });
  }

  Widget bindIsActiveDropDown(context) {
    accountMaster_page_controller.IsActive_controller.text = 'Yes';
    return Autocomplete<String>(
      displayStringForOption: _displayIsActiveForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
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
      initialValue: accountMaster_page_controller.IsActive_controller.value,
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
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = accountMaster_page_controller.IsActive_controller
                  .text.isEmpty ? 'Yes': accountMaster_page_controller.IsActive_controller.text,
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
            onTap: (){
              controller.clear();
            },
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
              *//*hintStyle: GoogleFonts.poppins(
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
              ),*//*

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
        initialSelection: "No",
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
        accountMaster_page_controller.Shipping_City_Controller.value.text ='';
        accountMaster_page_controller.Shipping_District_Controller.value.text = '';
        accountMaster_page_controller.Shipping_State_Controller.value.text ='';
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
            //maxLength: 50,
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


  Widget bindStateDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayStateListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
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
              //maxLength: 50,
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
    return Autocomplete<TatResponseModel>(
      displayStringForOption: _displayTatResponseListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
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
        accountMaster_page_controller.tatResponseType = selection.responseType!;
        //accountMaster_page_controller.getCompanyProfileTypeApi();
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
                      child: RichText(
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
    );
  }


  Future<void> insertAccountData() async {
    try {
      await crmDatabase.insertItem(AccountDraftModel(
        profile: accountMaster_page_controller.ImageUrl_Controller.value.text,
        accountName: accountMaster_page_controller.account_name_controller.value.text,
        accountOwner: accountMaster_page_controller.EmployeeMember_Controller.value.text.isEmpty?accountMaster_page_controller.UserName:accountMaster_page_controller.EmployeeMember_Controller.value.text,
        accountTitle: accountMaster_page_controller.AccountTitle_Controller.value.text,
        accountType: accountMaster_page_controller.account_type_controller.value.text,
        phoneNo: accountMaster_page_controller.PhoneNo_Controller.value.text,
        emailId: accountMaster_page_controller.EmailId_Controller.value.text,
        accountCategoryType: accountMaster_page_controller.account_cat_type_controller.value.text,
        companyProfileType: accountMaster_page_controller.comp_prof_type_controller.value.text,
        companyProfileRemark: accountMaster_page_controller.comp_prof_remarks_controller.value.text,
        companyProfileSubType: accountMaster_page_controller.comp_prof_sub_type_controller.value.text,
        gstType: accountMaster_page_controller.gst_registration_type_controller.value.text,
        gstNo: accountMaster_page_controller.GstNo_Controller.value.text,
        panNo: accountMaster_page_controller.PanNo_Controller.value.text,
        ifscCode: accountMaster_page_controller.IfscCode_Controller.value.text,
        address: accountMaster_page_controller.Address_controller.value.text,
        address2: accountMaster_page_controller.Address2_Controller.value.text,
        postCode: accountMaster_page_controller.PostCode_Controller.value.text,
        stateName: accountMaster_page_controller.State_Controller.value.text,
        city: accountMaster_page_controller.City_Controller.value.text,
        district: accountMaster_page_controller.District_Controller.value.text,
        shippingAddress: accountMaster_page_controller.Shipping_Address_controller.value.text,
        shippingAddress2: accountMaster_page_controller.Shipping_Address2_Controller.value.text,
        shippingPostCode: accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
        shippingStateCode: accountMaster_page_controller.Shipping_State_Controller.value.text,
        shippingCity: accountMaster_page_controller.Shipping_City_Controller.value.text,
        shippingDistrict: accountMaster_page_controller.Shipping_District_Controller.value.text,
        noOfEmployees: int.tryParse(accountMaster_page_controller.No_Of_Emp_Controller.value.text) ?? 0,
        annualRevenue: double.tryParse(accountMaster_page_controller.Annual_Revenue_Controller.value.text) ?? 0.0,
        tatResponseType: accountMaster_page_controller.tatResponseType,
        salesRepresentative: accountMaster_page_controller.Sale_Representative_Controller.value.text,
        regionalServiceHead: accountMaster_page_controller.Regional_service_head_Controller.value.text,
      ));
      Utils.showToastification('Customer', 'Data save in Draft');
      print('Data inserted successfully.');
    } catch (e) {
      print('Failed to insert data: $e');
    }
  }

  Future<void> updateAccountData(String draftId) async {
    try {
      await crmDatabase.updateItem(AccountDraftModel(
        id: int.tryParse(draftId),
        profile: accountMaster_page_controller.ImageUrl_Controller.value.text,
        accountName: accountMaster_page_controller.account_name_controller.value.text,
        accountOwner: accountMaster_page_controller.EmployeeMember_Controller.value.text.isEmpty?accountMaster_page_controller.UserName:accountMaster_page_controller.EmployeeMember_Controller.value.text,
        accountTitle: accountMaster_page_controller.AccountTitle_Controller.value.text,
        accountType: accountMaster_page_controller.account_type_controller.value.text,
        phoneNo: accountMaster_page_controller.PhoneNo_Controller.value.text,
        emailId: accountMaster_page_controller.EmailId_Controller.value.text,
        accountCategoryType: accountMaster_page_controller.account_cat_type_controller.value.text,
        companyProfileType: accountMaster_page_controller.comp_prof_type_controller.value.text,
        companyProfileRemark: accountMaster_page_controller.comp_prof_remarks_controller.value.text,
        companyProfileSubType: accountMaster_page_controller.comp_prof_sub_type_controller.value.text,
        gstType: accountMaster_page_controller.gst_registration_type_controller.value.text,
        gstNo: accountMaster_page_controller.GstNo_Controller.value.text,
        panNo: accountMaster_page_controller.PanNo_Controller.value.text,
        ifscCode: accountMaster_page_controller.IfscCode_Controller.value.text,
        address: accountMaster_page_controller.Address_controller.value.text,
        address2: accountMaster_page_controller.Address2_Controller.value.text,
        postCode: accountMaster_page_controller.PostCode_Controller.value.text,
        stateName: accountMaster_page_controller.State_Controller.value.text,
        city: accountMaster_page_controller.City_Controller.value.text,
        district: accountMaster_page_controller.District_Controller.value.text,
        shippingAddress: accountMaster_page_controller.Shipping_Address_controller.value.text,
        shippingAddress2: accountMaster_page_controller.Shipping_Address2_Controller.value.text,
        shippingPostCode: accountMaster_page_controller.Shipping_PostCode_Controller.value.text,
        shippingStateCode: accountMaster_page_controller.Shipping_State_Controller.value.text,
        shippingCity: accountMaster_page_controller.Shipping_City_Controller.value.text,
        shippingDistrict: accountMaster_page_controller.Shipping_District_Controller.value.text,
        noOfEmployees: int.tryParse(accountMaster_page_controller.No_Of_Emp_Controller.value.text) ?? 0,
        annualRevenue: double.tryParse(accountMaster_page_controller.Annual_Revenue_Controller.value.text) ?? 0.0,
        tatResponseType: accountMaster_page_controller.tatResponseType,
        salesRepresentative: accountMaster_page_controller.Sale_Representative_Controller.value.text,
        regionalServiceHead: accountMaster_page_controller.Regional_service_head_Controller.value.text,
      ));
      Utils.showToastification('Customer', 'Data updated in Draft');
      print('Data updated successfully.');
    } catch (e) {
      print('Failed to insert data: $e');
    }
  }


}