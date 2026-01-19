

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../component/back_button.dart';
import '../../../component/circular_loading.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class TaskMasterScreen extends StatelessWidget {

  TaskMasterScreen({super.key});

  final TaskMaster_page_controller = Get.put(Taskmastervm());
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final salesCycleController = Get.put(SalesCycleVm());
  Size size = Get.size;

  static String _displayTaskStatusForOption(String option) =>
      option;

  static String _displaySaleCycleActiveForOption(String option) =>
      option;

  static String _displayApproveRejectForOption(String option) =>
      option;

  static String _displayIsInfraLeadForOption(String option) =>
      option;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title: Row(
              children: [
                Text(
                  'Task Master',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Visibility(
                  //visible: TaskMaster_page_controller.isAdminWritePermission.value == '0'?true:false,
                  visible:TaskMaster_page_controller.isHeadofficePermission.value!="1"  ? true:false ,
                  child: IconButton(onPressed: () {
                    //TaskMaster_page_controller.clearCreateTaskController();
                    TaskMaster_page_controller.resetAllFieldOfFilter();
                    TaskMaster_page_controller.CallStatusMasterApiHit('Call');
                    TaskMaster_page_controller.getItemCategoryMstWithoutTaskIdApi();
                    TaskMaster_page_controller.getEmpMstEmailByApi();
                    Get.toNamed(RoutesName.addNewTaskMaster_screen);

                  }, icon: Icon(Icons.add)),
                ),


                IconButton(onPressed: () {
                  /*TaskMaster_page_controller.Task_status_controller.text = "All";
                  //TaskMaster_page_controller.isInfraLeadFilterController.text = "All";
                  TaskMaster_page_controller.SaleCycleActive_Controller.text = "All";*/
                  TaskMaster_page_controller.CallStatusMasterApiHit('Call',filter: "0");
                  TaskMaster_page_controller.MethodOfCallMasterApiHit(filter: "0");

                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: Obx((){
          print("circular loading..${TaskMaster_page_controller.loading.value}");
          if(TaskMaster_page_controller.loading.value)
            return const FullScreenLoader();
          return Visibility(child: RefreshIndicator(
            onRefresh: TaskMaster_page_controller.refreshList,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: TaskMaster_page_controller.loading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.green,
                        color: AllColors.textColor,
                      ),
                    );
                  }),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.only(
                                  right: 15, top: 2, left: 15, bottom: 2),
                              backgroundColor: TaskMaster_page_controller.is_done
                                  .value == 0 &&
                                  TaskMaster_page_controller.filter.value ==
                                      'Running'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text('Running',
                                  style: GoogleFonts.poppins(
                                    color: TaskMaster_page_controller.is_done.value == 0 &&
                                        TaskMaster_page_controller.filter.value == 'Running'
                                        ? AllColors.whiteColor
                                        : AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onPressed: () {
                                TaskMaster_page_controller.isInfraLeadFilterController.text = "All";
                                TaskMaster_page_controller.SaleCycleActive_Controller.text = "All";
                                TaskMaster_page_controller.pageNumber = 0;
                                TaskMaster_page_controller.date_filter.value = "Today";
                                TaskMaster_page_controller.is_done.value = 0;
                                TaskMaster_page_controller.filter.value = "Running";
                                TaskMaster_page_controller.getTaskMaster(
                                    TaskMaster_page_controller.pageNumber,
                                    TaskMaster_page_controller.is_Active.toString(), '', '',
                                    TaskMaster_page_controller.Task_status_controller.value.text,
                                    TaskMaster_page_controller.date_filter,
                                    TaskMaster_page_controller.is_done.value);
                              }, //Text
                            );
                          }),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.only(
                                  right: 15, top: 2, left: 15, bottom: 2),
                              backgroundColor: TaskMaster_page_controller.
                              is_done.value == 1 && TaskMaster_page_controller.filter.value == 'Completed'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text('Completed',
                                  style: GoogleFonts.poppins(
                                    color: TaskMaster_page_controller.
                                    is_done.value == 1 &&
                                        TaskMaster_page_controller.filter.value ==
                                            'Completed'
                                        ? AllColors.whiteColor
                                        : AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onPressed: () {
                                TaskMaster_page_controller.isInfraLeadFilterController.text = "All";
                                TaskMaster_page_controller.SaleCycleActive_Controller.text = "All";
                                TaskMaster_page_controller.pageNumber = 0;
                                TaskMaster_page_controller.is_done.value = 1;
                                TaskMaster_page_controller.date_filter.value = "";
                                TaskMaster_page_controller.filter.value = "Completed";
                                TaskMaster_page_controller.getTaskMaster(
                                    TaskMaster_page_controller.pageNumber,
                                    TaskMaster_page_controller.is_Active.toString(),
                                    '',
                                    '',
                                    TaskMaster_page_controller.Task_status_controller.value.text,
                                    TaskMaster_page_controller.date_filter,
                                    TaskMaster_page_controller.is_done.value);
                              }, //Text
                            );
                          }),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.only(
                                  right: 15, top: 2, left: 15, bottom: 2),
                              backgroundColor: TaskMaster_page_controller.
                              is_done.value == 0 &&
                                  TaskMaster_page_controller.filter.value ==
                                      'Pending DSAR'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text('Pending DSAR',
                                  style: GoogleFonts.poppins(
                                    color: TaskMaster_page_controller.
                                    is_done.value == 0 &&
                                        TaskMaster_page_controller.filter.value ==
                                            'Pending DSAR'
                                        ? AllColors.whiteColor
                                        : AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onPressed: () {
                                TaskMaster_page_controller
                                    .isInfraLeadFilterController.text = "All";
                                TaskMaster_page_controller
                                    .SaleCycleActive_Controller.text = "All";
                                TaskMaster_page_controller.pageNumber = 0;
                                TaskMaster_page_controller.is_done.value = 0;
                                TaskMaster_page_controller.date_filter.value = "";
                                TaskMaster_page_controller
                                    .filter.value = "Pending DSAR";
                                TaskMaster_page_controller
                                    .getTaskMaster(
                                    TaskMaster_page_controller.pageNumber,
                                    TaskMaster_page_controller.is_Active
                                        .toString(),
                                    '',
                                    '',
                                    'Pending DSAR',
                                    TaskMaster_page_controller.date_filter,
                                    TaskMaster_page_controller.is_done.value);
                              }, //Text
                            );
                          }),

                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.only(
                                  right: 15, top: 2, left: 15, bottom: 2),
                              backgroundColor: TaskMaster_page_controller.
                              is_done.value == 0 &&
                                  TaskMaster_page_controller.filter.value == 'All'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text('All ',
                                  style: GoogleFonts.poppins(
                                    color: TaskMaster_page_controller.
                                    is_done.value == 0 &&
                                        TaskMaster_page_controller.filter.value ==
                                            'All'
                                        ? AllColors.whiteColor
                                        : AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onPressed: () {
                                TaskMaster_page_controller
                                    .isInfraLeadFilterController.text = "All";
                                TaskMaster_page_controller
                                    .SaleCycleActive_Controller.text = "All";
                                TaskMaster_page_controller.pageNumber = 0;
                                TaskMaster_page_controller.is_done.value = 0;
                                TaskMaster_page_controller.date_filter.value =
                                "All";
                                TaskMaster_page_controller
                                    .filter.value = "All";
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
                              }, //Text
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: TaskMaster_page_controller.is_done.value == 0 &&
                          TaskMaster_page_controller.filter.value == "Running"
                          ? true
                          : false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() {
                                return ActionChip(
                                  elevation: 2,
                                  padding: EdgeInsets.only(
                                      right: 15, top: 2, left: 15, bottom: 2),
                                  backgroundColor: TaskMaster_page_controller
                                      .date_filter.value ==
                                      "Today"
                                      ? AllColors.primaryDark1
                                      : AllColors.grayColor,
                                  shadowColor: Colors.black,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: AllColors.grayColor)),
                                  //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                  //CircleAvatar
                                  label: Text("Today Calls",
                                      style: GoogleFonts.poppins(
                                        color: TaskMaster_page_controller
                                            .date_filter.value ==
                                            "Today"
                                            ? AllColors.whiteColor
                                            : AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  onPressed: () {
                                    TaskMaster_page_controller.pageNumber = 0;
                                    TaskMaster_page_controller
                                        .date_filter.value = "Today";
                                    TaskMaster_page_controller.is_done.value = 0;
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
                                  }, //Text
                                );
                              }),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Obx(
                                    () {
                                  return ActionChip(
                                    elevation: 2,
                                    padding: EdgeInsets.only(
                                        right: 15, top: 2, left: 15, bottom: 2),
                                    backgroundColor: TaskMaster_page_controller
                                        .date_filter.value ==
                                        "Future"
                                        ? AllColors.primaryDark1
                                        : AllColors.grayColor,
                                    shadowColor: Colors.black,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: AllColors.grayColor)),
                                    //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                    //CircleAvatar
                                    label: Text("Future Calls",
                                        style: GoogleFonts.poppins(
                                          color: TaskMaster_page_controller
                                              .date_filter.value ==
                                              "Future"
                                              ? AllColors.whiteColor
                                              : AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onPressed: () {
                                      TaskMaster_page_controller
                                          .date_filter.value = "Future";
                                      TaskMaster_page_controller.pageNumber = 0;
                                      TaskMaster_page_controller.is_done.value =
                                      0;
                                      TaskMaster_page_controller
                                          .getTaskMaster(
                                          TaskMaster_page_controller.pageNumber,
                                          TaskMaster_page_controller.is_Active
                                              .toString(),
                                          '',
                                          '',
                                          TaskMaster_page_controller.Task_status_controller.value.text,
                                          TaskMaster_page_controller.date_filter,
                                          TaskMaster_page_controller.is_done
                                              .value);
                                    }, //Text
                                  );
                                },
                              ),

                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Obx(
                                    () {
                                  return ActionChip(
                                    elevation: 2,
                                    padding: EdgeInsets.all(2),
                                    backgroundColor: TaskMaster_page_controller
                                        .date_filter.value ==
                                        "Breached"
                                        ? AllColors.primaryDark1
                                        : AllColors.grayColor,
                                    shadowColor: Colors.black,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: AllColors.grayColor)),
                                    //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                    //CircleAvatar
                                    label: Text('Lapsed Calls',
                                        style: GoogleFonts.poppins(
                                          color: TaskMaster_page_controller
                                              .date_filter.value ==
                                              "Breached"
                                              ? AllColors.whiteColor
                                              : AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onPressed: () {
                                      TaskMaster_page_controller
                                          .date_filter.value = "Breached";
                                      TaskMaster_page_controller.pageNumber = 0;
                                      TaskMaster_page_controller.is_done.value =
                                      0;
                                      TaskMaster_page_controller
                                          .getTaskMaster(
                                          TaskMaster_page_controller.pageNumber,
                                          TaskMaster_page_controller.is_Active
                                              .toString(),
                                          '',
                                          '',
                                          TaskMaster_page_controller.Task_status_controller.value.text,
                                          TaskMaster_page_controller.date_filter,
                                          TaskMaster_page_controller.is_done
                                              .value);
                                    }, //Text
                                  );
                                },
                              ),

                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Obx(
                                    () {
                                  return ActionChip(
                                    elevation: 2,
                                    padding: EdgeInsets.only(
                                        right: 35, top: 2, left: 35, bottom: 2),
                                    backgroundColor: TaskMaster_page_controller
                                        .date_filter.value ==
                                        "ALL"
                                        ? AllColors.primaryDark1
                                        : AllColors.grayColor,
                                    shadowColor: Colors.black,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: AllColors.grayColor)),
                                    //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                    //CircleAvatar
                                    label: Text('All Calls',
                                        style: GoogleFonts.poppins(
                                          color: TaskMaster_page_controller
                                              .date_filter.value ==
                                              "ALL"
                                              ? AllColors.whiteColor
                                              : AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onPressed: () {
                                      TaskMaster_page_controller
                                          .date_filter.value = "ALL";
                                      TaskMaster_page_controller.pageNumber = 0;
                                      TaskMaster_page_controller.is_done.value =
                                      0;
                                      TaskMaster_page_controller
                                          .getTaskMaster(
                                          TaskMaster_page_controller.pageNumber,
                                          TaskMaster_page_controller.is_Active
                                              .toString(),
                                          '',
                                          '',
                                          TaskMaster_page_controller.Task_status_controller.value.text,
                                          TaskMaster_page_controller.date_filter,
                                          TaskMaster_page_controller.is_done
                                              .value);
                                    }, //Text
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  /*Obx(() {
                  print("loading ${TaskMaster_page_controller.loading.value}");
                  return Visibility(
                    visible: TaskMaster_page_controller.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.green,
                      color: AllColors.textColor,
                    ),
                  );
                }),*/
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                      child: Obx(() {
                        return BindCustomerListView(context);
                      }),
                    ),
                  )


                ],
              ),
            ),
          ));
        })

      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (TaskMaster_page_controller.Task_Master_list.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (TaskMaster_page_controller.total_rows /
              TaskMaster_page_controller.rowsPerPage)
              .toInt();
          if ((TaskMaster_page_controller.total_rows %
              TaskMaster_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${TaskMaster_page_controller
                  .pageNumber} ${TaskMaster_page_controller
                  .total_rows} ${TaskMaster_page_controller
                  .rowsPerPage} ${total_page}");

          /*if (TaskMaster_page_controller.pageNumber + 1 != total_page) {
            TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber +1, TaskMaster_page_controller.is_Active.toString(), '', '', '');
            this.TaskMaster_page_controller.pageNumber += 1;
          }*/

          if (TaskMaster_page_controller.pageNumber + 1 < total_page) {
            TaskMaster_page_controller.getTaskMaster(
                TaskMaster_page_controller.pageNumber + 1,
                TaskMaster_page_controller.is_Active.toString(),
                '',
                '',
                TaskMaster_page_controller.Task_status_controller.text
                    .toString()
                ,
                TaskMaster_page_controller.date_filter,
                TaskMaster_page_controller.is_done.value);
            TaskMaster_page_controller.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          separatorBuilder: (context, index) =>
              Divider(
                height: .05,
                color: Colors.transparent,
              ),
          shrinkWrap: true,
          itemCount: TaskMaster_page_controller
              .Task_Master_list.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png", width: 300, height: 180,),
      );
    }
  }
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
  Widget BindCustomerRequestListView(context, int position) {
    String taskStatus = TaskMaster_page_controller.Task_Master_list[position].taskStatus!.toLowerCase();

    int IsReadyForApprove = TaskMaster_page_controller
        .Task_Master_list[position].isReadyForApprove!;
    String pipeLine = TaskMaster_page_controller.Task_Master_list[position]
        .taskDueTime!.isNotEmpty ? "|" : "";
    // Determine the color based on taskStatus

    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            print('task id......${TaskMaster_page_controller.Task_Master_list[position].taskId}');
            TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId, 'View', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
          },
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Task Status: ", value: TaskMaster_page_controller.Task_Master_list[position].taskStatus??"",),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Customer Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: InkWell(
                      child: Tooltip(
                        message: TaskMaster_page_controller
                            .Task_Master_list[position]
                            .accountName ?? "",
                        child: Text(
                          TaskMaster_page_controller
                              .Task_Master_list[position]
                              .accountName ??
                              "" + " | ${TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .accountName ?? ""}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,),
                        ),
                      ),
                      onTap: () {
                        account_vm_controller.view = 'FromTaskMainScreen';
                        contact_vm_controller.view = 'VIEWMainScreen';
                        account_vm_controller.getAccMasterBuyCodeApi(
                            TaskMaster_page_controller.Task_Master_list[position]
                                .accountCode);
                      },
                    ),
                  ),
                ],
              ),
              _buildLabelWithValue(label: "Customer Code: ", value: TaskMaster_page_controller.Task_Master_list[position].accountCode??"",),
              _buildLabelWithValue(label: "Contact Name: ", value: TaskMaster_page_controller.Task_Master_list[position].contactName??"",),
              _buildLabelWithValue(label: "Task Owner: ", value: TaskMaster_page_controller.Task_Master_list[position].taskOwner??"",),
              _buildLabelWithValue(label: "Task Due Date: ", value: StaticMethod.onlyDate(TaskMaster_page_controller.Task_Master_list[position].taskDueDate??""),),
              _buildLabelWithValue(label: "Type Of Call: ", value: TaskMaster_page_controller.Task_Master_list[position].typeOfCall??"",),
              _buildLabelWithValue(label: "Type Of Mode of Call: ", value: TaskMaster_page_controller.Task_Master_list[position].methodOfCall??"",),
              _buildLabelWithValue(label: "Last Activity Status: ", value: TaskMaster_page_controller.Task_Master_list[position].lastActivityStatus??"",),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sale Cycle ID : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[position]
                          .salesCycleId ?? "",
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    onTap: () {
                      salesCycleController.pageNumber = 0;
                      salesCycleController.clearSaleProductListController();
                      salesCycleController.filterQuoteAcceptedFlag.value="";
                      salesCycleController.clearAllFieldOfFilter();
                      salesCycleController.getsalesCycleData(
                          salesCycleController.pageNumber,
                          TaskMaster_page_controller
                              .Task_Master_list[position]
                              .salesCycleId!, "ViewHeader", 'FromTaskScreen');
                      salesCycleController.getSaleCycleProductByIdList(
                          salesCycleController.pageNumber,
                          TaskMaster_page_controller
                              .Task_Master_list[position].salesCycleId ?? "");

                      /*     salesCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(
                          salesCycleController.pageNumber ,
                          TaskMaster_page_controller
                              .Task_Master_list[position].salesCycleId ?? "");*/

                      salesCycleController.itemCategorySelectedlist.value = [];
                      salesCycleController.getPurchaseProcessApi();
                      salesCycleController.getPurchaseTimeFrameApi();
                      salesCycleController.getItemCategoryMstApi(
                          TaskMaster_page_controller.Task_Master_list[position].salesCycleId!,
                          TaskMaster_page_controller.Task_Master_list[position].taskId!,"");
                      salesCycleController.ProductCategoryWiseAmtGet(0,
                          TaskMaster_page_controller.Task_Master_list[position]
                              .salesCycleId!);
                    },
                  ),
                ],
              ),
              _buildLabelWithValue(label: "Product Category: ", value: TaskMaster_page_controller.Task_Master_list[position].productCategory??"",),
              _buildLabelWithValue(label: "Company Profile Type: ", value: TaskMaster_page_controller.Task_Master_list[position].companyProfileType??"",),
              //_buildLabelWithValue(label: "Account Category Type: ", value: TaskMaster_page_controller.Task_Master_list[position].acc??"",),
              _buildLabelWithValue(label: "Along With Person Name: ", value: TaskMaster_page_controller.Task_Master_list[position].alongWithPersonName??"",),
              _buildLabelWithValue(label: "Pin Code: ", value: TaskMaster_page_controller.Task_Master_list[position].postCode??"",),
              _buildLabelWithValue(label: "District: ", value: TaskMaster_page_controller.Task_Master_list[position].district??"",),
              _buildLabelWithValue(label: "Cluster Name: ", value: TaskMaster_page_controller.Task_Master_list[position].clustureHeadValue??"",),
              _buildLabelWithValue(label: "Region Name: ", value: TaskMaster_page_controller.Task_Master_list[position].branchHeadValue??"",),
              _buildLabelWithValue(label: "Task Remarks: ", value: TaskMaster_page_controller.Task_Master_list[position].taskRemarks??"",),
              _buildLabelWithValue(label: "Purpose Of Visit: ", value: TaskMaster_page_controller.Task_Master_list[position].purposeOfVisit??"",),
              _buildLabelWithValue(label: "Last Activity Updated On: ", value: TaskMaster_page_controller.Task_Master_list[position].lastActivityUpdatedOn??"",),
              _buildLabelWithValue(label: "Created On: ", value:StaticMethod.onlyDate(TaskMaster_page_controller.Task_Master_list[position].createdOn??"") ,),
              _buildLabelWithValue(label: "Reporting Person: ", value: TaskMaster_page_controller.Task_Master_list[position].approvedFullName??"",),
              _buildLabelWithValue(label: "Approved By: ", value: TaskMaster_page_controller.Task_Master_list[position].approvedFullName??"",),
              _buildLabelWithValue(label: "Approved On: ", value: TaskMaster_page_controller.Task_Master_list[position].approvedOn??"",),
              Visibility(
                visible: TaskMaster_page_controller.Task_Master_list[position]
                    .taskStatus == 'Rejected' ? true : false,
                child:  _buildLabelWithValue(label: "Rejected Reason: ", value: TaskMaster_page_controller.Task_Master_list[position].rejectReason??"",),
              ),
              _buildLabelWithValue(label: "Manager Remarks: ", value: TaskMaster_page_controller.Task_Master_list[position].managerRemarks??"",),

            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Task Id : ",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                    Flexible(
                      child: Tooltip(
                        message: TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskId??"",
                        child: Text(
                          TaskMaster_page_controller
                              .Task_Master_list[position]
                              .taskId??"",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            //color: getStatusColor(taskStatus),
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  taskStatus == 'pending for approval' ?
                  InkWell(
                    onTap: () {
                      if (IsReadyForApprove == 1) {
                        showApprovRejectDialog(context, TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskId!);
                      } else {
                        TaskMaster_page_controller.getTaskMaster(
                            0,
                            TaskMaster_page_controller.is_Active.toString(),
                            TaskMaster_page_controller.Task_Master_list[position]
                                .taskId,
                            'View',
                            'GET FROM TASK ID',
                            TaskMaster_page_controller.date_filter,
                            TaskMaster_page_controller.is_done.value);
                      }
                    },
                    child: Icon(Icons.update, color: Colors.blue,),
                  ) : (taskStatus.toLowerCase() == 'approved' || taskStatus.toLowerCase() == 'rejected' ? InkWell(
                    onTap: () {
                      TaskMaster_page_controller.getTaskMaster(
                          0,
                          TaskMaster_page_controller.is_Active.toString(),
                          TaskMaster_page_controller.Task_Master_list[position].taskId,
                          'View',
                          'GET FROM TASK ID',
                          TaskMaster_page_controller.date_filter,
                          TaskMaster_page_controller.is_done.value);

                      // TaskMaster_page_controller.getTaskMstDSARList(TaskMaster_page_controller.Task_Master_list[position].taskId);
                      // TaskMaster_page_controller.getItemCategoryMstApi(TaskMaster_page_controller.Task_Master_list[position].taskId);
                    },
                    child: Icon(Icons.remove_red_eye_outlined, color: Colors.blue,),
                  ) : SizedBox()),

                  Obx(() {
                    return Visibility(
                      visible: TaskMaster_page_controller.isAdminWritePermission.value == "1" &&
                          TaskMaster_page_controller.isHeadofficePermission.value == "0",
                      child: GestureDetector(
                        onTap: () => showConfirmCompleteDialog(context, position!),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    );
                  }),
                ],
              ),

            ],
          )

      ),
    );
  }
  Widget _buildLabelWithValue({
    required String label,
    required String? value,
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
          child: Tooltip(
            message: value??"",
            child: Text(
              value ?? "",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color:label=="Task Status: "? getStatusColor(value!):color,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  showConfirmCompleteDialog(BuildContext context, int index){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade100, // light red background
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 28,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delete",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700),
                    ),
                    Text("Do You Want to Delete This Task?",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                      softWrap: true,
                    ),
                  ],
                ),
              ),

            ],
          ),

          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                //print("position account master.....${index}");
                TaskMaster_page_controller.TaskMstDelete(index);
              },
              child: Text("Delete",style: TextStyle(color: AllColors.greenblue),),
            ),
          ],
        );
      },
    );
  }

  showApprovRejectDialog(context, String TaskId) {
    TaskMaster_page_controller.ApproveReject_Controller.clear();
    TaskMaster_page_controller.RejectReason_Controller.clear();
    TaskMaster_page_controller.managerRemarksController.value.clear();
    TaskMaster_page_controller.ApproveBool.value = false;
    TaskMaster_page_controller.RejectBool.value = false;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: TaskMaster_page_controller.ApproveBool.value,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: () {
                              if (TaskMaster_page_controller
                                  .ApproveReject_Controller.text.isEmpty ||
                                  TaskMaster_page_controller
                                      .ApproveReject_Controller == null) {
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
                                /*TaskMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
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
                      Obx(() {
                        return Visibility(
                            visible: TaskMaster_page_controller.RejectBool
                                .value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                    Color>(
                                  AllColors.lightredColor,
                                ),
                              ),
                              onPressed: () {
                                if (TaskMaster_page_controller
                                    .ApproveReject_Controller.text ==
                                    "Reject") {
                                  if (TaskMaster_page_controller
                                      .RejectReason_Controller.text.isEmpty ||
                                      TaskMaster_page_controller
                                          .RejectReason_Controller == null) {
                                    Utils.sanckBarError('Error : ',
                                        'Please Enter Reject Reason.');
                                  } else {
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
                                  /*TaskMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
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

  ConfirmationDialog(context, String taskId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
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
                            onPressed: () {
                              Get.back();
                              TaskMaster_page_controller.RejectReason_Controller
                                  .clear();
                              //TaskMaster_page_controller.ApproveReject_Controller.clear();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*TaskMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
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
                            onPressed: () {
                              TaskMaster_page_controller.ApproveRejectApiHit(
                                  taskId);
                              Navigator.pop(context);
                              /*TaskMaster_page_controller.pageNumber=0;
                          TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.is_Active.toString(), '', '', '');
                          Get.toNamed(RoutesName.taskMaster_screen);*/
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                /*TaskMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
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
        if (TaskMaster_page_controller.ApproveReject_Controller.text ==
            'Approve') {
          TaskMaster_page_controller.ApproveReject = "Approved";
          TaskMaster_page_controller.RejectBool.value = false;
          TaskMaster_page_controller.ApproveBool.value = true;
        } else {
          TaskMaster_page_controller.ApproveReject = "Rejected";
          TaskMaster_page_controller.RejectBool.value = true;
          TaskMaster_page_controller.ApproveBool.value = false;
        }
        //print('IsActive.....${TaskMaster_page_controller.IsActive_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            onTap: () {
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
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Task Status',
              labelText: 'Task Status',
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
            elevation: 4.0,
            child: Container(
              width: size.width * .5,
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


  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                //mainAxisSize: MainAxisSize.min, // Ensure minimal height
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_moon_rounded,
                          color: AllColors.primaryDark1,),
                        SizedBox(width: 5,),
                        Text(
                          "Filter ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Icon(
                              Icons.cancel,
                              color: AllColors.primaryDark1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                      child: Divider(
                        height: 1,
                        color: AllColors.primaryDark1,
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 5,),
                              bindTaskStatusDropDown(context),
                              SizedBox(height: 10,),
                              bindFilterData(context,'Task Id',TaskMaster_page_controller.filterTask_Id_controller),
                              SizedBox(height: 5,),
                              bindFilterData(context,'Customer Name',TaskMaster_page_controller.account_Name_controller),
                              SizedBox(height: 10,),
                              bindFilterData(context,'Customer Code',TaskMaster_page_controller.account_code_controller),
                              SizedBox(height: 10,),
                              bindTypeOfCallDropDown(context),
                              SizedBox(height: 10,),
                              bindMethodOfCallDropDown(context),
                              SizedBox(height: 10,),
                              bindCompProfileTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindLastActivityStatus(context),
                              SizedBox(height: 10,),
                              bindSaleCycleActiveDropDown(context),
                              SizedBox(height: 10,),
                              bindFilterData(context,'Sale Cycle Id',TaskMaster_page_controller.Sale_cycle_Id_controller),
                              SizedBox(height: 10,),
                              bindProductCategoryDropDown(context),
                              SizedBox(height: 10,),
                              bindProductCategoryTypeDropDown(context),
                              SizedBox(height: 10,),
                              filterWithTaskDueDate(context),
                              SizedBox(height: 10,),
                              bindFilterData(context,'Pin Code',TaskMaster_page_controller.postalCodeController.value),
                              SizedBox(height: 10,),
                              bindFilterData(context,'District',TaskMaster_page_controller.district_controller.value),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindTaskOwnerFilter(context),
                              SizedBox(height: 10,),
                              bindCreatedOn(context),
                              SizedBox(height: 10,),
                              bindFilterData(context,'Approved By',TaskMaster_page_controller.approved_by_controller.value),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: _buildButton(
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            Get.back();
                            TaskMaster_page_controller.resetAllFieldOfFilter();
                            TaskMaster_page_controller.clearFilterData();
                            TaskMaster_page_controller.pageNumber = 0;
                            TaskMaster_page_controller.getTaskMaster(
                                TaskMaster_page_controller.pageNumber,
                                TaskMaster_page_controller.is_Active.toString(),
                                '',
                                '',
                                TaskMaster_page_controller.Task_status_controller.text.toString(),
                                TaskMaster_page_controller.date_filter,
                                TaskMaster_page_controller.is_done.value);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            TaskMaster_page_controller.getTaskMaster(
                                TaskMaster_page_controller.pageNumber,
                                TaskMaster_page_controller.is_Active.toString(),
                                '',
                                '',
                                TaskMaster_page_controller.Task_status_controller.text.toString(),
                                TaskMaster_page_controller.date_filter,
                                TaskMaster_page_controller.is_done.value);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            TaskMaster_page_controller.SaveFilterData();
                          },
                        )),
                      ],
                    ),
                  ),
                 
                ],
              ),
            );
          },

        );
      },
    );
  }

  Widget _buildButton({
    required String text,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AllColors.whiteColor,
        foregroundColor: AllColors.lightgreyColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      onPressed: onTap,
      child: Center(
        child: FittedBox( // 🔥 PREVENTS OVERFLOW
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  bindFilterData(BuildContext context, String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: labelText,
          hintText: labelText,
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindLastActivityStatus(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.lastActivityStatus_Controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.lastActivityStatus_Controller.value.text.split('|');

        TaskMaster_page_controller.selectedDSARStatusList.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: TaskMaster_page_controller.DSARStatus_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: TaskMaster_page_controller.selectedDSARStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText:
            TaskMaster_page_controller.selectedDSARStatusList.isNotEmpty
                ? "Last Activity Status"
                : null,
            hintText: "Last Activity Status",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Last Activity Status",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          TaskMaster_page_controller.selectedDSARStatusList.value = selectedList;
          TaskMaster_page_controller.lastActivityStatus_Controller.value.text =
              selectedList.map((e) => e.taskStatus).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }


  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = TaskMaster_page_controller.clusterGetByEmailList;
      if (TaskMaster_page_controller.clusterName_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.clusterName_controller.value.text.split('|');
        TaskMaster_page_controller.SelectedCluster_list.value =[];
        TaskMaster_page_controller.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && TaskMaster_page_controller.SelectedCluster_list.isEmpty) {
          TaskMaster_page_controller.SelectedCluster_list.assignAll(availableItems);
          TaskMaster_page_controller.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          TaskMaster_page_controller.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = TaskMaster_page_controller.SelectedCluster_list;
      final selectedText = selected.isEmpty
          ? null
          : selected.map((e) => e.geoValue).join(', ');

      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              final searchController = TextEditingController();
              final tempSelected = <ClusterModal>[];
              tempSelected.addAll(TaskMaster_page_controller.SelectedCluster_list);

              List<ClusterModal> allItems =
                  TaskMaster_page_controller.clusterGetByEmailList;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? allItems
                    : allItems
                    .where((c) =>
                    (c.geoValue ?? "").toLowerCase().contains(query))
                    .toList();

                final allSelected =
                    allItems.isNotEmpty && tempSelected.length == allItems.length;

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Select Clusters',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: AllColors.primaryDark1),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))
                            ],
                          ),
                        ),

                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                            ),
                            onChanged: (v) => setState(() {}),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title: const Text('Select All'),
                            value: allSelected,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  tempSelected
                                      .clear();
                                  tempSelected.addAll(allItems);
                                } else {
                                  tempSelected.clear();
                                }
                              });
                            },
                          ),
                        ),

                        const Divider(height: 1),

                        // List
                        Expanded(
                          child: filtered.isEmpty
                              ? const Center(child: Text('No clusters found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.geoValue ?? "") ==
                                  (item.geoValue ?? ""));
                              return CheckboxListTile(
                                title: Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) =>
                                      (s.geoValue ?? "") ==
                                          (item.geoValue ?? ""));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        // Done button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.green,
                                    shadowColor: AllColors.green,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {

                                    TaskMaster_page_controller.filterDataChecker.value='';
                                    TaskMaster_page_controller.SelectedCluster_list.assignAll(tempSelected);
                                    TaskMaster_page_controller.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    TaskMaster_page_controller.getRegionsWithClusterFilterGetByEmail();

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Done',style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: "Cluster Name", // 👈 Label restored here
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Row(
            children: [
              Expanded(
                child: selectedText == null
                    ? Text(
                  "Select Cluster",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: AllFontSize.sisxteen,
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    });
  }
  Widget bindRegionNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = TaskMaster_page_controller.regionwithclusterGetByEmailList;
      if (TaskMaster_page_controller.RegionName_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        TaskMaster_page_controller.SelectedRegion_list.value=[];
        List<String> nameList = TaskMaster_page_controller.RegionName_controller.value.text.split('|');
        TaskMaster_page_controller.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && TaskMaster_page_controller.SelectedRegion_list.isEmpty) {
          TaskMaster_page_controller.SelectedRegion_list.assignAll(availableItems);
          TaskMaster_page_controller.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join(',');
          print("bind region ${TaskMaster_page_controller.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = TaskMaster_page_controller.SelectedRegion_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) => e.geoValue).join(', ');

      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              final searchController = TextEditingController();
              final tempSelected = <RegionWithClusterFilterModal>[];
              tempSelected.addAll(TaskMaster_page_controller.SelectedRegion_list);

              final allItems = TaskMaster_page_controller.regionwithclusterGetByEmailList;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty ? allItems : allItems.where((c) => (c.geoValue ?? "").toLowerCase().contains(query)).toList();

                final allSelected = allItems.isNotEmpty && tempSelected.length == allItems.length;

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Select Regions',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: AllColors.primaryDark1),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))
                            ],
                          ),
                        ),

                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                            ),
                            onChanged: (v) => setState(() {}),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title: const Text('Select All'),
                            value: allSelected,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  tempSelected.clear();
                                  tempSelected.addAll(allItems);
                                } else {
                                  tempSelected.clear();
                                }
                              });
                            },
                          ),
                        ),

                        const Divider(height: 1),

                        // List
                        Expanded(
                          child: filtered.isEmpty
                              ? const Center(child: Text('No regions found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.geoValue ?? "") ==
                                  (item.geoValue ?? ""));
                              return CheckboxListTile(
                                title: Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) =>
                                      (s.geoValue ?? "") ==
                                          (item.geoValue ?? ""));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        // Done button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.green,
                                    shadowColor: AllColors.green,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    TaskMaster_page_controller.filterDataChecker.value='';
                                    TaskMaster_page_controller.SelectedRegion_list.assignAll(tempSelected);
                                    TaskMaster_page_controller.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Done',style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: "Region Name", // 👈 Label like before
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Row(
            children: [
              Expanded(
                child: selectedText == null
                    ? Text(
                  "Select Region",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: AllFontSize.sisxteen,
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    });
  }

  bindTaskOwnerFilter(BuildContext context) {
    return Obx((){
      if (TaskMaster_page_controller.AccountOwner_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.AccountOwner_controller.value.text.split(',');

        TaskMaster_page_controller.SelectedEmployee_Member_list.value =
            List.generate(nameList.length, (index) {
              return EmployeeMemberModel(
                fullName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: TaskMaster_page_controller.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: TaskMaster_page_controller.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.SelectedEmployee_Member_list.isNotEmpty?"Account Owner":null,
            hintText: "Task Owner",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              " Task Owner",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.fullName).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<EmployeeMemberModel> selectedList) {
          TaskMaster_page_controller.SelectedEmployee_Member_list.value =
              selectedList;
          TaskMaster_page_controller.AccountOwner_controller.value.text =
              selectedList.map((e) => e.fullName).join(', ');
        },

        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          itemBuilder: (context, item, isSelected) =>
              ListTile(
                title: Text(item.fullName??""),
              ),
        ),
      );
    });

  }


  Widget bindTaskStatusDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: TaskMaster_page_controller.Task_status_controller,
      label: Text(
        "Task Status",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.sisxteen,
            fontWeight: FontWeight.w500),
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
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
      ),
      onSelected: (String? selection) {
        print(selection);
        TaskMaster_page_controller.Task_status_controller.text =
            _displayTaskStatusForOption(selection!).toString();
      },

      dropdownMenuEntries: TaskMaster_page_controller.TaskStatusListTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );
  }

  Widget bindSaleCycleActiveDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size
          .width - 15,
      controller: TaskMaster_page_controller.SaleCycleActive_Controller,
      label: Text(
        "Sale Cycle Active",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.sisxteen,
            fontWeight: FontWeight.w500),
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
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
      ),
      onSelected: (String? selection) {
        print(selection);
        TaskMaster_page_controller.SaleCycleActive_Controller.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },

      dropdownMenuEntries: TaskMaster_page_controller.SaleCycleActiveTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

    //todo commented by nirupma
    /*return Autocomplete<String>(
      displayStringForOption: _displaySaleCycleActiveForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.SaleCycleActiveTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.SaleCycleActiveTypeList
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
        TaskMaster_page_controller.SaleCycleActive_Controller.text =
            _displaySaleCycleActiveForOption(selection).toString();
        print('IsActive.....${TaskMaster_page_controller
            .SaleCycleActive_Controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = TaskMaster_page_controller.SaleCycleActive_Controller
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: () {
                  if (focusNode.hasFocus) {
                    focusNode.unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Sale Cycle Active',
              labelText: 'Sale Cycle Active',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.sisxteen),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
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
    );*/
  }


  filterWithTaskDueDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.filterTaskDuedateController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Due Date',
        labelText: 'Due Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.sisxteen),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1,
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final startDate = DateFormat('yyyy-MM-dd').format(picked.start);
          final endDate = DateFormat('yyyy-MM-dd').format(picked.end);
          TaskMaster_page_controller.createdOnStartToEnd.value="$startDate@$endDate";
          TaskMaster_page_controller.filterTaskDuedateController.value.text = '$startDate - $endDate';
        } else {
          TaskMaster_page_controller.filterTaskDuedateController.value.text = '';
          TaskMaster_page_controller.createdOnStartToEnd.value="";
        }
      },
    );
  }


  bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: TaskMaster_page_controller.filterTaskCreationOnController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Created On',
            labelText: 'Created On',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime start_date = new DateTime(1900);
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(
                      primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            TaskMaster_page_controller.filterTaskCreationOnController.value.text = outputFormat.format(date);
          else
            TaskMaster_page_controller.filterTaskCreationOnController.value.text = "";
        }

    );
  }
  bindTypeOfCallDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.Type_of_call_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.Type_of_call_controller.value.text.split('|');

        TaskMaster_page_controller.Selection_CallStatus_Master_list.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: TaskMaster_page_controller.CallStatus_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: TaskMaster_page_controller.Selection_CallStatus_Master_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.Selection_CallStatus_Master_list.isNotEmpty ? "Type Of Call" : null,
            hintText:  "All" ,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty) {
            return Text(
              "All",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          TaskMaster_page_controller.Selection_CallStatus_Master_list.value = selectedList;
          TaskMaster_page_controller.Type_of_call_controller.value.text =
              selectedList.where((e) => e.taskStatus?.toLowerCase() != 'all').map((e) => e.taskStatus).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }
  bindMethodOfCallDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.method_of_call_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.method_of_call_controller.value.text.split('|');

        TaskMaster_page_controller.Selection_MethodOfCall_Master_list.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: TaskMaster_page_controller.MethodOfCall_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: TaskMaster_page_controller.Selection_MethodOfCall_Master_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.Selection_MethodOfCall_Master_list.isNotEmpty ? "Mode Of Call" : null,
            hintText: "All",
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "All",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          TaskMaster_page_controller.Selection_MethodOfCall_Master_list.value = selectedList;
          TaskMaster_page_controller.method_of_call_controller.value.text =
              selectedList.where((e) => e.taskStatus?.toLowerCase() != 'all').map((e) => e.taskStatus).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }

  bindProductCategoryDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.product_category_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.product_category_controller.value.text.split('|');
        TaskMaster_page_controller.Selected_Item_Category_master_list_without_task.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: TaskMaster_page_controller.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: TaskMaster_page_controller.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
            hintText:  "Product Category" ,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty) {
            return Text(
              "Product Category",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.categoryName).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<ItemCategoryMstModel> selectedList) {
          TaskMaster_page_controller.Selected_Item_Category_master_list_without_task.value = selectedList;
          TaskMaster_page_controller.product_category_controller.value.text =
              selectedList.map((e) => e.categoryName).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.categoryName ?? ""),
          ),
        ),
      );
    });
  }
  Widget bindProductCategoryTypeDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: TaskMaster_page_controller.product_category_type_Controller.value,
      label: Text(
        "Product Category Type",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.sisxteen,
            fontWeight: FontWeight.w500),
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
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
      ),
      onSelected: (String? selection) {
        print(selection);
        TaskMaster_page_controller.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: TaskMaster_page_controller.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }

  bindCompProfileTypeDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.companyProfileTypeController.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.companyProfileTypeController.value.text.split('|');

        TaskMaster_page_controller.selected_company_type_list.value =
            List.generate(nameList.length, (index) {
              return CompanyTypeModal(
                description: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CompanyTypeModal>.multiSelection(
        items: TaskMaster_page_controller.company_profile_type_list,
        itemAsString: (CompanyTypeModal u) => u.description ?? "",
        selectedItems: TaskMaster_page_controller.selected_company_type_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.selected_company_type_list.isNotEmpty ? "Company Profile Type" : null,
            hintText: "Company Profile Type",
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Company Profile Type",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.description).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CompanyTypeModal> selectedList) {
          TaskMaster_page_controller.selected_company_type_list.value = selectedList;
          TaskMaster_page_controller.companyProfileTypeController.value.text =
              selectedList.map((e) => e.description).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.description ?? ""),
          ),
        ),
      );
    });
  }



}
