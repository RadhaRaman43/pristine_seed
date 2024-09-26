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

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          if(account_vm_controller.view=='Sales'){
            account_vm_controller.view='';
            Get.back();
          }else if (account_vm_controller.view=="TaskDashboard"){
            account_vm_controller.view='';
            Get.toNamed(RoutesName.AccountDashboardData_Screen);
          }
          else {
            //Get.offAllNamed(RoutesName.taskMaster_screen);
            TaskMaster_page_controller.pageNumber=0;
            TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.is_Active.toString(), '', '', '', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
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
            children: [
              Text(
                'Task Information',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Obx((){
                return  Visibility(
                  visible: TaskMaster_page_controller.TaskDSAR_Master_list.isNotEmpty?false:true,
                  //visible: account_vm_controller.view=='Sales'?false:true,
                  child: IconButton(onPressed: () {
                    //createDSARDialog(context);
                    TaskMaster_page_controller.DSAR_Status_type_controller.value.clear();
                    TaskMaster_page_controller.isInfraLead.value.text=TaskMaster_page_controller.Task_Master_list[0].isInfraLead == 1 ?"Yes":"No";
                    TaskMaster_page_controller.NextInterdate_controller.clear();
                    TaskMaster_page_controller.NextInterTime_controller.clear();
                    TaskMaster_page_controller.DSAR_Remarks_controller.clear();
                    TaskMaster_page_controller.EstClosuredate_controller.clear();
                    TaskMaster_page_controller.BudgetAmt_controller.clear();
                    TaskMaster_page_controller.ExpectedAmt_controller.clear();
                    TaskMaster_page_controller.DSARStatus.value = false;
                    if(TaskMaster_page_controller.Task_Master_list[0].isInfraLead == 1){
                      TaskMaster_page_controller.isInfraLeadValue.value = true;
                      print('value...${TaskMaster_page_controller.isInfraLeadValue.value}');
                    }
                    print('value2...${TaskMaster_page_controller.isInfraLeadValue.value}');
                    //TaskMaster_page_controller.isInfraLead.text="No";
                    TaskMaster_page_controller.isInfraLeadValueSubmit.value = false;
                    TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar == 1 ? Get.toNamed(RoutesName.addNewDSARTask_screen): "";
                  }, icon: Visibility(
                      visible: TaskMaster_page_controller.Task_Master_list[0].isCreateTaskDsar == 1 ? true : false,
                      child: Icon(Icons.add))),
                );
              }),


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
                    return viewTasketails(context);
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
                          "Manager Info",
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
                    return viewCreatorManagerDetail(context);
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
                    return viewDsarDetails(context);
                  }),
                ],
              ),
            ),
        
            /*Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              //color: AllColors.Card1Color,
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                //color: AllColors.Card1Color, // Set the inside color here
                border: Border.all(
                  color: AllColors.blackColor, // Set the border color here
                  //width: 1.0, // Adjust the border width if necessary
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
        
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Task DSAR History",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Obx(
                        () {
                      return IconButton(
                        onPressed: () {
                          TaskMaster_page_controller.toggle();
                          if (TaskMaster_page_controller
                              .isExpand.value ==
                              true) {
                            print(
                                "If......${TaskMaster_page_controller.isExpand.value}");
                          } else {
                            print(
                                "else......${TaskMaster_page_controller.isExpand.value}");
                          }
                        },
                        icon: Icon(
                          TaskMaster_page_controller
                              .isExpand.value
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          size: 25,
                          color: AllColors.primaryDark1,
                        ),
                      );
                    },
                  )
        
                ],
              ),
            ),
        
            SizedBox(height: 10,),
            Obx((){
              return Container(
                child:
                TaskMaster_page_controller.TaskDSAR_Master_list.value.length > 0
              && TaskMaster_page_controller.TaskDSAR_Master_list.value.isNotEmpty ?
              Flexible(
                  child: Visibility(
                  visible: TaskMaster_page_controller
                      .isExpand.value == true ? true : false,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                      TaskMaster_page_controller
                          .TaskDSAR_Master_list
                          .length,
                      itemBuilder: (context, index) {
                        var count = index + 1;
                        var timeLine_date_month =
                        StaticMethod.dateTimeToDate(
                            TaskMaster_page_controller
                                .TaskDSAR_Master_list[index]
                                .createdOn!);
                        var timeLine_date = StaticMethod.onlyMonthName(
                            TaskMaster_page_controller
                                .TaskDSAR_Master_list[index]
                                .createdOn??"");
                        return Container(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        //right: 10,
                                        bottom: 10,
                                        top: 40),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Tooltip(
                                            message:
                                            timeLine_date_month,
                                            child: Text(
                                              timeLine_date!,
                                              style: GoogleFonts
                                                  .poppins(
                                                color: AllColors
                                                    .textColor,
                                                fontSize:
                                                AllFontSize
                                                    .fourtine,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                              ),
                                            ),
                                          ),
                                          width:
                                          size.width * 0.11,
                                        ),
                                        SizedBox(
                                            width: size.width *
                                                0.12),
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets
                                                    .only(
                                                    left: 8,
                                                    right:
                                                    4),
                                                width:
                                                size.width *
                                                    .71,
                                                decoration:
                                                BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(
                                                            10),
                                                        topRight: Radius.circular(
                                                            10)),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          offset: Offset(0.0, 0.55),
                                                          blurRadius: 0.7,
                                                          blurStyle: BlurStyle.solid,
                                                          color: Colors.black54),
                                                    ],
                                                    color: AllColors
                                                        .whiteColor),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      TaskMaster_page_controller
                                                          .TaskDSAR_Master_list[index]
                                                          .dsarStatus??"",
                                                      style: GoogleFonts
                                                          .poppins(
                                                        color: AllColors
                                                            .textColor,
                                                        fontSize:
                                                        AllFontSize.fourtine,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      TaskMaster_page_controller
                                                          .TaskDSAR_Master_list[index]
                                                          .createdFullName??"",
                                                      style: GoogleFonts
                                                          .poppins(
                                                        color: AllColors
                                                            .textColor,
                                                        fontSize:
                                                        AllFontSize.nine,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets
                                                    .only(
                                                    left:
                                                    4),
                                                decoration: BoxDecoration(
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          offset: Offset(0.0,
                                                              0.55),
                                                          blurRadius:
                                                          0.5,
                                                          blurStyle: BlurStyle
                                                              .solid,
                                                          color:
                                                          Colors.black54)
                                                    ],
                                                    color: Colors
                                                        .white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top:
                                                            3),
                                                        width: size.width *
                                                            .7,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Date:  ",
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.primaryDark1,
                                                                        // Change this to your desired color for "Message:"
                                                                        fontSize: AllFontSize.fourtine,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: TaskMaster_page_controller.TaskDSAR_Master_list[index].nextInteractionDate!,
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.textColor,
                                                                        // This keeps the rest of the text color unchanged
                                                                        fontSize: AllFontSize.twelve,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Time:  ",
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.primaryDark1,
                                                                        // Change this to your desired color for "Message:"
                                                                        fontSize: AllFontSize.fourtine,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: TaskMaster_page_controller.TaskDSAR_Master_list[index].nextInteractionTime!,
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.textColor,
                                                                        // This keeps the rest of the text color unchanged
                                                                        fontSize: AllFontSize.twelve,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Is Infra Lead:  ",
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.primaryDark1,
                                                                        // Change this to your desired color for "Message:"
                                                                        fontSize: AllFontSize.fourtine,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: TaskMaster_page_controller.TaskDSAR_Master_list[index].isInfraLead==1?"Yes":"No",
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.textColor,
                                                                        // This keeps the rest of the text color unchanged
                                                                        fontSize: AllFontSize.twelve,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Remarks:  ",
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.primaryDark1,
                                                                        // Change this to your desired color for "Message:"
                                                                        fontSize: AllFontSize.fourtine,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: TaskMaster_page_controller.TaskDSAR_Master_list[index].remarks??"",
                                                                      style: GoogleFonts.poppins(
                                                                        color: AllColors.textColor,
                                                                        // This keeps the rest of the text color unchanged
                                                                        fontSize: AllFontSize.twelve,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                            ])),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 70,
                                    // left: 10,
                                    child: new Container(
                                      height: size.height * 0.7,
                                      width: 1.0,
                                      color:
                                      Colors.grey.shade400,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 35,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          bottom: 70,
                                          right: 20),
                                      child: Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration:
                                        new BoxDecoration(
                                          color:
                                          Colors.lightBlue,
                                          borderRadius:
                                          BorderRadius
                                              .circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            count.toString(),
                                            style: GoogleFonts
                                                .poppins(
                                              color: AllColors
                                                  .whiteColor,
                                              fontSize:
                                              AllFontSize
                                                  .ten,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      })
        
                  )
              )
                  : Text("No Task DSAR History Found...",
              style: GoogleFonts.poppins(
              color: AllColors.textColor,
              fontSize: AllFontSize.twenteetwo,
              fontWeight: FontWeight.w500,
              ),),
        
              );
            })*/
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
          Utils.showToastification('Success', 'Add Successfully');
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
                  "Method of Call",
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
                    account_vm_controller.view='Task';
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
                    color: Colors.green,
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
            /*SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Tasks Due Date",
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
                        .taskDueDate.toString() +
                        " | ${TaskMaster_page_controller
                            .Task_Master_list[0]
                            .taskDueTime}",
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[0]
                          .taskDueDate.toString() +
                          " | ${TaskMaster_page_controller
                              .Task_Master_list[0]
                              .taskDueTime}",
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
            ),*/
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
                  "Sale Cycle Acti. By",
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
                  "Sale Cycle Acti. on",
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
                    salesCycleController.getsalesCycleData(0, TaskMaster_page_controller
                        .Task_Master_list[0]
                        .salesCycleId!, "ViewHeader", 'Task');
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
                      visible: account_vm_controller.view=='Sales' || TaskMaster_page_controller.email==TaskMaster_page_controller
            .Task_Master_list[0].approvedBy ?false:true,
                      child: InkWell(
                          onTap: () {
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
                  StaticMethod.onlyDate(
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
                Text(
                  "Approved On",
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

  Widget viewDsarDetails(BuildContext context) {
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
            ),
            Row(
              children: [
                Text(
                  "Remarks",
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
                      .remarks?? "",
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

}