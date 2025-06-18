import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../component/default_button.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../../CRM_Models/Contact_Master_modal/Contact_Master_modal/Department_name_modal.dart';
import '../../../CRM_Models/Contact_Master_modal/Contact_Master_modal/Designation_modal.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';


class AddNewcontactMasterContact extends StatelessWidget{
  final contact_vm_controller = Get.put(ContactMasterVM());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size = Get.size;

  /*static String _displayAccNameForOption(AccountMasterModel option) =>
      option.accountName!+"(${option.accountCode!})";*/
  static String _displayAccNameForOption(AccountMasterModel option) =>
      option.accountName! + " (${option.accountCode!})";
  static String _displayDepartNameForOption(DepartNameModal option) =>
      option.deptName!;
  static String _displayDesignationNameForOption(DesignationModal option) =>
      option.designationname!;
  static String _displayIsHeDecisionMakerForOption(CustomList option) =>
      option.value!;

  final _formKey = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("FromPage....${accountMaster_page_controller.FromPage.value}");
        if(accountMaster_page_controller.FromPage == "Account"){
          contact_vm_controller.account_name_controller.clear();
          contact_vm_controller.contact_name_controller.clear();
          contact_vm_controller.depart_name_controller.clear();
          contact_vm_controller.phone_no_controller.clear();
          contact_vm_controller.emailId_controller.clear();
          Get.back();
        }else if(accountMaster_page_controller.FromPage == "Task"){
          contact_vm_controller.account_name_controller.clear();
          contact_vm_controller.contact_name_controller.clear();
          contact_vm_controller.depart_name_controller.clear();
          contact_vm_controller.phone_no_controller.clear();
          contact_vm_controller.emailId_controller.clear();
          Get.back();
        }
        else if(contact_vm_controller.FromPage.value== "AccountUpdate"){
          Get.toNamed(RoutesName.viewContacts_screen);
        }
        else{
          contact_vm_controller.filterIconColor.value=false;
          contact_vm_controller.account_name_controller.clear();
          contact_vm_controller.contact_name_controller.clear();
          contact_vm_controller.depart_name_controller.clear();
          contact_vm_controller.phone_no_controller.clear();
          contact_vm_controller.emailId_controller.clear();
          contact_vm_controller.getContactMasterList(0,"","","");
          Get.toNamed(RoutesName.contactMaster_screen);
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
              Text(
                contact_vm_controller.updateContact?'Update Contact':"Create Contact",
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              /*Spacer(),
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
                  message: contact_vm_controller.updateContact?'Update Contact':"Create Contact",
                  child: Text(contact_vm_controller.updateContact?'Update':'Create',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                onPressed: () {
                  if(contact_vm_controller.updateContact){
                    contact_vm_controller.createNewContactMstApi("Update");
                  }
                  else{
                    contact_vm_controller.contact_code="";
                    contact_vm_controller.createNewContactMstApi("Create");

                  }

                  //preventive_page_controller.createPreventiveCalenderCallApi();

                }, //Text
              ),*/
            ],
          )

      ),
      drawer: CustomDrawer(),
      floatingActionButton:  Visibility(
        visible:  accountMaster_page_controller.isAdminWritePermission=="0"?true:false,
        child: Container(
          margin: EdgeInsets.only(left: 30),
          child: DefaultButton(
            press: (){
              if(contact_vm_controller.updateContact){
                contact_vm_controller.createNewContactMstApi("Update");
              }
              else{
                contact_vm_controller.contact_code="";
                contact_vm_controller.createNewContactMstApi("Create");
              }

            },
            text: contact_vm_controller.updateContact?'Update Contact':'Create Contact',
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 70),
          height: size.height,
          width: size.width,
        child: SingleChildScrollView(
          child: IgnorePointer(
            ignoring:  accountMaster_page_controller.isAdminWritePermission=="1"?true:false,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:contact_vm_controller.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                SizedBox(height: 20,),
                Visibility(
                  visible: contact_vm_controller.updateContact,
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      readOnly: contact_vm_controller.updateContact,
                      controller: contact_vm_controller.contact_code_controller,
                      decoration: InputDecoration(
                        //hintText: "Alternate No",
                          labelText: "Contact Code",
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
                ),
                SizedBox(height: 15,),

                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //color: AllColors.whiteColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //height: size.height*10,
                        width: contact_vm_controller.updateContact?size.width*.92:size.width*.7,
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindAccountOwnerDropDown(context),
                      ),
                      Visibility(
                        visible: contact_vm_controller.updateContact==true?false:true,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AllColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AllColors.lightblackColor, // Set the border color to black
                              width: 1.0, // You can adjust the width of the border as needed
                            ),
                          ),
                          child: IconButton(
                              onPressed: (){
                                if( contact_vm_controller.FromPage.value=="AccountUpdate"){
                                  accountMaster_page_controller.FromPage.value = "AccountUpdate";
                                }else{
                                  accountMaster_page_controller.FromPage.value = "Contact";
                                }
                                accountMaster_page_controller.DraftId = '';
                                accountMaster_page_controller.clearController();
                                accountMaster_page_controller.getEmployeeMemberApi();
                                accountMaster_page_controller.getCompanyProfileTypeApi("");
                                accountMaster_page_controller.getGeoPostalCodeApi();
                                Get.toNamed(RoutesName.add_New_AccountMaster_screen);
                              }, icon: Icon(Icons.add)),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 15,),

                Obx((){
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      //readOnly: true,
                      maxLength: 500,
                      maxLines: 3,
                      controller: contact_vm_controller
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

                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: contact_vm_controller.contact_name_controller,
                    decoration: InputDecoration(
                        hintText: "Contact Name*",
                        labelText: "Contact Name*",
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
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
                      controller: contact_vm_controller.phone_no_controller,
                      decoration: InputDecoration(
                          hintText: "Phone No.*",
                          labelText: "Phone No.*",
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
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: contact_vm_controller.alternate_no_controller,
                    decoration: InputDecoration(
                        hintText: "Alternate Phone No.",
                        labelText: "Alternate Phone No.",
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
                  key: _formKeyEmail,
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
                      controller: contact_vm_controller.emailId_controller,
                      decoration: InputDecoration(
                          hintText: "Email Id",
                          labelText: "Email Id",
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
                ),
                SizedBox(height: 15,),
               /* Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: bindDepartNameDropDown(context),
                ),*/
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: contact_vm_controller.depart_name_controller,
                    decoration: InputDecoration(
                        hintText: "Department Name",
                        labelText: "Department Name",
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
                 /*Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: bindDesignationDropDown(context),

                ),*/
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: contact_vm_controller.designation_name_controller,
                    decoration: InputDecoration(
                        hintText: "Designation Name",
                        labelText: "Designation Name",
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
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: contact_vm_controller.reporting_person_controller,
                    decoration: InputDecoration(
                        hintText: "Reporting Person",
                        labelText: "Reporting Person",
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
                bindIsDecisionDropDown(context),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    maxLength: 500,
                    maxLines: 2,
                    controller: contact_vm_controller.contact_title_controller,
                    decoration: InputDecoration(
                        hintText: "Contact Title",
                        labelText: "Contact Title",
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
                /*SizedBox(height: 10,),*/


              ],
            ),
          ),
        ),
      ),
    ),
    );
  }


  Widget bindAccountOwnerDropDown(context){
    return IgnorePointer(
      ignoring: contact_vm_controller.updateContact || contact_vm_controller.insideOut == false,
      child: Autocomplete<AccountMasterModel>(
        displayStringForOption: _displayAccNameForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if(contact_vm_controller.updateContact){
            contact_vm_controller.Account_Master_list.value=[];
          }
          if (textEditingValue.text.isEmpty) {
            return contact_vm_controller.Account_Master_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          /*return contact_vm_controller.Account_Master_list
              .where((AccountMasterModel option) {
            return option.accountName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();*/
          return await contact_vm_controller.getAccountMaster(textEditingValue.text);
        },
        onSelected: (AccountMasterModel selection) {
          print(selection.accountName);
          // Update the TextField with the selected
          contact_vm_controller.account_name_controller.text =
              _displayAccNameForOption(selection).toString();
          contact_vm_controller.accountName.value=selection.accountName??"";
          contact_vm_controller.accountCode.value=selection.accountCode??"";
          contact_vm_controller.getAccMasterBuyCodeApi(selection.accountCode??"");

        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextFormField(
            readOnly: contact_vm_controller.updateContact || contact_vm_controller.insideOut == false,
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = contact_vm_controller.account_name_controller.text,
            focusNode: focusNode,
            onTapOutside: (value){
              FocusNode().unfocus();
            },

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
              hintText: 'Account Name',
              labelText: 'Account Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<AccountMasterModel> onSelected,
            Iterable<AccountMasterModel> suggestions) {
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
                    final AccountMasterModel option =
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
                                  text:  option.accountName!,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                                TextSpan(
                                  text: " (${option.accountCode!})",
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

                        /*Text(
                          option.accountName! + " (${option.accountCode!})",
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

  Widget bindDepartNameDropDown(context){
    return Autocomplete<DepartNameModal>(
      displayStringForOption: _displayDepartNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return contact_vm_controller.department_name_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return contact_vm_controller.department_name_list
            .where((DepartNameModal option) {
          return option.deptName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (DepartNameModal selection) {
        print(selection.deptName);
        // Update the TextField with the selected
        contact_vm_controller.depart_name_controller.text =
            _displayDepartNameForOption(selection).toString();
        contact_vm_controller.designation_dropDown.value=true;

        contact_vm_controller.designation_name_controller.clear();

        print('object...${contact_vm_controller.designation_name_controller.text}');
        contact_vm_controller.getDesignationList();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = contact_vm_controller.depart_name_controller.text,
          focusNode: focusNode,
          onChanged: (value){
            contact_vm_controller.designation_name_controller.clear();
            contact_vm_controller.designation_dropDown.value=false;
            contact_vm_controller.designation_dropDown.value=true;
          },
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            hintText: 'Department Name',
            labelText: 'Department Name',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<DepartNameModal> onSelected,
          Iterable<DepartNameModal> suggestions) {
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
                  final DepartNameModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.deptName.toString(),
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

  Widget bindDesignationDropDown(context){

    return Autocomplete<DesignationModal>(
      displayStringForOption: _displayDesignationNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return contact_vm_controller.designation_name_list;
        }
        return contact_vm_controller.designation_name_list
            .where((DesignationModal option) {
          return option.designationname
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (DesignationModal selection) {
        print(selection.designationname);
        // Update the TextField with the selected
        contact_vm_controller.designation_name_controller.text = _displayDesignationNameForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = contact_vm_controller.designation_name_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            hintText: 'Designation Name',
            labelText: 'Designation Name',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<DesignationModal> onSelected,
          Iterable<DesignationModal> suggestions) {
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
                  final DesignationModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.designationname.toString(),
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

  Widget bindIsDecisionDropDown(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0),
      width: double.infinity,
      child: DropdownMenu<CustomList>(
       // enableFilter: true,
       // requestFocusOnTap: true,
        width: size.width-30,
        controller: contact_vm_controller.IsHeDecisionMakerController.value,
        label: Text(
          "Role",
          style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize
                  .sisxteen),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        onSelected: (CustomList? selection) {
          print(selection);
          contact_vm_controller.IsHeDecisionMakerController.value.text =
              _displayIsHeDecisionMakerForOption(selection!).toString();

        },
        dropdownMenuEntries:
        contact_vm_controller.isHeDecisionMakerList.map<DropdownMenuEntry<CustomList>>((CustomList e) {
          return DropdownMenuEntry<CustomList>(value: e, label: e.value!,style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }


}