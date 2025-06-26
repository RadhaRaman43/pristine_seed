

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/emp_infor_system/mark_attendance_view_modal.dart';

class EmpMarkLeaveScreen extends StatelessWidget{
  MarkAttendanceViewmodel employeeMarkLeaveController=Get.put(MarkAttendanceViewmodel());
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
          title: Text(
            'Mark Leave',
            style: GoogleFonts.poppins(
              color: AllColors.whiteColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              employeeMarkLeaveController.getLeaveTypeData();
              employeeMarkLeaveController.getShortLeaveTime();
              employeeMarkLeaveController.getAnnualHolidaysList();
              Get.toNamed(RoutesName.empMarkLeaveAddScreen);
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
                              employeeMarkLeaveController.filterStatus.value == 'Pending'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Pending',
                                style: GoogleFonts.poppins(
                                  color: employeeMarkLeaveController.filterStatus.value == 'Pending'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                employeeMarkLeaveController.filterStatus.value = 'Pending';
                                employeeMarkLeaveController.getEmployeeLeaveData(employeeMarkLeaveController.filterStatus.value);
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
                                employeeMarkLeaveController.getEmployeeLeaveData(employeeMarkLeaveController.filterStatus.value);
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
                                employeeMarkLeaveController.getEmployeeLeaveData(employeeMarkLeaveController.filterStatus.value);
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
    var submission_date=StaticMethod.convertDateFormat1(employeeMarkLeaveController
        .employee_leave_data_list[index].workingDate??"");
    var approved_date=StaticMethod.convertDateFormat1(employeeMarkLeaveController
        .employee_leave_data_list[index].approvedOn??"");
    return Container(
      child: Card(
        child: ListTile(
          onTap: (){
            employeeMarkLeaveController.LeaveAction="Update";
            employeeMarkLeaveController.getLeaveTypeData();
            employeeMarkLeaveController.getShortLeaveTime();
            employeeMarkLeaveController.getAnnualHolidaysList();
            employeeMarkLeaveController.bindData(employeeMarkLeaveController
                .employee_leave_data_list[index]);
            Get.toNamed(RoutesName.empMarkLeaveAddScreen);
          },
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
                    .employee_leave_data_list[index].id.toString()??"",
                child: Text(
                  employeeMarkLeaveController
                      .employee_leave_data_list[index].id.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              Spacer(),
              Icon(Icons.update_sharp)
            ],
          ),
          subtitle: Column(
            children: [
              Row(
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
        
                  Tooltip(
                    message: employeeMarkLeaveController
                        .employee_leave_data_list[index].empName??"",
                    child: Text(
                      employeeMarkLeaveController
                          .employee_leave_data_list[index].empName??"",
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
              ),
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
                    'Working Date :',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
        
                  Flexible(
                    child: Tooltip(
                      message: submission_date,
                      child: Text(
                        submission_date.toString(),
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
                visible: employeeMarkLeaveController.employee_leave_data_list[index].approveStatus == 'Approved'?true:false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Approved By :',
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
                            .employee_leave_data_list[index].approvedBy??"",
                        child: Text(
                          employeeMarkLeaveController
                              .employee_leave_data_list[index].approvedBy??"",
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
              ),
        
              Visibility(
                visible: employeeMarkLeaveController.employee_leave_data_list[index].approveStatus == 'Approved'?true:false,
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
                visible: employeeMarkLeaveController.employee_leave_data_list[index].approveStatus == 'Rejected'.toUpperCase()?true:false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rejected By :',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Tooltip(
                        message:employeeMarkLeaveController
                            .employee_leave_data_list[index].approvedBy??"",
                        child: Text(
                          employeeMarkLeaveController
                              .employee_leave_data_list[index].approvedBy??"",
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
              ),
        
              Visibility(
                visible: employeeMarkLeaveController.employee_leave_data_list[index].approveStatus == 'Rejected'.toUpperCase()?true:false,
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
                visible: employeeMarkLeaveController.filterStatus == 'Rejected'?true:false,
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
              ),
            ],
          ),
        
        ),
      ),
    );
  }
/*
  filterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Filter',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            //  height: 220,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  bindLeaveTypeDropDown(context),

                  SizedBox(
                    height: 2,
                  ),

                  TextFormField(
                    controller: employeeMarkLeaveController.StartDate_filter_controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AllColors.primaryDark,
                        size: 25,
                      ),
                      labelText: "Start Date",
                      labelStyle: TextStyle(color: AllColors.primaryDark1),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1),
                      ),
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
                  ),

                  TextFormField(
                    controller: employeeMarkLeaveController.EndDate_filter_controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AllColors.primaryDark,
                        size: 25,
                      ),
                      labelText: "End Date",
                      labelStyle: TextStyle(color: AllColors.primaryDark1),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1),
                      ),
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
                        // Calculate the difference after selecting the end date
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          employeeMarkLeaveController.leaveCode_filter_controller.clear();
                          employeeMarkLeaveController.StartDate_filter_controller.clear();
                          employeeMarkLeaveController.EndDate_filter_controller.clear();
                          employeeMarkLeaveController.getEmployeeLeaveData(
                              employeeMarkLeaveController.status);
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          if(employeeMarkLeaveController.StartDate_filter_controller.value.text.isNotEmpty && employee_Mark_Leave_Controller.EndDate_filter_controller.value.text.isEmpty){
                            Utils.showMotionToast('End Date!', 'Please Select End Date');
                          }else{
                            Navigator.pop(context);
                            employeeMarkLeaveController.getEmployeeLeaveData(
                                employeeMarkLeaveController.status);
                          }

                          // todo  Your onPressed logic...
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Ok',
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bindLeaveTypeDropDown(context) {
    return Autocomplete<LeaveTypeModel >(
      displayStringForOption: _displayleavetypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return employee_Mark_Leave_Controller.leaveType_data_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        *//*return await employee_Mark_Leave_Controller
            .getTaskNoTeam(textEditingValue.text);*//*
        return employee_Mark_Leave_Controller.leaveType_data_list
            .where((LeaveTypeModel  option) {
          return option.leaveCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (LeaveTypeModel  selection) {
        print(selection.leaveCode);
        employee_Mark_Leave_Controller.leaveCode_filter_controller.text =
            _displayleavetypeForOption(selection).toString();
        //employee_Mark_Leave_Controller.task_no = selection.leaveCode!;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              FocusScope.of(context).unfocus();
            }
            employee_Mark_Leave_Controller.leaveCode_filter_controller.text = value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = employee_Mark_Leave_Controller.leaveCode_filter_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Leave code',
            labelText: 'Leave code',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AllColors.primaryDark1)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<LeaveTypeModel > onSelected,
          Iterable<LeaveTypeModel > suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor,
              width: size.width * .61,
              height: size.height * .15,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final LeaveTypeModel  option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Tooltip(
                              message: option.leaveCode.toString()+" (${option.description.toString()})",
                              child: Text(
                                option.leaveCode.toString()+" (${option.description.toString()})",
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                ),
                              ),
                            ),
                          ),
                          Divider(height: 0.3,color: AllColors.lightgreyColor,)
                        ],
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

  bindemployeeTaskMenu(BuildContext context, int index) {
    return Container(
      child: PopupMenuButton<String>(
        icon: Icon(Icons.menu,
        ), // Replace with your desired icon
        onSelected: (value) {
          if(value == 'Edit'){

            employee_Mark_Leave_Controller.selected_update_item.value=employee_Mark_Leave_Controller.employee_leave_data_list[index];

            BindEditleave(employee_Mark_Leave_Controller.selected_update_item.value);

            Get.toNamed(RoutesName.newLeaveCreateScreen);


          }
        },
        offset: Offset(-30, 40),

        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<String>> items = [];
          items.add(
            PopupMenuItem<String>(
              value: 'Edit',
              child: Row(
                children: [
                  Icon(Icons.update), // Set your desired icon here
                  SizedBox(width: 8), // Space between the icon and text
                  Text('Edit'),
                ],
              ),
            ),
          );


          return items;
        },
      ),
    );
  }

  BindEditleave(AttendanceLeaveDataModel selectedList){
    employee_Mark_Leave_Controller.getLeaveTypeData();
    employee_Mark_Leave_Controller.LeaveAction = 'Update';
    //var date = StaticMethod.convertDateFormat1(selectedList.workingDate.toString());
    employee_Mark_Leave_Controller.StartDate_controller.text = selectedList.workingDate.toString();
    employee_Mark_Leave_Controller.EndDate_controller.text = selectedList.workingDate.toString();
    employee_Mark_Leave_Controller.isHalfDay.value = selectedList.isHalfDay == 1 ?true:false;
    employee_Mark_Leave_Controller.isShortLeave.value = selectedList.isShortLeave == 1 ?true:false;
    employee_Mark_Leave_Controller.selectedRadio.value = selectedList.shortLeaveTime == "05:00 PM - 06:30 PM"?2:1;
    employee_Mark_Leave_Controller.leaveCode_controller.text=selectedList.leaveDescription.toString()+" (${selectedList.leaveCode.toString()})";
    employee_Mark_Leave_Controller.leave_selection.value.leaveCode = selectedList.leaveCode;
    selectedList.isCompOff == 1?employee_Mark_Leave_Controller.isComprehensiveLeave.value = true:false;
    employee_Mark_Leave_Controller.babyLeaveRerason_controller.text=selectedList.leaveReason.toString();
    employee_Mark_Leave_Controller.CompOffDate_controller.text = selectedList.compOffDate.toString();
    selectedList.leaveCode == "PAL"?employee_Mark_Leave_Controller.isPaternityLeave.value = true:false;
    employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = selectedList.isTwinBabies == 1?"Yes":"No";
    employee_Mark_Leave_Controller.babyName_controller.text = selectedList.babyName.toString();
    employee_Mark_Leave_Controller.babyGender_controller.text = selectedList.babyGender.toString();
    employee_Mark_Leave_Controller.babyBirthDate_controller.text = selectedList.babyBirthDate==null?"":selectedList.babyBirthDate.toString();
  }*/


}