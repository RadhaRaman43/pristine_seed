import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/dashboard_models/funnel_dashboard_model/funnel_Dashboard_model.dart';
import '../../CRM_VIewModels/Dashboard_VM/funnel_dashboard_Vm.dart';

class FunnelDashboardView extends StatelessWidget{
  FunnelDashboardView({super.key});

  final dashboard_view_Controller = Get.put(FunnelDashboardVm());
  Size size=Get.size;

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
                  //  showFilterBottomSheet(context);
                  }, icon: Icon(Icons.filter_alt_sharp))
                ],
              )
          ),
          drawer: CustomDrawer(),
          body: Column(
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
                          padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
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
                              SizedBox(width: 10,),
                              Obx((){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0 ,right: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
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
                                      Column(
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
                                      Column(
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
                          Text(
                            'User Wise Data List',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),


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
    String? Due_Date=StaticMethod.convertDateFormat1( dashboard_view_Controller.funnelDashboardUserWiseDataList[position].taskDueDate ?? "");
    String? LastActivityUpdatedOn=StaticMethod.convertDateFormat1( dashboard_view_Controller.funnelDashboardUserWiseDataList[position].lastActivityUpdatedOn ?? "");
    String? createdOn=StaticMethod.dateTimeToDate( dashboard_view_Controller.funnelDashboardUserWiseDataList[position].createdOn ?? "");
    String taskStatus =  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].taskStatus!;
    String pipeLine = dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
        .taskDueTime!.isNotEmpty ? "|" : "";
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
                    "Task Status : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
                          .taskStatus!,
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .taskStatus!,
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
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .taskId!,
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .taskId!,
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
                    "Manager Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    dashboard_view_Controller
                        .funnelDashboardUserWiseDataList[position]
                        .approvedFullName!,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),*/
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
                          .contactName!,
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .contactName!,
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
                          .contactName!,
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .contactName!,
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
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .typeOfCall!,
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .typeOfCall!,
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
                    "Method of Call : ",
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
                          .methodOfCall??"",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
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
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .taskDueDate,
                      child: Text(" ${dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
                          .taskDueDate ??
                          ""} ${pipeLine} ${dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
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
                      message: dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position].taskRemarks ?? "",
                      child: Text(
                        dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position].taskRemarks ?? "",
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
                        message: dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .rejectReason??"",
                        child: Text(
                          dashboard_view_Controller
                              .funnelDashboardUserWiseDataList[position]
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
          // trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
        ),
      ),
    );
  }



}

class FunnelData {
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
}

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
        tooltipBehavior: TooltipBehavior(enable: true),
        palette: <Color>[
          Colors.blue,
          Colors.orange,
          Colors.green,

        ],
        series: PyramidSeries<PyramidData, String>(
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



