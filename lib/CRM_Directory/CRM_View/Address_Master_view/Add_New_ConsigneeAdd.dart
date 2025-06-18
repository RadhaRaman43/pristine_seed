import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/State_master_model.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_Models/Address_Master_Model/PincodeMaster_Model.dart';
import '../../CRM_Models/Address_Master_Model/PostalCode_Model.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';
import '../Account_Master_view/update_account_master.dart';


class AddNewConsigneeadd extends StatelessWidget{
  AddNewConsigneeadd({super.key});

  final address_vm_controller = Get.put(Addressmastervm());
  final accountMaster_page_controller = Get.put(Accountmastervm());

  static String _displayGstRegisterTypeForOption(CustomList option) =>
      option.value!;

  static String _displayStateListForOption(PincodeMasterModel option) =>
      option.stateName!;

  static String _displayCityListForOption(PincodeMasterModel option) =>
      option.city!;

  static String _displayDistrictListForOption(PincodeMasterModel option) =>
      option.district!;

  static String _displayPostalCodeListForOption(PostalCodeModel option) =>
      option.pincode!;

  Size size=Get.size;
  final _formKey = GlobalKey<FormState>();
  final _formKeyGst = GlobalKey<FormState>();
  final _formKeyPanNo = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
           address_vm_controller.contact_name_controller.clear();
           address_vm_controller.Consignee_controller.value.clear();
           address_vm_controller.phone_no_controller.clear();
           address_vm_controller.emailId_controller.clear();
           address_vm_controller.pageNumber = 0;
           address_vm_controller.getAddressMasterList(accountMaster_page_controller.pageNumber,accountMaster_page_controller.account_code_controller.text);
      Get.back();
      return false;},
      child: Scaffold(
        appBar:  AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title:Row(
              children: [
                Text(
                  address_vm_controller.updateContact?'Update Address':"Add Address",
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
               /* Spacer(),
                ActionChip(
                  elevation: 2,
                  padding: EdgeInsets.all(5),
                  backgroundColor: AllColors.primaryDark1,
                  shadowColor: Colors.black,
                  shape: StadiumBorder(
                      side: BorderSide(color: AllColors.grayColor)),
                  //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                  //CircleAvatar
                  label: Tooltip(
                    message: address_vm_controller.updateContact?'Update Address':"Add Address",
                    child: Text(address_vm_controller.updateContact?'Update':'Create',
                        style: GoogleFonts.poppins(
                          color: AllColors.whiteColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  onPressed: () {
                    if(address_vm_controller.updateContact){
                      address_vm_controller.createNewAddressMstApi("Update");
                    }
                    else{
                      address_vm_controller.consignee_code="";
                      address_vm_controller.createNewAddressMstApi("Create");

                    }

                    //preventive_page_controller.createPreventiveCalenderCallApi();

                  }, //Text
                ),*/
              ],
            )

        ),
        drawer: CustomDrawer(),
        floatingActionButton:  Visibility(
          visible: accountMaster_page_controller.isAdminWritePermission=="0"?true:false,
          child: Container(
            margin: EdgeInsets.only(left: 30),
            child: DefaultButton(
              press: (){
                if(address_vm_controller.updateContact){
                  address_vm_controller.createNewAddressMstApi("Update");
                }
                else{
                  address_vm_controller.consignee_code="";
                  address_vm_controller.createNewAddressMstApi("Create");

                }

              },
              text: address_vm_controller.updateContact?'Update Contact':'Create Contact',
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 70),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: IgnorePointer(
              ignoring: accountMaster_page_controller.isAdminWritePermission=="1"?true:false,
              child: Column(
                children: [
                  SizedBox(height: 10),
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
                          Obx((){
                            return Visibility(
                              visible: address_vm_controller.updateContact,
                              child: Container(
                                child: TextFormField(
                                  readOnly: true,
                                  //initialValue: accountMaster_page_controller.AccountMasterGetCode_list[0].accountCode,
                                  controller: address_vm_controller.Consignee_controller.value,
                                  decoration: InputDecoration(
                                      hintText: "Consignee Id",
                                      labelText: "Consignee Id",
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
                            );
                          }),


                          SizedBox(height: 15,),
                          Container(
                           // padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
                              readOnly: true,
                              //initialValue: accountMaster_page_controller.AccountMasterGetCode_list[0].accountCode,
                              controller: address_vm_controller.account_code_controller,
                              decoration: InputDecoration(
                                  hintText: "Account Code",
                                  labelText: "Account Code",
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
                          Container(
                           // padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child:   TextFormField(
                              /*readOnly: accountMaster_page_controller.view=='FromTaskMainScreen'
                         || accountMaster_page_controller.view=='VIEW' ||
                         accountMaster_page_controller.view=='Task'||
                         accountMaster_page_controller.view=='FromSaleCycleMainScreen' ||
                         accountMaster_page_controller.view=="FromQuoteApproval"?true:false,*/
                              readOnly: true,
                              //initialValue: accountMaster_page_controller.AccountMasterGetCode_list[0].accountName!,
                              controller: address_vm_controller.account_name_controller,
                              decoration: InputDecoration(
                                  hintText: "Account Name*",
                                  labelText: "Account Name*",
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

                          Container(
                            // padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child:   TextFormField(
                              controller: address_vm_controller.contact_name_controller,
                              decoration: InputDecoration(
                                  hintText: "Address Name*",
                                  labelText: "Address Name*",
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
                                controller: address_vm_controller
                                    .phone_no_controller,
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
                              controller: address_vm_controller
                                  .alternate_no_controller,
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
                                controller: address_vm_controller
                                    .emailId_controller,
                                decoration: InputDecoration(
                                    hintText: "Email Id",
                                    labelText: "Email Id",
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

                          bindGstRegistrationTypeDropDown(context),

                          SizedBox(height: 15,),

                          Obx(() {
                            return
                              Visibility(
                                visible: address_vm_controller
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
                                              address_vm_controller.GstStateCode.value = value.substring(0, 2);
                                              print('First two digits: ${address_vm_controller.GstStateCode}');

                                             // print('List...${address_vm_controller.StateMaster_list.length}');


                                            }
                                            if (value.length >= 12) {
                                              address_vm_controller.GstPanNo.value = value.substring(2, 12);
                                              print('Next ten digits: ${address_vm_controller.GstPanNo}');
                                              // You can save nextTenDigits to a variable or perform other operations
                                            }
                                          },
                                          controller: address_vm_controller
                                              .GstNo_Controller,
                                          decoration: InputDecoration(
                                              hintText: "GST No*",
                                              labelText: "GST No*",
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
                                  else if(address_vm_controller.gst_registration_type_controller.value.text == 'Registered' && value != address_vm_controller.GstPanNo.value){
                                    return 'Please Enter Valid Pan No.';
                                  }else {
                                    return null;
                                  }
                                },

                                onChanged: (value) {
                                  // Clear the error when the user enters a value
                                  _formKeyPanNo.currentState?.validate();

                                },
                                controller: address_vm_controller
                                    .PanNo_Controller,
                                decoration: InputDecoration(
                                    hintText: "PAN No",
                                    labelText: "PAN No",
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
                              controller: address_vm_controller
                                  .IfscCode_Controller,
                              decoration: InputDecoration(
                                  hintText: "IFSC Code",
                                  labelText: "IFSC Code",
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

                          SizedBox(height: 5,),

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
                        labelText: 'Address',
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
                              onChanged: (value){
                                address_vm_controller.FullAddress_Controller.value.text = value + ", " + address_vm_controller
                                    .Address_controller.text + ", " + address_vm_controller
                                    .City_Controller.text + ", " + address_vm_controller
                                    .District_Controller.text + ", " + address_vm_controller
                                    .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;
                              },
                              controller: address_vm_controller
                                  .Address_controller,
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
                              onChanged: (value){
                                address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
                                    .Address_controller.text + ", " + value + ", " + address_vm_controller
                                    .City_Controller.text + ", " + address_vm_controller
                                    .District_Controller.text + ", " + address_vm_controller
                                    .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;
                              },
                              controller: address_vm_controller
                                  .Address2_Controller,
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


                          Container(

                              child: bindPostalCodeDropDown(context)
                          ),

                          SizedBox(height: 15,),

                          Container(
                            //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: bindStateDropDown(context),
                          ),


                          SizedBox(height: 15,),

                          Container(
                            child: bindCityDropDown(context)
                          ),

                          SizedBox(height: 15,),

                          Container(
                              child: bindDistrictDropDown(context)
                          ),


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
                                maxLength: 500,
                                maxLines: 3,
                                controller: address_vm_controller
                                    .FullAddress_Controller.value,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*Widget bindGstRegistrationTypeDropDown(context){
    return Autocomplete<CustomList>(
      displayStringForOption: _displayGstRegisterTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
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
        address_vm_controller.gst_registration_type_controller.value.text =
            _displayGstRegisterTypeForOption(selection).toString();
        if(address_vm_controller.gst_registration_type_controller.value.text == 'Registered'){
          address_vm_controller.GstRegistration.value = true;
        }else{
          // accountMaster_page_controller.GstStateList.addAll(accountMaster_page_controller.StateMaster_list);
          address_vm_controller.GstRegistration.value = false;
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
              ..text = address_vm_controller.gst_registration_type_controller.value
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'GST Registration Type*',
              labelText: 'GST Registration Type*',
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
        initialSelection: accountMaster_page_controller.get_Gst_Registration_list[1],
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
          address_vm_controller.gst_registration_type_controller.value.text =
              _displayGstRegisterTypeForOption(selection!).toString();
          if(address_vm_controller.gst_registration_type_controller.value.text == 'Registered'){
            address_vm_controller.GstRegistration.value = true;
          }else{
            // accountMaster_page_controller.GstStateList.addAll(accountMaster_page_controller.StateMaster_list);
            address_vm_controller.GstRegistration.value = false;
          }


        },

        dropdownMenuEntries: accountMaster_page_controller.get_Gst_Registration_list.map<DropdownMenuEntry<CustomList>>((CustomList e) {
          return DropdownMenuEntry<CustomList>(value: e, label: e.value!,style: ButtonStyle(
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
          return address_vm_controller.geoPostal_Code_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return address_vm_controller.geoPostal_Code_list
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
        address_vm_controller.PostCode_Controller.text =
            _displayPostalCodeListForOption(selection).toString();
        address_vm_controller.getStateMasterApi(address_vm_controller.PostCode_Controller.text, 'state');
        address_vm_controller.getStateMasterApi(address_vm_controller.PostCode_Controller.text, 'city');
        address_vm_controller.getStateMasterApi(address_vm_controller.PostCode_Controller.text, 'district');
        address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
            .Address_controller.text + ", " + address_vm_controller
            .Address2_Controller.text + ", " + address_vm_controller
            .City_Controller.text + ", " + address_vm_controller
            .District_Controller.text + ", " + address_vm_controller
            .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(
            onChanged: (value){
              address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
                  .Address_controller.text + ", " + address_vm_controller
                  .Address2_Controller.text + ", " + address_vm_controller
                  .City_Controller.text + ", " + address_vm_controller
                  .District_Controller.text + ", " + address_vm_controller
                  .State_Controller.text + ", " + value;
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = address_vm_controller.PostCode_Controller
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
              hintText: 'Post Code*',
              labelText: 'Post Code*',
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
          return address_vm_controller.StateMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return address_vm_controller.StateMasterPinCode_list
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
        address_vm_controller.State_Controller.text =
            _displayStateListForOption(selection).toString();
        address_vm_controller.GovtStateCode.value = accountMaster_page_controller.State_Controller.text.substring(0, 2);
        // print('GstCOde...: ${accountMaster_page_controller.GovtStateCode}');
        /* if(accountMaster_page_controller.gst_registration_type_controller.value.text == 'Registered' && accountMaster_page_controller.GstStateCode.value != selection.governmentStateCode){
          Utils.sanckBarError("Wrong State", "Please Select Valid State");
        }*/

        //accountMaster_page_controller.getCompanyProfileTypeApi();

        address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
            .Address_controller.text + ", " + address_vm_controller
            .Address2_Controller.text + ", " + address_vm_controller
            .City_Controller.text + ", " + address_vm_controller
            .District_Controller.text + ", " + address_vm_controller
            .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(
            onChanged: (value) {
              address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
                  .Address_controller.text + ", " + address_vm_controller
                  .Address2_Controller.text + ", " + address_vm_controller
                  .City_Controller.text + ", " + address_vm_controller
                  .District_Controller.text + ", " + value+ ", " + address_vm_controller.PostCode_Controller.text;

            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = address_vm_controller.State_Controller
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

  Widget bindCityDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayCityListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return address_vm_controller.CityMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return address_vm_controller.CityMasterPinCode_list
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
        address_vm_controller.City_Controller.text =
            _displayCityListForOption(selection).toString();
        FocusNode().unfocus();
        address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
            .Address_controller.text + ", " + address_vm_controller
            .Address2_Controller.text + ", " + address_vm_controller
            .City_Controller.text + ", " + address_vm_controller
            .District_Controller.text + ", " + address_vm_controller
            .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              onChanged: (value){
                address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
                    .Address_controller.text + ", " + address_vm_controller
                    .Address2_Controller.text + ", " + value + ", " + address_vm_controller
                    .District_Controller.text + ", " + address_vm_controller
                    .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = address_vm_controller.City_Controller
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

  Widget bindDistrictDropDown(context){
    return Autocomplete<PincodeMasterModel>(
      displayStringForOption: _displayDistrictListForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return address_vm_controller.DistrictMasterPinCode_list;
          // return const Iterable<PincodeMasterModel>.empty();
        }
        return address_vm_controller.DistrictMasterPinCode_list
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
        address_vm_controller.District_Controller.text =
            _displayDistrictListForOption(selection).toString();
        FocusNode().unfocus();
        address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
            .Address_controller.text + ", " + address_vm_controller
            .Address2_Controller.text + ", " + address_vm_controller
            .City_Controller.text + ", " + address_vm_controller
            .District_Controller.text + ", " + address_vm_controller
            .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              onChanged: (value){
                address_vm_controller.FullAddress_Controller.value.text = address_vm_controller
                    .Address_controller.text + ", " + address_vm_controller
                    .Address2_Controller.text + ", " + address_vm_controller
                    .City_Controller.text + ", " + value + ", " + address_vm_controller
                    .State_Controller.text + ", " + address_vm_controller.PostCode_Controller.text;
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = address_vm_controller.District_Controller
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

}