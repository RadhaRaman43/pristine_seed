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
import '../../CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';



class TaskMasterApprovalDetails extends StatelessWidget{
  TaskMasterApprovalDetails({super.key});
  final TaskMaster_page_controller=Get.put(TaskApprovalvm());
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  Size size=Get.size;



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
          TaskMaster_page_controller.resetAllFieldOfFilter();
          TaskMaster_page_controller.pageNumber = 0;
          TaskMaster_page_controller.is_Active=-1;
          TaskMaster_page_controller
              .getTaskMaster(
              TaskMaster_page_controller.pageNumber,
              TaskMaster_page_controller.is_Active
                  .toString(),
              '',
              '');
          Get.toNamed(RoutesName.taskApproval_List);
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
              Row(
                children: [
                  Obx((){
                    return  Visibility(
                      visible: TaskMaster_page_controller
                          .Task_Master_list[0]
                          .isReadyForApprove.toString()=='1'?true:false,
                      child: IconButton(onPressed: () {
                        TaskMaster_page_controller.showApprovRejectDialog(context, TaskMaster_page_controller.Task_Master_list[0].taskId!);
                      }, icon: Icon(Icons.update)),
                    );
                  }),

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
                      return viewGeoInfoDetail(context);
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
                      return viewDsarDetails(context);
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
                        'View',);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Account Name",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),

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
                      account_vm_controller.view='fromtaskapprovaldetailspage';
                    }
                    contact_vm_controller.view='fromtaskapprovaldetailspage';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Category ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  width: size.width * .3,
                  child:  Tooltip(
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
                    )

                )

              ],
            ),

            SizedBox(
              height: 3,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Along With Person Name ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  width: size.width * .3,
                  child: Tooltip(
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
                    )

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
                  Text(
                    TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1?'Yes':'No',
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
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
                  "Method Of Call",
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






}