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
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (businessTourPlanController.total_rows /
              businessTourPlanController.rowsPerPage)
              .toInt();
          if ((businessTourPlanController.total_rows %
              businessTourPlanController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${businessTourPlanController.pageNumber} ${businessTourPlanController.total_rows} ${businessTourPlanController.rowsPerPage} ${total_page}");


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
          businessTourPlanController.getBusinessTourPlanDetailsApi(businessTourPlanController.BusinessTourPlanList[position].tourId, "");
        },
        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(
              label: "Tour ID : ",
              value: businessTourPlanController.BusinessTourPlanList[position].tourId,
            ),
            _buildLabelWithValue(
              label: "Cluster: ",
              value: businessTourPlanController.BusinessTourPlanList[position].cluster,
              //width: size.width * 0.36,
            ),
            _buildLabelWithValue(
              label: "Region : ",
              value: businessTourPlanController.BusinessTourPlanList[position].region,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Frontliners : ",
              value: businessTourPlanController.BusinessTourPlanList[position].frontliners,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Touring Region : ",
              value: businessTourPlanController.BusinessTourPlanList[position].frontliners,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Status : ",
              value: businessTourPlanController.BusinessTourPlanList[position].status,
              // width: size.width * 0.36,
              color: getStatusColor(saleCycleStatus),
            ),
            _buildLabelWithValue(
              label: "Frontliners : ",
              value: businessTourPlanController.BusinessTourPlanList[position].frontliners,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Reporting Manager : ",
              value: businessTourPlanController.BusinessTourPlanList[position].reportingManager,
              // width: size.width * 0.36,

            ),

            _buildLabelWithValue(
              label: "Created By: ",
              value: businessTourPlanController.BusinessTourPlanList[position].createdFullName,
              //: size.width * 0.33,
            ),


            _buildLabelWithValue(
              label: "Created On: ",
              value: createdOn,
              //: size.width * 0.33,
            ),

            _buildLabelWithValue(
              label: "Reject Reason",
              value: businessTourPlanController.BusinessTourPlanList[position].rejectReason,
              //: size.width * 0.33,
            ),

            _buildLabelWithValue(
              label: "Approved/Rejected By: ",
              value: businessTourPlanController.BusinessTourPlanList[position].approvedFullName,
              //: size.width * 0.33,
            ),

            _buildLabelWithValue(
              label: "Approve On: ",
              value: approvedOn,
              //: size.width * 0.33,
            ),

          ],
        ),

        trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
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
    // accountMaster_page_controller.IsActive_controller.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
         // initialChildSize: 0.85,
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
                              SizedBox(
                                height: 10,
                              ),

                              TextField(
                                controller: businessTourPlanController.filterTourIdController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Tour ID',
                                    hintText: 'Tour ID',
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
                                controller: businessTourPlanController.filterClusterNameController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Cluster Name',
                                    hintText: 'Cluster Name',
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
                                controller: businessTourPlanController.filterTouringRegionController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Touring Region',
                                    hintText: 'Touring Region',
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
                                controller: businessTourPlanController.filterTouringNameController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Region Name',
                                    hintText: 'Region Name',
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
                                controller: businessTourPlanController.filterCreatedByController.value,
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
                              ),
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
                  ),
                ],
              ),
            );
          },

        );
      },
    );
  }


}