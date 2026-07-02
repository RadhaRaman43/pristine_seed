import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import 'package:path_provider/path_provider.dart';

import '../../../component/circular_loading.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/rollingforecastVM/rolling_force_cast_dashboard_vm.dart';

class RollingForceCastDashBoardScreen extends StatelessWidget{
  final dashboard_view_Controller = Get.put(RollingForceCastDashboardVm());
  Size size=Get.size;
  final GlobalKey _chartKey = GlobalKey();
  final GlobalKey _amountChartKey = GlobalKey();
  final GlobalKey _quantityChartKey = GlobalKey();

  static String _displayCustomerNeedIdentityStatusForOption(String option) => option;
  final NumberFormat formatter = NumberFormat.decimalPattern('en_IN');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Tooltip(
                      message: 'Rolling Forecast Dashboard',
                      child: Text(
                        'Rolling Forecast Dashboard',
                        style: GoogleFonts.poppins(
                          color: AllColors.whiteColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: "Download Excel",
                    child: IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: ()  {
                        dashboard_view_Controller.exportNonStandardExcelWithProgress(context,);;
                      },
                    ),
                  ),
                  Tooltip(
                    message: "Take Screenshot",
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () async {
                        await takeScreenshot(context, _chartKey);
                      },
                    ),
                  ),
                  IconButton(onPressed: () {
                    showFilterBottomSheet(context);
                  }, icon: Icon(Icons.filter_alt_sharp))
                ],
              )
          ),
          drawer: CustomDrawer(),
          body: Obx((){
            if(dashboard_view_Controller.loading.value /*|| saleCycleController.loading.value*/){
              return const FullScreenLoader();
            }
            return Column(
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
                                        visible: dashboard_view_Controller.userType?.toLowerCase() != 'bh',
                                        child: _buildActionChip("Cluster")),
                                    const SizedBox(width: 8),
                                    _buildActionChip("Region"),
                                    const SizedBox(width: 8),
                                    _buildActionChip("Employee"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          visible: dashboard_view_Controller.userType?.toLowerCase() != 'fl',
                        ),

                        Container(
                            padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Rolling Forecast',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Obx((){
                                  return  Text(
                                    'Date Ranges : ${dashboard_view_Controller.character.value} (${dashboard_view_Controller.formattedStartDate} - '
                                        '${dashboard_view_Controller.formattedEndDate})',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.twelve,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),

                                Obx((){
                                  if(dashboard_view_Controller.rollingForecastList.isNotEmpty ) {
                                    return Text(
                                      "Total value: ${dashboard_view_Controller
                                          .rollingForecastList[0].records?[0]
                                          .grandTotalAmount.toString()}",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    );
                                  }
                                  else{
                                    return Text("");
                                  }

                                }),

                              ],
                            )

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
                                      '${dashboard_view_Controller.geoValueName}',
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
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
                        const Divider(height: 1, color: AllColors.lightgreyColor,),
                        Container(
                          height: size.height/2,
                          child: Obx(() {
                            return BindDashboardWiseDataList(context);
                          }),
                        )
                      ],
                    )),
              ],
            );
          })
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
          dashboard_view_Controller.rollingForecastDashboardData();
        },
      );
    });
  }

  Widget BindDashboardBarChartData(BuildContext context) {
    if (dashboard_view_Controller.rollingForecastDashboardRecordList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assests/images/data-analytics.png",
              width: 150,
              height: 150,
            ),
            Text(
              'No Record Found',
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return RepaintBoundary(
      key: _chartKey,
      child: Column(
        children: [
          Text(
            "Estimated Amount",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color:AllColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          buildChart(context, isAmountChart: true, /*chartKey: _amountChartKey,*/),

          const SizedBox(height: 30),

          Text(
            "Quantity",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color:AllColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          buildChart(context, isAmountChart: false,/*chartKey: _quantityChartKey,*/),
        ],
      ),
    );
  }
  Widget buildChart(BuildContext context, {required bool isAmountChart, /*required  GlobalKey chartKey,*/}) {
    double chartWidth = max(MediaQuery.of(context).size.width, _calculateChartWidth(),);

    final maxY = _calculateMaxY(isAmountChart);
    final interval = _calculateInterval(maxY);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: _calculateChartHeight(),
          width: chartWidth,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.start,
              maxY: maxY,
              barGroups: _createBarGroups(isAmountChart),
              barTouchData: _barTouchData(isAmountChart),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: interval,
                    reservedSize: 80,
                    getTitlesWidget: (value, meta) {
                      if (value == meta.max) {
                        return const SizedBox.shrink();
                      }
                      return Text(
                        formatter.format(value.toInt()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (value, meta) =>
                        _getBottomTitles(value, meta, isAmountChart,),
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.grey, width: 1,),
                  bottom: BorderSide(color: Colors.grey, width: 1,),
                ),
              ),
              gridData: FlGridData(show: true, drawVerticalLine: false,),
            ),
          ),
        ),
      ),
    );
  }
  double _calculateChartHeight() {
    final count = dashboard_view_Controller.rollingForecastDashboardRecordList.length;
    if (count <= 10) {
      return 450;
    } else if (count <= 20) {
      return 500;
    } else {
      return 550;
    }
  }
  double _calculateMaxY(bool isAmountChart) {
    double maxValue = 0;
    for (var r in dashboard_view_Controller.rollingForecastDashboardRecordList) {
      double value = isAmountChart ? (r.grandTotalAmount ?? 0).toDouble()
          : (r.grandTotalQty ?? 0).toDouble();
      maxValue = max(maxValue, value);
    }
    if (maxValue == 0) return 100;

    //return ((maxValue / 10).ceil() * 11).toDouble();
    return (maxValue * 1.3).ceilToDouble();
  }
  List<BarChartGroupData> _createBarGroups(bool isAmountChart) {
    return List.generate(
      dashboard_view_Controller.rollingForecastDashboardRecordList.length,
          (index) {
        final record = dashboard_view_Controller.rollingForecastDashboardRecordList[index];
        double width = 50;
        if (dashboard_view_Controller.userType?.toLowerCase() == 'fl') {
          width = 85;
        } else if (dashboard_view_Controller.userType?.toLowerCase() == 'bh' &&
            dashboard_view_Controller.selectedOption == 'Region') {
          width = 85;
        }
        double yValue = isAmountChart
            ? (record.grandTotalAmount ?? 0).toDouble()
            : (record.grandTotalQty ?? 0).toDouble();

        return BarChartGroupData(
          x: index,
          barRods: [BarChartRodData(
              toY: yValue,
              color: isAmountChart ? Colors.blue : Colors.green,
              width: width,
              borderRadius: BorderRadius.zero,
            ),
          ],
        );
      },
    );
  }
  BarTouchData _barTouchData(bool isAmountChart) {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final record = dashboard_view_Controller.rollingForecastDashboardRecordList[
          group.x.toInt()];
          String name = dashboard_view_Controller.selectedOption.value == 'Employee' ?
          record.employee ?? "" : record.geoValue ?? "";
          return BarTooltipItem(
            "$name\n${isAmountChart ? 'Amount' : 'Qty'} : ${formatter.format(rod.toY)}",
            const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
  Widget _getBottomTitles(double value, TitleMeta meta, bool isAmountChart,) {
    final index = value.toInt();
    if (index >= dashboard_view_Controller.rollingForecastDashboardRecordList.length) {
      return const SizedBox.shrink();
    }

    final record = dashboard_view_Controller.rollingForecastDashboardRecordList[index];

    String name = dashboard_view_Controller.selectedOption.value ==
        'Employee' ? record.employee ?? "" : record.geoValue ?? "";

    double total = isAmountChart ? (record.grandTotalAmount ?? 0).toDouble()
        : (record.grandTotalQty ?? 0).toDouble();

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        children: [
          Text(
            formatter.format(total),
            style: TextStyle(
              fontSize: 10,
              color: AllColors.redColor,
            ),
          ),
          Text(name,
            style: TextStyle(fontSize: 10, color: AllColors.blackColor,),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  double _calculateChartWidth() {
    final count = dashboard_view_Controller.rollingForecastDashboardRecordList.length;
    const double barWidth = 150;
    const double minChartWidth = 1200;
    return count > 20 ? count * barWidth : minChartWidth;
  }
  double _calculateInterval(double maxY) {
    const desiredSteps = 5;
    double rawInterval = maxY / desiredSteps;
    double base = pow(10, (log(rawInterval) / ln10).floor(),).toDouble();
    if (rawInterval / base < 2) {
      return base;
    } else if (rawInterval / base < 5) {
      return 2 * base;
    } else {
      return 5 * base;
    }
  }

  Future<void> takeScreenshot(BuildContext context, GlobalKey<State<StatefulWidget>> chartKey) async {
    ValueNotifier<double> progress = ValueNotifier(0.0);
    showProgressDialog(context, progress);

    try {
      print("exception during take screen short");
      progress.value = 0.10;
      RenderRepaintBoundary boundary =
      chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image chartImage = await boundary.toImage(pixelRatio: 3.0);
      progress.value = 0.25;

      var chartBytes = await chartImage.toByteData(format: ui.ImageByteFormat.png);
      var chartUint8 = chartBytes!.buffer.asUint8List();
      const double textSectionHeight = 160;
      const double spacing = 20;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final double width = chartImage.width.toDouble();
      final double height = chartImage.height.toDouble() + textSectionHeight + spacing;
      final bgPaint = Paint()..color = const Color(0xFFFBF6F6);
      canvas.drawRect(Rect.fromLTWH(0, 0, width, height), bgPaint);
      drawHeader(canvas, width);


      final chartUiImage = await decodeImageFromList(chartUint8);
      canvas.drawImage(chartUiImage, Offset(0, textSectionHeight + spacing), Paint());
      final picture = recorder.endRecording();
      progress.value = 0.45;
      final finalImage = await picture.toImage(width.toInt(), height.toInt());
      var finalBytes = await finalImage.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = finalBytes!.buffer.asUint8List();
      progress.value = 0.65;

      // ---------------- Save to Gallery ------------------------
      await MediaStore.ensureInitialized();
      MediaStore.appFolder = "PristineSeed";

      String tempFilePath = await saveTempImage(pngBytes);

      progress.value = 0.80;

      final saveInfo = await MediaStore().saveFile(
        tempFilePath: tempFilePath,
        dirType: DirType.photo,
        dirName: DirName.dcim,
      );

      progress.value = 1.0; // close loading dialog


      if (saveInfo != null && saveInfo.isSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Screenshot saved to Gallery!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save screenshot')),
        );
      }

    } catch (e) {
      print("Screenshot error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Data does not found')),);
    }
    finally{
      Get.back();
    }
  }
  void showProgressDialog(BuildContext context, ValueNotifier<double> progress) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ValueListenableBuilder<double>(
          valueListenable: progress,
          builder: (context, value, _) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Saving screenshot..."),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(value: value),
                  const SizedBox(height: 10),
                  Text("${(value * 100).toStringAsFixed(0)}%",style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700),),
                ],
              ),
            );
          },
        );
      },
    );
  }
  double drawHeader(ui.Canvas canvas, double canvasWidth) {
    double startY = 40;
    double leftX = 40;

    List<Map<String, dynamic>> leftTexts = [
      {
        "text": "Rolling Forecast",
        "size": 34.0,
        "color": const Color(0xFF0C0C0C),
        "weight": FontWeight.bold
      },
      {
        "text":
        "Time Period - ${dashboard_view_Controller.character.value} (${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate})",
        "size": 22.0,
        "color": const Color(0xFF0C0C0C),
        "weight": FontWeight.w500
      },
      /*{
        "text": 'Quote Accep. :  ${dashboard_view_Controller.QuoteAccepted_controller.value.text}',
        "size": 22.0,
        "color": const Color(0xFF0C0C0C),
        "weight": FontWeight.w500
      },*/
      {
        "text": 'View : ${dashboard_view_Controller.selectedOption.value}',
        "size": 22.0,
        "color": const Color(0xFF0C0C0C),
        "weight": FontWeight.w500
      },
    ];

    for (var item in leftTexts) {
      final tp = TextPainter(
        text: TextSpan(
          text: item["text"],
          style: TextStyle(
            fontSize: item["size"],
            fontWeight: item["weight"],
            color: item["color"],
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      );

      tp.layout(maxWidth: canvasWidth * 0.6);
      tp.paint(canvas, Offset(leftX, startY));

      startY += tp.height + 8;
    }
    return startY + 10;
  }

  Future<String> saveTempImage(var bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File(
        "${tempDir.path}/CallDashboard_${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }

 /* Widget BindDashboardBarChartData(BuildContext context) {
    if (dashboard_view_Controller.rollingForecastDashboardRecordList.isEmpty) {
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
              const SizedBox(height: 20,)
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
          child: RepaintBoundary(
            key: _chartKey,
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
                        String? record = dashboard_view_Controller.rollingForecastDashboardRecordList[groupIndex].geoValue == null?
                        dashboard_view_Controller.rollingForecastDashboardRecordList[groupIndex].employee :
                        dashboard_view_Controller.rollingForecastDashboardRecordList[groupIndex].geoValue;

                        dashboard_view_Controller.geoValueName.value = record??"";
                        if(dashboard_view_Controller.selectedOption == 'Region'){
                          dashboard_view_Controller.RegionNameForApi = record??"";
                        }else if(dashboard_view_Controller.selectedOption == 'Cluster'){
                          dashboard_view_Controller.ClusterNameForApi = record??"";
                        }else if(dashboard_view_Controller.selectedOption == 'Employee'){
                          dashboard_view_Controller.EmployeeEmailIdForApi = dashboard_view_Controller.rollingForecastDashboardRecordList[groupIndex].emailId??"";
                        }

                        dashboard_view_Controller.rodName.value = dashboard_view_Controller.geoValueName.value;
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);

                      },
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: EdgeInsets.all(8),
                        tooltipRoundedRadius: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final record = dashboard_view_Controller.rollingForecastDashboardRecordList[group.x.toInt()];
                          String name = dashboard_view_Controller.selectedOption.value == 'Employee'
                              ? record.employee ?? ""
                              : record.geoValue ?? "";

                          String valueLabel;
                          valueLabel = 'Estimated Amount: ${rod.toY.toInt()}';
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
                          reservedSize: 80,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              formatter.format(value.toInt()),
                              style: const TextStyle(fontSize: 12, color: Colors.black),
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
        ),
      );
    }
  }
  double _calculateChartWidth() {
    final count = dashboard_view_Controller.rollingForecastDashboardRecordList.length;

    double barWidth = 20; // your actual bar width in pixels
    double barSpacing = 40; // gap between bars in pixels

    // total width = (bar width + spacing) × count
    return (barWidth + barSpacing) * count;
  }
  double _calculateMaxY() {
    double max = 0;
    for (var r in dashboard_view_Controller.rollingForecastDashboardRecordList) {
      max = [
        max,
        (r.grandTotalQty ?? 0).toDouble(),
      ].reduce((a, b) => a > b ? a : b);
    }

    if (max == 0) return 100;
    return ((max / 10).ceil() * 11).toDouble();
  }
  double _calculateInterval(double maxY) {
    // Desired number of intervals (around 6–10 is ideal)
    const desiredSteps = 5;

    // Step 1: Calculate raw step size
    double rawInterval = maxY / desiredSteps;

    // Step 2: Round it to a clean number (1, 2, 5, 10, 20, 50, 100, 200, etc.)
    double base = pow(10, (log(rawInterval) / ln10).floor()).toDouble(); // e.g., for 37 → base 10
    if (rawInterval / base < 2) {
      return base;
    } else if (rawInterval / base < 5) {
      return 2 * base;
    } else {
      return 5 * base;
    }
  }
  List<BarChartGroupData> _createBarGroups() {
    return List.generate(dashboard_view_Controller.rollingForecastDashboardRecordList.length, (index) {
      final record = dashboard_view_Controller.rollingForecastDashboardRecordList[index];
      double Width = 50;
      if(dashboard_view_Controller.userType?.toLowerCase() == 'fl'){
        Width = 85;
      }else if(dashboard_view_Controller.userType?.toLowerCase() == 'bh' && dashboard_view_Controller.selectedOption == 'Region') {
        Width = 85;
      }else{
        Width = 50;
      }
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (record.grandTotalQty ?? 0).toDouble(),
            color: Colors.blue,
            width: Width,
            borderRadius: BorderRadius.zero,
          ),
        ],
        barsSpace: 4, // Set this to 0 for no spacing (single bar effect)
      );
    });
  }
  Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 && index < dashboard_view_Controller.rollingForecastDashboardRecordList.length) {
      String name = dashboard_view_Controller.selectedOption.value == 'Employee'
          ? dashboard_view_Controller.rollingForecastDashboardRecordList[index].employee ?? ""
          : dashboard_view_Controller.rollingForecastDashboardRecordList[index].geoValue ?? "";

      double TotalCall = (dashboard_view_Controller.rollingForecastDashboardRecordList[index].grandTotalQty!);

      String formattedName = name.replaceAll(' ', '\n');

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: RotatedBox(
          quarterTurns: 4,
          child: Column(
            children: [
              Text('${formatter.format(TotalCall)}', style: TextStyle(
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
      );
    } else {
      return  const SizedBox.shrink();
    }
  }*/

  Widget BindDashboardWiseDataList(context) {
    if (dashboard_view_Controller.rollingForecastUserWiseList.value.isNotEmpty && dashboard_view_Controller.rollingForecastUserWiseList.value.length > 0) {
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
          itemCount: dashboard_view_Controller.rollingForecastUserWiseList.value.length,
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

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.yellow[900]!;
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

  Widget BindCustomerRequestListView(context, int position) {
    //String Status =  dashboard_view_Controller.rollingForecastUserWiseList[position].??"";
    
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Sales Forecast Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Tooltip(
                    message: dashboard_view_Controller.rollingForecastUserWiseList[position]
                        .salesForecastId??"",
                    child: Text(
                      dashboard_view_Controller
                          .rollingForecastUserWiseList[position]
                          .salesForecastId??"",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              InkWell(
                  onTap: (){

                   /* saleCycleController.ProductCategoryWiseAmtGet(0, dashboard_view_Controller.rollingForecastUserWiseList[position].salesCycleId!);
                    saleCycleController.pageNumber = 0;
                    saleCycleController.filterQuoteAcceptedFlag.value="";
                    saleCycleController.clearAllFieldOfFilter();
                    saleCycleController.getsalesCycleData(saleCycleController.pageNumber, dashboard_view_Controller.rollingForecastUserWiseList[position]
                        .salesCycleId!, "ViewHeader", "FromCommitDashboard");*/
                  },
                  child: Icon(Icons.remove_red_eye, size: 30,color: AllColors.textColor,))

            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Sales Cycle Id: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].salesCycleId??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Id: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].quoteId??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Customer Name: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].accountName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Customer Code: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].accountCode??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Estimate Amount: ", value: "₹ ${
                  dashboard_view_Controller
                      .numberFormatWithComma(dashboard_view_Controller
                      .rollingForecastUserWiseList[position]
                      .estBudgetAmount)
                      .toString()
              }",color:AllColors.textColor),
              _buildLabelWithValue(label: "Cluster Name: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].clusterName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Region Name: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].regionName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created By: ", value:  dashboard_view_Controller.rollingForecastUserWiseList[position].createdFullName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created On: ", value:StaticMethod.onlyDate(dashboard_view_Controller.rollingForecastUserWiseList[position].createdOn??"") ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Item Code: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].itemCode??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Item Name: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].itemName??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Item Variant: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].itemVarient??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Item Category Code: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].itemCategoryCode??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Parent Category Code: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].itemParentCategoryCode??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Qty: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].qty.toString()??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Approved Amt.: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].quoteApprovedAmountPerUnit.toString()??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Closer Month: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].closureMonth??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Closer Year: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].closureYear??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Validity: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].quoteValidity??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Required Cluster Name: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].requiredClusterName??"" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Required Region Name: ", value:dashboard_view_Controller.rollingForecastUserWiseList[position].requiredRegionName??"" ,color:AllColors.textColor),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    required Color color,

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
                        const SizedBox(width: 5,),
                        Text(
                          " Filter ",
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
                              const SizedBox(height: 5,),
                              RadioGroupDateRangeFilter(context),
                              const SizedBox(height: 10,),

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
                        Expanded(child: _buildButton(
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            dashboard_view_Controller.filterDataChecker.value='';
                            dashboard_view_Controller.clearFilterData();
                            dashboard_view_Controller.clearAllFilterController();
                            dashboard_view_Controller.pageNumber = 0;
                            dashboard_view_Controller.rollingForecastDashboardData();
                            Get.back();
                          },
                        )),


                        const SizedBox(width: 3,),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            dashboard_view_Controller.pageNumber = 0;
                            dashboard_view_Controller.rollingForecastDashboardData();
                            Get.back();
                          },
                        )),


                        const SizedBox(width: 3,),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            dashboard_view_Controller.filterDataChecker.value='';
                            dashboard_view_Controller.SaveFilterData();
                            /*dashboard_view_Controller.pageNumber = 0;
                            dashboard_view_Controller.funnelDashboardData();*/
                            Get.back();
                          },
                        )),

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

  RadioGroupDateRangeFilter(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
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
                        dashboard_view_Controller.rollingForecastDashboardData();
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
                        dashboard_view_Controller.rollingForecastDashboardData();
                        Get.back();
                      },
                    );
                  }),

                  Obx((){
                    return RadioListTile<String>(
                      title: const Text('Monthly' ,style: TextStyle(
                          fontSize: AllFontSize.sisxteen
                      ),),
                      value: 'Monthly',
                      dense: true,
                      groupValue: dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value??"";
                        dashboard_view_Controller.DateRange('monthly');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.rollingForecastDashboardData();
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
                        dashboard_view_Controller.rollingForecastDashboardData();
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
                        dashboard_view_Controller.rollingForecastDashboardData();
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
          const SizedBox(height: 10),
          bindData(context,'Sales Forecast Id', dashboard_view_Controller.filter_sale_forecast_id_cont.value),
          const SizedBox(height: 10),
          bindData(context,'Quote Id', dashboard_view_Controller.filter_quote_id_cont.value),
          const SizedBox(height: 10),
          bindData(context,'Sales Cycle Id', dashboard_view_Controller.filter_sale_cycle_id_cont.value),
          const SizedBox(height: 10),
          bindCustomerNameFilter(context),
          const SizedBox(height: 10),
          bindProductCategoryFilter(context),
          const SizedBox(height: 10),
          bindClusterNameFilter(context),
          const SizedBox(height: 10),
          bindRegionNameFilter(context),
          const SizedBox(height: 10),
          bindAccountOwnerFilter(context),
          const SizedBox(height: 10),
          bindFilterCreatedOn(context),



        ],

      ),

    );
  }
  bindData(BuildContext context, String labelText, TextEditingController controller,) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: labelText,
          hintText: labelText,
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

  bindCustomerNameFilter(BuildContext context) {
    return Obx(() {
      if (dashboard_view_Controller.CustomerName_controller.value.text.isNotEmpty &&
          dashboard_view_Controller.filterDataChecker.value == '1') {
        //List<String> nameList = dashboard_view_Controller.CustomerName_controller.value.text.split(',');
        List<String> nameList = dashboard_view_Controller.customerNameCode.split(',');

        dashboard_view_Controller.SelectedAccount_Master_list.assignAll(
          List.generate(nameList.length, (index) {
            return AccountMasterModel(
              accountName: nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')),
              accountCode: nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')')),
            );
          }),
        );
      }

      return DropdownSearch<AccountMasterModel>.multiSelection(
        compareFn: (item, selectedItem) =>
        item.accountName == selectedItem.accountName,
        asyncItems: (String filter) async {
          return await dashboard_view_Controller.getAccountMaster(filter);
        },
        itemAsString: (AccountMasterModel u) => "${u.accountName ?? ""}(${u.accountCode ?? ""})",
        selectedItems: dashboard_view_Controller.SelectedAccount_Master_list,
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty) {
            return Text(
              "Customer Name",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => "${e.accountName ?? ""}(${e.accountCode ?? ""})").join(', '),
              style: TextStyle(color: Colors.black),
            ),
          );
        },

        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: dashboard_view_Controller.SelectedAccount_Master_list
                .isNotEmpty ? "Customer Name" : null,
            hintText: "Search Customer",
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        onChanged: (List<AccountMasterModel> selectedList) {
          dashboard_view_Controller.SelectedAccount_Master_list.assignAll(
              selectedList);
          dashboard_view_Controller.customerNameCode = selectedList.map((e) =>
          "${e.accountName ?? ""}(${e.accountCode ?? ""})").join(', ');
          dashboard_view_Controller.CustomerName_controller.value.text =
              selectedList.map((e) => e.accountCode).join(', ');
        },

        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          isFilterOnline: true,
          searchDelay: const Duration(milliseconds: 300),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),

          itemBuilder: (context, item, isSelected) {
            return ListTile(
              title: Text("${item.accountName ?? ""}(${item.accountCode ?? ""})",
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
            );
          },
        ),
      );
    });
  }

  bindProductCategoryFilter(BuildContext context) {
    return Obx((){
      if (dashboard_view_Controller.ProductCategory_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.ProductCategory_controller.value.text.split(',');

        dashboard_view_Controller.SelectedProductCategory_list.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
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

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = dashboard_view_Controller.clusterGetByEmailList;
      if (dashboard_view_Controller.clusterName_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.clusterName_controller.value.text.split(',');
        dashboard_view_Controller.SelectedCluster_list.value =[];
        dashboard_view_Controller.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && dashboard_view_Controller.SelectedCluster_list.isEmpty) {
          dashboard_view_Controller.SelectedCluster_list.assignAll(availableItems);
          dashboard_view_Controller.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join(',');
          dashboard_view_Controller.getRegionsWithClusterFilterGetByEmail();
        }
      }
    });

    return Obx(() {
      final selected = dashboard_view_Controller.SelectedCluster_list;
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
              tempSelected.addAll(dashboard_view_Controller.SelectedCluster_list);
              List<ClusterModal> allItems = dashboard_view_Controller.clusterGetByEmailList;
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
                          child: filtered.isEmpty ? const Center(child: Text('No clusters found')) : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.geoValue ?? "") == (item.geoValue ?? ""));
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
                              horizontal: 50, vertical: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    dashboard_view_Controller.filterDataChecker.value='';
                                    dashboard_view_Controller.SelectedCluster_list.assignAll(tempSelected);
                                    dashboard_view_Controller.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join(', ');
                                    dashboard_view_Controller.getRegionsWithClusterFilterGetByEmail();

                                    Navigator.of(context).pop();
                                  },
                                  child:  Text('Done',style: GoogleFonts.poppins(
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
      final availableItems = dashboard_view_Controller.regionwithclusterGetByEmailList;
      if (dashboard_view_Controller.RegionName_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        dashboard_view_Controller.SelectedRegion_list.value=[];
        List<String> nameList = dashboard_view_Controller.RegionName_controller.value.text.split(',');
        dashboard_view_Controller.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && dashboard_view_Controller.SelectedRegion_list.isEmpty) {
          dashboard_view_Controller.SelectedRegion_list.assignAll(availableItems);
          dashboard_view_Controller.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join(',');
          print("bind region ${dashboard_view_Controller.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = dashboard_view_Controller.SelectedRegion_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) => e.geoValue).join(', ');

      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16)),),
            builder: (context) {
              final searchController = TextEditingController();
              final tempSelected = <RegionWithClusterFilterModal>[];
              tempSelected.addAll(dashboard_view_Controller.SelectedRegion_list);

              final allItems = dashboard_view_Controller.regionwithclusterGetByEmailList;

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
                              horizontal: 50, vertical: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    dashboard_view_Controller.filterDataChecker.value='';
                                    dashboard_view_Controller.SelectedRegion_list.assignAll(tempSelected);
                                    dashboard_view_Controller.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join(', ');
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

  Widget bindAccountOwnerFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Obx(() {
      if (dashboard_view_Controller.AccountOwner_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        //List<String> nameList = sale_fore_cast_vm.AccountOwner_controller.value.text.split(',');
        List<String> nameList = dashboard_view_Controller.accountNameCode.split(',');
        dashboard_view_Controller.SelectedEmployee_Member_list.value = List.generate(nameList.length, (index) {
          debugPrint("empid.... ${nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')'))}");
          return EmployeeMemberModel(
            userFullName: dashboard_view_Controller.isAdminWritePermission=="1" ?
            nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')):"",
            fullName: dashboard_view_Controller.isAdminWritePermission!="1"?
            nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')):"",
            salesPersonEmpCode:nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')')),
          );
        });
      }

      final selected = dashboard_view_Controller.SelectedEmployee_Member_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) =>
      "${dashboard_view_Controller.isAdminWritePermission=="1"?e.userFullName ?? "":e.fullName ?? ""}(${e.salesPersonEmpCode ?? ""})").join(', ');
      return GestureDetector(
        onTap: ()  {
          openBottomSheet(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: selectedText != null ?  "Sales Cycle Owner": "", // 👈 Label restored here
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
                  "Sales Cycle Owner",
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

  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16)),),
        builder: (context){
          dashboard_view_Controller.tempSelected.value = [];
          dashboard_view_Controller.tempSelected.addAll(dashboard_view_Controller.SelectedEmployee_Member_list);
          dashboard_view_Controller.filtered.value = dashboard_view_Controller.employee_Member_list;
          return Obx((){
            dashboard_view_Controller.allSelected.value = dashboard_view_Controller.filtered.isNotEmpty
                && dashboard_view_Controller.tempSelected.length == dashboard_view_Controller.filtered.length;
            return Visibility(
                visible: dashboard_view_Controller.selectOwner.value,
                child: Padding(
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
                                  'Select Sales Cycle Owner',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.black),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: const Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))

                            ],
                          ),
                        ),
                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: dashboard_view_Controller.searchController.value,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: dashboard_view_Controller.searchController.value.text.isNotEmpty ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  dashboard_view_Controller.searchController.value.clear();
                                  if(dashboard_view_Controller.isAdminWritePermission=="1") {
                                    dashboard_view_Controller.EmployeeMasterGet(dashboard_view_Controller.searchController.value.text);
                                  }
                                  else{
                                    dashboard_view_Controller.filtered.value =dashboard_view_Controller.searchController.value.text.isEmpty ?
                                    dashboard_view_Controller.employee_Member_list:dashboard_view_Controller.employee_Member_list.where((c) =>
                                        (c.fullName ?? "").toLowerCase().contains(dashboard_view_Controller.searchController.value.text)).toList();
                                  }


                                },
                              ) : null,
                            ),
                            onChanged: (v)
                            {
                              if(dashboard_view_Controller.isAdminWritePermission=="1") {
                                dashboard_view_Controller.EmployeeMasterGet(dashboard_view_Controller.searchController.value.text);
                              }
                              else{
                                dashboard_view_Controller.filtered.value =dashboard_view_Controller.searchController.value.text.isEmpty ?
                                dashboard_view_Controller.employee_Member_list:dashboard_view_Controller.employee_Member_list.where((c) =>
                                    ("${c.fullName ?? ""} ${c.salesPersonEmpCode ?? ""}").toLowerCase().contains(dashboard_view_Controller.searchController.value.text)).toList();
                              }

                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title:dashboard_view_Controller.allSelected.value?const Text('UnSelect All'): const Text('Select All'),
                            value: dashboard_view_Controller.allSelected.value,
                            onChanged: (val) {
                              if (val == true) {
                                dashboard_view_Controller.tempSelected.clear();
                                dashboard_view_Controller.allSelected.value=true;
                                dashboard_view_Controller.tempSelected.addAll(dashboard_view_Controller.filtered);
                              } else {
                                dashboard_view_Controller.allSelected.value=false;
                                dashboard_view_Controller.tempSelected.clear();
                              }
                              dashboard_view_Controller.selectOwner.value=false;
                              dashboard_view_Controller.selectOwner.value=true;
                            },
                          ),
                        ),

                        const Divider(height: 1),
                        Obx((){
                          return Visibility(visible:dashboard_view_Controller.loading.value,
                            child:LinearProgressIndicator(
                              backgroundColor: AllColors.primaryDark1,
                              color: AllColors.textColor,
                            ), );
                        }),


                        // List
                        Expanded(
                          child: dashboard_view_Controller.filtered.isEmpty ? const Center(child: Text('No Record Found!')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: dashboard_view_Controller.filtered.length,
                            itemBuilder: (context, idx) {
                              final item = dashboard_view_Controller.filtered[idx];
                              dashboard_view_Controller.isSel.value = dashboard_view_Controller.tempSelected.any((s) =>
                              (dashboard_view_Controller.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                  (dashboard_view_Controller.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                              return CheckboxListTile(
                                title: Text("${dashboard_view_Controller.isAdminWritePermission=="1"?
                                item.userFullName ?? "":item.fullName ?? ""}(${item.salesPersonEmpCode ?? ""})"),
                                value: dashboard_view_Controller.isSel.value,
                                onChanged: (v) {
                                  if (v == true) {
                                    dashboard_view_Controller.isSel.value=true;
                                    dashboard_view_Controller.tempSelected.add(item);
                                  } else {
                                    dashboard_view_Controller.isSel.value=false;
                                    dashboard_view_Controller.tempSelected.removeWhere((s) =>
                                    (dashboard_view_Controller.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                        (dashboard_view_Controller.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                                    //(s.userFullName ?? "") == (item.userFullName ?? ""));
                                  }
                                  dashboard_view_Controller.selectOwner.value=false;
                                  dashboard_view_Controller.selectOwner.value=true;
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
                                  onPressed: () {
                                    dashboard_view_Controller.SelectedEmployee_Member_list
                                        .assignAll(dashboard_view_Controller.tempSelected);

                                    dashboard_view_Controller.accountNameCode= dashboard_view_Controller.tempSelected.map((nameCode)
                                    =>"${dashboard_view_Controller.isAdminWritePermission=="1"?nameCode.userFullName??"":nameCode.fullName??""}(${nameCode.salesPersonEmpCode})" ).join(', ') ;

                                    dashboard_view_Controller.AccountOwner_controller.value.text =
                                        dashboard_view_Controller.tempSelected.map((e) => e.empId).join(', ');

                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('Done',style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
        }
    );
  }

  bindFilterCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: dashboard_view_Controller.filter_created_on_star_to_cont.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Created On',
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
          dashboard_view_Controller.filter_created_on_cont.value.text = '$startDate @ $endDate';
          dashboard_view_Controller.filter_created_on_star_to_cont.value.text='$startDate - $endDate';
        } else {
          dashboard_view_Controller.filter_created_on_star_to_cont.value.text='';
          dashboard_view_Controller.filter_created_on_cont.value.text="";
        }
      },
    );
  }

}