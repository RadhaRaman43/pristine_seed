import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/Dashboard_VM/funnel_dashboard_Vm.dart';

class FunnelDashboardView extends StatelessWidget{
  FunnelDashboardView({super.key});

  final dashboard_view_Controller = Get.put(FunnelDashboardVm());
  Size size=Get.size;

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayCommitStatusForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
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
                    'Funnel Dashboard',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 17.0,
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
          body: RefreshIndicator(
            onRefresh: (){
              return dashboard_view_Controller.onRefereshMethod();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return Visibility(
                    visible: dashboard_view_Controller.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.green,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Expanded(
                    child: ListView(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 15.0, bottom: 0.0, top: 15.0),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Active Funnel',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Obx((){
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0 ,right: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            dashboard_view_Controller.clearAllFilterController();
                                            dashboard_view_Controller.SelectedTabForApi = 'Suspect';
                                            dashboard_view_Controller.pageNumber = 0;
                                            dashboard_view_Controller.funnelDashboardData();
                                           // dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);
                                          },
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.green[50],
                                              border: Border.all(
                                                color: AllColors.skyBlue, // Set the border color here
                                                width: 1.0, // Adjust the border width if necessary
                                              ),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '1. Suspect',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.blackColor,
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '${dashboard_view_Controller.totalSuspectPrice}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.green,
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            dashboard_view_Controller.clearAllFilterController();
                                            dashboard_view_Controller.SelectedTabForApi = 'Prospect';
                                            dashboard_view_Controller.pageNumber = 0;
                                            dashboard_view_Controller.funnelDashboardData();
                                           // dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);
                                          },
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.amber[50],
                                              border: Border.all(
                                                color: AllColors.skyBlue, // Set the border color here
                                                width: 1.0, // Adjust the border width if necessary
                                              ),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '2. Prospect',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.blackColor,
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '${dashboard_view_Controller.totalProspectPrice}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.orange,
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            dashboard_view_Controller.clearAllFilterController();
                                            dashboard_view_Controller.SelectedTabForApi = 'Propose';
                                            dashboard_view_Controller.pageNumber = 0;
                                            dashboard_view_Controller.funnelDashboardData();
                                           // dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);
                                          },
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              border: Border.all(
                                                color: AllColors.skyBlue, // Set the border color here
                                                width: 1.0, // Adjust the border width if necessary
                                              ),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '3. Propose',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.blackColor,
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '${dashboard_view_Controller.totalProposePrice}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.blue,
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  );
                                })

                              ],
                            ),


                        ),

                        Obx(() {
                          return BindDashboardFunnelChartData(context);
                        }),
                        Container(
                            padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                            child:
                            Obx((){
                              return  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    dashboard_view_Controller.SelectedTabForApi.isEmpty?
                                    'All Details':dashboard_view_Controller.SelectedTabForApi,
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    '(' +dashboard_view_Controller.total_rows.value.toString()+')',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.redColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              );
                            })
                        ),

                        Divider(
                          height: 1,
                          color: AllColors.lightgreyColor,
                        ),
                        Container(
                          height: size.height/2,
                          child: Obx(() {
                            return BindDashboardWiseDataList(context);
                          }),
                        )
                      ],
                    )),



              ],
            ),
          ),
        ),
    );

  }

  Widget BindDashboardFunnelChartData(BuildContext context) {
    /*if (dashboard_view_Controller.isShimmerLoading.value) {
      return BarChartShimmer(context);
    } else*/ if (dashboard_view_Controller.funnelDashboardList.isEmpty) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assests/images/data-analytics.png", width: 150, height: 150,),
              Text('No Record Found',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20,)
            ],
          )
      );
    } else {

      return PyramidChartWidget(
        suspect: double.tryParse(dashboard_view_Controller.totalSuspectPrice.value) ?? 0,
        prospect: double.tryParse(dashboard_view_Controller.totalProspectPrice.value) ?? 0,
        propose: double.tryParse(dashboard_view_Controller.totalProposePrice.value) ?? 0,
      );
    }
  }


  Widget BindDashboardWiseDataList(context) {
    if (dashboard_view_Controller.funnelDashboardUserWiseDataList.value.isNotEmpty && dashboard_view_Controller.funnelDashboardUserWiseDataList.value.length > 0) {
      print("ghd");
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (dashboard_view_Controller.total_rows.value /
              dashboard_view_Controller.rowsPerPage)
              .toInt();
          if ((dashboard_view_Controller.total_rows.value %
              dashboard_view_Controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${dashboard_view_Controller.pageNumber} ${dashboard_view_Controller.total_rows.value} ${dashboard_view_Controller.rowsPerPage} ${total_page}");
          if (dashboard_view_Controller.pageNumber + 1 < total_page) {
            dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber+1);
            dashboard_view_Controller.pageNumber += 1;
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
          itemCount: dashboard_view_Controller.funnelDashboardUserWiseDataList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assests/images/no_data_remove.png", width: 150, height: 150,),
              Text('No Record Found',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w700),
              )
            ],
          ));
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    String taskStatus =  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].salesCycleStatus??"";
    Color getStatusColor(String status) {
      switch (status.toUpperCase()) {
        case 'PENDING':
          return Colors.brown[900]!;
        case 'REJECTED':
          return Colors.red;
        case 'APPROVED':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          onTap: () {

          },
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sales Cycle Stage : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
                          .salesCycleStatus??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .salesCycleStatus??"",
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
                    "Sales Cycle Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .salesCycleId??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .salesCycleId??"",
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
                    "Task Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .taskId??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
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
                    "Quote Accepted	: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .quoteAccepted??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .quoteAccepted??"",
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
                    "Approval Status: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .salesCycleApprovalStatus??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .salesCycleApprovalStatus??"",
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
                    "Customer Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    child: Container(
                      width: size.width * .4,
                      child: Tooltip(
                        message: dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .accountName ?? "",
                        child: Text(
                          dashboard_view_Controller
                              .funnelDashboardUserWiseDataList[position]
                              .accountName ??
                              "" + " | ${dashboard_view_Controller
                                  .funnelDashboardUserWiseDataList[position]
                                  .accountName ?? ""}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Customer Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .contactName??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
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
                    "Contact Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .contactName??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
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
                    "Created By : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .createdFullName??"" +
                          "| ${StaticMethod.dateTimeToDate(
                              dashboard_view_Controller
                                  .funnelDashboardUserWiseDataList[position]
                                  .createdOn??"")}",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .createdFullName??"" +
                            "| ${StaticMethod.dateTimeToDate(
                                dashboard_view_Controller
                                    .funnelDashboardUserWiseDataList[position]
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

              Visibility(
                visible: dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
                    .salesCycleApprovalStatus == 'Rejected' ? true : false,
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
                        message: dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .rejectReason??"",
                        child: Text(
                          dashboard_view_Controller
                              .funnelDashboardUserWiseDataList[position]
                              .rejectReason??"",
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
          // trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
        ),
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
                          "Dashboard Filter ",
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
                              RadioGroupDateRangeFilter(context),
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

                              dashboard_view_Controller.pageNumber = 0;
                              dashboard_view_Controller.funnelDashboardData();
                              Get.back();
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

                              dashboard_view_Controller.clearAllFilterController();
                              dashboard_view_Controller.pageNumber = 0;
                              dashboard_view_Controller.funnelDashboardData();
                              Get.back();

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

  RadioGroupDateRangeFilter(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            //margin: EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColors.grayColor, // Set the border color here
                width: 1.0, // Adjust the border width if necessary
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date Ranges',
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                    fontSize: AllFontSize.twentee),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx((){
                    return RadioListTile<String>(
                      title: const Text('Day' , style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Day',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                        dashboard_view_Controller.DateRange('day');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.funnelDashboardData();
                        Get.back();
                      },
                    );
                  }),

                  Obx((){
                    return RadioListTile<String>(
                      title: const Text('Weakly' , style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Weakly',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                        dashboard_view_Controller.DateRange('week');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.funnelDashboardData();
                        Get.back();
                      },
                    );
                  }),

                  Obx((){
                    return RadioListTile<String>(
                      title: const Text('Month' ,style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Month',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                        dashboard_view_Controller.DateRange('month');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.funnelDashboardData();
                        Get.back();
                      },
                    );
                  }),

                  Obx((){
                    return  RadioListTile<String>(
                      title: const Text('Quarterly', style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Quarterly',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                        dashboard_view_Controller.DateRange('quarterly');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.funnelDashboardData();
                        Get.back();
                      },
                    );
                  }),

                  Obx((){
                    return RadioListTile<String>(
                      title: const Text('Financial Year', style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Financial Year',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                        dashboard_view_Controller.DateRange('financial');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.funnelDashboardData();
                        Get.back();
                      },
                    );
                  }),

                  Obx((){
                    return RadioListTile<String>(
                      title: const Text('Custom', style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Custom',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                      },

                    );
                  }),

                  Obx((){
                    return filterWithCustomDate(context);
                  })


                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          bindSalesStageStatus(context),
          SizedBox(height: 10),
          bindQuoteSubmitted(context),
          SizedBox(height: 10),
          bindCustomerNameFilter(context),
          SizedBox(height: 10),
          bindAccountOwnerFilter(context),
          SizedBox(height: 10),
          bindProductCategoryFilter(context),
          SizedBox(height: 10),
          bindIsCommitDropDown(context),
          SizedBox(height: 10),
          bindClusterNameFilter(context),
          SizedBox(height: 10),
          bindRegionNameFilter(context),



        ],

      ),

    );
  }

  filterWithCustomDate(BuildContext context) {
    return IgnorePointer(
      ignoring: dashboard_view_Controller.character.value != "Custom",
      child: TextField(
        cursorColor: AllColors.primaryDark1,
        controller: dashboard_view_Controller.filterCustomDateController.value,
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          suffixIcon: Icon(Icons.calendar_month),
          hintText: 'Select Start Date -End Date',
          labelText: 'Date Range',
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
            dashboard_view_Controller.formattedStartDate.value = startDate;
            dashboard_view_Controller.formattedEndDate.value = endDate;
            dashboard_view_Controller.filterCustomDateController.value.text =
            '$startDate - $endDate';
          } else {
            dashboard_view_Controller.filterCustomDateController.value.text = '';
            dashboard_view_Controller.formattedStartDate.value = '';
            dashboard_view_Controller.formattedEndDate.value = '';
          }
        },
      ),
    );
  }

  bindSalesStageStatus(BuildContext context) {
    return Obx((){
      return DropdownSearch<String>.multiSelection(
        items: dashboard_view_Controller.SalesCycleStageStatusList,
        itemAsString: (String u) => u,
        selectedItems: dashboard_view_Controller.selectedSalesStageStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.selectedSalesStageStatusList.isNotEmpty?"Sales Cycle Stage":null,
            hintText: "Sales Cycle Stage",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Sales Cycle Stage",
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
              selectedItems.map((e) => e).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<String> selectedList) {
          dashboard_view_Controller.selectedSalesStageStatusList.value =
              selectedList;
          dashboard_view_Controller.StageName_controller.value.text =
              selectedList.map((e) => e).join(', ');
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

          itemBuilder: (context, item, isSelected) =>
              ListTile(
                title: Text(item),
              ),
        ),
      );
    });

  }

  bindCustomerNameFilter(BuildContext context) {
    return Obx((){
      return  DropdownSearch<AccountMasterModel>.multiSelection(
        items: dashboard_view_Controller.Account_Master_list,
        itemAsString: (AccountMasterModel u) => u.accountName??"",
        selectedItems: dashboard_view_Controller.SelectedAccount_Master_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedAccount_Master_list.isNotEmpty?"Customer Name":null,
            hintText: "Customer Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              " Customer Name",
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
              selectedItems.map((e) => e.accountName).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<AccountMasterModel> selectedList) {
          dashboard_view_Controller.SelectedAccount_Master_list.value =
              selectedList;
          dashboard_view_Controller.CustomerName_controller.value.text =
              selectedList.map((e) => e.accountName).join(', ');
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
                title: Text(item.accountName??""),
              ),
        ),
      );
    });

  }

  bindAccountOwnerFilter(BuildContext context) {
    return Obx((){
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: dashboard_view_Controller.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: dashboard_view_Controller.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedEmployee_Member_list.isNotEmpty?"Account Owner":null,
            hintText: "Account Owner",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              " Account Owner",
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
          dashboard_view_Controller.SelectedEmployee_Member_list.value =
              selectedList;
          dashboard_view_Controller.AccountOwner_controller.value.text =
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

  bindProductCategoryFilter(BuildContext context) {
    return Obx((){
      return  DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: dashboard_view_Controller.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName??"",
        selectedItems: dashboard_view_Controller.SelectedProductCategory_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedProductCategory_list.isNotEmpty?"Product Category":null,
            hintText: "Product Category",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
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
          dashboard_view_Controller.SelectedProductCategory_list.value =
              selectedList;
          dashboard_view_Controller.ProductCategory_controller.value.text =
              selectedList.map((e) => e.categoryName).join(', ');
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
                title: Text(item.categoryName??""),
              ),
        ),
      );
    });

  }

  bindClusterNameFilter(BuildContext context) {
    return Obx((){
      return  DropdownSearch<ClusterModal>.multiSelection(
        items: dashboard_view_Controller.clusterGetByEmailList,
        itemAsString: (ClusterModal u) => u.geoValue??"",
        selectedItems: dashboard_view_Controller.SelectedCluster_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedCluster_list.isNotEmpty?"Cluster Name":null,
            hintText: "Cluster Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Cluster Name",
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
              selectedItems.map((e) => e.geoValue).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<ClusterModal> selectedList) {
          dashboard_view_Controller.SelectedCluster_list.value =
              selectedList;
          dashboard_view_Controller.clusterName_controller.value.text =
              selectedList.map((e) => e.geoValue).join(', ');
          dashboard_view_Controller.getRegionsWithClusterFilterGetByEmail();
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
                title: Text(item.geoValue??""),
              ),
        ),
      );
    });

  }

  bindRegionNameFilter(BuildContext context) {
    return Obx((){
      return  DropdownSearch<RegionWithClusterFilterModal>.multiSelection(
        items: dashboard_view_Controller.regionwithclusterGetByEmailList,
        itemAsString: (RegionWithClusterFilterModal u) => u.geoValue??"",
        selectedItems: dashboard_view_Controller.SelectedRegion_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedRegion_list.isNotEmpty?"Region Name":null,
            hintText: "Region Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Region Name",
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
              selectedItems.map((e) => e.geoValue).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<RegionWithClusterFilterModal> selectedList) {
          dashboard_view_Controller.SelectedRegion_list.value = selectedList;
          dashboard_view_Controller.RegionName_controller.value.text =
              selectedList.map((e) => e.geoValue).join(', ');
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
                title: Text(item.geoValue??""),
              ),
        ),
      );
    });

  }

  bindQuoteSubmitted(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width*.96,
      controller: dashboard_view_Controller.QuoteAccepted_controller.value,
      label: Text(
        "Quote Accepted",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w600),
      ),
      initialSelection: 'All',
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AllColors.primaryDark1,
          ),
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
        dashboard_view_Controller.QuoteAccepted_controller.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!)
                .toString();
      },

      dropdownMenuEntries: dashboard_view_Controller.quoteAcceptedList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e,
            label: e,
            style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(AllColors.primaryDark1),
            ));
      }).toList(),
    );
  }

  bindIsCommitDropDown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width*.96,
      controller: dashboard_view_Controller.IsCommit_controller.value,
      label: Text(
        "Is Commit",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w600),
      ),
     // initialSelection: 'ALL',
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AllColors.primaryDark1,
          ),
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
        dashboard_view_Controller.IsCommit_controller.value.text =
            _displayCommitStatusForOption(selection!)
                .toString();
      },

      dropdownMenuEntries: dashboard_view_Controller.isCommitList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e,
            label: e,
            style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(AllColors.primaryDark1),
            ));
      }).toList(),
    );
  }


}

/*class FunnelData {
  final String label;
  final double value;

  FunnelData(this.label, this.value);
}

class FunnelChartWidget extends StatelessWidget {
  final double propose;
  final double prospect;
  final double suspect;

  const FunnelChartWidget({
    super.key,
    required this.propose,
    required this.prospect,
    required this.suspect,
  });

  @override
  Widget build(BuildContext context) {
    final List<FunnelData> data = [
      FunnelData('Propose', propose),
      FunnelData('Prospect', prospect),
      FunnelData('Suspect', suspect),
    ];

    return SfFunnelChart(
      title: ChartTitle(text: 'Funnel Chart'),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: FunnelSeries<FunnelData, String>(
        dataSource: data,
        xValueMapper: (FunnelData data, _) => data.label,
        yValueMapper: (FunnelData data, _) => data.value,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.inside,
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        pointColorMapper: (FunnelData data, _) {
          switch (data.label) {
            case 'Propose':
              return Colors.blue;
            case 'Prospect':
              return Colors.orange;
            case 'Suspect':
              return Colors.green;
            default:
              return Colors.grey;
          }
        },
      ),
    );
  }
}*/


class PyramidData {
  final String stage;
  final double value;

  PyramidData(this.stage, this.value, );
}


class PyramidChartWidget extends StatelessWidget {
  final double suspect;
  final double prospect;
  final double propose;

  const PyramidChartWidget({
    super.key,
    required this.suspect,
    required this.prospect,
    required this.propose,
  });

  @override
  Widget build(BuildContext context) {
    final List<PyramidData> chartData = [
      PyramidData('Propose', propose),
      PyramidData('Prospect', prospect),
      PyramidData('Suspect', suspect),
    ];

    return Transform.rotate(
      angle: 3.1416,
      child: SfPyramidChart(
        tooltipBehavior: TooltipBehavior(enable: false),
        palette: <Color>[
          Colors.blue,
          Colors.orange,
          Colors.green,

        ],
        series: PyramidSeries<PyramidData, String>(
         // onPointTap: Utils.sanckBarError('sagduiasw', 'sduigsdiugh'),
          dataSource: chartData,
          xValueMapper: (PyramidData data, _) => data.stage,
          yValueMapper: (PyramidData data, _) => data.value,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            //labelPosition: ChartDataLabelPosition.inside,
          ),
        ),
      ),
    );
  }

}



