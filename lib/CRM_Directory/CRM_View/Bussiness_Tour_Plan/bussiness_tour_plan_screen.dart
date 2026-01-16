import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_VIewModels/Bussiness_Tour_Plan_Vm/BusinessPlanTour_Vm.dart';

class BussinessTourPlanScreen extends StatelessWidget{
  BussinessTourPlanScreen({super.key});

  BusinessPlanTourViewModel businessTourPlanController=Get.put(BusinessPlanTourViewModel());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Get.toNamed(RoutesName.homeScreen);
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
                  'Business Tour Plan',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: (){
                  businessTourPlanController.startDateController.value.clear();
                  businessTourPlanController.endDateController.value.clear();
                  businessTourPlanController.touringRegionController.value.clear();
                  OpenDialogToCreateBTP(context);
                },
                    icon: Icon(Icons.add)),
                IconButton(onPressed: () {
                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh:businessTourPlanController.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:businessTourPlanController.loading.value ,
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
                              businessTourPlanController.filterStatusFlag.value == 'PENDING'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Pending',
                                style: GoogleFonts.poppins(
                                  color: businessTourPlanController.filterStatusFlag.value == 'PENDING'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                businessTourPlanController.filterStatusFlag.value = 'PENDING';
                                businessTourPlanController.pageNumber=0;
                                businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              businessTourPlanController.filterStatusFlag.value == 'PENDING FOR APPROVAL'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Pending For Approval',
                                style: GoogleFonts.poppins(
                                  color: businessTourPlanController.filterStatusFlag.value == 'PENDING FOR APPROVAL'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                businessTourPlanController.filterStatusFlag.value = 'PENDING FOR APPROVAL';
                                businessTourPlanController.pageNumber=0;
                                businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
                              },
                            );
                          }),
                          SizedBox(width: 8), // optional spacing between chips
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              businessTourPlanController.filterStatusFlag.value == 'APPROVED'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Approved / Reject',
                                style: GoogleFonts.poppins(
                                  color: businessTourPlanController.filterStatusFlag.value == 'APPROVED'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                businessTourPlanController.filterStatusFlag.value = 'APPROVED';
                                businessTourPlanController.pageNumber=0;
                                businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
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
    if (businessTourPlanController.BusinessTourPlanList.value.isNotEmpty && businessTourPlanController.BusinessTourPlanList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          int total_page = (businessTourPlanController.total_rows / businessTourPlanController.rowsPerPage).toInt();
          if ((businessTourPlanController.total_rows %
              businessTourPlanController.rowsPerPage) > 0) total_page += 1;
          print("last index ${businessTourPlanController.pageNumber} ${businessTourPlanController.total_rows} ${businessTourPlanController.rowsPerPage} ${total_page}");
          if (businessTourPlanController.pageNumber + 1 < total_page) {
            businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber + 1,);
            businessTourPlanController.pageNumber += 1;
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
          itemCount: businessTourPlanController.BusinessTourPlanList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    var createdOn=StaticMethod.dateTimeToDate(businessTourPlanController.BusinessTourPlanList[position].createdOn??"");
    var approvedOn=StaticMethod.dateTimeToDate(businessTourPlanController.BusinessTourPlanList[position].approvedOn??"");
    String saleCycleStatus = businessTourPlanController.BusinessTourPlanList[position].status??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'PENDING' || 'Pending':
          return Colors.yellow[900]!;
        case 'Rejected' || 'REJECTED':
          return AllColors.redColor;
        case 'APPROVED' || 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL' || 'Pending For Approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          businessTourPlanController.getBusinessTourPlanDetailsApi(businessTourPlanController.BusinessTourPlanList[position].tourId, "TourDetail");
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Tour ID : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  child: Tooltip(
                    message: businessTourPlanController.BusinessTourPlanList[position].tourId?? "",
                    child: Text(
                      businessTourPlanController.BusinessTourPlanList[position].tourId?? "",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color:Colors.blue,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
          ],
        ),
        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(
              label: "Cluster: ",
              value: businessTourPlanController.BusinessTourPlanList[position].cluster,
            ),
            _buildLabelWithValue(
              label: "Region : ",
              value: businessTourPlanController.BusinessTourPlanList[position].region,
            ),
            _buildLabelWithValue(
              label: "Touring Region : ",
              value: businessTourPlanController.BusinessTourPlanList[position].touringRegion,
            ),
            _buildLabelWithValue(
              label: "Status : ",
              value: businessTourPlanController.BusinessTourPlanList[position].status,
              color: getStatusColor(saleCycleStatus),
            ),
            _buildLabelWithValue(
              label: "Start Date : ",
              value: businessTourPlanController.BusinessTourPlanList[position].startDate,
            ),
            _buildLabelWithValue(
              label: "End Date : ",
              value: businessTourPlanController.BusinessTourPlanList[position].endDate,
            ),
            _buildLabelWithValue(
              label: "Reporting Manager : ",
              value: businessTourPlanController.BusinessTourPlanList[position].reportingFullName,
            ),
            _buildLabelWithValue(
              label: "Created By: ",
              value: businessTourPlanController.BusinessTourPlanList[position].createdFullName,
            ),
            _buildLabelWithValue(
              label: "Created On: ",
              value: createdOn,
            ),
            Visibility(
              visible: (saleCycleStatus=="Rejected" || saleCycleStatus=="REJECTED" || saleCycleStatus=="APPROVED"|| saleCycleStatus=="Approved"),
              child: _buildLabelWithValue(
                label: "Reject Reason",
                value: businessTourPlanController.BusinessTourPlanList[position].rejectReason,
              ),
            ),
            _buildLabelWithValue(
              label: "Approved/Rejected By: ",
              value: businessTourPlanController.BusinessTourPlanList[position].approvedFullName,
            ),
            Visibility(
                visible: (saleCycleStatus=="Rejected" || saleCycleStatus=="REJECTED" || saleCycleStatus=="APPROVED"|| saleCycleStatus=="Approved"),
                child: _buildLabelWithValue(
                label: "Approve On: ",
                value: approvedOn,
              ),),

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
            ),
          ),
        ),
      ],
    );
  }

  void OpenDialogToCreateBTP(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Create Tour',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
             // height: size.height*.6,
              width: size.width*45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: businessTourPlanController.touringRegionController.value,
                      decoration: InputDecoration(
                          hintText: "Touring Region",
                          labelText: "Touring Region",
                          //suffixIcon: Icon(Icons.email),
                          hintStyle: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.ten),
                          labelStyle: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w500,
                              fontSize: AllFontSize.sisxteen),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AllFontSize.ten,
                              horizontal: AllFontSize.ten),

                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),
                  ),
                  SizedBox(height: 10,),
                  bindStartDatePicker(context),
                  SizedBox(height: 10,),
                  bindEndDatePicker(context),
                  SizedBox(height: 15,),
                  Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      text: 'Create',
                      press: (){
                        businessTourPlanController.BusinessTourPlanHeaderCreate();
                        Get.back();

                      },
                    ),
                  ),
                ],
              )
                ],
              ),
            ),
          );
        }
    );
  }

  Widget bindStartDatePicker(context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        controller: businessTourPlanController.startDateController.value,
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
          if (businessTourPlanController.startDateController.value.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              businessTourPlanController.startDateController.value.text,
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
            initialDate:
            initialDate, // Use the previously selected date or today
            firstDate: stating_date,
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
            businessTourPlanController.startDateController.value.text =
                outputFormat.format(date);
          }
        },
      ),
    );
  }


  Widget bindEndDatePicker(context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        controller: businessTourPlanController.endDateController.value,
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
          String startDateText =
              businessTourPlanController.startDateController.value.text;
          DateTime stating_date = startDateText.isNotEmpty
              ? DateFormat('yyyy-MM-dd').parse(startDateText)
              : DateTime.now();

          // Get the previously selected end date or use today
          String endDateText =
              businessTourPlanController.endDateController.value.text;
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
            businessTourPlanController.endDateController.value.text = outputFormat.format(date);

          }
        },
      ),
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
                mainAxisSize: MainAxisSize.max, // Ensure minimal height
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10,),
                              bindfilterText(context,'Tour ID',businessTourPlanController.filterTourIdController.value),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindfilterText(context,'Touring Region',businessTourPlanController.filterTouringRegionController.value),
                              SizedBox(height: 10,),
                              bindFilterStartDate(context),
                              SizedBox(height: 10,),
                              bindFilterEndDate(context),
                              SizedBox(height: 10,),
                              bindfilterText(context,'Created By',businessTourPlanController.filterCreatedByController.value),
                              SizedBox(height: 10,),
                              bindCrteatedOn(context),

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
                            businessTourPlanController.clearFilterData();
                            businessTourPlanController.clearAllFieldOfFilter();
                            businessTourPlanController.pageNumber=0;
                            businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            businessTourPlanController.pageNumber = 0;
                            businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            businessTourPlanController.SaveFilterData();
                          },
                        )),
                      ],
                    ),
                  ),

                 /* Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
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
                              businessTourPlanController.pageNumber = 0;
                              businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
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
                              businessTourPlanController.clearAllFieldOfFilter();
                              businessTourPlanController.pageNumber=0;
                              businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);

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
                  ),*/
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


  bindFilterStartDate(BuildContext context) {
    return  TextFormField(
      controller: businessTourPlanController.StartDate_filter_controller.value,
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
        if (businessTourPlanController.StartDate_filter_controller.value.text.isNotEmpty) {
          initialDate = DateFormat('yyyy-MM-dd').parse(
            businessTourPlanController.StartDate_filter_controller.value.text,
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
        businessTourPlanController.StartDate_filter_controller.value.text =
            outputFormat.format(date!);

      },
    );
  }

  bindFilterEndDate(BuildContext context) {
    return  TextFormField(
      controller: businessTourPlanController.EndDate_filter_controller.value,
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
            businessTourPlanController.StartDate_filter_controller.value.text;
        DateTime stating_date = startDateText.isNotEmpty
            ? DateFormat('yyyy-MM-dd').parse(startDateText)
            : DateTime.now();

        // Get the previously selected end date or use today
        String endDateText =
            businessTourPlanController.EndDate_filter_controller.value.text;
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
          businessTourPlanController.EndDate_filter_controller.value.text =
              outputFormat.format(date);
        }
      },
    );
  }
  bindCrteatedOn(BuildContext context) {
    return  TextFormField(
      controller: businessTourPlanController.createdOn_filter_controller.value,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_month),
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Created On',
          hintText: 'Created On',
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
        if (businessTourPlanController.createdOn_filter_controller.value.text.isNotEmpty) {
          initialDate = DateFormat('yyyy-MM-dd').parse(
            businessTourPlanController.createdOn_filter_controller.value.text,
          );
        } else {
          initialDate = DateTime.now();
        }
        // Define the first and last date of the current year
        DateTime stating_date = DateTime(DateTime.now().year, 1, 1); // January 1st
        DateTime ending_date = DateTime(DateTime.now().year, 12, 31);

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
          businessTourPlanController.createdOn_filter_controller.value.text =
              outputFormat.format(date);
        }
      },
    );
  }

  bindfilterText(BuildContext context, String hintData, TextEditingController controller) {
    return   TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: hintData,
          hintText: hintData,
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

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = businessTourPlanController.clusterGetByEmailList;
      if (businessTourPlanController.clusterName_controller.value.text.isNotEmpty && businessTourPlanController.filterDataChecker.value=='1') {
        List<String> nameList = businessTourPlanController.clusterName_controller.value.text.split('|');
        businessTourPlanController.SelectedCluster_list.value =[];
        businessTourPlanController.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && businessTourPlanController.SelectedCluster_list.isEmpty) {
          businessTourPlanController.SelectedCluster_list.assignAll(availableItems);
          businessTourPlanController.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          businessTourPlanController.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = businessTourPlanController.SelectedCluster_list;
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
              tempSelected.addAll(businessTourPlanController.SelectedCluster_list);

              List<ClusterModal> allItems =
                  businessTourPlanController.clusterGetByEmailList;

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

                                    businessTourPlanController.filterDataChecker.value='';
                                    businessTourPlanController.SelectedCluster_list.assignAll(tempSelected);
                                    businessTourPlanController.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    businessTourPlanController.getRegionsWithClusterFilterGetByEmail();

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
      final availableItems = businessTourPlanController.regionwithclusterGetByEmailList;
      if (businessTourPlanController.RegionName_controller.value.text.isNotEmpty && businessTourPlanController.filterDataChecker.value=='1') {
        businessTourPlanController.SelectedRegion_list.value=[];
        List<String> nameList = businessTourPlanController.RegionName_controller.value.text.split('|');
        businessTourPlanController.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && businessTourPlanController.SelectedRegion_list.isEmpty) {
          businessTourPlanController.SelectedRegion_list.assignAll(availableItems);
          businessTourPlanController.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join(',');
          print("bind region ${businessTourPlanController.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = businessTourPlanController.SelectedRegion_list;
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
              tempSelected.addAll(businessTourPlanController.SelectedRegion_list);

              final allItems = businessTourPlanController.regionwithclusterGetByEmailList;

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
                                    businessTourPlanController.filterDataChecker.value='';
                                    businessTourPlanController.SelectedRegion_list.assignAll(tempSelected);
                                    businessTourPlanController.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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

}