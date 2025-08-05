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
import '../../CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';
import '../../CRM_VIewModels/emp_infor_system/emp_mark_leave_request_vm.dart';
import '../../CRM_VIewModels/emp_infor_system/leave_request_approval_vm.dart';

class LeaveRequestApprovalScreen extends StatelessWidget{

  final employeeLeaveRequestController = Get.put(LeaveRequestApprovalVm());
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
                  'Approval List',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),

                IconButton(onPressed: () {

                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: employeeLeaveRequestController.refreshApprovalList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible: employeeLeaveRequestController.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8), // optional spacing
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                              backgroundColor:
                              employeeLeaveRequestController.filterStatus.value == 'Pending for Approval'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Pending',
                                style: GoogleFonts.poppins(
                                  color: employeeLeaveRequestController.filterStatus.value == 'Pending for Approval'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeLeaveRequestController.filterStatus.value = 'Pending for Approval';
                                employeeLeaveRequestController.pageNumber=0;
                                employeeLeaveRequestController.getEmployeeLeaveRequestRejectApproveDataGet(employeeLeaveRequestController.filterStatus.value, employeeLeaveRequestController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              employeeLeaveRequestController.filterStatus.value == 'Approved'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Approved',
                                style: GoogleFonts.poppins(
                                  color: employeeLeaveRequestController.filterStatus.value == 'Approved'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeLeaveRequestController.filterStatus.value = 'Approved';
                                employeeLeaveRequestController.pageNumber=0;
                                employeeLeaveRequestController.getEmployeeLeaveRequestRejectApproveDataGet(employeeLeaveRequestController.filterStatus.value,employeeLeaveRequestController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8), // optional spacing between chips
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              employeeLeaveRequestController.filterStatus.value == 'Rejected'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Rejected',
                                style: GoogleFonts.poppins(
                                  color: employeeLeaveRequestController.filterStatus.value == 'Rejected'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeLeaveRequestController.filterStatus.value = 'Rejected';
                                employeeLeaveRequestController.pageNumber=0;
                                employeeLeaveRequestController.getEmployeeLeaveRequestRejectApproveDataGet(employeeLeaveRequestController.filterStatus.value,employeeLeaveRequestController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
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
    if (employeeLeaveRequestController.employee_leave_data_Approval_list.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (employeeLeaveRequestController.total_rows /
              employeeLeaveRequestController.rowsPerPage)
              .toInt();
          if ((employeeLeaveRequestController.total_rows %
              employeeLeaveRequestController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${employeeLeaveRequestController
                  .pageNumber} ${employeeLeaveRequestController
                  .total_rows} ${employeeLeaveRequestController
                  .rowsPerPage} ${total_page}");

         if (employeeLeaveRequestController.pageNumber + 1 < total_page) {
           employeeLeaveRequestController.getEmployeeLeaveRequestRejectApproveDataGet(
               employeeLeaveRequestController.filterStatus.value,
             employeeLeaveRequestController.pageNumber + 1
            );
           employeeLeaveRequestController.pageNumber += 1;
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
          itemCount: employeeLeaveRequestController
              .employee_leave_data_Approval_list.value.length,
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

  Widget BindCustomerRequestListView(context, int index) {
    var createdOn=StaticMethod.convertDateFormat1(employeeLeaveRequestController
        .employee_leave_data_Approval_list[index].createdOn??"");
    var startDate=StaticMethod.convertDateFormat1(employeeLeaveRequestController
        .employee_leave_data_Approval_list[index].fromDate??"");
    var endDate=StaticMethod.convertDateFormat1(employeeLeaveRequestController
        .employee_leave_data_Approval_list[index].toDate??"");
    var approved_date=StaticMethod.convertDateFormat1(employeeLeaveRequestController
        .employee_leave_data_Approval_list[index].approvedOn??"");

    String status= employeeLeaveRequestController
        .employee_leave_data_Approval_list[index].status?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'pending for approval':
          return Colors.blueAccent;
        case  'rejected':
          return Colors.red[900]!;
        case 'approved':
          return Colors.green;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        title:  Row(
          children: [
            Text(
              'Leave Id :',
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w700,
              ),
            ),
            Tooltip(
              message: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].leaveId.toString()??"",
              child: Text(
                employeeLeaveRequestController
                    .employee_leave_data_Approval_list[index].leaveId.toString()??"",
                style: GoogleFonts.poppins(
                  color: AllColors.textColor,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),


          ],
        ),
        subtitle:  Column(
          children: [
            _buildLabelWithValue(
              label: "Emp Name : ",
              value: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].createdFullName,
            ),

            _buildLabelWithValue(
              label: "Status : ",
              value: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].status,
              // width: size.width * 0.36,
              color: getStatusColor(status),
            ),
            _buildLabelWithValue(
              label: "Created On : ",
              value: createdOn,
            ),
            _buildLabelWithValue(
              label: "Leave Description : ",
              value: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].leaveDescription,
            ),
            _buildLabelWithValue(
              label: "Leave Reason : ",
              value: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].leaveReason,
            ),
            _buildLabelWithValue(
              label: "Start Date : ",
              value: startDate,
            ),
            _buildLabelWithValue(
              label: "End Date : ",
              value: endDate,
            ),

            _buildLabelWithValue(
              label: "No of Days : ",
              value: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].noOfDays.toString(),
            ),

            Visibility(
              visible: employeeLeaveRequestController.filterStatus == 'Approved',
              child: _buildLabelWithValue(
                label: "Approved On : ",
                value: approved_date,
              ),
            ),



            Visibility(
              visible: employeeLeaveRequestController.filterStatus == 'Rejected',
              child: Column(
                children: [
                  _buildLabelWithValue(
                    label: "Rejected On : ",
                    value: approved_date,
                  ),

                  _buildLabelWithValue(
                    label: "Reject Remarks : ",
                    value: employeeLeaveRequestController
                        .employee_leave_data_Approval_list[index].rejectRemarks,
                  ),
                ],
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: AllColors.primaryDark1,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      )
                  ),
                    child: Icon(Icons.check, color: Colors.blue,)),
                SizedBox(width: 10,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: AllColors.primaryDark1,
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        )
                    ),
                    child: Icon(Icons.close_outlined, color: Colors.red,)),
              ],
            )

          ],
        ),

      ),
    );
  }
  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
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
                color: color,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

}