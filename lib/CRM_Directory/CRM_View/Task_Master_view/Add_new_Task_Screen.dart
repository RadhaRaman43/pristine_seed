import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';

class AddNewTaskScreen extends StatelessWidget{
  AddNewTaskScreen({super.key});

  final taskMaster_page_controller=Get.put(Taskmastervm());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  Size size=Get.size;


  static String _displayAccountNameForOption(AccountMasterModel option) =>
      option.accountName!+"(${option.accountCode!})";

  static String _displayContactNameForOption(ContactMstGetListModal option) =>
      option.contactName!;

  static String _displayTypeOfCallForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  static String _displayMethodOfCallForOption(CallStatusMasterModel option) =>
      option.taskStatus!;
  static String _displaySalesIdForOption(SalesCycleModal option) =>
      option.salesCycleId!;

  static String _displayIsInfraLeadForOption(String option) =>
      option;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  static String _displayAlongPersonForOption(AlongWithPersonModel option) =>
      (option.firstName?.toString() ?? "") +
          " " +
          (option.middleName?.toString() ?? "") +
          " " +
          (option.lastName?.toString() ?? "");


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      //Get.offAllNamed(RoutesName.taskMaster_screen);
          taskMaster_page_controller.resetAllFieldOfFilter();
          taskMaster_page_controller.clearCreateTaskController();
      Get.toNamed(RoutesName.taskMaster_screen);
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
                'Create Task',
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
                  message: "Create Task ",
                  child: Text('Create',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                onPressed: () {

                  if(taskMaster_page_controller.account_Name_controller.text.isEmpty || taskMaster_page_controller.account_Name_controller == null){
                    Utils.sanckBarError('Account Name!', "Please Enter Account Name");
                    return  ;
                  }
                  if(taskMaster_page_controller.Contact_Name_controller.text.isEmpty || taskMaster_page_controller.Contact_Name_controller == null){
                    Utils.sanckBarError('Contact NAme!', "Please Enter Contact Name");
                    return  ;
                  }
                  if(taskMaster_page_controller.Type_of_call_controller.text.isEmpty || taskMaster_page_controller.Type_of_call_controller == null){
                    Utils.sanckBarError('Type of Call!', "Please Enter Type Of Call");
                    return  ;
                  }
                  if(taskMaster_page_controller.Method_of_call_controller.text.isEmpty || taskMaster_page_controller.Method_of_call_controller == null){
                    Utils.sanckBarError('Method of Call!', "Please Enter Method of Call");
                    return  ;
                  }

                  if(taskMaster_page_controller.Method_of_call_controller.text == 'Physical Meeting' && taskMaster_page_controller.PusposeOfVisit_controller.text.isEmpty){
                    Utils.sanckBarError('Purpose Of Visit!', "Please Enter Purpose of Visit");
                    return  ;
                  }

                  taskMaster_page_controller.TaskMasterCreate();

                }, //Text
              ),*/
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:taskMaster_page_controller.loading.value ,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              SizedBox(height: 25,),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      width: size.width*.7,
                      child: bindAccountNameDropDown(context),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AllColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AllColors.lightblackColor,
                          width: 1.0,
                        ),
                      ),
                      child: IconButton(
                          onPressed: (){
                            accountMaster_page_controller.FromPage.value = "Task";
                            accountMaster_page_controller.DraftId = '';
                            accountMaster_page_controller.clearController();
                            accountMaster_page_controller.getEmployeeMemberApi();
                            accountMaster_page_controller.getCompanyProfileTypeApi("");
                            accountMaster_page_controller.getCompanyProfileSubTypeApi();
                            accountMaster_page_controller.getGeoPostalCodeApi(50,'');
                            Get.toNamed(RoutesName.add_New_AccountMaster_screen);
                          }, icon: Icon(Icons.add)),
                    )
                  ],
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
                      width: size.width*.7,
                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: bindContactNameDropDown(context),
                    ),
                    Container(
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
                            contact_vm_controller.resetAllContactCreativeField('Icon');
                            contact_vm_controller.insideOut = true;
                            accountMaster_page_controller.FromPage.value = "Task";
                            //contact_vm_controller.IsHeDecisionMakerController.value.text = "No";
                            contact_vm_controller.getAccountMaster("");
                            contact_vm_controller.getDecisionRoleMaster();
                            Get.toNamed(RoutesName.addNewContactMaster_screen);
                          }, icon: Icon(Icons.add)),
                    )
                  ],
                ),
              ),


              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: bindTypeOfCallDropDown(context),
              ),

              Obx(() {
                return
                  Visibility(
                    visible: taskMaster_page_controller.PaymentCall.value,
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Container(
                         // padding: EdgeInsets.only(left: 15.0,),
                          child: bindIsSalesIdNessDropDown(context),

                        ),
                      ],
                    ),
                  );
              }),

              Obx(() {
                return
                  Visibility(
                    visible: taskMaster_page_controller.IsSalesId.value,
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: bindSalesIdDropDown(context),

                        ),
                      ],
                    ),
                  );
              }),

              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: bindMethodOfCallDropDown(context)

              ),

              /*SizedBox(height: 15,),
              bindIsInfraLeadDropDown(context),*/

              SizedBox(height: 15,),

              bindDateOfVisit(context),

              SizedBox(height: 15,),

              bindVisitTimePicker(context),

              SizedBox(height: 15,),

              bindAlongWithPersonDropDown(context),
              SizedBox(height: 10,),
              Obx(() {
                return
                  Wrap(
                    spacing: 8.0,
                    children: taskMaster_page_controller.SelectedAlongPersonWith_list.map((category) {
                      return Chip(
                        label: Text((category.firstName?.toString() ?? "") +
                            " " +
                            (category.middleName?.toString() ?? "") +
                            " " +
                            (category.lastName?.toString() ?? "")
                        ),
                        onDeleted: () {
                          taskMaster_page_controller.SelectedAlongPersonWith_list.remove(category);
                        },
                      );
                    }).toList(),
                  );

              }),
              SizedBox(height: 10,),

              bindProductCategoryDropDown(context),
              SizedBox(height: 10,),
              Obx(() {
                return
                  Wrap(
                    spacing: 8.0,
                    children: taskMaster_page_controller.Item_Category_Selected_list.map((category) {
                      return Chip(
                        label: Text(category.categoryName!),
                        onDeleted: () {
                          taskMaster_page_controller.Item_Category_Selected_list.remove(category);
                        },
                      );
                    }).toList(),
                  );

              }),
              SizedBox(height: 10,),

               Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                      maxLength: 500,
                      maxLines: 2,
                      controller: taskMaster_page_controller.Task_Remarks_controller,
                      decoration: InputDecoration(
                          hintText: 'Task Remarks',
                          labelText: 'Task Remarks',
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

              Obx(() {
                return
                  Visibility(
                    visible: taskMaster_page_controller.PurposeOfVisit.value,
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextFormField(
                            maxLength: 500,
                            maxLines: 2,
                            controller: taskMaster_page_controller.PusposeOfVisit_controller,
                            decoration: InputDecoration(
                                hintText: 'Purpose Of Visit',
                                labelText: 'Purpose Of Visit',
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
                  );
              }),

              SizedBox(height: 15,),

              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: DefaultButton(
                  press: (){
                    if(taskMaster_page_controller.account_Name_controller.text.isEmpty || taskMaster_page_controller.account_Name_controller == null){
                      Utils.sanckBarError('Account Name!', "Please Enter Customer Name");
                      return  ;
                    }
                    if(taskMaster_page_controller.Type_of_call_controller.value.text!="New Call" &&
                       ( taskMaster_page_controller.Contact_Name_controller.text.isEmpty ||
                           taskMaster_page_controller.Contact_Name_controller == null) ){
                      Utils.sanckBarError('Contact Name!', "Please Enter Contact Name");
                      return  ;
                    }
                    /*if(taskMaster_page_controller.Contact_Name_controller.text.isEmpty || taskMaster_page_controller.Contact_Name_controller == null){
                      Utils.sanckBarError('Contact NAme!', "Please Enter Contact Name");
                      return  ;
                    }*/
                    if(taskMaster_page_controller.Type_of_call_controller.value.text.isEmpty || taskMaster_page_controller.Type_of_call_controller.value.text == null){
                      Utils.sanckBarError('Type of Call!', "Please Enter Type Of Call");
                      return  ;
                    }

                    if(taskMaster_page_controller.Type_of_call_controller.value.text == "Payment Call" && taskMaster_page_controller.Sale_cycle_Id_controller.text.isEmpty){
                      Utils.sanckBarError('Sales Id!', "Please Enter Sales Id");
                      return  ;
                    }

                    if(taskMaster_page_controller.Method_of_call_controller.text.isEmpty || taskMaster_page_controller.Method_of_call_controller == null){
                      Utils.sanckBarError('Mode of Call!', "Please Enter Mode of Call");
                      return  ;
                    }

                    /*if(taskMaster_page_controller.isInfraLeadFilterController.text.isEmpty || taskMaster_page_controller.isInfraLeadFilterController == null){
                      Utils.sanckBarError('Is Infra Lead!', "Please Enter Is Infra Lead");
                      return  ;
                    }*/

                    if(taskMaster_page_controller.DataOFVisitController.value.text.isEmpty || taskMaster_page_controller.DataOFVisitController == null){
                      Utils.sanckBarError('Date Of Visit!', "Please Enter Date Of Visit");
                      return  ;
                    }

                    if(taskMaster_page_controller.Method_of_call_controller.text == 'Physical Meeting' && taskMaster_page_controller.PusposeOfVisit_controller.text.isEmpty){
                      Utils.sanckBarError('Purpose Of Visit!', "Please Enter Purpose of Visit");
                      return  ;
                    }


                    taskMaster_page_controller.TaskMasterCreate();
                  },
                  text: "Create Task",
                ),
              ),

            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget bindAccountNameDropDown(context){
    return Autocomplete<AccountMasterModel>(
      displayStringForOption: _displayAccountNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return taskMaster_page_controller.getAccountMaster(taskMaster_page_controller.rowsPerPage,"");
        }
        return taskMaster_page_controller.getAccountMaster(taskMaster_page_controller.rowsPerPage,textEditingValue.text);
      },
      onSelected: (AccountMasterModel selection) {
        taskMaster_page_controller.account_Name_controller.text =
            _displayAccountNameForOption(selection).toString();
        taskMaster_page_controller.account_code.value=selection.accountCode!;
        taskMaster_page_controller.account_name.value=selection.accountName!;
            taskMaster_page_controller.getContactMasterList(taskMaster_page_controller.account_code.value,taskMaster_page_controller.account_name.value);
            taskMaster_page_controller.pageNumber = 0;
        print('I select account name');
            taskMaster_page_controller.getSaleIDByAccountCode(taskMaster_page_controller.pageNumber);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.account_Name_controller
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
            hintText: 'Customer Name',
            labelText: 'Customer Name',
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
                      child: Text(
                          option.accountName!+"(${option.accountCode!})",
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen // Change the text color here
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

  Widget bindContactNameDropDown(context){
    return Autocomplete<ContactMstGetListModal>(
      displayStringForOption: _displayContactNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return taskMaster_page_controller.contact_master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return taskMaster_page_controller.contact_master_list
            .where((ContactMstGetListModal option) {
          return option.contactName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ContactMstGetListModal selection) {
        //print(selection.loginEmailId);
        // Update the TextField with the selected
        taskMaster_page_controller.Contact_Name_controller.text =
            _displayContactNameForOption(selection).toString();
        taskMaster_page_controller.contact_code.value=selection.contactCode!;
        //taskMaster_page_controller.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Contact_Name_controller
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
            hintText: 'Contact Name',
            labelText: 'Contact Name',

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ContactMstGetListModal> onSelected,
          Iterable<ContactMstGetListModal> suggestions) {
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
                  final ContactMstGetListModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.contactName.toString(),
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

  Widget bindTypeOfCallDropDown(context){
    return Autocomplete<CallStatusMasterModel>(
      displayStringForOption: _displayTypeOfCallForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return taskMaster_page_controller.CallStatus_Master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return taskMaster_page_controller.CallStatus_Master_list
            .where((CallStatusMasterModel option) {
          return option.taskStatus
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CallStatusMasterModel selection) {
        taskMaster_page_controller.Type_of_call_controller.value.text =
            _displayTypeOfCallForOption(selection).toString();
        taskMaster_page_controller.isSalesNecessaryController.value.clear();
        if( taskMaster_page_controller.Type_of_call_controller.value.text == 'Payment Call' || taskMaster_page_controller.Type_of_call_controller.value.text == 'Follow-Up Call'){
          taskMaster_page_controller.PaymentCall.value = true;
        }else{
          taskMaster_page_controller.PaymentCall.value = false;
          taskMaster_page_controller.IsSalesId.value = false;
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Type_of_call_controller.value.text,
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
            hintText: 'Type Of Call*',
            labelText: 'Type Of Call*',
            /*hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
            ),*/
            /*focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),*/
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CallStatusMasterModel> onSelected,
          Iterable<CallStatusMasterModel> suggestions) {
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
                  final CallStatusMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.taskStatus.toString(),
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

  Widget bindMethodOfCallDropDown(context){
    return Autocomplete<CallStatusMasterModel>(
      displayStringForOption: _displayMethodOfCallForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return taskMaster_page_controller.MethodOfCall_Master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return taskMaster_page_controller.MethodOfCall_Master_list
            .where((CallStatusMasterModel option) {
          return option.taskStatus
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CallStatusMasterModel selection) {
        //print(selection.loginEmailId);
        // Update the TextField with the selected
        taskMaster_page_controller.Method_of_call_controller.text =
            _displayMethodOfCallForOption(selection).toString();


        if( taskMaster_page_controller.Method_of_call_controller.text == 'Physical Meeting'){
         // print(taskMaster_page_controller.Method_of_call_controller.text);
          taskMaster_page_controller.PurposeOfVisit.value = true;
        }else{
          taskMaster_page_controller.PurposeOfVisit.value = false;
         // print('else part...${taskMaster_page_controller.Method_of_call_controller.text}');
        }
        //taskMaster_page_controller.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            controller.clear();
          },
         /* onTap: (){
            if(focusNode.hasFocus){
              focusNode.unfocus();
            }else{
              focusNode.requestFocus();
            }
          },*/
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Method_of_call_controller
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
            hintText: 'Mode Of Call*',
            labelText: 'Mode of Call*',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CallStatusMasterModel> onSelected,
          Iterable<CallStatusMasterModel> suggestions) {
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
                  final CallStatusMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.taskStatus.toString(),
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

  Widget bindSalesIdDropDown(context){
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      print('woring...');
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // You have reached the end of the list
        int totalPage = (taskMaster_page_controller.total_rows /
            taskMaster_page_controller.rowsPerPage)
            .toInt();
        if ((taskMaster_page_controller.total_rows %
            taskMaster_page_controller.rowsPerPage) >
            0) totalPage += 1;

        print(
            "last index ${taskMaster_page_controller.pageNumber} ${taskMaster_page_controller.total_rows} ${taskMaster_page_controller.rowsPerPage} ${totalPage}");

        // Fetch the next page if there are more pages
        if (taskMaster_page_controller.pageNumber + 1 < totalPage) {
          taskMaster_page_controller.getSaleIDByAccountCode(
              taskMaster_page_controller.pageNumber + 1).then((_) {
            taskMaster_page_controller.pageNumber += 1;
          });
        }
      }
    });
    return Autocomplete<SalesCycleModal>(
      displayStringForOption: _displaySalesIdForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return taskMaster_page_controller.Sales_Id_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return taskMaster_page_controller.Sales_Id_list
            .where((SalesCycleModal option) {
          return option.accountName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (SalesCycleModal selection) {
        print(selection.salesCycleId);
        // Update the TextField with the selected
        taskMaster_page_controller.Sale_cycle_Id_controller.text =
            _displaySalesIdForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Sale_cycle_Id_controller.text,
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
            hintText: 'Sales Id*',
            labelText: 'Sales Id*',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<SalesCycleModal> onSelected,
          Iterable<SalesCycleModal> suggestions) {
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
                  final SalesCycleModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        // option.accountName!+"(${option.accountCode!})",
                        option.salesCycleId!,
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

  Widget bindIsSalesIdNessDropDown(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0),
      width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width-30,
        controller: taskMaster_page_controller.isSalesNecessaryController.value,
        label: Text(
          "Is Sales Cycle Required",
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
          taskMaster_page_controller.isSalesNecessaryController.value.text =
              _displayIsInfraLeadForOption(selection!).toString();

          if(taskMaster_page_controller.isSalesNecessaryController.value.text == 'Yes'){
            taskMaster_page_controller.IsSalesId.value = true;
          }else{
            taskMaster_page_controller.IsSalesId.value = false;
          }


        },

        dropdownMenuEntries: taskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  Widget bindIsInfraLeadDropDown(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: double.infinity,
        child: DropdownMenu<String>(
          width: size.width-30,
        controller: taskMaster_page_controller.isInfraLeadFilterController,
        label: Text(
          "Is Infra Lead",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w300),
        ),

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
          taskMaster_page_controller.isInfraLeadFilterController.text =
              _displayIsInfraLeadForOption(selection!).toString();


        },

        dropdownMenuEntries: taskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }
  Widget bindDateOfVisit(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextField(
        cursorColor: AllColors.primaryDark1,
        controller: taskMaster_page_controller.DataOFVisitController.value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two,
            horizontal: AllFontSize.ten,
          ),
          suffixIcon: Icon(Icons.calendar_month),
          hintText: 'Date Of Visit',
          labelText: 'Date Of Visit',
          hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten,
          ),
          labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.sisxteen,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onTap: () async {
          DateTime? initialDate;
          String dateString = taskMaster_page_controller.DataOFVisitController.value.text;

          try {
            if (dateString.isNotEmpty) {
              initialDate = DateFormat('dd-MM-yyyy').parseStrict(dateString);
            } else {
              initialDate = DateTime.now();
            }
          } catch (e) {
            initialDate = DateTime.now(); // Fallback if parsing fails
          }

          DateTime endingDate = DateTime(2200);
          FocusScope.of(context).requestFocus(FocusNode());

          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900), // Allow selection from 1900 onwards
            lastDate: endingDate,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );

          if (date != null) {
            taskMaster_page_controller.DataOFVisitController.value.text =
                DateFormat('dd-MM-yyyy').format(date);
          } else {
            taskMaster_page_controller.DataOFVisitController.value.text = "";
          }
        },
      ),
    );
  }

  /*Widget bindDateOfVisit(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextField(
        cursorColor: AllColors.primaryDark1,
        controller: taskMaster_page_controller.DataOFVisitController.value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two,
            horizontal: AllFontSize.ten,
          ),
          suffixIcon: Icon(Icons.calendar_month),
          hintText: 'Date Of Visit',
          labelText: 'Date Of Visit',
          hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten,
          ),
          labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.sisxteen,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
          onTap: () async {
            DateTime? initialDate;
            String dateString = taskMaster_page_controller.DataOFVisitController.value.text;

            try {
              if (dateString.isNotEmpty) {
                initialDate = DateFormat('dd-MM-yyyy').parseStrict(dateString);
              } else {
                initialDate = DateTime.now();
              }
            } catch (e) {
              initialDate = DateTime.now(); // Fallback if parsing fails
            }

            DateTime endingDate = DateTime(2200);
            FocusScope.of(context).requestFocus(FocusNode());

            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime.now(),
              lastDate: endingDate,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: AllColors.primaryDark1,
                    colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );

            if (date != null) {
              taskMaster_page_controller.DataOFVisitController.value.text =
                  DateFormat('dd-MM-yyyy').format(date);
            } else {
              taskMaster_page_controller.DataOFVisitController.value.text = "";
            }
          }

      ),
    );
  }*/


  Widget bindVisitTimePicker(context){
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextField(
        controller: taskMaster_page_controller.VisitTime_controller.value,
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
          //contentPadding: EdgeInsets.symmetric(vertical:5,horizontal:5),
          hintText: "Time Of Visit",
          labelText: 'Time Of Visit',
          hintStyle: TextStyle(color: AllColors.blackColor),
          labelStyle: TextStyle(color: AllColors.blackColor),
          suffixIcon: Icon(
            Icons.watch_later_outlined,
            color: AllColors.primaryDark,
            size: 25,
          ),
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          // Add a clear icon if needed
          filled: true,
          fillColor: Colors.white,
          // Light gray background
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        cursorColor: AllColors.primaryDark,
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          TimeOfDay? newTime = await showTimePicker(context: context,
            initialTime: TimeOfDay(hour: 12, minute: 00),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark, // Change the primary color
                  //accentColor: AllColors.primaryDark1, // Change the accent color
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );

          if (newTime != null) {
            final now = DateTime.now();
            final selectedTime = DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
            final formattedTime = DateFormat.jm().format(selectedTime); // Format to 12-hour format
            taskMaster_page_controller.VisitTime_controller.value.text = formattedTime;
          }


        },
      ),
    );
  }

  Widget bindAlongWithPersonDropDown(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Autocomplete<AlongWithPersonModel>(
        displayStringForOption: _displayAlongPersonForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return taskMaster_page_controller.AlongPersonWith_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return taskMaster_page_controller.AlongPersonWith_list
              .where((AlongWithPersonModel option) {
            return option.firstName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (AlongWithPersonModel selection) {
          // Update the TextField with the selected
          taskMaster_page_controller.AlongPersonWith_controller.text =
              _displayAlongPersonForOption(selection).toString();

          if (!taskMaster_page_controller.SelectedAlongPersonWith_list.contains(selection)) {
            taskMaster_page_controller.SelectedAlongPersonWith_list.add(selection);
            Utils.showToastification('Success', 'Add Successfully');
          }else{
            Utils.showErrorToastification('Error', 'Already Selected');
          }

          // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: (){
             /* if(focusNode.hasFocus){
                focusNode.unfocus();
              }else{
                focusNode.requestFocus();
              }*/

              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = taskMaster_page_controller.AlongPersonWith_controller
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
              hintText: 'Along With Person Name',
              labelText: 'Along With Person Name',

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<AlongWithPersonModel> onSelected,
            Iterable<AlongWithPersonModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final AlongWithPersonModel option =
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
                                text:  (option.firstName?.toString() ?? "") +
                                    " " +
                                    (option.middleName?.toString() ?? "") +
                                    " " +
                                    (option.lastName?.toString() ?? ""),
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                ),
                              ),
                              TextSpan(
                                text: " (${option.empId!})",
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




  Widget  bindProductCategoryDropDown(context){
   return DropdownMenu<ItemCategoryMstModel>(
      width: MediaQuery.of(context).size.width-25,
      controller: taskMaster_page_controller.ItemCat_type_controller,
      label: Text(
        "Product Category",
       /* style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w300),*/
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AllColors.primaryDark1,
          ),
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
      menuHeight: 200,
      onSelected: (ItemCategoryMstModel? selection) {
        print(selection);
        taskMaster_page_controller.ItemCat_type_controller.text =
            _displayItemCatMasterForOption(selection!).toString();

        if (!taskMaster_page_controller.Item_Category_Selected_list.contains(selection)) {
          taskMaster_page_controller.Item_Category_Selected_list.add(selection);
          Utils.showToastification('Success', 'Add Successfully');
        }else{
          Utils.showErrorToastification('Error', 'Already Selected');
        }
      },

      dropdownMenuEntries: taskMaster_page_controller.Item_Category_master_list_without_task
          .map<DropdownMenuEntry<ItemCategoryMstModel>>((ItemCategoryMstModel e) {
        return DropdownMenuEntry<ItemCategoryMstModel>(
            value: e,
            label: e.categoryName??"",
            style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(AllColors.primaryDark1),
            ));
      }).toList(),
    );
  }


/*  Widget bindProductCategoryDropDown(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Autocomplete<ItemCategoryMstModel>(
        displayStringForOption: _displayItemCatMasterForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return taskMaster_page_controller.Item_Category_master_list_without_task;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return taskMaster_page_controller.Item_Category_master_list_without_task
              .where((ItemCategoryMstModel option) {
            return option.categoryName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (ItemCategoryMstModel selection) {
          // Update the TextField with the selected
          taskMaster_page_controller.ItemCat_type_controller.text =
              _displayItemCatMasterForOption(selection).toString();

          if (!taskMaster_page_controller.Item_Category_Selected_list.contains(selection)) {
            taskMaster_page_controller.Item_Category_Selected_list.add(selection);
            Utils.showToastification('Success', 'Add Successfully');
          }else{
            Utils.showErrorToastification('Error', 'Already Selected');
          }

          // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: (){
              if(focusNode.hasFocus){
                focusNode.unfocus();
              }else{
                focusNode.requestFocus();
              }
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = taskMaster_page_controller.ItemCat_type_controller
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
              hintText: 'Product Category',
              labelText: 'Product Category',

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
            Iterable<ItemCategoryMstModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.7,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final ItemCategoryMstModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.categoryName.toString(),
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
  }*/

}