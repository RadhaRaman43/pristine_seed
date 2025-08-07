import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/Dashboard_VM/call_dashboard_vm.dart';

class CallDashboardViewScreen extends StatelessWidget{
  CallDashboardViewScreen({super.key});

  final dashboard_view_Controller = Get.put(CallDashboardVm());
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
                    'Call Dashboard',
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
                      Visibility(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8), // optional spacing
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: dashboard_view_Controller.userType != 'Branch Head',
                                      child: _buildActionChip("Cluster")),
                                  SizedBox(width: 8),
                                  _buildActionChip("Region"),
                                  SizedBox(width: 8),
                                  _buildActionChip("Employee"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        visible: dashboard_view_Controller.userType != 'Frontliners',
                      ),

                      Container(
                          padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
                          child:
                          Obx((){
                            return  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Task Due ${dashboard_view_Controller.character.value}',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '${dashboard_view_Controller.character.value} : Type Of Calls (R)',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          })


                      ),

                      Obx(() {
                        return BindDashboardBarChartData(context);
                      }),

                      Container(
                          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                          child:
                          Obx((){
                            return  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible : dashboard_view_Controller.rodName == '',
                                  child: Text(
                                    'All ${dashboard_view_Controller.selectedOption.value}',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible : dashboard_view_Controller.rodName != '',
                                  child: Text(
                                    '${dashboard_view_Controller.geoValueName} ${dashboard_view_Controller.rodName}',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
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

    );
  }

  Widget _buildActionChip(String label) {
    return Obx(() {
      final isSelected = dashboard_view_Controller.selectedOption.value == label;
      return ActionChip(
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        backgroundColor: isSelected ? AllColors.primaryDark1 : AllColors.grayColor,
        shadowColor: Colors.black,
        shape: StadiumBorder(
          side: BorderSide(color: AllColors.grayColor),
        ),
        label: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? AllColors.whiteColor : AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          dashboard_view_Controller.selectedOption.value = label;
          dashboard_view_Controller.clearAllFilterController();
          dashboard_view_Controller.pageNumber = 0;
          dashboard_view_Controller.callDashboardData();
        },
      );
    });
  }

  /*Widget BindDashboardBarChartData(BuildContext context) {
    double chartWidth = max(MediaQuery.of(context).size.width, _calculateChartWidth());
    final maxY = _calculateMaxY();
    final interval = _calculateInterval(maxY);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 450, // fixed height avoids layout issues
          width: chartWidth,  // increase for scrollable horizontal chart
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.start,
                maxY: maxY,
                barGroups: _createBarGroups(),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.lightBlue[50],
                    tooltipPadding: EdgeInsets.all(8),
                    tooltipRoundedRadius: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final record = dashboard_view_Controller.callDashboardRecordList[group.x.toInt()];
                      // Choose label
                      String name = dashboard_view_Controller.selectedOption.value == 'Employee'
                          ? record.employee ?? ""
                          : record.geoValue ?? "";

                      // Pick value based on rodIndex
                      String valueLabel;
                      switch (rodIndex) {
                        case 0:
                          valueLabel = 'Follow-up: ${rod.toY.toInt()}';
                          break;
                        case 1:
                          valueLabel = 'New Call: ${rod.toY.toInt()}';
                          break;
                        case 2:
                          valueLabel = 'Payment: ${rod.toY.toInt()}';
                          break;
                        default:
                          valueLabel = 'Value: ${rod.toY.toInt()}';
                      }

                      return BarTooltipItem(
                        '$name\n$valueLabel',
                        const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false,)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: _getBottomTitles,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    left: BorderSide(color: Colors.grey, width: 1),
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }*/

  Widget BindDashboardBarChartData(BuildContext context) {
    /*if (dashboard_view_Controller.isShimmerLoading.value) {
      return BarChartShimmer(context);
    } else*/ if (dashboard_view_Controller.callDashboardRecordList.isEmpty) {
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
      double chartWidth = max(MediaQuery.of(context).size.width, _calculateChartWidth());
      final maxY = _calculateMaxY();
      final interval = _calculateInterval(maxY);

      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 450,
            width: chartWidth,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child:
              BarChart(
                BarChartData(
                  alignment: BarChartAlignment.start,
                  maxY: maxY,
                  barGroups: _createBarGroups(),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
                      if (!event.isInterestedForInteractions || response == null || response.spot == null) return;
                      final rodIndex = response.spot!.touchedRodDataIndex;
                      final groupIndex = response.spot!.touchedBarGroupIndex;
                      String? record = dashboard_view_Controller.callDashboardRecordList[groupIndex].geoValue == null?dashboard_view_Controller.callDashboardRecordList[groupIndex].employee : dashboard_view_Controller.callDashboardRecordList[groupIndex].geoValue;

                      dashboard_view_Controller.geoValueName.value = record??"";
                      if(dashboard_view_Controller.selectedOption == 'Region'){
                        dashboard_view_Controller.RegionNameForApi = record??"";
                      }else if(dashboard_view_Controller.selectedOption == 'Cluster'){
                        dashboard_view_Controller.ClusterNameForApi = record??"";
                      }else if(dashboard_view_Controller.selectedOption == 'Employee'){
                        dashboard_view_Controller.EmployeeEmailIdForApi = dashboard_view_Controller.callDashboardRecordList[groupIndex].emailId??"";
                      }

                      print('geoNameValue...${record}');


                      switch (rodIndex) {
                        case 0:
                          dashboard_view_Controller.TypeOfCallForApi = 'Follow-Up Call';
                          dashboard_view_Controller.rodName.value = 'Follow-Up Call';
                          dashboard_view_Controller.pageNumber = 0;
                          dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);
                          break;
                        case 1:
                          dashboard_view_Controller.TypeOfCallForApi = 'New Call';
                          dashboard_view_Controller.rodName.value = 'New Call';
                         // dashboard_view_Controller.geoValueName.value = record??"";
                          dashboard_view_Controller.pageNumber = 0;
                          dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);
                          break;
                        case 2:
                          dashboard_view_Controller.TypeOfCallForApi = 'Payment Call';
                          dashboard_view_Controller.rodName.value = 'Payment Call';
                         // dashboard_view_Controller.geoValueName.value = record??"";
                          dashboard_view_Controller.pageNumber = 0;
                          dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);
                          break;
                      }
                    },
                    touchTooltipData: BarTouchTooltipData(
                     // tooltipBgColor: Colors.lightBlue[50],
                      tooltipPadding: EdgeInsets.all(8),
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final record = dashboard_view_Controller.callDashboardRecordList[group.x.toInt()];
                        String name = dashboard_view_Controller.selectedOption.value == 'Employee'
                            ? record.employee ?? ""
                            : record.geoValue ?? "";



                        String valueLabel;
                        switch (rodIndex) {
                          case 0:
                            valueLabel = 'Follow-up: ${rod.toY.toInt()}';

                            break;
                          case 1:
                            valueLabel = 'New Call: ${rod.toY.toInt()}';

                            break;
                          case 2:
                            valueLabel = 'Payment: ${rod.toY.toInt()}';

                            break;
                          default:
                            valueLabel = 'Value: ${rod.toY.toInt()}';

                        }

                        return BarTooltipItem(
                          '$name\n$valueLabel',
                          const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: interval,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: _getBottomTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(color: Colors.grey, width: 1),
                      bottom: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }


  Widget BarChartShimmer(BuildContext context) {
    // Example "bar heights" to match your image visually
    final List<double> barHeights = [100, 120, 200, 190, 150, 170, 160];

    return SizedBox(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 160.0, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(barHeights.length, (index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 20,
                height: barHeights[index],
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Provide max Y value based on data (adds some padding)
  /*double _calculateMaxY() {
    double max = 0;
    for (var r in dashboard_view_Controller.callDashboardRecordList) {
      max = [
        max,
        (r.newCall ?? 0).toDouble(),
        (r.followUpCall ?? 0).toDouble(),
        (r.paymentCall ?? 0).toDouble()
      ].reduce((a, b) => a > b ? a : b);
    }
    return (max + 12).ceilToDouble();
  }*/

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

    if (max == 0) return 100; // force 0-100 scale if no data

    // Round up to next multiple of 10
    return ((max / 10).ceil() * 11).toDouble();
  }

  double _calculateInterval(double maxY) {
    if (maxY <= 20) return 1;
    if (maxY <= 50) return 5;
    if (maxY <= 100) return 10;
    if (maxY <= 500) return 50;
    if (maxY <= 1000) return 100;
    if (maxY <= 10000) return 1000;
    return (maxY / 10).roundToDouble(); // fallback
  }

  /// Dynamically create groups of bars
  List<BarChartGroupData> _createBarGroups() {
    return List.generate(dashboard_view_Controller.callDashboardRecordList.length, (index) {
      final record = dashboard_view_Controller.callDashboardRecordList[index];
      double Width = 20;
      if(dashboard_view_Controller.userType == 'Frontliners'){
        Width = 100;
      }else if(dashboard_view_Controller.userType == 'Branch Head' && dashboard_view_Controller.selectedOption == 'Region') {
        Width = 100;
      }else{
        Width = 20;
      }
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (record.followUpCall ?? 0).toDouble(),
            color: Colors.blue,
            width: Width,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: (record.newCall ?? 0).toDouble(),
            color: Colors.green,
            width: Width,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: (record.paymentCall ?? 0).toDouble(),
            color: Colors.orange,
            width: Width,
            borderRadius: BorderRadius.zero,
          ),

        ],
        barsSpace: 2,
      );
    });
  }

  /// X-axis label widget
  Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 && index < dashboard_view_Controller.callDashboardRecordList.length) {
      String name = dashboard_view_Controller.selectedOption.value == 'Employee'
          ? dashboard_view_Controller.callDashboardRecordList[index].employee ?? ""
          : dashboard_view_Controller.callDashboardRecordList[index].geoValue ?? "";

      int TotalCall = (dashboard_view_Controller.callDashboardRecordList[index].newCall!) + (dashboard_view_Controller.callDashboardRecordList[index].followUpCall!) + (dashboard_view_Controller.callDashboardRecordList[index].paymentCall!);

      String formattedName = name.replaceAll(' ', '\n');
      print('totalCallc ${TotalCall}');

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: RotatedBox(
          quarterTurns: 4,
          child: Column(
            children: [
              Text('All Calls : ${TotalCall.toString()}', style: TextStyle(
                fontSize: 10, color: AllColors.redColor
              ),),
              Text(
                formattedName,
                style: TextStyle(fontSize: 10, color: AllColors.blackColor),
                softWrap: true,
                maxLines: 2, // or more if needed
                overflow: TextOverflow.ellipsis, // optional: show "..." if too long
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        /*child: Transform.rotate(
          angle: -0.5, // approx -28.6 degrees (negative to tilt upward)
          child: Text(
            name,
            style: TextStyle(fontSize: 12, color: AllColors.blackColor),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),*/
      );
    } else {
      return SizedBox.shrink();
    }
  }

  double _calculateChartWidth() {
    final count = dashboard_view_Controller.callDashboardRecordList.length;
    if (count <= 2) return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    final groupWidth = 3 * 15 + 15 * 2; // 3 bars × bar width + 2 × bar space
    return count * groupWidth + 100; // extra padding
  }


  Widget BindDashboardWiseDataList(context) {
    if (dashboard_view_Controller.callDashboardUserWiseDataList.value.isNotEmpty && dashboard_view_Controller.callDashboardUserWiseDataList.value.length > 0) {
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
          itemCount: dashboard_view_Controller.callDashboardUserWiseDataList.value.length,
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
    String? Due_Date=StaticMethod.convertDateFormat1( dashboard_view_Controller.callDashboardUserWiseDataList[position].taskDueDate ?? "");
    String? LastActivityUpdatedOn=StaticMethod.convertDateFormat1( dashboard_view_Controller.callDashboardUserWiseDataList[position].lastActivityUpdatedOn ?? "");
    String? createdOn=StaticMethod.dateTimeToDate( dashboard_view_Controller.callDashboardUserWiseDataList[position].createdOn ?? "");
    String taskStatus =  dashboard_view_Controller.callDashboardUserWiseDataList[position].taskStatus!;
    String pipeLine = dashboard_view_Controller.callDashboardUserWiseDataList[position]
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
                      message: dashboard_view_Controller.callDashboardUserWiseDataList[position]
                          .taskStatus!,
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .taskId!,
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
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
                        .callDashboardUserWiseDataList[position]
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
                            .callDashboardUserWiseDataList[position]
                            .accountName ?? "",
                        child: Text(
                          dashboard_view_Controller
                              .callDashboardUserWiseDataList[position]
                              .accountName ??
                              "" + " | ${dashboard_view_Controller
                                  .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .contactName!,
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .contactName!,
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .typeOfCall!,
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .methodOfCall??"",
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .createdFullName??"" +
                          "| ${StaticMethod.dateTimeToDate(
                              dashboard_view_Controller
                                  .callDashboardUserWiseDataList[position]
                                  .createdOn??"")}",
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
                            .createdFullName??"" +
                            "| ${StaticMethod.dateTimeToDate(
                                dashboard_view_Controller
                                    .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position]
                          .taskDueDate,
                      child: Text(" ${dashboard_view_Controller
                          .callDashboardUserWiseDataList[position]
                          .taskDueDate ??
                          ""} ${pipeLine} ${dashboard_view_Controller
                          .callDashboardUserWiseDataList[position]
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
                          .callDashboardUserWiseDataList[position].taskRemarks ?? "",
                      child: Text(
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position].taskRemarks ?? "",
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
                visible: dashboard_view_Controller.callDashboardUserWiseDataList[position]
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
                            .callDashboardUserWiseDataList[position]
                            .rejectReason??"",
                        child: Text(
                          dashboard_view_Controller
                              .callDashboardUserWiseDataList[position]
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
                              dashboard_view_Controller.callDashboardData();
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
                              dashboard_view_Controller.callDashboardData();
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
                        dashboard_view_Controller.callDashboardData();
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
                        dashboard_view_Controller.callDashboardData();
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
                        dashboard_view_Controller.callDashboardData();
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
                        dashboard_view_Controller.callDashboardData();
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
                        dashboard_view_Controller.callDashboardData();
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
          bindTaskStatus(context),
          SizedBox(height: 10),
          bindCustomerNameFilter(context),
          SizedBox(height: 10),
          bindTypeCallFilter(context),
          SizedBox(height: 10),
          bindLastActivityStatus(context),
          SizedBox(height: 10),
          bindProductCategoryFilter(context),
          SizedBox(height: 10),
          bindAccountOwnerFilter(context),
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

  bindTaskStatus(BuildContext context) {
    return Obx((){
      return DropdownSearch<String>.multiSelection(
        items: dashboard_view_Controller.TaskStatusListTypeList,
        itemAsString: (String u) => u,
        selectedItems: dashboard_view_Controller.selectedTaskStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.selectedTaskStatusList.isNotEmpty?"Task Status":null,
            hintText: "Task Status",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Task Status",
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
          dashboard_view_Controller.selectedTaskStatusList.value =
              selectedList;
          dashboard_view_Controller.task_Status_controller.value.text =
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

  bindLastActivityStatus(BuildContext context) {
    return Obx((){
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: dashboard_view_Controller.DSARStatus_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus??"",
        selectedItems: dashboard_view_Controller.selectedDSARStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.selectedDSARStatusList.isNotEmpty?"Last Activity Status":null,
            hintText: "Last Activity Status",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Last Activity Status",
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
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          dashboard_view_Controller.selectedDSARStatusList.value =
              selectedList;
          dashboard_view_Controller.lastActivity_Status_controller.value.text =
              selectedList.map((e) => e.taskStatus).join(', ');
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
                title: Text(item.taskStatus??""),
              ),
        ),
      );
    });

  }

  bindTypeCallFilter(BuildContext context) {
    return Obx((){
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: dashboard_view_Controller.TypeCall_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus??"",
        selectedItems: dashboard_view_Controller.selectedTypeCallList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.selectedTypeCallList.isNotEmpty?"Type Of Call":null,
            hintText: "Type Of Call",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Type Of Call",
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
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          dashboard_view_Controller.selectedTypeCallList.value =
              selectedList;
          dashboard_view_Controller.typeOfCall_controller.value.text =
              selectedList.map((e) => e.taskStatus).join(', ');
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
                title: Text(item.taskStatus??""),
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
          dashboard_view_Controller.clusterName_controller.value.text =
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


}