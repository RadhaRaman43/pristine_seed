import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:dropdown_search/dropdown_search.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';

class AccountdashboarddatalistScreen extends StatelessWidget{
  AccountdashboarddatalistScreen({super.key});

  final accountMaster_page_controller=Get.put(Accountmastervm());
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  Size size=Get.size;

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
      Get.toNamed(RoutesName.AccountDashboardCount_Screen);
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
                    '${accountMaster_page_controller.day_flag} Task List',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {
                    showFilterBottomSheet(context);
                  }, icon: Icon(Icons.filter_alt_sharp))
                ],
              )

          ),
          drawer: CustomDrawer(),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:accountMaster_page_controller.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                    child:
                    Obx(() {
                      return BindAccountDashboardListView(context);
                    }),

                  ),
                ),
              ],
            ),
          ),
        ),
        );
  }

  Widget BindAccountDashboardListView(context) {
    if (accountMaster_page_controller
        .AccountDashboardDataList.value.isNotEmpty &&
        accountMaster_page_controller
            .AccountDashboardDataList.value.length >
            0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (accountMaster_page_controller.total_rows /
              accountMaster_page_controller.rowsPerPage)
              .toInt();
          if ((accountMaster_page_controller.total_rows %
              accountMaster_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (accountMaster_page_controller.pageNumber + 1 < total_page) {
            accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber + 1,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.AccountCode, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);
            this.accountMaster_page_controller.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          separatorBuilder: (context, index) => Divider(
            height: .05,
            color: Colors.transparent,
          ),
          shrinkWrap: true,
          itemCount: accountMaster_page_controller
              .AccountDashboardDataList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindAccountDataListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }


  Widget BindAccountDataListView(context, int position) {
    String taskStatus = accountMaster_page_controller.AccountDashboardDataList[position].taskStatus!;
    String pipeLine= accountMaster_page_controller.AccountDashboardDataList[position].taskDueTime!.isNotEmpty?"|":"";
    int? IsActive = accountMaster_page_controller.AccountDashboardDataList[position].isInfraLead;
    String isActive = "";
    if(IsActive == 1){
      isActive = "Yes";
    }else{
      isActive = "No";
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
      return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          /* TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId , 'View');
          TaskMaster_page_controller.getTaskMstDSARList(TaskMaster_page_controller.Task_Master_list[position].taskId);
        */
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
                    message:  accountMaster_page_controller.AccountDashboardDataList[position]
                        .taskStatus??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataList[position]
                          .taskStatus??"",
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
                InkWell(
                  child: Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: accountMaster_page_controller.AccountDashboardDataList[position]
                          .taskId??"",
                      child: Text(
                        accountMaster_page_controller.AccountDashboardDataList[position]
                            .taskId??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,),
                      ),
                    ),
                  ),
                  onTap: (){
                    accountMaster_page_controller.view='TaskDashboard';
                    TaskMaster_page_controller.getTaskMaster(0,
                        TaskMaster_page_controller.is_Active
                            .toString(),
                        accountMaster_page_controller.AccountDashboardDataList[position]
                            .taskId,
                        '', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
                    Get.toNamed(RoutesName.taskMasterDetails_screen);
                  },
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
                  accountMaster_page_controller.AccountDashboardDataList[position]
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
                      message: accountMaster_page_controller.AccountDashboardDataList[position]
                          .accountName ?? "",
                      child: Text(
                        accountMaster_page_controller.AccountDashboardDataList[position]
                            .accountName??
                            "" + " | ${accountMaster_page_controller.AccountDashboardDataList[position]
                                .accountName ?? ""}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                         // decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.wavy,),
                      ),
                    ),
                  ),
                  /*onTap: (){
                      account_vm_controller.view='FromTaskMainScreen';
                      contact_vm_controller.view='VIEWMainScreen';
                      account_vm_controller.getAccMasterBuyCodeApi(TaskMaster_page_controller.Task_Master_list[position].accountCode);
                    },*/
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
                    message: accountMaster_page_controller.AccountDashboardDataList[position]
                        .contactName??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataList[position]
                          .contactName??"",
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
                    message: accountMaster_page_controller.AccountDashboardDataList[position]
                        .typeOfCall??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataList[position]
                          .typeOfCall??"",
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
                    accountMaster_page_controller.AccountDashboardDataList[position]
                        .salesCycleId ?? "",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                  /*onTap: (){
                      salesCycleController.getsalesCycleData(0, TaskMaster_page_controller
                          .Task_Master_list[position]
                          .salesCycleId!, "ViewHeader", 'FromTaskScreen');
                    },*/
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
                    message: accountMaster_page_controller.AccountDashboardDataList[position]
                        .methodOfCall??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataList[position]
                          .methodOfCall??"",
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
                    message: accountMaster_page_controller.AccountDashboardDataList[position]
                        .createdFullName??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataList[position]
                          .createdFullName??"" + "| ${StaticMethod.dateTimeToDate(accountMaster_page_controller.AccountDashboardDataList[position]
                          .createdOn??"")}",
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
                    message: accountMaster_page_controller.AccountDashboardDataList[position]
                        .taskDueDate,
                    child: Text(" ${accountMaster_page_controller.AccountDashboardDataList[position]
                        .taskDueDate ?? ""} ${pipeLine} ${accountMaster_page_controller.AccountDashboardDataList[position]
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
            /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Is Infra Lead : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  *//*onTap: (){
                      showInfraLeadDetails(context,  position);
                    },*//*
                  child: Text(
                    accountMaster_page_controller.AccountDashboardDataList[position].isInfraLead==1?"Yes":"No",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,),
                  ),
                ),
              ],
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    message: accountMaster_page_controller.AccountDashboardDataList[position].taskRemarks ?? "",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataList[position].taskRemarks ?? "",
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
              visible: accountMaster_page_controller.AccountDashboardDataList[position].taskStatus=='Rejected'?true:false,
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
                      message: accountMaster_page_controller.AccountDashboardDataList[position]
                          .rejectReason??"",
                      child: Text(
                        accountMaster_page_controller.AccountDashboardDataList[position]
                            .methodOfCall??"",
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

        //leading: bindAvatar(accountMaster_page_controller.Account_Master_list[position].profile),
        /*trailing: taskStatus == 'PENDING FOR APPROVAL' && IsReadyForApprove == 1 ? InkWell(
            onTap: (){
              showApprovRejectDialog(context, TaskMaster_page_controller
                  .Task_Master_list[position]
                  .taskId!);
            },
            child: Icon(Icons.update,  color: Colors.blue,),
          ) : (taskStatus.toLowerCase() == 'approved'?InkWell(
            onTap: (){
              TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId , 'View', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
              // TaskMaster_page_controller.getTaskMstDSARList(TaskMaster_page_controller.Task_Master_list[position].taskId);
              // TaskMaster_page_controller.getItemCategoryMstApi(TaskMaster_page_controller.Task_Master_list[position].taskId);
            },
            child: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
          ):SizedBox()
          )*/

      ),
    );;
  }

  void showFilterBottomSheet(BuildContext context) {
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
                        /*bindTaskStatusDropDown(context),

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
                        ),*/

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

                        SizedBox(
                          height: 10,
                        ),

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
                                  Get.back();
                                  accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);


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
                                  TaskMaster_page_controller.Contact_Name_controller.clear();
                                  TaskMaster_page_controller.Type_of_call_controller.clear();
                                  TaskMaster_page_controller.SaleCycleActive_Controller.clear();
                                  TaskMaster_page_controller.Sale_cycle_Id_controller.clear();
                                  TaskMaster_page_controller.isInfraLeadFilterController.clear();
                                  accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);


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
  }

  Widget bindTaskStatusDropDown(context) {
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
        print('IsActive.....${TaskMaster_page_controller.Task_status_controller.text}');
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
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
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
    return Autocomplete<String>(
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
        print('IsActive.....${TaskMaster_page_controller.SaleCycleActive_Controller.text}');
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
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
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
    );
  }

  Widget bindIsInfraLeadDropDown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width-15,
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

      dropdownMenuEntries: TaskMaster_page_controller.SaleCycleActiveTypeList.map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
      }).toList(),
    );
  }


}