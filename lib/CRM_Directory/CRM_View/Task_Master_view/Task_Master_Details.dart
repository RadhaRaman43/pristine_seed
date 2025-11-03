import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_Master_model.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class TaskMasterDetails extends StatelessWidget{

  TaskMasterDetails({super.key});
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  SalesCycleVm salesCycleController=Get.put(SalesCycleVm());
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  Size size=Get.size;
  static String _displayDSARTypeForOption(CallStatusMasterModel option) =>
      option.taskStatus!;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  static String _displayApproveRejectForOption(String option) =>
      option;

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
          print('fromPageName.....${account_vm_controller.view}');
          if(account_vm_controller.view=='Sales'){
            Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
            //account_vm_controller.view='';
           // Get.back();
          }else if (account_vm_controller.view=="TaskDashboard") {
            account_vm_controller.view = '';
            Get.toNamed(RoutesName.AccountDashboardData_Screen);
          }else if (TaskMaster_page_controller.FromPage=="from_pendingDSARDashboard"){
            TaskMaster_page_controller.FromPage.value='';
            Get.toNamed(RoutesName.pendingDSARDashboardViewScreen);
         }
          else if (TaskMaster_page_controller.FromPage=="from_CallDashboard"){
          TaskMaster_page_controller.FromPage.value='';
          Get.toNamed(RoutesName.callDashboardViewScreen);
         }
          else {
            TaskMaster_page_controller.resetAllFieldOfFilter();
            TaskMaster_page_controller.pageNumber = 0;
            TaskMaster_page_controller
                .date_filter.value = "Today";
            TaskMaster_page_controller
                .is_done.value = 0;
            TaskMaster_page_controller
                .filter.value = "Running";
            TaskMaster_page_controller.is_Active=-1;
            TaskMaster_page_controller
                .getTaskMaster(
                TaskMaster_page_controller.pageNumber,
                TaskMaster_page_controller.is_Active
                    .toString(),
                '',
                '',
                TaskMaster_page_controller.Task_status_controller.value.text,
                TaskMaster_page_controller.date_filter,
                TaskMaster_page_controller.is_done.value);

            //Get.offAllNamed(RoutesName.taskMaster_screen);

           /* TaskMaster_page_controller.pageNumber=0;
            TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber,
            TaskMaster_page_controller.is_Active.toString(), '', '', '',
            TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);*/
            Get.toNamed(RoutesName.taskMaster_screen);
          }
         // Get.back();

      return false;
    }, child: Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Task Information',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
             // Spacer(),
              TaskMaster_page_controller.Task_Master_list.isEmpty?SizedBox():
              Row(
                children: [
                  Obx((){
                    print("DSAR..R${TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar??""}");
                    return  Visibility(
                      visible: TaskMaster_page_controller.TaskDSAR_Master_list.isEmpty?true:false,
                      //visible: account_vm_controller.view=='Sales'?false:true,
                      child: IconButton(onPressed: () {
                        //createDSARDialog(context);
                        TaskMaster_page_controller.DSAR_Status_type_controller.value.clear();
                       // TaskMaster_page_controller.isInfraLead.value.text=TaskMaster_page_controller.Task_Master_list[0].isInfraLead == 1 ?"Yes":"No";
                        TaskMaster_page_controller.NextInterdate_controller.clear();
                        TaskMaster_page_controller.NextInterTime_controller.clear();
                        TaskMaster_page_controller.DSAR_Remarks_controller.clear();
                        TaskMaster_page_controller.EstClosuredate_controller.clear();
                        TaskMaster_page_controller.BudgetAmt_controller.clear();
                        TaskMaster_page_controller.ExpectedAmt_controller.clear();
                        TaskMaster_page_controller.Method_of_call_controller.clear();
                        TaskMaster_page_controller.getContactMasterList(TaskMaster_page_controller.Task_Master_list[0].accountCode??"",TaskMaster_page_controller.Task_Master_list[0].accountName??"");
                        TaskMaster_page_controller.PurposeOfVisit.value = false;
                        TaskMaster_page_controller.DSARStatus.value = false;
                        if(TaskMaster_page_controller.Task_Master_list[0].isInfraLead == 1){
                          TaskMaster_page_controller.isInfraLeadValue.value = true;
                        }
                        TaskMaster_page_controller.isInfraLeadValueSubmit.value = false;
                        TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar == 1 ? Get.toNamed(RoutesName.addNewDSARTask_screen): "";
                      }, icon: Visibility(
                          visible: TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar == 1 && TaskMaster_page_controller.isAdminWritePermission == "0",
                          child: Icon(Icons.add))),
                    );
                  }),
                  Obx((){
                    return  Visibility(
                      visible: TaskMaster_page_controller
                          .Task_Master_list[0]
                          .isReadyForApprove.toString()=='1'?true:false,
                      child: IconButton(onPressed: () {
                         showApprovRejectDialog(context, TaskMaster_page_controller.Task_Master_list[0].taskId!);
                      }, icon: Icon(Icons.update)),
                    );
                  }),

                  Obx((){
                    return Visibility(
                      visible: TaskMaster_page_controller
                          .Task_Master_list[0]
                          .taskStatus?.toLowerCase() == 'rejected' && TaskMaster_page_controller.isAdminWritePermission=="1"?true:false,
                      child: IconButton(
                        icon: Icon(Icons.lock_open_rounded),
                        onPressed: (){
                          showTaskReopenDialog(context, TaskMaster_page_controller.Task_Master_list[0].taskId!);
                        },
                      )

                      /*ActionChip(
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
                            Icon(Icons.lock_open_rounded),
                            //SizedBox(width: 5,),
                            *//*Tooltip(
                              message: "Reopen task ",
                              child: Text('Reopen',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.ten,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),*//*
                          ],
                        ),
                        onPressed: () async {
                          showTaskReopenDialog(context, TaskMaster_page_controller.Task_Master_list[0].taskId!);
                        }, //Text
                      ),*/
                    );
                  })


                ],
              )



            ],
          )
      ),
      drawer: CustomDrawer(),
      body: Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Card(
              color: AllColors.whiteColor,
              elevation: 10,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      /*border: Border.all(
                        color: AllColors.blackColor, // Set the border color here
                      ),*/
                      borderRadius: BorderRadius.circular(10.0),
                      color: AllColors.textColor,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.border_color_outlined, color: AllColors.whiteColor,),
                        ),
                        Text(
                          "Task/Sale Info",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                              () {
                            return IconButton(
                              onPressed: () {
                                TaskMaster_page_controller.toggle();
                                if (TaskMaster_page_controller
                                    .isExpandDetails.value ==
                                    true) {
                                  print(
                                      "If......${TaskMaster_page_controller.isExpandDetails.value}");
                                } else {
                                  print(
                                      "else......${TaskMaster_page_controller.isExpandDetails.value}");
                                }
                              },
                              icon: Icon(
                                TaskMaster_page_controller
                                    .isExpandDetails.value
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 25,
                                color: AllColors.whiteColor,
                              ),
                            );
                          },
                        )
        
                      ],
                    ),
                  ),
                 // Divider(color: Colors.black,),
                  Obx(() {
                    if(TaskMaster_page_controller.Task_Master_list.length>0 &&
                        TaskMaster_page_controller.Task_Master_list.isNotEmpty){
                      return viewTasketails(context);
                    }else{
                      return SizedBox();
                    }

                  }),
                ],
              ),
            ),
        
        
            SizedBox(height: 5,),
        
            Card(
              color: AllColors.whiteColor,
              elevation: 10,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      /*border: Border.all(
                        color: AllColors.blackColor, // Set the border color here
                      ),*/
                      borderRadius: BorderRadius.circular(10.0),
                        color: AllColors.textColor
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.person, color: AllColors.whiteColor,),
                        ),
                        Text(
                          "Created Manager Info",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                              () {
                            return IconButton(
                              onPressed: () {
                                TaskMaster_page_controller.toggleCrtd();
                                if (TaskMaster_page_controller
                                    .isExpandCrtd.value ==
                                    true) {
                                  print(
                                      "If......${TaskMaster_page_controller.isExpandCrtd.value}");
                                } else {
                                  print(
                                      "else......${TaskMaster_page_controller.isExpandCrtd.value}");
                                }
                              },
                              icon: Icon(
                                TaskMaster_page_controller
                                    .isExpandCrtd.value
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 25,
                                color: AllColors.whiteColor,
                              ),
                            );
                          },
                        )
        
                      ],
                    ),
                  ),
                  Obx(() {
                    if(TaskMaster_page_controller.Task_Master_list.length>0 &&
                        TaskMaster_page_controller.Task_Master_list.isNotEmpty){
                      return viewCreatorManagerDetail(context);
                    }else{
                      return SizedBox();
                    }
                   // return viewCreatorManagerDetail(context);
                  }),
                ],
              ),
            ),
        
            SizedBox(height: 5,),

            Card(
              color: AllColors.whiteColor,
              elevation: 10,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      /*border: Border.all(
                        color: AllColors.blackColor, // Set the border color here
                      ),*/
                        borderRadius: BorderRadius.circular(10.0),
                        color: AllColors.textColor
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.person, color: AllColors.whiteColor,),
                        ),
                        Text(
                          "Geo Info",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                              () {
                            return IconButton(
                              onPressed: () {
                                TaskMaster_page_controller.toggleGeoInfoCrtd();
                                if (TaskMaster_page_controller
                                    .isExpandGeoInfo.value ==
                                    true) {
                                  print(
                                      "If......${TaskMaster_page_controller.isExpandGeoInfo.value}");
                                } else {
                                  print(
                                      "else......${TaskMaster_page_controller.isExpandGeoInfo.value}");
                                }
                              },
                              icon: Icon(
                                TaskMaster_page_controller
                                    .isExpandGeoInfo.value
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 25,
                                color: AllColors.whiteColor,
                              ),
                            );
                          },
                        )

                      ],
                    ),
                  ),
                  Obx(() {
                    if(TaskMaster_page_controller.Task_Master_list.length>0 &&
                        TaskMaster_page_controller.Task_Master_list.isNotEmpty){
                      return viewGeoInfoDetail(context);
                    }else{
                      return SizedBox();
                    }
                   // return viewGeoInfoDetail(context);
                  }),
                ],
              ),
            ),

            SizedBox(height: 5,),
        
           /* Card(
              color: AllColors.whiteColor,
              elevation: 10,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                        color: AllColors.textColor
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.library_books_sharp, color: AllColors.whiteColor),
                        ),
                        Text(
                          "Infra Details",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                              () {
                            return IconButton(
                              onPressed: () {
                                TaskMaster_page_controller.toggleInfraDetails();
                                if (TaskMaster_page_controller
                                    .isExpandInfraDeatils.value ==
                                    true) {
                                  print(
                                      "If......${TaskMaster_page_controller.isExpandInfraDeatils.value}");
                                } else {
                                  print(
                                      "else......${TaskMaster_page_controller.isExpandInfraDeatils.value}");
                                }
                              },
                              icon: Icon(
                                TaskMaster_page_controller
                                    .isExpandInfraDeatils.value
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 25,
                                color: AllColors.whiteColor,
                              ),
                            );
                          },
                        )
        
                      ],
                    ),
                  ),
                  Obx(() {
                    return viewInfraDetails(context);
                  }),
                ],
              ),
            ),

            SizedBox(height: 5,),*/

            Card(
              color: AllColors.whiteColor,
              elevation: 10,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      /*border: Border.all(
                        color: AllColors.blackColor, // Set the border color here
                      ),*/
                        borderRadius: BorderRadius.circular(10.0),
                        color: AllColors.textColor
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.library_books_sharp, color: AllColors.whiteColor),
                        ),
                        Text(
                          "DSAR Details",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                              () {
                            return IconButton(
                              onPressed: () {
                                TaskMaster_page_controller.toggleDsar();
                                if (TaskMaster_page_controller
                                    .isExpandDSAR.value ==
                                    true) {
                                  print(
                                      "If......${TaskMaster_page_controller.isExpandDSAR.value}");
                                } else {
                                  print(
                                      "else......${TaskMaster_page_controller.isExpandDSAR.value}");
                                }
                              },
                              icon: Icon(
                                TaskMaster_page_controller
                                    .isExpandDSAR.value
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 25,
                                color: AllColors.whiteColor,
                              ),
                            );
                          },
                        )

                      ],
                    ),
                  ),
                  Obx(() {
                    if(TaskMaster_page_controller.Task_Master_list.length>0){
                      return viewDsarDetails(context);
                    }else{
                      return SizedBox();
                    }

                  }),
                ],
              ),
            ),

          ],
        ),
      ),
              ),
    ),
    );
  }

  showProductCatDialog(context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Product Category',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              //height: size.height*.3,
              width: size.width*4,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Wrap(
                children: [
                  bindItemCategoryDropDown(context),
                  SizedBox(height: 65,),
                  Obx((){
                    return Visibility(
                      visible: TaskMaster_page_controller.Item_Category_Selected_list.length > 0 ? true : false,
                      child: Wrap(
                        spacing: 8.0,
                        children: TaskMaster_page_controller.Item_Category_Selected_list.map((category) {
                          return Chip(
                            label: Text(category.categoryName??""),
                            onDeleted: () {
                              TaskMaster_page_controller.Item_Category_Selected_list.remove(category);
                            },
                          );
                        }).toList(),
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
                          TaskMaster_page_controller.TaskSaleCatCreateApiHit('Details');
                          Navigator.pop(context);

                        },
                        child: Container(
                          width: 100,
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

                    ],)

                ],
              ),
            ),
          );
        });
  }

  showAlongPersonDialog(context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Along with person name',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              //height: size.height*.3,
              width: size.width*4,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Wrap(
                children: [
                  bindAlongWithPersonDropDown(context),
                  SizedBox(height: 65,),
                  Obx((){
                    return Visibility(
                      visible: TaskMaster_page_controller.SelectedAlongPersonWith_list.length > 0 ? true : false,
                      child: Wrap(
                        spacing: 8.0,
                        children: TaskMaster_page_controller.SelectedAlongPersonWith_list.map((category) {
                          return Chip(
                            label: Text(category.name??""),
                            onDeleted: () {
                              TaskMaster_page_controller.SelectedAlongPersonWith_list.remove(category);
                            },
                          );
                        }).toList(),
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
                          TaskMaster_page_controller.TaskPersonMstCreateAPI('Details');
                          Navigator.pop(context);

                        },
                        child: Container(
                          width: 100,
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

                    ],)

                ],
              ),
            ),
          );
        });
  }

  Widget bindAlongWithPersonDropDown(context){
    return Autocomplete<AlongWithPersonModel>(
      displayStringForOption: _displayAlongPersonForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.AlongPersonWith_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.AlongPersonWith_list
            .where((AlongWithPersonModel option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (AlongWithPersonModel selection) {
        // Update the TextField with the selected
        TaskMaster_page_controller.AlongPersonWith_controller.text =
            _displayAlongPersonForOption(selection).toString();

        if (!TaskMaster_page_controller.SelectedAlongPersonWith_list.contains(selection)) {
          TaskMaster_page_controller.SelectedAlongPersonWith_list.add(selection);
         // Utils.showToastification('Success', 'Add Successfully');
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
            ..text = TaskMaster_page_controller.AlongPersonWith_controller
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
              width: size.width *.7,
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
                              text:  (option.name?.toString() ?? ""),
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
    );
  }

  Widget bindItemCategoryDropDown(context){
    return
      Autocomplete<ItemCategoryMstModel>(
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

        print('Controller.....${TaskMaster_page_controller.ItemCat_type_controller.text}');
        if (!TaskMaster_page_controller.Item_Category_Selected_list.contains(selection)) {
          //TaskMaster_page_controller.Item_Category_code_list.add(selection.categoryCode!);
          TaskMaster_page_controller.Item_Category_Selected_list.add(selection);
         // Utils.showToastification('Success', 'Add Successfully ${selection.categoryCode}');
          print('CateCode....${TaskMaster_page_controller.Item_Category_code_list.length}');
        }else{
          Utils.showErrorToastification('Error', 'Already Selected');
        }
        TaskMaster_page_controller.ItemCat_type_controller.clear();
        // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
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
       // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
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
            suffixIcon: InkWell(
              /*onTap: (){
                  focusNode.requestFocus();
                  accountMaster_page_controller.getEmployeeMemberApi();
                },*/
                child: Icon(Icons.arrow_drop_down)),
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
            elevation: 4.0,
            child: Container(
              width: size.width*.7,
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

  Widget viewTasketails(BuildContext context) {
    String taskStatus = TaskMaster_page_controller.Task_Master_list[0]
        .taskStatus?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'approved':
          return Colors.green;
        case 'rejected':
          return Colors.red;
        case 'pending for approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    String? dateTimeCreatedOn=StaticMethod.onlyDate(TaskMaster_page_controller.Task_Master_list[0].dateOfVisit ?? "");
    return   Visibility(
      visible: TaskMaster_page_controller.isExpandDetails.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Previous Task ID",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    print('task....${TaskMaster_page_controller
                        .Task_Master_list[0].taskId}');
                    TaskMaster_page_controller.getTaskMaster(0,
                        TaskMaster_page_controller.is_Active
                            .toString(),
                        TaskMaster_page_controller
                            .Task_Master_list[0].previousTaskId,
                        'View', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
                  },
                  child: Text(
                    TaskMaster_page_controller
                        .Task_Master_list[0]
                        .previousTaskId ?? "",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Task ID",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .taskId ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Type of Call",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .typeOfCall ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Mode of Call",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .methodOfCall ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Account Name",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                InkWell(
                  child: Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[0]
                          .accountName ?? "",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[0]
                            .accountName ??
                            "" + " | ${TaskMaster_page_controller
                                .Task_Master_list[0]
                                .accountName ?? ""}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.wavy,),
                      ),
                    ),
                  ),
                  onTap: (){
                    if(account_vm_controller.view=="Sales"){
                      account_vm_controller.view="Sales";
                    }else{
                      account_vm_controller.view='Task';
                    }
                    contact_vm_controller.view='VIEW';
                    account_vm_controller.getAccMasterBuyCodeApi(TaskMaster_page_controller.Task_Master_list[0].accountCode);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Contact Name',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .contactName ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),

            Row(
              children: [
                Text(
                  "Task Status",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .taskStatus ?? "",
                  style: GoogleFonts.poppins(
                    color: getStatusColor(taskStatus),
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Date of Visit",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: dateTimeCreatedOn,
                    child: Text(
                      dateTimeCreatedOn??"",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Time of Visit",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[0]
                        .timeOfVisit.toString() ,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .timeOfVisit.toString() ,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Sale Cycle Active",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.IsSaleCycleActive,
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Sale Cycle Activated By",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[0]
                        .salesCycleActivatedBy == null
                        ? ''
                        : TaskMaster_page_controller
                        .Task_Master_list[0]
                        .salesCycleActivatedBy,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .salesCycleActivatedBy == null
                          ? ''
                          : TaskMaster_page_controller
                          .Task_Master_list[0]
                          .salesCycleActivatedBy ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),

            Row(
              children: [
                Text(
                  "Sale Cycle Activated on",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Tooltip(
                  message: TaskMaster_page_controller
                      .Task_Master_list[0]
                      .salesCycleActivatedOn == null
                      ? ''
                      : StaticMethod.onlyDate(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .salesCycleActivatedOn!) ?? "",
                  child: Text(
                    TaskMaster_page_controller
                        .Task_Master_list[0]
                        .salesCycleActivatedOn == null
                        ? ''
                        : StaticMethod.onlyDate(
                        TaskMaster_page_controller
                            .Task_Master_list[0]
                            .salesCycleActivatedOn!) ?? "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Sale Cycle ID",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                  child: Text(
                    TaskMaster_page_controller
                        .Task_Master_list[0]
                        .salesCycleId ?? "",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                  onTap: (){
                    salesCycleController.pageNumber = 0;
                    salesCycleController.clearSaleProductListController();
                    salesCycleController.filterQuoteAcceptedFlag.value="";
                    salesCycleController.pageNumber=0;
                    salesCycleController.clearAllFieldOfFilter();
                    salesCycleController.getsalesCycleData( salesCycleController.pageNumber, TaskMaster_page_controller.Task_Master_list[0].salesCycleId!, "ViewHeader", 'Task');
                    salesCycleController.getSaleCycleProductByIdList(salesCycleController.pageNumber, TaskMaster_page_controller
                        .Task_Master_list[0].salesCycleId??"" );

                  /*  salesCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(
                        salesCycleController.pageNumber ,
                        TaskMaster_page_controller
                            .Task_Master_list[0].salesCycleId??"");*/

                    salesCycleController.itemCategorySelectedlist.value = [];
                    salesCycleController.getPurchaseProcessApi();
                    salesCycleController.getPurchaseTimeFrameApi();
                    salesCycleController.getItemCategoryMstApi(TaskMaster_page_controller.Task_Master_list[0].salesCycleId! ,TaskMaster_page_controller.Task_Master_list[0].taskId! );
                    salesCycleController.ProductCategoryWiseAmtGet(0, TaskMaster_page_controller.Task_Master_list[0].salesCycleId!);

                  },
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),

            Row(
              children: [
                Text(
                  "Product Category ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Container(
                      width: size.width * .3,
                      child: Obx(() {
                        return Tooltip(
                          message: TaskMaster_page_controller
                              .Task_Master_list[0]
                              .productCategory == null || TaskMaster_page_controller
                              .Task_Master_list[0]
                              .productCategory == ''
                              ? ''
                              : TaskMaster_page_controller
                              .Task_Master_list[0]
                              .productCategory ?? '',
                          child: Text(
                            TaskMaster_page_controller
                                .Task_Master_list[0]
                                .productCategory == null || TaskMaster_page_controller
                                .Task_Master_list[0]
                                .productCategory == ''
                                ? ''
                                : TaskMaster_page_controller
                                .Task_Master_list[0]
                                .productCategory ?? "",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }),
                    ),
                    SizedBox(width: 2,),
                    Visibility(
                      visible:
                      TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar==1 &&
                          account_vm_controller.view!='TaskDashboard' &&
                      TaskMaster_page_controller.TaskDSAR_Master_list.length==0 ?true:false,
                     /* TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar==1||
                      account_vm_controller.view=='Sales'
                          || account_vm_controller.view=='TaskDashboard'
                          || TaskMaster_page_controller.email==TaskMaster_page_controller.Task_Master_list[0].approvedBy ?false:true,*/
                      child: InkWell(
                          onTap: () {
                            print('sales and dashboard view:${ account_vm_controller.view} ${TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar}');
                            TaskMaster_page_controller
                                .Item_Category_Selected_list
                                .value = [];
                            for (int i = 0; i <
                                TaskMaster_page_controller
                                    .Item_Category_master_list
                                    .length; i++) {
                              if (TaskMaster_page_controller
                                  .Item_Category_master_list[i]
                                  .isSelected == 1) {
                                TaskMaster_page_controller
                                    .Item_Category_Selected_list
                                    .add(
                                    TaskMaster_page_controller
                                        .Item_Category_master_list[i]);
                                //TaskMaster_page_controller.Item_Category_code_list.add(TaskMaster_page_controller.Item_Category_master_list[i].categoryCode!);


                                print(
                                    'LIstSIze.....${TaskMaster_page_controller
                                        .Item_Category_Selected_list
                                        .length}');
                              }
                              else {
                                print('NoLIstSIze.....');
                              }
                            }
                            TaskMaster_page_controller
                                .ItemCat_type_controller.clear();
                            showProductCatDialog(context);
                          },
                          child: Icon(Icons.add)),
                    )
                  ],
                )

              ],
            ),

            SizedBox(
              height: 3,
            ),

            Row(
              children: [
                Text(
                  "Along With Person Name ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Container(
                      width: size.width * .3,
                      child: Obx(() {
                        return Tooltip(
                          message: TaskMaster_page_controller
                              .Task_Master_list[0]
                              .alongWithPersonName == null || TaskMaster_page_controller
                              .Task_Master_list[0]
                              .alongWithPersonName == ''
                              ? ''
                              : TaskMaster_page_controller
                              .Task_Master_list[0]
                              .alongWithPersonName ?? '',
                          child: Text(
                            TaskMaster_page_controller
                                .Task_Master_list[0]
                                .alongWithPersonName == null || TaskMaster_page_controller
                                .Task_Master_list[0]
                                .alongWithPersonName == ''
                                ? ''
                                : TaskMaster_page_controller
                                .Task_Master_list[0]
                                .alongWithPersonName ?? "",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }),
                    ),
                    SizedBox(width: 2,),
                    Visibility(
                      visible:
                      TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar==1 &&
                          account_vm_controller.view!='TaskDashboard' &&
                          TaskMaster_page_controller.TaskDSAR_Master_list.length==0 ?true:false,
                      /*TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar==1||
                      account_vm_controller.view=='Sales' || account_vm_controller.view=='TaskDashboard' || TaskMaster_page_controller.email==TaskMaster_page_controller
                          .Task_Master_list[0].approvedBy ?false:true,*/
                      child: InkWell(
                          onTap: () {
                            TaskMaster_page_controller
                                .SelectedAlongPersonWith_list
                                .value = [];
                            for (int i = 0; i <
                                TaskMaster_page_controller
                                    .AlongPersonWith_list
                                    .length; i++) {
                              if (TaskMaster_page_controller
                                  .AlongPersonWith_list[i]
                                  .isSelected == 1) {
                                TaskMaster_page_controller
                                    .SelectedAlongPersonWith_list
                                    .add(
                                    TaskMaster_page_controller
                                        .AlongPersonWith_list[i]);
                                //TaskMaster_page_controller.Item_Category_code_list.add(TaskMaster_page_controller.Item_Category_master_list[i].categoryCode!);


                                print(
                                    'LIstSIzeAlong.....${TaskMaster_page_controller
                                        .SelectedAlongPersonWith_list
                                        .length}');
                              }
                              else {
                                print('NoLIstSIze.....');
                              }
                            }
                            TaskMaster_page_controller
                                .AlongPersonWith_controller.clear();
                            showAlongPersonDialog(context);
                          },
                          child: Icon(Icons.add)),
                    )
                  ],
                )

              ],
            ),
            Row(
              children: [
                Text(
                  "Task Remarks",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[0]
                        .taskRemarks == null
                        ? ''
                        : TaskMaster_page_controller
                        .Task_Master_list[0]
                        .taskRemarks,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .taskRemarks == null
                          ? ''
                          : TaskMaster_page_controller
                          .Task_Master_list[0]
                          .taskRemarks ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),

            Visibility(
              visible: TaskMaster_page_controller
                  .Task_Master_list[0]
                  .taskStatus!.toLowerCase() == 'rejected',
              child: Row(
                children: [
                  Text(
                    "Reject Remarks",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[0]
                          .rejectReason == null
                          ? ''
                          : TaskMaster_page_controller
                          .Task_Master_list[0]
                          .rejectReason,
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[0]
                            .rejectReason == null
                            ? ''
                            : TaskMaster_page_controller
                            .Task_Master_list[0]
                            .rejectReason ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Manager Remarks",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[0]
                        .managerRemarks == null
                        ? ''
                        : TaskMaster_page_controller
                        .Task_Master_list[0]
                        .managerRemarks,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .managerRemarks == null
                          ? ''
                          : TaskMaster_page_controller
                          .Task_Master_list[0]
                          .managerRemarks ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),

            Row(
              children: [
                Text(
                  "Reopen Remarks",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[0]
                        .reopenRemarks == null
                        ? ''
                        : TaskMaster_page_controller
                        .Task_Master_list[0]
                        .reopenRemarks,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .reopenRemarks == null
                          ? ''
                          : TaskMaster_page_controller
                          .Task_Master_list[0]
                          .reopenRemarks ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget viewCreatorManagerDetail(BuildContext context) {
    return   Visibility(
      visible: TaskMaster_page_controller.isExpandCrtd.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Created By",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .createdFullName ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Created On",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.formatDateWithTime(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .createdOn!) ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Manager Name",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .approvedFullName ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text("Approved/Rejected On",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.formatDateWithTime(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .approvedOn??"") ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Purpose of Visit",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[0]
                        .purposeOfVisit == null
                        ? ''
                        : TaskMaster_page_controller
                        .Task_Master_list[0]
                        .purposeOfVisit,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .purposeOfVisit == null
                          ? ''
                          : TaskMaster_page_controller
                          .Task_Master_list[0]
                          .purposeOfVisit ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget viewGeoInfoDetail(BuildContext context) {
    return   Visibility(
      visible: TaskMaster_page_controller.isExpandGeoInfo.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            /*Row(
              children: [
                Text(
                  "Frontliner ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .frontlinerValue ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),*/
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Region Name",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.onlyDate(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .branchHeadValue??"") ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            /*Row(
              children: [
                Text(
                  "Zone Head",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .Task_Master_list[0]
                      .zoneHeadValue ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),*/
            Row(
              children: [
                Text(
                  "Cluster Name",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.onlyDate(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .clustureHeadValue??"") ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget viewInfraDetails(BuildContext context) {
    String? expOrderDate=StaticMethod.convertDateFormat1(TaskMaster_page_controller.Task_Master_list[0].expectedDateOfOrder ?? "");
    String? inaugurationDate=StaticMethod.convertDateFormat1(TaskMaster_page_controller.Task_Master_list[0].inaugrationDateOfProject ?? "");
    String? expDateOfCompletion=StaticMethod.convertDateFormat1(TaskMaster_page_controller.Task_Master_list[0].expectedDateOfCompletion ?? "");
    return   Visibility(
      visible: TaskMaster_page_controller.isExpandInfraDeatils.value == true ? true : false,
      child:
      Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Infra Lead",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    print("Length${TaskMaster_page_controller.userGeoHierarchyy.length}");
                    TaskMaster_page_controller.infraFlag = 'FromDetailsPage';
                    for(int i=0; i<TaskMaster_page_controller.userGeoHierarchyy.length;i++){
                      if(TaskMaster_page_controller.userGeoHierarchyy[i].myLevel==1){
                        TaskMaster_page_controller.userRegionUpdateController.text=TaskMaster_page_controller.userGeoHierarchyy[i-1].geoValue!;
                        TaskMaster_page_controller.userClusterUpdateController.text=TaskMaster_page_controller.userGeoHierarchyy[i-2].geoValue!;
                      }
                    }
                    if(TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1){
                      TaskMaster_page_controller.isInfraYes.value = true;
                    }else{
                      TaskMaster_page_controller.isInfraYes.value = false;
                    }
                    TaskMaster_page_controller.viewAllDetailsOfTaskUpdateInfra();
                    //TaskMaster_page_controller.isInfraLeadUpdateController.value.text=TaskMaster_page_controller.isInfraLead.value.text;
                    TaskMaster_page_controller.getItemCategoryMstApiHit(TaskMaster_page_controller.Task_Master_list[0].taskId,
                        TaskMaster_page_controller.Task_Master_list[0].infraLeadNo,"");
                    Get.toNamed(RoutesName.updateTaskMstInfraScreen);
                  },
                  child: Text(
                    TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1?'Yes':'No',
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Infra Lead No.",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].infraLeadNo??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "User Region",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].userRegion??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),


            Row(
              children: [
                Text(
                  "User Cluster",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].userClusture??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Project Value",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].projectValue.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Exp Date of Order",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  expOrderDate??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Drawing Collected",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].drawingCollected==1?"Yes":"No",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Proposal Submitted",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].proposalSubmitted==1?"Yes":"No",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Inauguration Date of Project",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  inaugurationDate??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Architect",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].architect??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Executive Engineer",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].executiveEngineer??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Name of Infra Department",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].nameOfInfraDepartment??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Name of Agency Contactor",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].nameOfAgencyContrator??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Expected Revenue",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].expectedRevenue.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Value Of Quote",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller.Task_Master_list[0].valueOfQuote.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Expected Date Of Completion",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  expDateOfCompletion??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      )
    );
  }

  Widget viewDsarDetails(BuildContext context) {
    print('hcsdgyuifgy${TaskMaster_page_controller
        .Task_Master_list[0]
        .isReadyForApprove}');
    return   Visibility(
      visible: TaskMaster_page_controller.isExpandDSAR.value == true ? true : false,
      child: TaskMaster_page_controller.TaskDSAR_Master_list.value.length > 0
          && TaskMaster_page_controller.TaskDSAR_Master_list.value.isNotEmpty ?
      Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "DSAR Status",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .TaskDSAR_Master_list[0]
                      .dsarStatus??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Interaction Date",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.onlyDate(
                      TaskMaster_page_controller
                          .TaskDSAR_Master_list[0]
                          .nextInteractionDate??"") ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Interaction Time",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.onlyDate(
                      TaskMaster_page_controller
                          .TaskDSAR_Master_list[0]
                          .nextInteractionTime??"") ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            /*Row(
              children: [
                Text(
                  "Is Infra Lead",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    showInfraLeadDetails(context,   TaskMaster_page_controller
                        .Task_Master_list );
                  },
                  child: Text(
                    TaskMaster_page_controller
                        .Task_Master_list[0]
                        .isInfraLead==1?"Yes":"No",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),*/
            Row(
              children: [
                Text(
                  "Mode Of Call",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .TaskDSAR_Master_list[0]
                      .methodOfCall?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Purpose Of Visit",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  TaskMaster_page_controller
                      .TaskDSAR_Master_list[0]
                      .purposeOfVisit?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text( "Call Description",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width*.4,
                  child: Tooltip(
                    message:
                        TaskMaster_page_controller
                            .TaskDSAR_Master_list[0]
                            .remarks?? "",
                    child: Text(
                      TaskMaster_page_controller
                          .TaskDSAR_Master_list[0]
                          .remarks?? "",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Created Name",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                      TaskMaster_page_controller
                          .TaskDSAR_Master_list[0]
                          .createdFullName?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Created On",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  StaticMethod.onlyDate(
                      TaskMaster_page_controller
                          .TaskDSAR_Master_list[0]
                          .createdOn!) ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ) : Container(
        height: 100,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text("No Task DSAR History Found...",
          style: GoogleFonts.poppins(
            color: AllColors.textColor,
            fontSize: AllFontSize.twenteetwo,
            fontWeight: FontWeight.w500,
          ),),
      ),
    );
  }

  void showInfraLeadDetails(BuildContext context, RxList<TaskMasterGetModel> task_master_list) {
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return  Container(
          width: double.infinity,
          height: size.height/2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleBackButton(
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Infra Lead Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: AllColors.primaryDark1,)),
                    )

                  ],
                ),
              ),
              Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
              // Obx(() {
              //  return
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "User Region",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].userRegion??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),

                        Row(
                          children: [
                            Text(
                              "User Cluster",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].userClusture??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Project Value",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].projectValue.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Exp Date of Order",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].expectedDateOfOrder??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Drawing Collected",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].drawingCollected==1?"Yes":"No",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Proposal Submitted",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].proposalSubmitted==1?"Yes":"No",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Inaugration Date of Project",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].inaugrationDateOfProject??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Architect",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].architect??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Executive Engineer",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].executiveEngineer??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Name of Infra Department",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].nameOfInfraDepartment??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Name of Agency Contactor",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].nameOfAgencyContrator??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Expected Revenue",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].expectedRevenue.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Value Of Quote",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].valueOfQuote.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Expected Date Of Completion",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              task_master_list[0].expectedDateOfCompletion??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              //  })
            ],
          ),
        );
      },
    );
  }

  showTaskReopenDialog(context, String TaskId){
    TaskMaster_page_controller.taskReopenRemarksController.value.clear();
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
              title:  Text(
                'Reopen Task',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              content: Wrap(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                controller: TaskMaster_page_controller
                    .taskReopenRemarksController.value,
                decoration: InputDecoration(
                    hintText: "Reopen Remarks",
                    labelText: "Reopen Remarks",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    /*focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),*/
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),
                  SizedBox(height: 55,),

                   Center(
                     child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.greenblue,
                          ),
                        ),
                        onPressed: ()  {
                          if(TaskMaster_page_controller.taskReopenRemarksController.value.text.isEmpty || TaskMaster_page_controller.taskReopenRemarksController.value.text == null) {
                            Utils.sanckBarError(
                                'Error : ', 'Please enter reopen remarks.');
                            return;
                          }
                          TaskMaster_page_controller.taskReopenApiHit(TaskId);
                          Navigator.pop(context);


                        },
                        child: Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text('Submit',
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                   ),

                ],
              )
          );
        });
  }

  showApprovRejectDialog(context, String TaskId){
    TaskMaster_page_controller.ApproveReject_Controller.clear();
    TaskMaster_page_controller.RejectReason_Controller.clear();
    TaskMaster_page_controller.managerRemarksController.value.clear();
    TaskMaster_page_controller.ApproveBool.value = false;
    TaskMaster_page_controller.RejectBool.value = false;
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
              title:  Text(
                'Update Task',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              content: Wrap(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  bindApprovRejectDropDown(context),
                  SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible: TaskMaster_page_controller.ApproveBool
                          .value,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          controller: TaskMaster_page_controller
                              .managerRemarksController.value,
                          decoration: InputDecoration(
                              hintText: "Manager Remarks",
                              labelText: "Manager Remarks",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten,
                                  horizontal: AllFontSize.ten),

                              /*focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),*/
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible: TaskMaster_page_controller.RejectBool
                          .value,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          controller: TaskMaster_page_controller
                              .RejectReason_Controller,
                          decoration: InputDecoration(
                              hintText: "Reject Reason",
                              labelText: "Reject Reason",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten,
                                  horizontal: AllFontSize.ten),

                              /*focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),*/
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),
                      ),
                    );

                  }),
                  SizedBox(height: 55,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [
                      Obx((){
                        return Visibility(
                          visible: TaskMaster_page_controller.ApproveBool.value,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              if(TaskMaster_page_controller.ApproveReject_Controller.text.isEmpty || TaskMaster_page_controller.ApproveReject_Controller == null) {
                                Utils.sanckBarError(
                                    'Error : ', 'Please select Type.');
                                return;
                              }
                              Navigator.pop(context);
                              ConfirmationDialog(context, TaskId);


                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Approve',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      ),
                      Obx((){
                        return Visibility(
                            visible: TaskMaster_page_controller.RejectBool.value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.lightredColor,
                                ),
                              ),
                              onPressed: ()  {
                                if(TaskMaster_page_controller.ApproveReject_Controller.text== "Reject"){
                                  if(TaskMaster_page_controller.RejectReason_Controller.text.isEmpty || TaskMaster_page_controller.RejectReason_Controller == null){
                                    Utils.sanckBarError('Error : ', 'Please Enter Reject Reason.');
                                  }else{
                                    Navigator.pop(context);
                                    ConfirmationDialog(context, TaskId);
                                    //TaskMaster_page_controller.UpdateTaskStatus(context);
                                  }
                                }


                              },
                              child: Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: Text('Reject',
                                  /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ));
                      })
                      ,
                    ],)
                ],
              )
          );
        });
  }

  ConfirmationDialog(context, String taskId){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to Update this Task?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();
                              TaskMaster_page_controller.RejectReason_Controller.clear();
                              //TaskMaster_page_controller.ApproveReject_Controller.clear();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              TaskMaster_page_controller.ApproveRejectApiHit(taskId);
                              Navigator.pop(context);
                              /*TaskMaster_page_controller.pageNumber=0;
                          TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.is_Active.toString(), '', '', '');
                          Get.toNamed(RoutesName.taskMaster_screen);*/
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          );

        });
  }

  Widget bindApprovRejectDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayApproveRejectForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.approveRejectList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.approveRejectList
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
        TaskMaster_page_controller.ApproveReject_Controller.text =
            _displayApproveRejectForOption(selection).toString();
        if(TaskMaster_page_controller.ApproveReject_Controller.text == 'Approve'){
          TaskMaster_page_controller.ApproveReject = "Approved";
          TaskMaster_page_controller.RejectBool.value = false;
          TaskMaster_page_controller.ApproveBool.value = true;
        }else{
          TaskMaster_page_controller.ApproveReject = "Rejected";
          TaskMaster_page_controller.RejectBool.value = true;
          TaskMaster_page_controller.ApproveBool.value = false;
        }
        //print('IsActive.....${accountMaster_page_controller.IsActive_controller.text}');
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
              focusNode.requestFocus();
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = TaskMaster_page_controller.ApproveReject_Controller
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
              hintText: 'Task Status',
              labelText: 'Task Status',

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
            elevation: 4.0,
            child: Container(
              width: size.width*.5,
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

}