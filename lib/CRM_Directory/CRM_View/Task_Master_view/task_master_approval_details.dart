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
          TaskMaster_page_controller.getTaskMasterApprovalList(
              TaskMaster_page_controller.pageNumber,
              TaskMaster_page_controller.is_Active.toString(),
          );
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
                    print("hhhhh ${TaskMaster_page_controller.Task_Master_list_line_Wise[0].isReadyForApprove} ");
                    return  Visibility(
                      visible: TaskMaster_page_controller.Task_Master_list_line_Wise[0].isReadyForApprove==1 &&
                          TaskMaster_page_controller.isHeadofficePermission!="1"? true:false
                          /*&& TaskMaster_page_controller.isAdminWritePermission=="1"*/ && TaskMaster_page_controller.isHeadofficePermission!="1",
                      child: IconButton(onPressed: () {
                        TaskMaster_page_controller.showApprovRejectDialog(context, TaskMaster_page_controller.Task_Master_list_line_Wise[0].taskId!);
                      }, icon: const Icon(Icons.update)),
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
                          Obx(() {
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
                                  TaskMaster_page_controller.isExpandCrtd.value ? Icons.arrow_drop_down : Icons.arrow_drop_up,
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
    String taskStatus = TaskMaster_page_controller.Task_Master_list_line_Wise[0].taskStatus?.toLowerCase()??"";
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
    String? dateTimeCreatedOn = StaticMethod.onlyDate(TaskMaster_page_controller.Task_Master_list_line_Wise[0].dateOfVisit ?? "");
    return   Visibility(
      visible: TaskMaster_page_controller.isExpandDetails.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            _buildLabelWithValue(label: "Previous Task ID",
              value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].previousTaskId ?? "",
              onTap: () {
                print('task....${TaskMaster_page_controller
                    .Task_Master_list_line_Wise[0].taskId}');
                TaskMaster_page_controller.getTaskMaster(0,
                  TaskMaster_page_controller.is_Active
                      .toString(),
                  TaskMaster_page_controller
                      .Task_Master_list_line_Wise[0].previousTaskId,
                );
              },
              color:Colors.blueAccent,
            ),

            _buildLabelWithValue(label: "Task ID", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].taskId ?? "",),

            _buildLabelWithValue(label: "Type of Call", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].typeOfCall ?? "",),

            _buildLabelWithValue(label: "Mode of Call", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].methodOfCall ?? "",),

            _buildLabelWithValue(label: "Customer Name",
              value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].accountName ?? "",
              onTap: (){
                if(account_vm_controller.view=="Sales"){
                  account_vm_controller.view="Sales";
                }else{
                  account_vm_controller.view='fromtaskapprovaldetailspage';
                }
                contact_vm_controller.view='fromtaskapprovaldetailspage';
                account_vm_controller.getAccMasterBuyCodeApi(TaskMaster_page_controller.Task_Master_list_line_Wise[0].accountCode);
              },
              color:Colors.blueAccent,
            ),
            _buildLabelWithValue(label: "Customer Code", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].accountCode ?? "",),

            _buildLabelWithValue(label: 'Contact Name', value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].contactName ?? "",),

            _buildLabelWithValue(label: "Task Status", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].taskStatus ?? "",color: getStatusColor(taskStatus)),

            _buildLabelWithValue(label: "Product Category ", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].productCategory ?? "",),

            _buildLabelWithValue(label: "Date of Visit", value: dateTimeCreatedOn,),

            _buildLabelWithValue(label: "Time of Visit", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].timeOfVisit ?? "",),

            _buildLabelWithValue(label: "Sale Cycle Active", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].isSalesCycleActive ==1?"Yes":"No",),

            _buildLabelWithValue(label: "Sale Cycle Activated By", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].salesCycleActivatedBy ?? "",),

            _buildLabelWithValue(label: "Sale Cycle Activated On", value: StaticMethod.onlyDate(TaskMaster_page_controller.Task_Master_list_line_Wise[0].salesCycleActivatedOn??""),),

            _buildLabelWithValue(label: "Sale Cycle ID", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].salesCycleId ?? "",),

            _buildLabelWithValue(label: "Along With Person Name ", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].alongWithPersonName ?? "",),

            _buildLabelWithValue(label: "Task Remarks", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].taskRemarks ?? "",),

            Visibility(
              visible: TaskMaster_page_controller.Task_Master_list_line_Wise[0].taskStatus!.toLowerCase() == 'rejected',
              child: _buildLabelWithValue(label: "Reject Remarks", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].rejectReason ?? "",),
            ),

            _buildLabelWithValue(label: "Manager Remarks", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].managerRemarks ?? "",),

            _buildLabelWithValue(label: "Reopen Remarks", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].reopenRemarks ?? "",),

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
            _buildLabelWithValue(label: "Created By", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].createdFullName ?? "",),
            _buildLabelWithValue(label: "Created On", value:StaticMethod.formatDateWithTime(TaskMaster_page_controller.Task_Master_list_line_Wise[0].createdOn!) ?? "",),
            _buildLabelWithValue(label: "Reporting Manager Name", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].approvedFullName ?? "",),
            _buildLabelWithValue(label: "Approved/Rejected By", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].approvedFullName ?? "",),
            _buildLabelWithValue(label: "Approved/Rejected On", value: StaticMethod.formatDateWithTime(TaskMaster_page_controller.Task_Master_list_line_Wise[0].approvedOn??"") ?? "",),
            _buildLabelWithValue(label: "Purpose of Visit", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].purposeOfVisit ?? "",),

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
            _buildLabelWithValue(label: "Region Name", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].branchHeadValue ?? "",),
            _buildLabelWithValue(label: "Cluster Name", value: TaskMaster_page_controller.Task_Master_list_line_Wise[0].clustureHeadValue ?? "",),

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
            _buildLabelWithValue(label: "DSAR Status", value: TaskMaster_page_controller.TaskDSAR_Master_list[0].dsarStatus??"",),
            _buildLabelWithValue(label: "Interaction Date", value: StaticMethod.onlyDate(TaskMaster_page_controller.TaskDSAR_Master_list[0].nextInteractionDate??"") ?? "",),
            _buildLabelWithValue(label: "Interaction Time", value: TaskMaster_page_controller.TaskDSAR_Master_list[0].nextInteractionTime?? "",),
            _buildLabelWithValue(label: "Mode Of Call", value: TaskMaster_page_controller.TaskDSAR_Master_list[0].methodOfCall?? "",),
            _buildLabelWithValue(label: "Purpose Of Visit", value: TaskMaster_page_controller.TaskDSAR_Master_list[0].purposeOfVisit?? "",),
            _buildLabelWithValue(label: "Call Description", value: TaskMaster_page_controller.TaskDSAR_Master_list[0].remarks?? "",),
            _buildLabelWithValue(label: "Created Name", value: TaskMaster_page_controller.TaskDSAR_Master_list[0].createdFullName?? "",),
            _buildLabelWithValue(label: "Created On", value: StaticMethod.formatDateWithTime(TaskMaster_page_controller.TaskDSAR_Master_list[0].createdOn?? ""),),

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

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    VoidCallback? onTap,
    Color color = AllColors.textColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: onTap,
            child: Tooltip(
              message: value??"",
              child: Text(
                value ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color:color,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                  decoration:label== "Account Name"? TextDecoration.underline:null,
                  decorationStyle:label=="Account Name" ? TextDecorationStyle.wavy:null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }





}