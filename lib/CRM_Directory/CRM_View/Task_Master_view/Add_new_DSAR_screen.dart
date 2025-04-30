import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';

class AddNewDsarScreen extends StatelessWidget{
  AddNewDsarScreen({super.key});
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  Size size=Get.size;
  static String _displayDSARTypeForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  static String _displayTypeOfCallForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  static String _displayMethodOfCallForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          TaskMaster_page_controller.isInfraLeadValue.value=false;
          //Get.back();
      Get.toNamed(RoutesName.taskMasterDetails_screen);
      TaskMaster_page_controller.DSARStatus.value = false;
      TaskMaster_page_controller.typeOfCall.value = false;
      TaskMaster_page_controller.ItemCateDropDown.value = false;
      TaskMaster_page_controller.DSAR_Status_type_controller.value.clear();
      TaskMaster_page_controller.Type_of_call_controller.clear();
      TaskMaster_page_controller.ItemCat_type_controller.clear();
      TaskMaster_page_controller.NextInterdate_controller.clear();
      TaskMaster_page_controller.NextInterTime_controller.clear();
      TaskMaster_page_controller.DSAR_Remarks_controller.clear();
      TaskMaster_page_controller.EstClosuredate_controller.clear();
      TaskMaster_page_controller.BudgetAmt_controller.clear();
      TaskMaster_page_controller.ExpectedAmt_controller.clear();
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
                'Create DSAR Task',
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
                      side: BorderSide(color: AllColors.whiteColor)),
                  //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                  //CircleAvatar
                  label: Tooltip(
                    message: "Create DSAR ",
                    child: Text('Create',
                        style: GoogleFonts.poppins(
                          color: AllColors.whiteColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  onPressed: () {
                    print('infra lead...${TaskMaster_page_controller.Task_Master_list[0].isInfraLead}');
                    print('infra lead2...${TaskMaster_page_controller.isInfraLead.value.text}');
                    *//*if( TaskMaster_page_controller
                        .Task_Master_list[0].isInfraLead==0 && TaskMaster_page_controller.isInfraLead.value.text == 'Yes' ){
                      Utils.sanckBarError("Message", "Is Infra Lead is Yes Please Add Infra Details");
                    }
                    else{
                      TaskMaster_page_controller.TaskDSARMasterCreate();
                    }
*//*

                    if(TaskMaster_page_controller.isInfraLeadValueSubmit.value) {
                      //Utils.sanckBarError("Message", "Created");
                      TaskMaster_page_controller.TaskDSARMasterCreate();
                    }
                    else if(TaskMaster_page_controller.ItemCateDropDown.value && TaskMaster_page_controller.isInfraLeadValue.value){

                      Utils.sanckBarError("Message", "Is Infra Lead is Yes Please Add Infra Details");

                    }else{
                      //Utils.sanckBarError("Message", "Created2");
                      TaskMaster_page_controller.TaskDSARMasterCreate();
                    }
                    }, //Text
                ),
*/

             /* Obx((){
                return Visibility(
                  visible:TaskMaster_page_controller.isInfraLeadValue.value?false:true,
                  child: ActionChip(
                    elevation: 2,
                    padding: EdgeInsets.all(5),
                    backgroundColor: AllColors.primaryDark1,
                    shadowColor: Colors.black,
                    shape: StadiumBorder(
                        side: BorderSide(color: AllColors.grayColor)),
                    //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                    //CircleAvatar
                    label: Tooltip(
                      message: "Update Task",
                      child: Text('Next',
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    onPressed: () {
                      TaskMaster_page_controller.isInfraLeadUpdateController.text=TaskMaster_page_controller.isInfraLead.text;
                      Get.toNamed(RoutesName.updateTaskMstInfraScreen);

                    }, //Text
                  ),
                );
              }),*/


            ],
          )
      ),
      drawer: CustomDrawer(),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(left:30),
        child: DefaultButton(
          //text: "${TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1?"Update":"Add"} Infra Details",
          text: "Create DSAR",
          press: (){
            if(TaskMaster_page_controller.DSAR_Status_type_controller.value.text == ""){
              Utils.sanckBarError("Message", "Please select DSAR Status");
            }
            else if(TaskMaster_page_controller.isInfraLeadValueSubmit.value) {
              //Utils.sanckBarError("Message", "Created");
              TaskMaster_page_controller.TaskSaleCatCreateApiHit("DSAR");
              TaskMaster_page_controller.TaskDSARMasterCreate();

            }
            else if(TaskMaster_page_controller.ItemCateDropDown.value && TaskMaster_page_controller.isInfraLeadValue.value){

              Utils.sanckBarError("Message", "Is Infra Lead is Yes Please Add Infra Details");

            }else{
              //Utils.sanckBarError("Message", "Created2");
              TaskMaster_page_controller.TaskSaleCatCreateApiHit("DSAR");
              TaskMaster_page_controller.TaskDSARMasterCreate();

            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 70),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: bindDSARStatusDropDown(context),
              ),

              SizedBox(height: 20),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.DSARStatus.value,
                  child: Column(
                    children: [
                      bindIsInfraLead(context),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),
              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.typeOfCall.value,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindTypeOfCallDropDown(context),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.typeOfCall.value,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindMethodOfCallDropDown(context),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.ItemCateDropDown.value,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        height: 50,
                        //width: size.width*7,
                       /* child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                //color: AllColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              //height: size.height*10,
                              width: size.width*.7,
                              child:bindItemCategoryDropDown(context) ,
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
                                    TaskMaster_page_controller.TaskSaleCatCreateApiHit("DSAR");
                                    //AddCompSubProTypeDailog(context);
                                  }, icon: Icon(Icons.add)),
                            )
                          ],
                        ),*/
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindItemCategoryDropDown(context),
                      ),
                      SizedBox(height: 15,),
                      Wrap(
                        spacing: 8.0,
                        children: TaskMaster_page_controller.Item_Category_Selected_list.map((category) {
                          return Chip(
                            label: Text(category.categoryName!),
                            onDeleted: () {
                                TaskMaster_page_controller.Item_Category_Selected_list.remove(category);
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 15,),
                    ],

                  ),
                );
              }),



              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.DSARStatus.value,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindNextInterDatePicker(context),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.DSARStatus.value,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindNextInterTimePicker(context),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.ItemCateDropDown.value,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: bindEstClouserDatePicker(context),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.ItemCateDropDown.value,
                    child:  Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: TaskMaster_page_controller.BudgetAmt_controller,
                            decoration: InputDecoration(
                                hintText: "Budget Amount",
                                labelText: "Budget Amount",
                                //suffixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),


                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),

                          ),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),);
              }),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.ItemCateDropDown.value,
                  child:  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: TaskMaster_page_controller.ExpectedAmt_controller,
                          decoration: InputDecoration(
                              hintText: "Expected Amount",
                              labelText: "Expected Amount",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),


                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),);
              }),

              Obx(() {
                return
                  Visibility(
                    visible: TaskMaster_page_controller.PurposeOfVisit.value,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextFormField(
                            maxLength: 500,
                            maxLines: 2,
                            controller: TaskMaster_page_controller.PusposeOfVisit_controller,
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
                        SizedBox(height: 15,),
                      ],
                    ),
                  );
              }),





              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  maxLength: 500,
                  maxLines: 2,
                  controller: TaskMaster_page_controller.DSAR_Remarks_controller,
                  decoration: InputDecoration(
                      hintText: "Call Description",
                      labelText: "Call Description",
                      //suffixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),


                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),

                ),
              ),


              SizedBox(height: 15,),
             Obx((){
               return  Visibility(
                   visible: TaskMaster_page_controller.ItemCateDropDown.value && TaskMaster_page_controller.isInfraLeadValue.value ? true:false,
                // visible: TaskMaster_page_controller.DSAR_Status_type_controller.value.text == 'Sales Cycle' && TaskMaster_page_controller.isInfraLead.value.text  == "Yes",
                 child: Padding(
                   padding: const EdgeInsets.only(left:10, right: 10, top: 10),
                   child: DefaultButton(
                     //text: "${TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1?"Update":"Add"} Infra Details",
                     text: "Update Infra Details",
                     press: (){
                       print("Length${TaskMaster_page_controller.userGeoHierarchyy.length}");
                       for(int i=0; i<TaskMaster_page_controller.userGeoHierarchyy.length;i++){
                         if(TaskMaster_page_controller.userGeoHierarchyy[i].myLevel==1){
                           TaskMaster_page_controller.userRegionUpdateController.text=TaskMaster_page_controller.userGeoHierarchyy[i-1].geoValue!;
                           TaskMaster_page_controller.userClusterUpdateController.text=TaskMaster_page_controller.userGeoHierarchyy[i-2].geoValue!;
                         }
                       }
                       if(TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1){
                         TaskMaster_page_controller.viewAllDetailsOfTaskUpdateInfra();
                       }
                       TaskMaster_page_controller.isInfraLeadUpdateController.text=TaskMaster_page_controller.isInfraLead.value.text;
                       Get.toNamed(RoutesName.updateTaskMstInfraScreen);
                     },
                   ),
                 ),
               );
             }),

              SizedBox(height: 15,),






            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget bindDSARStatusDropDown(context){
    return Autocomplete<CallStatusMasterModel>(
      displayStringForOption: _displayDSARTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.DSARStatus_Master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.DSARStatus_Master_list
            .where((CallStatusMasterModel option) {
          return option.taskStatus
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CallStatusMasterModel selection) {
        // Update the TextField with the selected
        TaskMaster_page_controller.DSAR_Status_type_controller.value.text =
            _displayDSARTypeForOption(selection).toString();
        TaskMaster_page_controller.Method_of_call_controller.clear();
        TaskMaster_page_controller.PurposeOfVisit.value = false;
        TaskMaster_page_controller.CallStatusMasterApiHit('CALL DSAR');
        if(TaskMaster_page_controller.DSAR_Status_type_controller.value.text == "Revisit"){
          TaskMaster_page_controller.CallStatusMasterApiHit('CALL DSAR REVISIT');
        }else{
          TaskMaster_page_controller.CallStatusMasterApiHit('CALL DSAR OTHER');
        }

        if(TaskMaster_page_controller.DSAR_Status_type_controller.value.text == "Reschedule" && TaskMaster_page_controller.Task_Master_list[0].typeOfCall == "New Call"){
          TaskMaster_page_controller.Type_of_call_controller.text= "New Call";
          TaskMaster_page_controller.typeOfCall.value = false;
          TaskMaster_page_controller.typeOfCall.value = true;
        }else{
          TaskMaster_page_controller.Type_of_call_controller.clear();
          TaskMaster_page_controller.typeOfCall.value = false;
          TaskMaster_page_controller.typeOfCall.value = true;
        }

        if(selection.isNextInteraction == 1 && selection.isTypeOfCall == 1){
          TaskMaster_page_controller.typeOfCall.value = true;
          TaskMaster_page_controller.DSARStatus.value = true;
          TaskMaster_page_controller.ItemCateDropDown.value = false;
        }else if(selection.isNextInteraction == 1 && selection.isTypeOfCall == 0 ){
          TaskMaster_page_controller.DSARStatus.value = true;
          TaskMaster_page_controller.typeOfCall.value = false;
          TaskMaster_page_controller.ItemCateDropDown.value = true;
          TaskMaster_page_controller.Item_Category_Selected_list.value = [];
          for(int i = 0; i < TaskMaster_page_controller.Item_Category_master_list.length; i++ ){
            if(TaskMaster_page_controller.Item_Category_master_list[i].isSelected == 1){
              TaskMaster_page_controller.Item_Category_Selected_list.add(TaskMaster_page_controller.Item_Category_master_list[i]);
              print('LIstSIze.....${TaskMaster_page_controller.Item_Category_Selected_list.length}');
            }
            else{
              print('NoLIstSIze.....${TaskMaster_page_controller.Item_Category_Selected_list.length}');
            }
          }
        }else if(selection.isNextInteraction ==0 && selection.isTypeOfCall ==0){
          TaskMaster_page_controller.DSARStatus.value = false;
          TaskMaster_page_controller.typeOfCall.value = false;
          TaskMaster_page_controller.ItemCateDropDown.value = false;
          TaskMaster_page_controller.isInfraLeadValue.value=false;
        }

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = TaskMaster_page_controller.DSAR_Status_type_controller.value
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
            hintText: 'DSAR Status',
            labelText: 'DSAR Status',

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

  Widget bindTypeOfCallDropDown(context){
    return Autocomplete<CallStatusMasterModel>(
      displayStringForOption: _displayTypeOfCallForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.CallStatus_Master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.CallStatus_Master_list
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
        TaskMaster_page_controller.Type_of_call_controller.text =
            _displayTypeOfCallForOption(selection).toString();
        //taskMaster_page_controller.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = TaskMaster_page_controller.Type_of_call_controller
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
            hintText: 'Type Of Call',
            labelText: 'Type Of Call',

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
          return TaskMaster_page_controller.MethodOfCall_Master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.MethodOfCall_Master_list
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
        TaskMaster_page_controller.Method_of_call_controller.text =
            _displayMethodOfCallForOption(selection).toString();


        if( TaskMaster_page_controller.Method_of_call_controller.text == 'Physical Meeting'){
          // print(taskMaster_page_controller.Method_of_call_controller.text);
          TaskMaster_page_controller.PurposeOfVisit.value = true;
        }else{
          TaskMaster_page_controller.PurposeOfVisit.value = false;
          // print('else part...${taskMaster_page_controller.Method_of_call_controller.text}');
        }
        //taskMaster_page_controller.AccountOwner = selection.loginEmailId!;
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
            ..text = TaskMaster_page_controller.Method_of_call_controller
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

  Widget bindItemCategoryDropDown(context){
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemCatMasterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.Item_Category_master_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.Item_Category_master_list
            .where((ItemCategoryMstModel option) {
          return option.categoryName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstModel selection) {
        // Update the TextField with the selected
        TaskMaster_page_controller.ItemCat_type_controller.text =
            _displayItemCatMasterForOption(selection).toString();

        if (!TaskMaster_page_controller.Item_Category_Selected_list.contains(selection)) {
          TaskMaster_page_controller.Item_Category_Selected_list.add(selection);
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
            controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = TaskMaster_page_controller.ItemCat_type_controller
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: (){
                  focusNode.requestFocus();
                  controller.clear();
                },
                child: Icon(Icons.arrow_drop_down)),
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
    );
  }

  Widget bindNextInterDatePicker(context) {
    return Container(
      //padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: TextField(
        controller: TaskMaster_page_controller.NextInterdate_controller,
        readOnly: true,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(vertical:5,horizontal:5),
          hintText: "Next Interaction Date",
          labelText: 'Next Interaction Date',
          hintStyle: TextStyle(color: AllColors.blackColor),
          labelStyle: TextStyle(color: AllColors.blackColor),
          suffixIcon: Icon(
            Icons.calendar_month,
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
          DateTime? initialDate;
          String dateString = TaskMaster_page_controller.NextInterdate_controller.value.text;

          try {
            if (dateString.isNotEmpty) {
              initialDate = DateFormat('dd-MM-yyyy').parseStrict(dateString);
            } else {
              initialDate = DateTime.now();
            }
          } catch (e) {
            initialDate = DateTime.now(); // Fallback if parsing fails
          }

          DateTime stating_date = DateTime.now();
          DateTime ending_date = new DateTime(3000);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: stating_date,
            lastDate: ending_date,

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
          var outputFormat = DateFormat('dd-MM-yyyy');
          TaskMaster_page_controller.NextInterdate_controller.text =
              outputFormat.format(date!);

        },
      ),
    );
  }



  Widget bindNextInterTimePicker(context){
    return Container(
      child: TextField(
        controller: TaskMaster_page_controller.NextInterTime_controller,
        readOnly: true,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(vertical:5,horizontal:5),
          hintText: "Next Interaction Time",
          labelText: 'Next Interaction Time',
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
            TaskMaster_page_controller.NextInterTime_controller.text = formattedTime;
          }


        },
      ),
    );
  }

  Widget bindEstClouserDatePicker(context) {
    return Container(
      //padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: TextField(
        controller: TaskMaster_page_controller.EstClosuredate_controller,
        readOnly: true,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(vertical:5,horizontal:5),
          hintText: "Estimated Closure Date",
          labelText: 'Estimated Closure Date',
          hintStyle: TextStyle(color: AllColors.blackColor),
          labelStyle: TextStyle(color: AllColors.blackColor),
          suffixIcon: Icon(
            Icons.calendar_month,
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
          DateTime? initialDate;
          String dateString = TaskMaster_page_controller.EstClosuredate_controller.value.text;

          try {
            if (dateString.isNotEmpty) {
              initialDate = DateFormat('dd-MM-yyyy').parseStrict(dateString);
            } else {
              initialDate = DateTime.now();
            }
          } catch (e) {
            initialDate = DateTime.now(); // Fallback if parsing fails
          }
          DateTime stating_date = DateTime.now();
          DateTime ending_date = new DateTime(3000);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: stating_date,
            lastDate: ending_date,

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
          var outputFormat = DateFormat('dd-MM-yyyy');
          TaskMaster_page_controller.EstClosuredate_controller.text =
              outputFormat.format(date!);

        },
      ),
    );
  }

  Widget bindIsInfraLead(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        enabled: TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1?false:true,
        width: size.width-30,
        controller: TaskMaster_page_controller.isInfraLead.value,
        label: Text(
          "Is Infra Lead",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
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
        onSelected: (String? selection) {
          print(selection);
          TaskMaster_page_controller.isInfraLead.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
          if(TaskMaster_page_controller.isInfraLead.value.text=="Yes"){
            TaskMaster_page_controller.isInfraLeadValue.value=true;
          }else{
            TaskMaster_page_controller.isInfraLeadValue.value=false;
          }
          print("Is Lead ${TaskMaster_page_controller.isInfraLead.value.text}");

        },
        dropdownMenuEntries:
        TaskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }


}