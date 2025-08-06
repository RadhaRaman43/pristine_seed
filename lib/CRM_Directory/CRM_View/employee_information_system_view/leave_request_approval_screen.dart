

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/emp_infor_modal/mark_leave_request_modal.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/emp_infor_modal/leave_type_modal.dart';
import '../../CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';
import '../../CRM_VIewModels/emp_infor_system/emp_mark_leave_request_vm.dart';
import '../../CRM_VIewModels/emp_infor_system/leave_request_approval_vm.dart';

class LeaveRequestApprovalScreen extends StatelessWidget{

  final employeeLeaveRequestController = Get.put(LeaveRequestApprovalVm());
  Size size = Get.size;

  static String _displayleavetypeForOption(LeaveTypeModel option) =>
      option.description! + " (" + option.leaveCode! + ")";


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
                  'Mark Leave Approval',
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

            Spacer(),

            GestureDetector(
              onTap: (){
                diologForApproveReject(context, employeeLeaveRequestController
                    .employee_leave_data_Approval_list[index]);
              },
                child: Icon(Icons.update_sharp, color: AllColors.primaryDark1,)
            )


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


           /* Visibility(
              visible: employeeLeaveRequestController
                  .employee_leave_data_Approval_list[index].status?.toLowerCase()=="pending for approval",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                       diologForApproveReject(context, "Approve", employeeLeaveRequestController
                           .employee_leave_data_Approval_list[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: AllColors.primaryDark1,
                          border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          )
                      ),
                        child: Icon(Icons.check, color: Colors.blue,)),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: AllColors.primaryDark1,
                            border: Border.all(
                              color: Colors.red,
                              width: 2.0,
                            )
                        ),
                        child: Icon(Icons.close_outlined, color: Colors.red,)),
                  ),
                ],
              ),
            )*/

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

  void diologForApproveReject(context,MarkLeaveRequestModal employee_leave_data_approval_list) {
/*    var toDate=StaticMethod.convertDateFormat1(employee_leave_data_approval_list.toDate??"");
    var startDate=StaticMethod.convertDateFormat1(employee_leave_data_approval_list.fromDate??"");*/
    employeeLeaveRequestController.EndDate_controller.text=employee_leave_data_approval_list.toDate??"";
    employeeLeaveRequestController.StartDate_controller.text=employee_leave_data_approval_list.fromDate??"";
    showModalBottomSheet(context: context, builder: (context){
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
                    "Leave Approve/Reject",
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

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AllColors.grayColor1, // Set the border color here
                            width: 1.0, // Adjust the border width if necessary
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            _buildLabelWithValue(
                              label: "Created By : ",
                              value: employee_leave_data_approval_list.createdFullName,
                            ),
                            _buildLabelWithValue(
                              label: "Leave Type : ",
                              value:employee_leave_data_approval_list.leaveDescription,
                            ),
                            _buildLabelWithValue(
                                label: "Start Date : ",
                                value: employee_leave_data_approval_list.fromDate
                            ),
                            _buildLabelWithValue(
                              label: "End Date : ",
                              value: employee_leave_data_approval_list.toDate,
                            ),
                          ],
                        ),
                      ),

                      Center(
                          child: Divider(
                            height: 1,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 10,),


                      Obx((){
                        employeeLeaveRequestController.approveReject_controller.value.text="Approve";
                        return bindAction(context);
                      }),
                      SizedBox(height: 10,),
                      bindLeaveTypeDropDown(context),
                      SizedBox(height: 10,),

                      bindFromDatePicker(context),
                      SizedBox(height: 10,),
                      bindEndDatePicker(context),

                      SizedBox(height: 20,),
                      Obx((){
                        return  Container(
                          width: size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(employeeLeaveRequestController.approveRejectFlag.value=="Approve"
                                  ?AllColors.primaryDark1:AllColors.redColor)
                            ),
                            child: Text(employeeLeaveRequestController.approveRejectFlag.value,
                              style: GoogleFonts.poppins(
                                color: AllColors.whiteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            onPressed: () {

                            },
                          ),
                        );
                      })



                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }


  Widget bindEndDatePicker(context) {
    return Container(
     // padding: const EdgeInsets.only(right: 10),
      child: TextFormField(
        controller: employeeLeaveRequestController.EndDate_controller,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Select End Date',
            labelText: 'Select End Date',
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
            )),
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          // Get the start date and parse it
         /* String startDateText =
              employeeLeaveRequestController.StartDate_controller.text;
          DateTime stating_date = startDateText.isNotEmpty
              ? DateFormat('yyyy-MM-dd').parse(startDateText)
              : DateTime.now();*/
          DateTime initialDate = DateTime.now();
          if (employeeLeaveRequestController
              .StartDate_controller.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              employeeLeaveRequestController.StartDate_controller.text,
            );
          }
          var ending_date=DateTime.now();
          if(employeeLeaveRequestController
              .EndDate_controller.text.isNotEmpty){
            ending_date = DateFormat('yyyy-MM-dd').parse(
              employeeLeaveRequestController.EndDate_controller.text,
            );
          }
        /*  // Get the previously selected end date or use today
          String endDateText =
              employeeLeaveRequestController.EndDate_controller.text;
          DateTime initialDate = endDateText.isNotEmpty
              ? DateFormat('yyyy-MM-dd').parse(endDateText)
              : stating_date;
          DateTime ending_date = DateTime(2200);*/
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: ending_date,
            firstDate: initialDate,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  colorScheme:
                  ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme:
                  ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );

          // Update the controller with the selected date
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null) {
            employeeLeaveRequestController.EndDate_controller.text =
                outputFormat.format(date);
            calculateLeaveDays(); // Calculate the difference after selecting the end date
          }
        },
      ),
    );
  }

  Widget bindFromDatePicker(context) {
    return Container(
      //padding: const EdgeInsets.only(right: 10),
      child: TextFormField(
        controller: employeeLeaveRequestController.StartDate_controller,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Select Start Date',
            labelText: 'Select Start Date',
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
            )),
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          // Check if a date is already selected and parse it
          DateTime initialDate = DateTime.now();
          if (employeeLeaveRequestController
              .StartDate_controller.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              employeeLeaveRequestController.StartDate_controller.text,
            );
          }
          var ending_date=DateTime.now();
          if(employeeLeaveRequestController
              .EndDate_controller.text.isNotEmpty){
            ending_date = DateFormat('yyyy-MM-dd').parse(
              employeeLeaveRequestController.EndDate_controller.text,
            );
          }


          // Define the range of selectable dates
         // DateTime stating_date = DateTime(1900);
         // DateTime ending_date = DateTime(2200);
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate:
            initialDate, // Use the previously selected date or today
            firstDate: initialDate,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  colorScheme:
                  ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme:
                  ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );

          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null) {
            employeeLeaveRequestController.StartDate_controller.text =
                outputFormat.format(date);
            if (employeeLeaveRequestController
                .EndDate_controller.text.isNotEmpty) {
              calculateLeaveDays();
            }
          }
        },
      ),
    );
  }

  void calculateLeaveDays() {
    String startDateText =
        employeeLeaveRequestController.StartDate_controller.text;
    String endDateText = employeeLeaveRequestController.EndDate_controller.text;

    if (startDateText.isNotEmpty && endDateText.isNotEmpty) {
      DateTime startDate = DateFormat('yyyy-MM-dd').parse(startDateText);
      DateTime endDate = DateFormat('yyyy-MM-dd').parse(endDateText);

      employeeLeaveRequestController.Datedifference.value =
          endDate.difference(startDate).inDays + 1;
      employeeLeaveRequestController.isDateDifferenceShow.value = true;
      print(
          "Leave Days: ${employeeLeaveRequestController.Datedifference.value}"); // Replace with your logic to display or use the result
    } else {
      print("Both start date and end date must be selected.");
    }
  }

  bindAction(BuildContext context) {
    return Container(
    padding: const EdgeInsets.only(right: 15),
    child: DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size
          .width-20,
      controller: employeeLeaveRequestController.approveReject_controller.value,
      label: Text(
        "Action",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w700),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AllColors.primaryDark1,),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
        print("hhdfg$selection");
        employeeLeaveRequestController.approveReject_controller.value.text =
            _displaySaleCycleActiveForOption(selection!)
                .toString();
        employeeLeaveRequestController.approveRejectFlag.value=selection;
      },
      dropdownMenuEntries:
      employeeLeaveRequestController.approveRejectList.map<
          DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    ),
    );
  }

  Widget bindLeaveTypeDropDown(context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownMenu<LeaveTypeModel>(
        width: MediaQuery.of(context).size.width - 20,
        controller: employeeLeaveRequestController.leaveCode_controller,
        label: Text(
          "Type Of Leave",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
        onSelected: (LeaveTypeModel? selection) {
          print(selection!.description);
          employeeLeaveRequestController.leaveCode_controller.text =
              _displayleavetypeForOption(selection).toString();
          employeeLeaveRequestController.CompOffDate_controller.clear();
          employeeLeaveRequestController.babyName_controller.clear();
          employeeLeaveRequestController.babyGender_controller.clear();
          employeeLeaveRequestController.babyBirthDate_controller.clear();

          employeeLeaveRequestController.leave_selection.value = selection;
          FocusScope.of(context).unfocus();
        },
        dropdownMenuEntries: employeeLeaveRequestController.leaveType_data_list
            .map<DropdownMenuEntry<LeaveTypeModel>>((LeaveTypeModel e) {
          return DropdownMenuEntry<LeaveTypeModel>(
              value: e,
              label: e.description!,
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(AllColors.primaryDark1),
              ));
        }).toList(),
      ),
    );
  }
}