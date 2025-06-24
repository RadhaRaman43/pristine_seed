import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/emp_infor_modal/leave_type_modal.dart';
import '../../CRM_VIewModels/emp_infor_system/mark_attendance_view_modal.dart';

class EmpMarkLeaveAddScreen extends StatelessWidget{
  MarkAttendanceViewmodel employee_Mark_Leave_Controller=Get.put(MarkAttendanceViewmodel());
  Size size=Get.size;


  static String _displayleavetypeForOption(LeaveTypeModel  option) =>
      option.description! +" (" +option.leaveCode!+")";

  static String _displayIsTwinBabiesForOption(String option) =>
      option;

  static String _displayBabiesGenderForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
   return WillPopScope( onWillPop: ()async{
     Get.offAllNamed(RoutesName.empMarkLeaveScreen);
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
             'Create Leave',
             style: GoogleFonts.poppins(
               color: AllColors.whiteColor,
               fontSize: 18.0,
               fontWeight: FontWeight.w700,
             ),
           ),
           
         ],
       ),
     ),
     drawer: CustomDrawer(),
     body:  Container(
       child: Column(
         children: [
           Expanded(
             child: SingleChildScrollView(
               child: Container(
                 padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                 child: Column(
                   children: [
                     bindFromDatePicker(context),
                     SizedBox(height: 10,),
                     bindEndDatePicker(context),
                     /*Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [


                                       ],
                                     ),*/
                     SizedBox(height: 10,),
                     Obx((){
                       return Visibility(
                         visible: employee_Mark_Leave_Controller.isDateDifferenceShow.value,
                         child: Container(
                           alignment: Alignment.centerLeft,
                           child: Text("You are applying for the ${employee_Mark_Leave_Controller.Datedifference.value} Days Leave",
                             style: GoogleFonts.poppins(
                               color: AllColors.redColor,
                               fontSize: AllFontSize.thirtine,
                               fontWeight: FontWeight.w600,
                             ),
                           ),
                         ),
                       );
                     }),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text(
                               'Is Half Day',
                               style: GoogleFonts.poppins(
                                 color: AllColors.primaryDark1,
                                 fontSize: AllFontSize.sisxteen,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             Obx((){
                               return Checkbox(
                                 value: employee_Mark_Leave_Controller.isHalfDay.value,
                                 onChanged: (value) {
                                   print('ishalfLeave${employee_Mark_Leave_Controller.isHalfDay.value}');
                                   employee_Mark_Leave_Controller.onHalfDayChanged(value);
                                 },);
                             })

                           ],
                         ),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text(
                               'Is Short Leave',
                               style: GoogleFonts.poppins(
                                 color: AllColors.primaryDark1,
                                 fontSize: AllFontSize.sisxteen,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             Obx((){
                               return Checkbox(
                                 value: employee_Mark_Leave_Controller.isShortLeave.value,
                                 onChanged: (value) {
                                   print('isShortLeave${employee_Mark_Leave_Controller.isShortLeave.value}');
                                   employee_Mark_Leave_Controller.onShortLeaveChanged(value);
                                 },);
                             })

                           ],
                         )
                       ],
                     ),
                     SizedBox(height: 10,),
                     Obx((){
                       return Visibility(
                         visible: employee_Mark_Leave_Controller.isShortLeave.value,
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Radio(
                                     value: 1,
                                     groupValue: employee_Mark_Leave_Controller.selectedRadio.value,
                                     onChanged: (value){
                                       employee_Mark_Leave_Controller.selectRadio(value!);
                                       employee_Mark_Leave_Controller.ShortLeaveTiming = (employee_Mark_Leave_Controller.ShortleaveTime_list[0].morningLeaveStart! +" - "+employee_Mark_Leave_Controller.ShortleaveTime_list[0].morningLeaveEnd!);

                                     }),


                                 /*  Text(
                                     employee_Mark_Leave_Controller.ShortleaveTime_list[0].morningLeaveStart! + " To " +
                                                       employee_Mark_Leave_Controller.ShortleaveTime_list[0].morningLeaveEnd!,
                                                   style: GoogleFonts.poppins(
                                                     color: AllColors.primaryDark1,
                                                     fontSize: AllFontSize.thirtine,
                                                     fontWeight: FontWeight.w600,
                                                   ),
                                                 ),*/

                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Obx((){
                                   return Radio(
                                       value: 2,
                                       groupValue: employee_Mark_Leave_Controller.selectedRadio.value,
                                       onChanged: (value){
                                         employee_Mark_Leave_Controller.selectRadio(value!);
                                         employee_Mark_Leave_Controller.ShortLeaveTiming = (employee_Mark_Leave_Controller.ShortleaveTime_list[0].eveningLeaveStart! +" - "+employee_Mark_Leave_Controller.ShortleaveTime_list[0].eveningLeaveEnd!);

                                       });
                                 }),

                                 /*  Text(
                                                   employee_Mark_Leave_Controller.ShortleaveTime_list[0].eveningLeaveStart! + " To " +
                                                       employee_Mark_Leave_Controller.ShortleaveTime_list[0].eveningLeaveEnd!,
                                                   style: GoogleFonts.poppins(
                                                     color: AllColors.primaryDark1,
                                                     fontSize: AllFontSize.thirtine,
                                                     fontWeight: FontWeight.w600,
                                                   ),
                                                 ),*/

                               ],
                             ),
                           ],

                         ),
                       );
                     }),
                     SizedBox(height: 10,),
                     Obx((){
                       return Visibility(
                           visible: employee_Mark_Leave_Controller.isLeaveType.value,
                           child: bindLeaveTypeDropDown(context));
                     }),

                     Obx((){
                       return Visibility(
                         visible: employee_Mark_Leave_Controller.isComprehensiveLeave.value,
                         child: Container(
                           child: Column(
                             children: [
                               SizedBox(height: 10.0,),
                               bindCompOffDatePicker(context),
                             ],
                           ),
                         ),
                       );
                     }),
                     SizedBox(height: 10,),
                     Obx((){
                       return  Visibility(
                         visible: employee_Mark_Leave_Controller.isPaternityLeave.value,
                         child: Container(
                           child: Column(
                             children: [
                               SizedBox(height: 10.0,),
                               bindisTwinBabiesDropDown(context),
                               SizedBox(height: 10.0,),
                               bindBabyName(context),
                               SizedBox(height: 10.0,),
                               bindBabyGender(context),
                               SizedBox(height: 10.0,),
                               bindBabyBirthDatePicker(context),
                               SizedBox(height: 10.0,),
                             ],
                           ),
                         ),
                       );
                     }),

                     SizedBox(height: 5.0,),
                     bindLeaveReason(context),

                   ],
                 ),
               ),
             ),
           ),
           SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Expanded(
                   child: DefaultButton(
                     text: "Reset",
                     press: () {
                       employee_Mark_Leave_Controller.clearField();

                     },
                   ),
                 ),
                 SizedBox(width: size.width * .035),
                 Expanded(
                     child: DefaultButton(
                       text: employee_Mark_Leave_Controller.LeaveAction=="Add"?"Create":"Update",
                       press: () {
                           employee_Mark_Leave_Controller. employeeLeaveMarkData(employee_Mark_Leave_Controller.LeaveAction);

                       },

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

  Widget bindEndDatePicker(context) {
    return Container(
      child: TextFormField(
        controller: employee_Mark_Leave_Controller.EndDate_controller,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
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
            )
        ),
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          // Get the start date and parse it
          String startDateText =
              employee_Mark_Leave_Controller.StartDate_controller.text;
          DateTime stating_date = startDateText.isNotEmpty
              ? DateFormat('yyyy-MM-dd').parse(startDateText)
              : DateTime.now();

          // Get the previously selected end date or use today
          String endDateText =
              employee_Mark_Leave_Controller.EndDate_controller.text;
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
            employee_Mark_Leave_Controller.EndDate_controller.text =
                outputFormat.format(date);
            calculateLeaveDays(); // Calculate the difference after selecting the end date
          }
        },
      ),
    );
  }

  Widget bindFromDatePicker(context) {
    return Container(
      child: TextFormField(
        controller: employee_Mark_Leave_Controller.StartDate_controller,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
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
            )
        ),
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          // Check if a date is already selected and parse it
          DateTime initialDate = DateTime.now();
          if (employee_Mark_Leave_Controller.StartDate_controller.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              employee_Mark_Leave_Controller.StartDate_controller.text,
            );
          }

          // Define the range of selectable dates
          DateTime stating_date = DateTime(1900);
          DateTime ending_date = DateTime(2200);

          // Remove focus from the field
          FocusScope.of(context).requestFocus(FocusNode());

          // Show the date picker
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate, // Use the previously selected date or today
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
            employee_Mark_Leave_Controller.StartDate_controller.text =
                outputFormat.format(date);
            if(employee_Mark_Leave_Controller.EndDate_controller.text.isNotEmpty){
              calculateLeaveDays();
            }
          }
        },
      ),
    );
  }

  Widget bindLeaveTypeDropDown(context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownMenu<LeaveTypeModel>(
        width: MediaQuery
            .of(context)
            .size
            .width-20,
        controller: employee_Mark_Leave_Controller.leaveCode_controller,
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


        onSelected: (LeaveTypeModel? selection) {
          print(selection!.description);
          employee_Mark_Leave_Controller.leaveCode_controller.text =
              _displayleavetypeForOption(selection).toString();
          employee_Mark_Leave_Controller.CompOffDate_controller.clear();
          employee_Mark_Leave_Controller.babyName_controller.clear();
          employee_Mark_Leave_Controller.babyGender_controller.clear();
          employee_Mark_Leave_Controller.babyBirthDate_controller.clear();

          employee_Mark_Leave_Controller.leave_selection.value=selection;
          //employee_Mark_Leave_Controller.task_no = selection.leaveCode!;

          if(selection.description == 'Comprehensive Leave'){
            employee_Mark_Leave_Controller.isComprehensiveLeave.value = true;
            employee_Mark_Leave_Controller.isPaternityLeave.value = false;
            employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = "";
          }else if(selection.description == 'Paternity Leave'){
            employee_Mark_Leave_Controller.isComprehensiveLeave.value = false;
            employee_Mark_Leave_Controller.isPaternityLeave.value = true;
            employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = "No";
          }else{
            print("Emplty");
            employee_Mark_Leave_Controller.isComprehensiveLeave.value = false;
            employee_Mark_Leave_Controller.isPaternityLeave.value = false;
            employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = "";

          }
          FocusScope.of(context).unfocus();
        },
        dropdownMenuEntries:
        employee_Mark_Leave_Controller.leaveType_data_list.map<
            DropdownMenuEntry<LeaveTypeModel>>((LeaveTypeModel e) {
          return DropdownMenuEntry<LeaveTypeModel>(
              value: e, label: e.description!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
    return Autocomplete<LeaveTypeModel >(
      displayStringForOption: _displayleavetypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return employee_Mark_Leave_Controller.leaveType_data_list.value;
        }
        
        return employee_Mark_Leave_Controller.leaveType_data_list
            .where((LeaveTypeModel  option) {
          return option.description
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (LeaveTypeModel  selection) {
        print(selection.description);
        employee_Mark_Leave_Controller.leaveCode_controller.text =
            _displayleavetypeForOption(selection).toString();
        employee_Mark_Leave_Controller.CompOffDate_controller.clear();
        employee_Mark_Leave_Controller.babyName_controller.clear();
        employee_Mark_Leave_Controller.babyGender_controller.clear();
        employee_Mark_Leave_Controller.babyBirthDate_controller.clear();

        employee_Mark_Leave_Controller.leave_selection.value=selection;
        //employee_Mark_Leave_Controller.task_no = selection.leaveCode!;

        if(selection.description == 'Comprehensive Leave'){
          employee_Mark_Leave_Controller.isComprehensiveLeave.value = true;
          employee_Mark_Leave_Controller.isPaternityLeave.value = false;
          employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = "";
        }else if(selection.description == 'Paternity Leave'){
          employee_Mark_Leave_Controller.isComprehensiveLeave.value = false;
          employee_Mark_Leave_Controller.isPaternityLeave.value = true;
          employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = "No";
        }else{
          employee_Mark_Leave_Controller.isComprehensiveLeave.value = false;
          employee_Mark_Leave_Controller.isPaternityLeave.value = false;
          employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = "";

        }


        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              // FocusScope.of(context).unfocus();
              employee_Mark_Leave_Controller.isComprehensiveLeave.value = false;
              employee_Mark_Leave_Controller.isPaternityLeave.value = false;
            }
            employee_Mark_Leave_Controller.leaveCode_controller.text = value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = employee_Mark_Leave_Controller.leaveCode_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten
              ),
              hintText: 'Type Of Leave',
              labelText: 'Type of Leave',
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
                            width: size.width * .8,
                            child: Tooltip(
                              message: option.description.toString()+" (${option.leaveCode.toString()})",
                              child: Text(
                                option.description.toString()+" (${option.leaveCode.toString()})",
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

  Widget bindCompOffDatePicker(context) {
    return Container(
      child: TextFormField(
        controller: employee_Mark_Leave_Controller.CompOffDate_controller,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffix: Icon(Icons.calendar_month),
            hintText: 'Comp off date',
            labelText: 'Comp off date',
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
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          DateTime stating_date = new DateTime(1900);
          DateTime ending_date = DateTime.now();
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: stating_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme:
                  ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            employee_Mark_Leave_Controller.CompOffDate_controller.text =
                outputFormat.format(date);
          else
            employee_Mark_Leave_Controller.CompOffDate_controller.text = "";
        },
      ),
    );
  }

  Widget bindisTwinBabiesDropDown(context) {
    return Container(
      padding: const EdgeInsets.only( right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-20,
        controller: employee_Mark_Leave_Controller.isTwinBabies_cobtroller,
        label: Text(
          "Is Twin Babies",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
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
          print(selection);
          employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text =
              _displayIsTwinBabiesForOption(selection!).toString();
          FocusScope.of(context).unfocus();

        },
        dropdownMenuEntries:
        employee_Mark_Leave_Controller.isTwinBabiesList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
    return Autocomplete<String >(
      displayStringForOption: _displayIsTwinBabiesForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return employee_Mark_Leave_Controller.isTwinBabiesList.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }

        return employee_Mark_Leave_Controller.isTwinBabiesList
            .where((String  option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String  selection) {
        print(selection);
        employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text =
            _displayIsTwinBabiesForOption(selection).toString();
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
            employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text = value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = employee_Mark_Leave_Controller.isTwinBabies_cobtroller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten
              ),

              hintText: 'Is Twin Babies',
              labelText: 'Is Twin Babies',
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
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String > onSelected,
          Iterable<String > suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: InkWell(
              child: Container(
                color: AllColors.grayColor,
                width: size.width * .8,
                height: size.height * .15,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final String  option = suggestions.elementAt(index);
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
                              width: size.width * .8,
                              child: Text(
                                option.toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
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
          ),
        );
      },
    );
  }

  Widget bindBabyName(context) {
    return TextFormField(
      controller: employee_Mark_Leave_Controller.babyName_controller,
      onChanged: (value) {
        employee_Mark_Leave_Controller.babyName_controller.text;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
          hintText: 'Baby Name',
          labelText: 'Baby Name',
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
      cursorColor: AllColors.primaryDark1,
    );
  }

  Widget bindBabyGender(context) {
    return Container(
      padding: const EdgeInsets.only( right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-20,
        controller: employee_Mark_Leave_Controller.babyGender_controller,
        label: Text(
          "Baby Gender",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
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
          print(selection);
          employee_Mark_Leave_Controller.babyGender_controller.text =
              _displayBabiesGenderForOption(selection!).toString();
          FocusScope.of(context).unfocus();
        },
        dropdownMenuEntries:
        employee_Mark_Leave_Controller.isBabiesGenderList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
    return Autocomplete<String >(
      displayStringForOption: _displayBabiesGenderForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return employee_Mark_Leave_Controller.isBabiesGenderList.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }

        return employee_Mark_Leave_Controller.isBabiesGenderList
            .where((String  option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String  selection) {
        print(selection);
        employee_Mark_Leave_Controller.babyGender_controller.text =
            _displayBabiesGenderForOption(selection).toString();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              FocusScope.of(context).unfocus();
            }
            employee_Mark_Leave_Controller.babyGender_controller.text = value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = employee_Mark_Leave_Controller.babyGender_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Baby Gender',
            labelText: 'Baby Gender',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String > onSelected,
          Iterable<String > suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: InkWell(
              child: Container(
                color: AllColors.grayColor,
                width: size.width * .8,
                height: size.height * .15,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final String  option = suggestions.elementAt(index);
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
                              width: size.width * .8,
                              child: Text(
                                option.toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
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
          ),
        );
      },
    );
  }

  Widget bindBabyBirthDatePicker(context) {
    return Container(
      child: TextFormField(
        controller: employee_Mark_Leave_Controller.babyBirthDate_controller,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            hintText: 'Baby Birth Date',
            labelText: 'Baby Birth Date',
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
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          // Check if a date is already selected and parse it
          DateTime initialDate = DateTime.now();
          if (employee_Mark_Leave_Controller.babyBirthDate_controller.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              employee_Mark_Leave_Controller.babyBirthDate_controller.text,
            );
          }

          // Define the range of selectable dates
          DateTime stating_date = DateTime.now();
          DateTime ending_date = DateTime(2200);

          // Remove focus from the field
          FocusScope.of(context).requestFocus(FocusNode());

          // Show the date picker
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate, // Use the previously selected date or today
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
            employee_Mark_Leave_Controller.babyBirthDate_controller.text =
                outputFormat.format(date);
          }
        },
      ),
    );
  }

  Widget bindLeaveReason(context) {
    return TextFormField(
      controller: employee_Mark_Leave_Controller.babyLeaveRerason_controller,
      // / keyboardType: TextInputType.number,
      onChanged: (value) {
        employee_Mark_Leave_Controller.babyLeaveRerason_controller.text;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
          hintText: 'Reason',
          labelText: 'Reason',
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
      cursorColor: AllColors.primaryDark1,
    );
  }

  void calculateLeaveDays() {
    String startDateText = employee_Mark_Leave_Controller.StartDate_controller.text;
    String endDateText = employee_Mark_Leave_Controller.EndDate_controller.text;

    if (startDateText.isNotEmpty && endDateText.isNotEmpty) {
      DateTime startDate = DateFormat('yyyy-MM-dd').parse(startDateText);
      DateTime endDate = DateFormat('yyyy-MM-dd').parse(endDateText);

      employee_Mark_Leave_Controller.Datedifference.value = endDate.difference(startDate).inDays + 1;
      employee_Mark_Leave_Controller.isDateDifferenceShow.value = true;
      print("Leave Days: ${employee_Mark_Leave_Controller.Datedifference.value}"); // Replace with your logic to display or use the result
    } else {
      print("Both start date and end date must be selected.");
    }
  }

  void openHolidaysListDialog(BuildContext context, Size size) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        if(employee_Mark_Leave_Controller.Annual_Holidays_list.length > 0) {

          return Container(
            width: double.infinity, // Adjust dialog width
            height: size.height * 0.5, // Adjust dialog height
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Holiday List',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Obx((){
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: employee_Mark_Leave_Controller.Annual_Holidays_list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          //padding: const EdgeInsets.only(top:0, bottom: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AllColors.blackColor,
                                    offset: Offset(0.5,1),
                                    blurRadius:2
                                )

                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  // color: Colors.blueAccent,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                                  ),
                                  child: Center(
                                    child: Text(employee_Mark_Leave_Controller.Annual_Holidays_list[index].dateMonth.toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.whiteColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: AllFontSize.twentee,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),

                                Text(employee_Mark_Leave_Controller.Annual_Holidays_list[index].date.toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.thhirty,
                                  ) ,
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Tooltip(
                                    message: employee_Mark_Leave_Controller.Annual_Holidays_list[index].description.toString(),
                                    child: Text(employee_Mark_Leave_Controller.Annual_Holidays_list[index].description.toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: AllFontSize.fourtine,
                                      ) ,
                                      overflow: TextOverflow.ellipsis,

                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Text(employee_Mark_Leave_Controller.Annual_Holidays_list[index].day.toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.blackColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: AllFontSize.twentee,
                                      ),

                                    ),
                                  ),
                                ),


                              ],
                            )
                        );
                      },
                    ),
                  );
                })

              ],
            ),
          );
        }
        return Container(
          width: double.infinity, // Adjust dialog width
          height: size.height * 0.5, // Adjust dialog height
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Holiday List',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: Image.asset("assets/images/no record found.jpg")),


            ],
          ),
        );

      },
    );
  }


}