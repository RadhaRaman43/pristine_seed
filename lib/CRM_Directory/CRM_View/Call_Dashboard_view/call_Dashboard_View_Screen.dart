import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
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
                    backgroundColor: AllColors.green,
                    color: AllColors.textColor,
                  ),
                );
              }),
              Expanded(
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8), // optional spacing
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildActionChip("Cluster"),
                                SizedBox(width: 8),
                                _buildActionChip("Region"),
                                SizedBox(width: 8),
                                _buildActionChip("Employee"),
                              ],
                            ),
                          ),
                        ),
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
                                Text(
                                  'All ${dashboard_view_Controller.selectedOption.value}',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '(' +dashboard_view_Controller.total_rows.toString()+')',
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
          dashboard_view_Controller.pageNumber = 0;
          dashboard_view_Controller.callDashboardData();
        },
      );
    });
  }

  Widget BindDashboardBarChartData(BuildContext context) {
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
          child: BarChart(
           /* BarChartData(
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
            ),*/
            BarChartData(
              alignment: BarChartAlignment.start,
              maxY: maxY,
              barGroups: _createBarGroups(),
              /*barTouchData: BarTouchData(enabled: true),*/
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

  double _calculateInterval(double maxY) {
    if (maxY <= 20) return 1;
    if (maxY <= 50) return 5;
    if (maxY <= 100) return 10;
    if (maxY <= 500) return 50;
    if (maxY <= 1000) return 100;
    if (maxY <= 10000) return 1000;
    return (maxY / 5).roundToDouble(); // fallback
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
            width: 20,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: (record.newCall ?? 0).toDouble(),
            color: Colors.green,
            width: 20,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: (record.paymentCall ?? 0).toDouble(),
            color: Colors.orange,
            width: 20,
            borderRadius: BorderRadius.zero,
          ),

        ],
        barsSpace: 2,
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

      String formattedName = name.replaceAll(' ', '\n');

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: RotatedBox(
          quarterTurns: 4,
          child: Text(
            formattedName,
            style: TextStyle(fontSize: 10, color: AllColors.blackColor),
            softWrap: true,
            maxLines: 2, // or more if needed
            overflow: TextOverflow.ellipsis, // optional: show "..." if too long
            textAlign: TextAlign.center,
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

          int total_page = (dashboard_view_Controller.total_rows /
              dashboard_view_Controller.rowsPerPage)
              .toInt();
          if ((dashboard_view_Controller.total_rows %
              dashboard_view_Controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${dashboard_view_Controller.pageNumber} ${dashboard_view_Controller.total_rows} ${dashboard_view_Controller.rowsPerPage} ${total_page}");
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
      return Center(child: Column(
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

}