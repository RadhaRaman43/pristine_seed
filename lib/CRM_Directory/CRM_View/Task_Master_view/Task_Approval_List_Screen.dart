import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';

class TaskApprovalListScreen extends StatelessWidget{

  final TaskMaster_page_controller = Get.put(TaskApprovalvm());
  Size size = Get.size;




  static String _displaySaleCycleActiveForOption(String option) =>
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
                  'Task Approval List',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),

                IconButton(onPressed: () {
                  TaskMaster_page_controller.isInfraLeadFilterController.text = "All";
                  TaskMaster_page_controller.SaleCycleActive_Controller.text = "All";
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

          if (TaskMaster_page_controller.pageNumber + 1 < total_page) {
            TaskMaster_page_controller.getTaskMasterApprovalList(
                TaskMaster_page_controller.pageNumber + 1,
                TaskMaster_page_controller.is_Active.toString(),
                );
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
            TaskMaster_page_controller.pageNumber=0;
            TaskMaster_page_controller.getTaskMaster(
              TaskMaster_page_controller.pageNumber,
                TaskMaster_page_controller.is_Active.toString(),
                TaskMaster_page_controller.Task_Master_list[position].taskId,);

          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
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
                      child: Tooltip(
                        message: TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskStatus??"",
                        child: Text(
                          TaskMaster_page_controller
                              .Task_Master_list[position]
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx((){
                    return  Visibility(
                      visible: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .isReadyForApprove.toString()=='1' && TaskMaster_page_controller.Task_Master_list[position].createdBy?.toLowerCase()!=TaskMaster_page_controller.email.toLowerCase()
                          && TaskMaster_page_controller.isHeadofficePermission!="1"?true:false,
                      child: IconButton(onPressed: () {
                        TaskMaster_page_controller.showApprovRejectDialog(context, TaskMaster_page_controller.Task_Master_list[0].taskId!);
                      }, icon: Icon(Icons.update)),
                    );
                  }),
                ],
              ),
              Icon(Icons.remove_red_eye, color: AllColors.textColor,),

            ],
          ),
          subtitle: Column(
            children: [
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
                          .taskId??"",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskId??"",
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
                        .approvedFullName??"",
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
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .accountName??"",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .accountName??"",
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
                          .contactName??"",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
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
                      message: TaskMaster_page_controller
                          .Task_Master_list[position]
                          .typeOfCall??"",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Mode of Call : ",
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
                          .methodOfCall??"",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
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
                          .createdFullName??"" +
                          "| ${StaticMethod.dateTimeToDate(
                              TaskMaster_page_controller
                                  .Task_Master_list[position]
                                  .createdOn??"")}",
                      child: Text(
                        TaskMaster_page_controller
                            .Task_Master_list[position]
                            .createdFullName??"" +
                            "| ${StaticMethod.dateTimeToDate(
                                TaskMaster_page_controller
                                    .Task_Master_list[position]
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
                            .rejectReason??"",
                        child: Text(
                          TaskMaster_page_controller
                              .Task_Master_list[position]
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
            ],
          ),
          /*trailing: Icon(Icons.remove_red_eye, color: AllColors.textColor,),*/
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    //TaskMaster_page_controller.IsActive_controller.clear();
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
                              SizedBox(height: 5,),
                              bindData(context,'Task Id',TaskMaster_page_controller.filterTask_Id_controller),
                              SizedBox(height: 5,),
                              bindData(context,'Customer Name',TaskMaster_page_controller.account_Name_controller),
                              SizedBox(height: 10,),
                              bindData(context,'Customer Code',TaskMaster_page_controller.account_code_controller),
                              SizedBox(height: 10,),
                              //bindTypeOfCall(),
                              bindTypeOfCallDropDown(context),
                              SizedBox(height: 10,),
                              //bindMethodOfcall(),
                              bindMethodOfCallDropDown(context),
                              SizedBox(height: 10,),
                              /*bindCreatedBy(),
                              SizedBox(height: 10,),*/
                              /*filterAccountOwner(),
                              SizedBox(height: 10,),*/
                              bindCompProfileTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindLastActivityStatus(context),
                              SizedBox(height: 10,),
                              bindSaleCycleActiveDropDown(context),
                              SizedBox(height: 10,),
                              filterWithTaskDueDate(context),
                              SizedBox(height: 10,),
                              bindData(context,'Pin Code',TaskMaster_page_controller.postalCodeController.value),
                              SizedBox(height: 10,),
                              bindData(context,'District',TaskMaster_page_controller.district_controller.value),
                              SizedBox(height: 10,),
                              //bindBranchHead(),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              //bindClusterHead(),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindAccountOwnerFilter(context),
                              SizedBox(height: 10,),
                              bindCreatedOn(context),
                              SizedBox(height: 10,),
                              bindProductCategory(context),
                              SizedBox(height: 10,),
                              bindProductCategoryTypeDropDown(context),
                              SizedBox(height: 10,),
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
                              TaskMaster_page_controller.getTaskMasterApprovalList(
                                  TaskMaster_page_controller.pageNumber,
                                  TaskMaster_page_controller.SaleCycleActive_Controller.text,
                                  );
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
                              TaskMaster_page_controller.getTaskMasterApprovalList(
                                  TaskMaster_page_controller.pageNumber,
                                  TaskMaster_page_controller.is_Active.toString(),
                                 );
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

  bindData(BuildContext context,String labelText, TextEditingController controller) {
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

  bindAccountOwnerFilter(BuildContext context) {
    return Obx((){
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

  bindCompProfileTypeDropDown(BuildContext context) {
    return Obx(() {
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
  bindLastActivityStatus(BuildContext context) {
    return Obx(() {
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

  Widget bindSaleCycleActiveDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
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

  }

  bindTypeOfCallDropDown(BuildContext context) {
    return Obx(() {
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

  bindProductCategory(BuildContext context) {
    return Obx(() {
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

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = TaskMaster_page_controller.clusterGetByEmailList;
      if (availableItems.isNotEmpty &&
          TaskMaster_page_controller.SelectedCluster_list.isEmpty) {
        TaskMaster_page_controller.SelectedCluster_list.assignAll(availableItems);
        TaskMaster_page_controller.clusterName_controller.value.text =
            availableItems.map((e) => e.geoValue).join(', ');
        TaskMaster_page_controller.getRegionsWithClusterFilterGetByEmail();
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
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
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
                                  onPressed: () {
                                    TaskMaster_page_controller.SelectedCluster_list
                                        .assignAll(tempSelected);
                                    TaskMaster_page_controller
                                        .clusterName_controller.value.text =
                                        tempSelected
                                            .map((e) => e.geoValue)
                                            .join(', ');
                                    TaskMaster_page_controller
                                        .getRegionsWithClusterFilterGetByEmail();

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Done'),
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
      if (availableItems.isNotEmpty &&
          TaskMaster_page_controller.SelectedRegion_list.isEmpty) {
        TaskMaster_page_controller.SelectedRegion_list.assignAll(availableItems);
        TaskMaster_page_controller.RegionName_controller.value.text =
            availableItems.map((e) => e.geoValue).join(', ');

      }
    });
    return Obx(() {
      final selected = TaskMaster_page_controller.SelectedRegion_list;
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
              final tempSelected = <RegionWithClusterFilterModal>[];
              tempSelected.addAll(TaskMaster_page_controller.SelectedRegion_list);

              final allItems =
                  TaskMaster_page_controller.regionwithclusterGetByEmailList;

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
                                  'Select Regions',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: AllColors.primaryDark1),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
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
                                  onPressed: () {
                                    TaskMaster_page_controller.SelectedRegion_list
                                        .assignAll(tempSelected);
                                    TaskMaster_page_controller.RegionName_controller
                                        .value.text =
                                        tempSelected
                                            .map((e) => e.geoValue)
                                            .join(', ');
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Done'),
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



}