

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/emp_infor_system/emp_mark_leave_request_vm.dart';
import '../../CRM_VIewModels/emp_infor_system/mark_attendance_view_modal.dart';

class EmpMarkLeaveRequestScreen extends StatelessWidget{
  EmpMarkLeaveRequestVm employeeMarkLeaveController=Get.put(EmpMarkLeaveRequestVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mark Leave',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              
              InkWell(
                onTap: (){
                  //filterDialog(context);
                  showFilterBottomSheet(context);
                }, child: Icon(Icons.filter_alt))
            ],
          ),
        ),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              employeeMarkLeaveController.getLeaveTypeData();
              employeeMarkLeaveController.getShortLeaveTime();
              employeeMarkLeaveController.getAnnualHolidaysList();
              Get.toNamed(RoutesName.empMarkLeaveRequestAddScreen);
            },
            backgroundColor: AllColors.primaryDark1,
            child: Icon(Icons.add,color: AllColors.whiteColor,)
        ),
        body: RefreshIndicator(
          onRefresh:employeeMarkLeaveController.refreshList,
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Obx(() {
                    return Visibility(
                      visible: employeeMarkLeaveController.loading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.textColor,
                      ),
                    );
                  },
                  ),
                ),
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
                              employeeMarkLeaveController.filterStatus.value == 'Pending for Approval'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Pending',
                                style: GoogleFonts.poppins(
                                  color: employeeMarkLeaveController.filterStatus.value == 'Pending for Approval'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeMarkLeaveController.filterStatus.value = 'Pending for Approval';
                                employeeMarkLeaveController.pageNumber=0;
                                employeeMarkLeaveController.getEmployeeLeaveData(employeeMarkLeaveController.filterStatus.value, employeeMarkLeaveController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              employeeMarkLeaveController.filterStatus.value == 'Approved'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Approved',
                                style: GoogleFonts.poppins(
                                  color: employeeMarkLeaveController.filterStatus.value == 'Approved'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeMarkLeaveController.filterStatus.value = 'Approved';
                                employeeMarkLeaveController.pageNumber=0;
                                employeeMarkLeaveController.getEmployeeLeaveData(employeeMarkLeaveController.filterStatus.value,employeeMarkLeaveController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8), // optional spacing between chips
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              employeeMarkLeaveController.filterStatus.value == 'Rejected'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Rejected',
                                style: GoogleFonts.poppins(
                                  color: employeeMarkLeaveController.filterStatus.value == 'Rejected'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeMarkLeaveController.filterStatus.value = 'Rejected';
                                employeeMarkLeaveController.pageNumber=0;
                                employeeMarkLeaveController.getEmployeeLeaveData(employeeMarkLeaveController.filterStatus.value,employeeMarkLeaveController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() => bindListView(context),
                ),

              ],
            ),

          ),
        ),
      ), );
  }


  bindListView(BuildContext context) {
    print("length${employeeMarkLeaveController.employee_leave_data_list.value.length}");
    if(employeeMarkLeaveController.employee_leave_data_list.value.isNotEmpty &&
        employeeMarkLeaveController.employee_leave_data_list.value != null) {
      ScrollController scrollController = ScrollController();
      return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.only(bottom: 100 ),
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BindEmployeeList(context, index);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 0.5,
                color: AllColors.primaryDark,
              );
            },
            itemCount: employeeMarkLeaveController.employee_leave_data_list.length),
      );
    } else {
      return Center(child: Image.asset("assests/images/no_data_remove.png"));
    }
  }





  BindEmployeeList(BuildContext context, int index) {
    var createdOn=StaticMethod.convertDateFormat1(employeeMarkLeaveController
        .employee_leave_data_list[index].createdOn??"");
    var startDate=StaticMethod.convertDateFormat1(employeeMarkLeaveController
        .employee_leave_data_list[index].fromDate??"");
    var endDate=StaticMethod.convertDateFormat1(employeeMarkLeaveController
        .employee_leave_data_list[index].toDate??"");
    var approved_date=StaticMethod.convertDateFormat1(employeeMarkLeaveController
        .employee_leave_data_list[index].approvedOn??"");

    String status= employeeMarkLeaveController
        .employee_leave_data_list[index].status?.toLowerCase()??"";
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
    return Container(
      child: Card(
        child: ListTile(
          title: Row(
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
                message: employeeMarkLeaveController
                    .employee_leave_data_list[index].leaveId.toString()??"",
                child: Text(
                  employeeMarkLeaveController
                      .employee_leave_data_list[index].leaveId.toString()??"",
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
          subtitle: Column(
            children: [
              _buildLabelWithValue(
                label: "Emp Name : ",
                value: employeeMarkLeaveController
                    .employee_leave_data_list[index].createdFullName,
              ),

              _buildLabelWithValue(
                label: "Status : ",
                value: employeeMarkLeaveController
                    .employee_leave_data_list[index].status,
                // width: size.width * 0.36,
                color: getStatusColor(status),
              ),
              _buildLabelWithValue(
                label: "Created On : ",
                value: createdOn,
              ),
              _buildLabelWithValue(
                label: "Leave Description : ",
                value: employeeMarkLeaveController
                    .employee_leave_data_list[index].leaveDescription,
              ),
              _buildLabelWithValue(
                label: "Leave Reason : ",
                value: employeeMarkLeaveController
                    .employee_leave_data_list[index].leaveReason,
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
                value: employeeMarkLeaveController
                    .employee_leave_data_list[index].noOfDays.toString(),
              ),

              Visibility(
                visible: employeeMarkLeaveController.filterStatus == 'Approved',
                child: _buildLabelWithValue(
                  label: "Approved On : ",
                  value: approved_date,
                ),
              ),



              Visibility(
                visible: employeeMarkLeaveController.filterStatus == 'Rejected',
                child: Column(
                  children: [
                    _buildLabelWithValue(
                      label: "Rejected On : ",
                      value: approved_date,
                    ),

                    _buildLabelWithValue(
                      label: "Reject Remarks : ",
                      value: employeeMarkLeaveController
                          .employee_leave_data_list[index].rejectRemarks,
                    ),
                  ],
                ),
              ),
             /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emp Name :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].createdFullName??"",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].createdFullName??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].status??"",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].status??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Created On :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: createdOn??"",
                      child: Text(
                        createdOn??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              *//*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Is Half Day :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Tooltip(
                    message: employeeMarkLeaveController
                        .employee_leave_data_list[index].isHalfDay == 1?"Yes":"No",
                    child: Text(
                      employeeMarkLeaveController
                          .employee_leave_data_list[index].isHalfDay == 1?"Yes":"No",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),



                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Is Short Leave :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].isShortLeave == 1?"Yes":"No",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].isShortLeave == 1?"Yes":"No",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Short Leave Time :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].shortLeaveTime??"",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].shortLeaveTime??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),*//*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leave Description :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].leaveDescription??"",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].leaveDescription??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leave Reason :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].leaveReason??"",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].leaveReason??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Date :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: startDate??"",
                      child: Text(
                        startDate??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'End Date :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: endDate??"",
                      child: Text(
                        endDate??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No of Days :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: employeeMarkLeaveController
                          .employee_leave_data_list[index].noOfDays.toString(),
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].noOfDays.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reporting Manager :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message:employeeMarkLeaveController
                          .employee_leave_data_list[index].approvedFullName??"",
                      child: Text(
                        employeeMarkLeaveController
                            .employee_leave_data_list[index].approvedFullName??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),


                ],
              ),

              Visibility(
                visible: employeeMarkLeaveController.employee_leave_data_list[index].status?.toLowerCase() == 'approved',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Approved On :',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Tooltip(
                      message: approved_date??"",
                      child: Text(
                        approved_date??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),


                  ],
                ),
              ),



              Visibility(
                visible: employeeMarkLeaveController.employee_leave_data_list[index].status?.toLowerCase() == 'rejected',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rejected On:',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Tooltip(
                      message: approved_date??"",
                      child: Text(
                        approved_date??"",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),


                  ],
                ),
              ),

              Visibility(
                visible: employeeMarkLeaveController.filterStatus == 'Rejected',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rejected Remarks:',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      child: Tooltip(
                        message: employeeMarkLeaveController
                            .employee_leave_data_list[index].rejectRemarks??"",
                        child: Text(
                          employeeMarkLeaveController
                              .employee_leave_data_list[index].rejectRemarks??"",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
            ],
          ),

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


  bindFilterStartDate(BuildContext context) {
    return  TextFormField(
      controller: employeeMarkLeaveController.StartDate_filter_controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_month),
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Start Date',
          hintText: 'Start Date',
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
      onTap: () async {
        DateTime? initialDate;
        if (employeeMarkLeaveController.StartDate_filter_controller.text.isNotEmpty) {
          initialDate = DateFormat('yyyy-MM-dd').parse(
            employeeMarkLeaveController.StartDate_filter_controller.text,
          );
        } else {
          initialDate = DateTime.now();
        }
        // Define the first and last date of the current year
        DateTime stating_date = DateTime(DateTime.now().year, 1, 1); // January 1st
        DateTime ending_date = DateTime(DateTime.now().year, 12, 31); // December 31st
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
        var outputFormat = DateFormat('yyyy-MM-dd');
        employeeMarkLeaveController.StartDate_filter_controller.text =
            outputFormat.format(date!);

      },
    );
  }

  bindFilterEndDate(BuildContext context) {
    return  TextFormField(
      controller: employeeMarkLeaveController.EndDate_filter_controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_month),
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'End Date',
          hintText: 'End Date',
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
      onTap: () async {
        // Get the start date and parse it
        String startDateText =
            employeeMarkLeaveController.StartDate_filter_controller.text;
        DateTime stating_date = startDateText.isNotEmpty
            ? DateFormat('yyyy-MM-dd').parse(startDateText)
            : DateTime.now();

        // Get the previously selected end date or use today
        String endDateText =
            employeeMarkLeaveController.EndDate_filter_controller.text;
        DateTime initialDate = endDateText.isNotEmpty
            ? DateFormat('yyyy-MM-dd').parse(endDateText)
            : stating_date;

        // Ensure the end date cannot be earlier than the start date
        DateTime ending_date = DateTime(2200);

        // Remove focus from the field
        FocusScope.of(context).requestFocus(FocusNode());

        // Show the date picker
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: stating_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1,
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        // Update the controller with the selected date
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null) {
          employeeMarkLeaveController.EndDate_filter_controller.text =
              outputFormat.format(date);
        }
      },
    );
  }

  bindLeaveId(BuildContext context) {
    return   TextField(
      controller: employeeMarkLeaveController.leaveId_filter_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Leave Id',
          hintText: 'Leave Id',
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
    );
  }




  bindLeaveCode(BuildContext context) {
    return  TextField(
      controller: employeeMarkLeaveController.leaveCode_filter_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Leave Code',
          hintText: 'Leave Code',
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

    );
  }



  void showFilterBottomSheet(BuildContext context) {
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
                        Get.back();
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
                          height: 10,
                        ),
                        bindLeaveId(context),
                        SizedBox(
                          height: 10,
                        ),
                        bindLeaveCode(context),
                        SizedBox(
                          height: 10,
                        ),
                        bindFilterStartDate(context),
                        SizedBox(
                          height: 10,
                        ),
                        bindFilterEndDate(context),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DefaultButton(
                                text: 'Reset',
                                press: (){
                                  employeeMarkLeaveController.leaveCode_filter_controller.clear();
                                  employeeMarkLeaveController.StartDate_filter_controller.clear();
                                  employeeMarkLeaveController.EndDate_filter_controller.clear();
                                  employeeMarkLeaveController.leaveId_filter_controller.clear();
                                  employeeMarkLeaveController.pageNumber=0;
                                  employeeMarkLeaveController.getEmployeeLeaveData(
                                      employeeMarkLeaveController.filterStatus.value, employeeMarkLeaveController.pageNumber);
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: DefaultButton(
                                text:  'Submit',
                                press: (){
                                  employeeMarkLeaveController.pageNumber=0;
                                  employeeMarkLeaveController.getEmployeeLeaveData(
                                      employeeMarkLeaveController.filterStatus.value, employeeMarkLeaveController.pageNumber);
                                  Get.back();
                                },
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
}

