import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/Dashboard_VM/call_dashboard_vm.dart';

class CallDashboardViewScreen extends StatelessWidget{
  CallDashboardViewScreen({super.key});

  final dashboard_view_Controller = Get.put(CallDashboardVm());

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
                    'Call Dashboard',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {
                    //showFilterBottomSheet(context);
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
                            dashboard_view_Controller.selectedOption.value=="Cluster"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Cluster',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.selectedOption.value=="Cluster"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              //dashboard_view_Controller.filterQuoteAcceptedFlag.value = 'Cluster';
                              dashboard_view_Controller.selectedOption.value="Cluster";
                              //dashboard_view_Controller.pageNumber=0;
                             // dashboard_view_Controller.getsalesCycleData(dashboard_view_Controller.pageNumber, "", "",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8),
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                            backgroundColor:dashboard_view_Controller.selectedOption.value=="Region"

                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Region',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.selectedOption.value=="Region"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              //dashboard_view_Controller.filterQuoteAcceptedFlag.value = 'Region';
                              dashboard_view_Controller.selectedOption.value = "Region";
                              //dashboard_view_Controller.pageNumber=0;
                              //dashboard_view_Controller.getsalesCycleData(dashboard_view_Controller.pageNumber, "", "",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8), // optional spacing between chips
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                            backgroundColor:dashboard_view_Controller.selectedOption.value=="Employee"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Employee',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.selectedOption.value=="Employee"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              //dashboard_view_Controller.filterQuoteAcceptedFlag.value = 'Employee';
                              dashboard_view_Controller.selectedOption.value="Employee";
                             // dashboard_view_Controller.pageNumber=0;
                             // dashboard_view_Controller.getsalesCycleData(dashboard_view_Controller.pageNumber, "", "",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),

              Obx(() {
                return BindDashboardBarChartData(context);
              }),

            ],
          ),
        ),

    );
  }

  Widget BindDashboardBarChartData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 300, // fixed height avoids layout issues
          width: _calculateChartWidth(),  // increase for scrollable horizontal chart
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.start,
              maxY: _calculateMaxY(),
              barGroups: _createBarGroups(),
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5, // ensures 0, 5, 10, ..., 50
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
                  )
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
                  )
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _getBottomTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false,),
              gridData: FlGridData(show: false),
             // alignment: BarChartAlignment.spaceAround,
            ),
          ),
        ),
      ),
    );
  }

  /// Provide max Y value based on data (adds some padding)
  double _calculateMaxY() {
    double max = 0;
    for (var r in dashboard_view_Controller.callDashboardRecordList) {
      max = [
        max,
        (r.newCall ?? 0).toDouble(),
        (r.followUpCall ?? 0).toDouble(),
        (r.paymentCall ?? 0).toDouble()
      ].reduce((a, b) => a > b ? a : b);
    }
    return (max + 10).ceilToDouble();
  }


  /// Dynamically create groups of bars
  List<BarChartGroupData> _createBarGroups() {
    return List.generate(dashboard_view_Controller.callDashboardRecordList.length, (index) {
      final record = dashboard_view_Controller.callDashboardRecordList[index];

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (record.followUpCall ?? 0).toDouble(),
            color: Colors.blue,
            width: 8,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: (record.newCall ?? 0).toDouble(),
            color: Colors.green,
            width: 8,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: (record.paymentCall ?? 0).toDouble(),
            color: Colors.orange,
            width: 8,
            borderRadius: BorderRadius.zero,
          ),

        ],
        barsSpace: 1,
      );
    });
  }

  /// X-axis label widget
  /*Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    String name ;
    if(dashboard_view_Controller.selectedOption.value == 'Employee'){
      name = dashboard_view_Controller.callDashboardRecordList[index].employee??"";
    }else{
      name = dashboard_view_Controller.callDashboardRecordList[index].geoValue??"";
    }

    if (index >= 0 && index < dashboard_view_Controller.callDashboardRecordList.length) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(name,
          style: TextStyle(fontSize: 10, color: AllColors.blackColor),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }*/


  Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 && index < dashboard_view_Controller.callDashboardRecordList.length) {
      String name = dashboard_view_Controller.selectedOption.value == 'Employee'
          ? dashboard_view_Controller.callDashboardRecordList[index].employee ?? ""
          : dashboard_view_Controller.callDashboardRecordList[index].geoValue ?? "";

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 8,
        child: RotatedBox(
          quarterTurns: 4, // rotates text 360 degrees
          child: SizedBox(
            width: 20, // set a fixed width to allow wrapping
            child: Text(
              name,
              style: TextStyle(fontSize: 10, color: AllColors.blackColor),
              softWrap: true,
              maxLines: 2, // or more if needed
              overflow: TextOverflow.ellipsis, // optional: show "..." if too long
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  double _calculateChartWidth() {
    final count = dashboard_view_Controller.callDashboardRecordList.length;
    final groupWidth = 3 * 8 + 2 * 4; // 3 bars × bar width + 2 × bar space
    return count * groupWidth + 40; // extra padding
  }

}