

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../component/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
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
                IconButton(onPressed: () {
                  //TaskMaster_page_controller.clearCreateTaskController();
                  TaskMaster_page_controller
                      .getItemCategoryMstWithoutTaskIdApi();
                  TaskMaster_page_controller.getEmpMstEmailByApi();
                  Get.toNamed(RoutesName.addNewTaskMaster_screen);
                }, icon: Icon(Icons.add)),


                IconButton(onPressed: () {
                  TaskMaster_page_controller.Task_status_controller.text =
                  "All";
                  TaskMaster_page_controller.isInfraLeadFilterController.text =
                  "All";
                  TaskMaster_page_controller.SaleCycleActive_Controller.text =
                  "All";
                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: TaskMaster_page_controller.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
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
                                  color: TaskMaster_page_controller.is_done
                                      .value == 0 &&
                                      TaskMaster_page_controller.filter.value ==
                                          'Running'
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
                              TaskMaster_page_controller
                                  .date_filter.value = "Today";
                              TaskMaster_page_controller
                                  .is_done.value = 0;
                              TaskMaster_page_controller
                                  .filter.value = "Running";
                              TaskMaster_page_controller
                                  .getTaskMaster(
                                  TaskMaster_page_controller.pageNumber,
                                  TaskMaster_page_controller.is_Active
                                      .toString(),
                                  '',
                                  '',
                                  '',
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
                            is_done.value == 1 &&
                                TaskMaster_page_controller.filter.value ==
                                    'Completed'
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
                              TaskMaster_page_controller
                                  .isInfraLeadFilterController.text = "All";
                              TaskMaster_page_controller
                                  .SaleCycleActive_Controller.text = "All";
                              TaskMaster_page_controller.pageNumber = 0;
                              TaskMaster_page_controller.is_done.value = 1;
                              TaskMaster_page_controller.date_filter.value = "";
                              TaskMaster_page_controller
                                  .filter.value = "Completed";
                              TaskMaster_page_controller
                                  .getTaskMaster(
                                  TaskMaster_page_controller.pageNumber,
                                  TaskMaster_page_controller.is_Active
                                      .toString(),
                                  '',
                                  '',
                                  '',
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
                                  '',
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
                                      '',
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
                                        '',
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
                                        '',
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
                                        '',
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

                Obx(() {
                  return Visibility(
                    visible: TaskMaster_page_controller.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
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
        ),
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
        child: Image.asset(
          "assests/images/no_data_remove.png", width: 300, height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    String taskStatus = TaskMaster_page_controller.Task_Master_list[position]
        .taskStatus!;

    int IsReadyForApprove = TaskMaster_page_controller
        .Task_Master_list[position].isReadyForApprove!;
    String pipeLine = TaskMaster_page_controller.Task_Master_list[position]
        .taskDueTime!.isNotEmpty ? "|" : "";
    // Determine the color based on taskStatus
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
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            print('task id......${TaskMaster_page_controller.Task_Master_list[position].taskId}');
            TaskMaster_page_controller.getTaskMaster(
                0,
                TaskMaster_page_controller.is_Active.toString(),
                TaskMaster_page_controller.Task_Master_list[position].taskId,
                'View',
                'GET FROM TASK ID',
                TaskMaster_page_controller.date_filter,
                TaskMaster_page_controller.is_done.value);
          },
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Task Status : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .taskStatus!,
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskStatus!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: getStatusColor(taskStatus),
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Task Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .taskId!,
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskId!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Manager Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    TaskMaster_page_controller
                        .Task_Master_list[position]
                        .approvedFullName!,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Name : ",
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
                    ),
                    onTap: () {
                      account_vm_controller.view = 'FromTaskMainScreen';
                      contact_vm_controller.view = 'VIEWMainScreen';
                      account_vm_controller.getAccMasterBuyCodeApi(
                          TaskMaster_page_controller.Task_Master_list[position]
                              .accountCode);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Contact Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .contactName!,
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .contactName!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Type Of Call : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .typeOfCall!,
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .typeOfCall!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
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
                      salesCycleController.getsalesCycleData(
                          salesCycleController.pageNumber,
                          TaskMaster_page_controller
                              .Task_Master_list[position]
                              .salesCycleId!, "ViewHeader", 'FromTaskScreen');
                      salesCycleController.getSaleCycleProductByIdList(
                          salesCycleController.pageNumber,
                          TaskMaster_page_controller
                              .Task_Master_list[position].salesCycleId ?? "");
                      salesCycleController.itemCategorySelectedlist.value = [];
                      salesCycleController.getPurchaseProcessApi();
                      salesCycleController.getPurchaseTimeFrameApi();
                      salesCycleController.getItemCategoryMstApi(
                          TaskMaster_page_controller.Task_Master_list[position]
                              .salesCycleId!,
                          TaskMaster_page_controller.Task_Master_list[position]
                              .taskId!);
                      salesCycleController.ProductCategoryWiseAmtGet(0,
                          TaskMaster_page_controller.Task_Master_list[position]
                              .salesCycleId!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Method of Call : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .methodOfCall!,
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .methodOfCall!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Product Category : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .productCategory ?? "",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .productCategory ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Created By : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .createdFullName! +
                          "| ${StaticMethod.dateTimeToDate(
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .createdOn!)}",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .createdFullName! +
                            "| ${StaticMethod.dateTimeToDate(
                                TaskMaster_page_controller
                                    .Task_Master_list[position]
                                    .createdOn!)}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Due Date : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .taskDueDate,
                      child: Text(" ${TaskMaster_page_controller
                          .Task_Master_list[position]
                          .taskDueDate ??
                          ""} ${pipeLine} ${TaskMaster_page_controller
                          .Task_Master_list[position]
                          .taskDueTime } "
                        ,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Is Infra Lead : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    TaskMaster_page_controller
                        .Task_Master_list[position].isInfraLead == 1
                        ? "Yes"
                        : "No",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Remarks : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position].taskRemarks ?? "",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position].taskRemarks ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),

                    ),
                  ),
                ],
              ),
              Visibility(
                visible: TaskMaster_page_controller.Task_Master_list[position]
                    .taskStatus == 'Rejected' ? true : false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Rejected Reason : ",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Tooltip(
                        message: TaskMaster_page_controller
                            .Task_Master_list[position]
                            .rejectReason!,
                        child: Text(
                          TaskMaster_page_controller
                              .Task_Master_list[position]
                              .methodOfCall!,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Method of Call : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[position]
                        .methodOfCall!,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[position]
                          .methodOfCall!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),*/
            ],
          ),

          /*trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                if(IsReadyForApprove == 1){
                  showApprovRejectDialog(context, TaskMaster_page_controller
                      .Task_Master_list[position]
                      .taskId!);
                }else {
                  TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId , 'View', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
                }
              },
              child: Icon(Icons.update,  color: Colors.blue,),
            ),
            InkWell(
              onTap: (){
                TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId , 'View', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);

              },
              child: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
            )
          ],
        ),*/
          trailing: taskStatus == 'PENDING FOR APPROVAL' ?
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
          ) : SizedBox())

      ),
    );
  }

  showApprovRejectDialog(context, String TaskId) {
    TaskMaster_page_controller.ApproveReject_Controller.clear();
    TaskMaster_page_controller.RejectReason_Controller.clear();
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
    //accountMaster_page_controller.IsActive_controller.clear();
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
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
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
                              SizedBox(
                                height: 5,
                              ),
                              bindTaskStatusDropDown(context),
                              SizedBox(
                                height: 10,
                              ),
                              bindTaskId(),
                              SizedBox(
                                height: 5,
                              ),
                              bindAccountName(),
                              SizedBox(
                                height: 10,
                              ),
                              bindAccountCode(),
                              SizedBox(
                                height: 10,
                              ),

                              bindTypeOfCall(),
                              SizedBox(
                                height: 10,
                              ),
                              bindMethodOfcall(),
                              SizedBox(
                                height: 10,
                              ),
                              bindCompProfileTypeDropDown(),
                              SizedBox(
                                height: 10,
                              ),
                              bindIsInfraLeadDropDown(context),
                              SizedBox(
                                height: 10,
                              ),
                              bindLastActivityStatus(),
                              SizedBox(
                                height: 10,
                              ),
                              bindSaleCycleActiveDropDown(context),
                              SizedBox(
                                height: 10,
                              ),

                              bindSaleCycleId(),
                              SizedBox(height: 10,),
                              bindProductCategory(),
                              SizedBox(
                                height: 10,
                              ),
                              bindCreatedOn(context),

                              SizedBox(
                                height: 10,
                              ),
                              bindCreatedBy(),
                              SizedBox(height: 10,),

                              filterAccountOwner(),
                              SizedBox(height: 10,),

                              /*  filterIsClosedCompleted(),
                              SizedBox(height: 10,),*/

                              /*   filterDayFlag( ),
                              SizedBox(height: 10,),*/

                              filterWithTaskDueDate(context),
                              SizedBox(height: 10,),

                              bindEmailId(),
                              SizedBox(
                                height: 10,
                              ),

                              bindPhoneNo(),
                              SizedBox(
                                height: 10,
                              ),

                              bindPostalCode(),
                              SizedBox(
                                height: 10,
                              ),

                              bindDistrict(),
                              SizedBox(
                                height: 10,
                              ),

                              bindFrontLinerValue(),
                              SizedBox(
                                height: 10,
                              ),

                              bindBranchHead(),
                              SizedBox(
                                height: 10,
                              ),

                              bindZoneHead(),
                              SizedBox(
                                height: 10,
                              ),

                              bindClusterHead(),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark,
                                      width: 1),
                                )),
                            onPressed: () {
                              Get.back();
                              TaskMaster_page_controller.pageNumber = 0;
                              TaskMaster_page_controller.getTaskMaster(
                                  TaskMaster_page_controller.pageNumber,
                                  TaskMaster_page_controller.is_Active
                                      .toString(),
                                  '',
                                  '',
                                  TaskMaster_page_controller
                                      .Task_status_controller.text.toString()
                                  ,
                                  TaskMaster_page_controller.date_filter,
                                  TaskMaster_page_controller.is_done.value);
                              //TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.IsActive_controller.text);
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                )),
                            onPressed: () {
                              Get.back();
                              TaskMaster_page_controller.resetAllFieldOfFilter();
                              TaskMaster_page_controller.pageNumber = 0;
                              TaskMaster_page_controller.getTaskMaster(
                                  TaskMaster_page_controller.pageNumber,
                                  TaskMaster_page_controller.is_Active
                                      .toString(),
                                  '',
                                  '',
                                  TaskMaster_page_controller
                                      .Task_status_controller.text.toString()
                                  ,
                                  TaskMaster_page_controller.date_filter,
                                  TaskMaster_page_controller.is_done.value);


                              //accountMaster_page_controller.Address_controller.clear();
                              // accountMaster_page_controller.Annual_Revenue_Controller.clear();
                              //accountMaster_page_controller.No_Of_Emp_Controller.clear();
                              //accountMaster_page_controller.no_of_employees_min = '';
                              // accountMaster_page_controller.no_of_employees_max = '';
                              // accountMaster_page_controller.annual_revenue_min = '';
                              //accountMaster_page_controller.annual_revenue_max = '';
                              //accountMaster_page_controller.account_cat_type_controller.clear();

                            },
                            child: Text(
                              'Reset',
                              style: GoogleFonts.poppins(
                                  color: AllColors.redColor,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
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


  bindTaskId() {
    return TextField(
      controller: TaskMaster_page_controller.filterTask_Id_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Task Id',
          hintText: 'Task Id',
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

  bindCompProfileTypeDropDown() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.companyProfileTypeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Company Profile Type',
          hintText: 'Company Profile Type',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindPostalCode() {
    return TextField(
      controller: TaskMaster_page_controller.postalCodeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Postal Code',
          hintText: 'Postal Code',
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

  bindDistrict() {
    return TextField(
      controller: TaskMaster_page_controller.district_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'District',
          hintText: 'District',
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

  bindCreatedBy() {
    return TextField(
      controller: TaskMaster_page_controller.created_by_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Created By',
          hintText: 'Created By',
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

  bindFrontLinerValue() {
    return TextField(
      controller: TaskMaster_page_controller.frontliner_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'FrontLiner Value',
          hintText: 'FrontLiner Value',
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

  bindClusterHead() {
    return TextField(
      controller: TaskMaster_page_controller.cluster_head_value_controller
          .value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Cluster Head Value',
          hintText: 'Cluster Head Value',
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

  bindZoneHead() {
    return TextField(
      controller: TaskMaster_page_controller.zone_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Zone Head Value',
          hintText: 'Zone Head Value',
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

  bindBranchHead() {
    return TextField(
      controller: TaskMaster_page_controller.branch_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Branch Head Value',
          hintText: 'Branch Head Value',
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

  bindAccountCode() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.account_code_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Code',
          hintText: 'Account Code',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindAccountName() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.account_Name_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Name',
          hintText: 'Account Name',
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
  }

  bindEmailId() {
    return TextField(
      controller: TaskMaster_page_controller.EmailId_Controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Email Id',
          hintText: 'Email Id',
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

  bindLastActivityStatus() {
    return TextField(
      controller: TaskMaster_page_controller.lastActivityStatus_Controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Last Activity Status ',
          hintText: 'Last Activity Status',
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

  bindPhoneNo() {
    return TextField(
      controller: TaskMaster_page_controller.PhoneNo_Controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Phone No.',
          hintText: 'Phone No.',
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

  //todo comment code for new filter added in api and filter is not work properly
/*  void showFilterBottomSheet(BuildContext context) {
    TaskMaster_page_controller.pageNumber = 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure minimal height
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_moon_rounded, color: AllColors.primaryDark1,),
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
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        bindTaskStatusDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        TextField(
                          controller: TaskMaster_page_controller.filterTask_Id_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              labelText: 'Task Id',
                              hintText: 'Task Id',
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
                        ),

                        SizedBox(
                          height: 10,
                        ),


                        TextField(
                          controller: TaskMaster_page_controller.account_Name_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                            labelText: 'Account Name',
                            hintText: 'Account Name',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        TextField(
                          controller: TaskMaster_page_controller.Contact_Name_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                            labelText: 'Contact Name',
                            hintText: 'Contact Name',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        TextField(
                          controller: TaskMaster_page_controller.Type_of_call_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                            labelText: 'Type Of Call',
                            hintText: 'Type Of Call',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        bindIsInfraLeadDropDown(context),
                        SizedBox(
                          height: 10,
                        ),
                        bindSaleCycleActiveDropDown(context),
                        SizedBox(
                          height: 10,
                        ),

                        TextField(
                          controller: TaskMaster_page_controller.Sale_cycle_Id_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                            labelText: 'Sale Cycle Id',
                            hintText: 'Sale Cycle Id',
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
                        ),

                        SizedBox(height: 10,),

                        */ /*filterWithTaskCreationOn( context),

                        SizedBox(height: 10,),
                        filterWithTaskDueDate( context),
                        SizedBox(height: 10,),*/ /*

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark,
                                      width: 1),
                                )),
                                onPressed: () {
                                  TaskMaster_page_controller.account_name.value = TaskMaster_page_controller.account_Name_controller.text;
                                  Get.back();
                                  TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.SaleCycleActive_Controller.text, TaskMaster_page_controller.filterTask_Id_controller.text, '', TaskMaster_page_controller.Task_status_controller.text.toString(), TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);


                                },
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                )),
                                onPressed: () {
                                  Get.back();
                                  TaskMaster_page_controller.filterTask_Id_controller.clear();
                                  TaskMaster_page_controller.Task_status_controller.clear();
                                  TaskMaster_page_controller.account_Name_controller.clear();
                                  TaskMaster_page_controller.account_name.value = "";
                                  TaskMaster_page_controller.Contact_Name_controller.clear();
                                  TaskMaster_page_controller.Type_of_call_controller.clear();
                                  TaskMaster_page_controller.SaleCycleActive_Controller.clear();
                                  TaskMaster_page_controller.Sale_cycle_Id_controller.clear();
                                  TaskMaster_page_controller.isInfraLeadFilterController.clear();
                                  TaskMaster_page_controller.filterTaskCreationOnController.value.clear();
                                  TaskMaster_page_controller.filterTaskDuedateController.value.clear();
                                  TaskMaster_page_controller.getTaskMaster(0, 'All', '', '', '',TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);

                                },
                                child: Text(
                                  'Reset',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.redColor,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }*/

  Widget bindTaskStatusDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size
          .width - 15,
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
    //todo commeted by nirupma
    return Autocomplete<String>(
      displayStringForOption: _displayTaskStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.TaskStatusListTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.TaskStatusListTypeList
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
        TaskMaster_page_controller.Task_status_controller.text =
            _displayTaskStatusForOption(selection).toString();
        print('IsActive.....${TaskMaster_page_controller.Task_status_controller
            .text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = TaskMaster_page_controller.Task_status_controller
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
              hintText: 'Task Status',
              labelText: 'Task Status',
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

  Widget bindIsInfraLeadDropDown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size
          .width - 15,
      controller: TaskMaster_page_controller.isInfraLeadFilterController,
      label: Text(
        "Is Infra Lead",
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
        TaskMaster_page_controller.isInfraLeadFilterController.text =
            _displayIsInfraLeadForOption(selection!).toString();
      },

      dropdownMenuEntries: TaskMaster_page_controller.SaleCycleActiveTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );
  }

  void showInfraLeadDetails(context, int position) {
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: size.height / 2,
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
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Infra Lead Details(${TaskMaster_page_controller
                            .Task_Master_list[position].taskId})",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close, color: AllColors.primaryDark1,)),
                    )

                  ],
                ),
              ),
              Center(child: Divider(height: 1, color: AllColors.primaryDark1,)),
              // Obx(() {
              //  return
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position].userRegion ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position].userClusture ??
                                  "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position].projectValue
                                  .toString(),
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .expectedDateOfOrder ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .drawingCollected == 1 ? "Yes" : "No",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .proposalSubmitted == 1 ? "Yes" : "No",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .inaugrationDateOfProject ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position].architect ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .executiveEngineer ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .nameOfInfraDepartment ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .nameOfAgencyContrator ?? "",
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position].expectedRevenue
                                  .toString(),
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position].valueOfQuote
                                  .toString(),
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
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .expectedDateOfCompletion ?? "",
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

  bindCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.filterTaskCreationOnController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
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
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
          /* initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(Duration(days: 7)),
        ),*/
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
          TaskMaster_page_controller.filterTaskCreationOnController.value.text = '$startDate - $endDate';
        } else {
          TaskMaster_page_controller.filterTaskCreationOnController.value.text = '';
          TaskMaster_page_controller.createdOnStartToEnd.value="";
        }
      },
    );
  }

  filterWithTaskCreationOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: TaskMaster_page_controller.filterTaskCreationOnController
            .value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Task Created On',
            labelText: 'Task Created On',
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
          DateTime ending_date = new DateTime(2200);
          DateTime start_date = new DateTime(1900);
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
            TaskMaster_page_controller.filterTaskCreationOnController.value
                .text = outputFormat.format(date);
          else
            TaskMaster_page_controller.filterTaskCreationOnController.value
                .text = "";
        }

    );
  }

  filterWithTaskDueDate(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: TaskMaster_page_controller.filterTaskDuedateController
            .value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Task Due Date',
            labelText: 'Task Due Date',
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
            TaskMaster_page_controller.filterTaskDuedateController.value.text =
                outputFormat.format(date);
          else
            TaskMaster_page_controller.filterTaskDuedateController.value.text =
            "";
        }


    );
  }

  bindTypeOfCall() {
    return TextField(
      controller: TaskMaster_page_controller.Type_of_call_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Type Of Call',
          hintText: 'Type Of Call',
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

  bindSaleCycleId() {
    return TextField(
      controller: TaskMaster_page_controller.Sale_cycle_Id_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Sale Cycle Id',
          hintText: 'Sale Cycle Id',
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

  bindProductCategory() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.product_category_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Product Category',
          hintText: 'Product Category',
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
  }

  bindMethodOfcall() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.method_of_call_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Method Of Call',
          hintText: 'Method Of Call',
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
  }

  filterAccountOwner() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.account_owner_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Owner',
          hintText: 'Account Owner',
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
  }

  filterIsClosedCompleted() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.account_Name_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Name',
          hintText: 'Account Name',
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
  }

  filterDayFlag() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.account_Name_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Name',
          hintText: 'Account Name',
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
  }
}
