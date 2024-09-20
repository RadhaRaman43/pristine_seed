import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';

class AddNewTaskScreen extends StatelessWidget{
  AddNewTaskScreen({super.key});

  final taskMaster_page_controller=Get.put(Taskmastervm());
  Size size=Get.size;


  static String _displayAccountNameForOption(AccountMasterModel option) =>
      option.accountName!+"(${option.accountCode!})";

  static String _displayContactNameForOption(ContactMstGetListModal option) =>
      option.contactName!;

  static String _displayTypeOfCallForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  static String _displayMethodOfCallForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      //Get.offAllNamed(RoutesName.taskMaster_screen);
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
              Spacer(),
              /*IconButton(onPressed: () {
                //showFilterBottomSheet(context);
              }, icon: Icon(Icons.add)),*/
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
              ),
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: Container(
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
                child: bindAccountNameDropDown(context),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: bindContactNameDropDown(context),
              ),

              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: bindTypeOfCallDropDown(context),
              ),

              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: bindMethodOfCallDropDown(context)

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

                )



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
          return taskMaster_page_controller.Account_Master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return taskMaster_page_controller.Account_Master_list
            .where((AccountMasterModel option) {
          return option.accountName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (AccountMasterModel selection) {
        //print(selection.loginEmailId);
        // Update the TextField with the selected
        taskMaster_page_controller.account_Name_controller.text =
            _displayAccountNameForOption(selection).toString();
        taskMaster_page_controller.account_code.value=selection.accountCode!;
        taskMaster_page_controller.account_name.value=selection.accountName!;
            taskMaster_page_controller.getContactMasterList();
        //taskMaster_page_controller.AccountOwner = selection.loginEmailId!;
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
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            hintText: 'Account Name',
            labelText: 'Account Name',
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
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Contact_Name_controller
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            hintText: 'Contact Name',
            labelText: 'Contact Name',
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
        //print(selection.loginEmailId);
        // Update the TextField with the selected
        taskMaster_page_controller.Type_of_call_controller.text =
            _displayTypeOfCallForOption(selection).toString();
        //taskMaster_page_controller.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Type_of_call_controller
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            hintText: 'Type Of Call',
            labelText: 'Type Of Call',
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
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = taskMaster_page_controller.Method_of_call_controller
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            hintText: 'Method Of Call',
            labelText: 'Method of Call',
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

}