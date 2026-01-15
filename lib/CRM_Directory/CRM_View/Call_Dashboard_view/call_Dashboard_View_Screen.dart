import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_store_plus/media_store_plus.dart';


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
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';

class CallDashboardViewScreen extends StatelessWidget {
  CallDashboardViewScreen({super.key});

  final dashboard_view_Controller = Get.put(CallDashboardVm());
  final TaskMaster_page_controller = Get.put(Taskmastervm());
  Size size = Get.size;
  final GlobalKey _chartKey = GlobalKey();

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
                  'Call Dashboard',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Tooltip(
                  message: "Take Screenshot",
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () async {
                      await takeScreenshot(context, _chartKey);
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showFilterBottomSheet(context);
                    },
                    icon: Icon(Icons.filter_alt_sharp))
              ],
            )),
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
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8), // optional spacing
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                                visible: dashboard_view_Controller.userType !=
                                    'Branch Head',
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
                    padding:
                        EdgeInsets.only(left: 15.0, bottom: 0.0, top: 10.0),
                    child: Obx(() {
                      return Column(
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
                          SizedBox(
                            width: 10,
                          ),
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
                    })),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '1. Follow-Up-Call',
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '2. New Call',
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
                            '3. Payment Call',
                            style: GoogleFonts.poppins(
                              color: Colors.orange,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return BindDashboardBarChartData(context, key: _chartKey);
                }),
                Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: dashboard_view_Controller.rodName == '',
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
                            visible: dashboard_view_Controller.rodName != '',
                            child: Text(
                              '${dashboard_view_Controller.geoValueName} ${dashboard_view_Controller.rodName}',
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '(' +
                                dashboard_view_Controller.total_rows.value
                                    .toString() +
                                ')',
                            style: GoogleFonts.poppins(
                              color: AllColors.redColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    })),
                Divider(
                  height: 1,
                  color: AllColors.lightgreyColor,
                ),
                Container(
                  height: size.height / 2,
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
  Future<void> takeScreenshot(BuildContext context, GlobalKey<State<StatefulWidget>> chartKey) async {

    ValueNotifier<double> progress = ValueNotifier(0.0);
    showProgressDialog(context, progress);

    try {
      progress.value = 0.10;

      RenderRepaintBoundary boundary =
      chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image chartImage = await boundary.toImage(pixelRatio: 3.0);

      progress.value = 0.25;

      var chartBytes =
      await chartImage.toByteData(format: ui.ImageByteFormat.png);
      var chartUint8 = chartBytes!.buffer.asUint8List();

      const double textSectionHeight = 80;
      const double spacing = 20;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      final double width = chartImage.width.toDouble();
      final double height =
          chartImage.height.toDouble() + textSectionHeight + spacing;

      final bgPaint = Paint()..color = const Color(0xFFFBF6F6);
      canvas.drawRect(Rect.fromLTWH(0, 0, width, height), bgPaint);

      drawVerticalLabels(canvas);

      final chartUiImage = await decodeImageFromList(chartUint8);
      canvas.drawImage(
          chartUiImage, Offset(0, textSectionHeight + spacing), Paint());

      final picture = recorder.endRecording();

      progress.value = 0.45;

      final finalImage =
      await picture.toImage(width.toInt(), height.toInt());

      var finalBytes =
      await finalImage.toByteData(format: ui.ImageByteFormat.png);
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
      Get.back();
      print("Screenshot error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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

  void drawVerticalLabels(ui.Canvas canvas) {
    double startY = 20;      // top padding
    double gap = 35;         // space between labels
    double x = 20;           // left margin

    List<Map<String, dynamic>> labels = [
      {"text": "1. Follow-Up Call", "color": Color(0xFF3694D3)},
      {"text": "2. New Call", "color": Color(0xFF086D1E)},
      {"text": "3. Payment Call", "color": Color(0xFFCC5A37)},
    ];

    for (var item in labels) {
      final tp = TextPainter(
        text: TextSpan(
          text: item["text"],
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: item["color"],
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      );

      tp.layout();

      tp.paint(canvas, Offset(x, startY));
      startY += tp.height + gap;
    }
  }

  Future<String> saveTempImage(var bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File(
        "${tempDir.path}/CallDashboard_${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Widget BindDashboardBarChartData(BuildContext context, {Key? key}) {
    if (dashboard_view_Controller.callDashboardRecordList.isEmpty) {
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
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ));
    } else {
      double chartWidth = max(MediaQuery.of(context).size.width, _calculateChartWidth());
      final maxY = _calculateMaxY();
      final interval = _calculateInterval(maxY);

      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RepaintBoundary(
            key: _chartKey,
            child: SizedBox(
              height: 450,
              width: chartWidth,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.start,
                  maxY: maxY,
                  barGroups: _createBarGroups(),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback:
                        (FlTouchEvent event, BarTouchResponse? response) {
                      if (!event.isInterestedForInteractions ||
                          response == null ||
                          response.spot == null) return;
                      final rodIndex = response.spot!.touchedRodDataIndex;
                      final groupIndex = response.spot!.touchedBarGroupIndex;
                      String? record = dashboard_view_Controller.callDashboardRecordList[groupIndex].geoValue == null
                          ? dashboard_view_Controller.callDashboardRecordList[groupIndex].employee
                          : dashboard_view_Controller.callDashboardRecordList[groupIndex].geoValue;
                      dashboard_view_Controller.geoValueName.value = record ?? "";
                      if (dashboard_view_Controller.selectedOption == 'Region') {
                        dashboard_view_Controller.RegionNameForApi = record ?? "";
                      } else if (dashboard_view_Controller.selectedOption == 'Cluster') {
                        dashboard_view_Controller.ClusterNameForApi = record ?? "";
                      } else if (dashboard_view_Controller.selectedOption == 'Employee') {
                        dashboard_view_Controller.EmployeeEmailIdForApi =
                            dashboard_view_Controller.callDashboardRecordList[groupIndex].emailId ?? "";
                      }

                      print('geoNameValue...${record}');

                      switch (rodIndex) {
                        case 0:
                          dashboard_view_Controller.TypeOfCallForApi =
                              'Follow-Up Call';
                          dashboard_view_Controller.rodName.value =
                              'Follow-Up Call';
                          dashboard_view_Controller.pageNumber = 0;
                          dashboard_view_Controller.getDashboardUserWiseData(
                              dashboard_view_Controller.pageNumber);
                          break;
                        case 1:
                          dashboard_view_Controller.TypeOfCallForApi = 'New Call';
                          dashboard_view_Controller.rodName.value = 'New Call';
                          // dashboard_view_Controller.geoValueName.value = record??"";
                          dashboard_view_Controller.pageNumber = 0;
                          dashboard_view_Controller.getDashboardUserWiseData(
                              dashboard_view_Controller.pageNumber);
                          break;
                        case 2:
                          dashboard_view_Controller.TypeOfCallForApi =
                              'Payment Call';
                          dashboard_view_Controller.rodName.value =
                              'Payment Call';
                          // dashboard_view_Controller.geoValueName.value = record??"";
                          dashboard_view_Controller.pageNumber = 0;
                          dashboard_view_Controller.getDashboardUserWiseData(
                              dashboard_view_Controller.pageNumber);
                          break;
                      }
                    },
                    touchTooltipData: BarTouchTooltipData(
                      // tooltipBgColor: Colors.lightBlue[50],
                      tooltipPadding: EdgeInsets.all(8),
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final record = dashboard_view_Controller
                            .callDashboardRecordList[group.x.toInt()];
                        String name =
                            dashboard_view_Controller.selectedOption.value ==
                                    'Employee'
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
                        reservedSize: 40,
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
                    topTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: _getTopTitles,
                    )),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
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

    if (max == 0) return 100;
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

  List<BarChartGroupData> _createBarGroups() {
    return List.generate(
        dashboard_view_Controller.callDashboardRecordList.length, (index) {
      final record = dashboard_view_Controller.callDashboardRecordList[index];
      double Width = 20;
      if (dashboard_view_Controller.userType == 'Frontliners') {
        Width = 100;
      } else if (dashboard_view_Controller.userType == 'Branch Head' &&
          dashboard_view_Controller.selectedOption == 'Region') {
        Width = 100;
      } else {
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
  Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 &&
        index < dashboard_view_Controller.callDashboardRecordList.length) {
      String name = dashboard_view_Controller.selectedOption.value == 'Employee'
          ? dashboard_view_Controller.callDashboardRecordList[index].employee ??
              ""
          : dashboard_view_Controller.callDashboardRecordList[index].geoValue ??
              "";

      //int TotalCall = (dashboard_view_Controller.callDashboardRecordList[index].newCall!) + (dashboard_view_Controller.callDashboardRecordList[index].followUpCall!) + (dashboard_view_Controller.callDashboardRecordList[index].paymentCall!);
      String followUpCall = dashboard_view_Controller
          .callDashboardRecordList[index].followUpCall
          .toString();
      String newCall = dashboard_view_Controller
          .callDashboardRecordList[index].newCall
          .toString();
      String paymentCall = dashboard_view_Controller
          .callDashboardRecordList[index].paymentCall
          .toString();

      String formattedName = name.replaceAll(' ', '\n');
      //  print('totalCallc ${TotalCall}');

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: RotatedBox(
          quarterTurns: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${followUpCall=='0'?"":followUpCall}    ${newCall=='0'?'':newCall}    ${paymentCall=='0'?'':paymentCall}',
                style: TextStyle(fontSize: 10, color: AllColors.blackColor),
              ),
              Text(
                formattedName,
                style: TextStyle(fontSize: 10, color: AllColors.blackColor),
                softWrap: true,
                maxLines: 2, // or more if needed
                overflow:
                    TextOverflow.ellipsis, // optional: show "..." if too long
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _getTopTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 &&
        index < dashboard_view_Controller.callDashboardRecordList.length) {
      int TotalCall =
          (dashboard_view_Controller.callDashboardRecordList[index].newCall!) +
              (dashboard_view_Controller
                  .callDashboardRecordList[index].followUpCall!) +
              (dashboard_view_Controller
                  .callDashboardRecordList[index].paymentCall!);

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: RotatedBox(
          quarterTurns: 4,
          child: Text(
            'All Calls : ${TotalCall.toString()}',
            style: TextStyle(fontSize: 10, color: AllColors.blackColor),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  double _calculateChartWidth() {
    final count = dashboard_view_Controller.callDashboardRecordList.length;
    if (count <= 2)
      return MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .width;
    final groupWidth = 3 * 15 + 15 * 2; // 3 bars × bar width + 2 × bar space
    return count * groupWidth + 100; // extra padding
  }
  Widget _buildActionChip(String label) {
    return Obx(() {
      final isSelected =
          dashboard_view_Controller.selectedOption.value == label;
      return ActionChip(
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        backgroundColor:
        isSelected ? AllColors.primaryDark1 : AllColors.grayColor,
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


  Widget BindDashboardWiseDataList(context) {
    if (dashboard_view_Controller
            .callDashboardUserWiseDataList.value.isNotEmpty &&
        dashboard_view_Controller.callDashboardUserWiseDataList.value.length >
            0) {
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
            dashboard_view_Controller.getDashboardUserWiseData(
                dashboard_view_Controller.pageNumber + 1);
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
          itemCount: dashboard_view_Controller
              .callDashboardUserWiseDataList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assests/images/no_data_remove.png",
            width: 150,
            height: 150,
          ),
          Text(
            'No Record Found',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700),
          )
        ],
      ));
    }
  }

  Widget BindCustomerRequestListView(context, int position)
  {
    String taskStatus = dashboard_view_Controller
        .callDashboardUserWiseDataList[position].taskStatus!;
    String pipeLine = dashboard_view_Controller
            .callDashboardUserWiseDataList[position].taskDueTime!.isNotEmpty
        ? "|"
        : "";
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
          onTap: () {},
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Task Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Tooltip(
                    message: dashboard_view_Controller
                            .callDashboardUserWiseDataList[position].taskId ??
                        "",
                    child: Text(
                      dashboard_view_Controller
                              .callDashboardUserWiseDataList[position].taskId ??
                          "",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    TaskMaster_page_controller.FromPage.value =
                        'from_CallDashboard';
                    TaskMaster_page_controller.getTaskMaster(
                        0,
                        TaskMaster_page_controller.is_Active.toString(),
                        dashboard_view_Controller
                            .callDashboardUserWiseDataList[position].taskId,
                        '',
                        'GET FROM TASK ID',
                        TaskMaster_page_controller.date_filter,
                        TaskMaster_page_controller.is_done.value);
                    Get.toNamed(RoutesName.taskMasterDetails_screen);
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    size: 30,
                    color: AllColors.textColor,
                  ))
            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Task Status: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].taskStatus ?? "",color:getStatusColor(taskStatus)),
              _buildLabelWithValue(label: "Customer Name: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].accountName  ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Customer Code: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].accountCode  ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Contact Name: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].contactName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Type of Call: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].typeOfCall ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Mode of Call: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].methodOfCall ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Task Remarks: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].taskRemarks ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Purpose Of Visit: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].purposeOfVisit ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Company Profile Type: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].companyProfileType ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Account Owner: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].accountOwnerFullName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Last Activity Status: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].lastActivityStatus ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Last Activity Updated On: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].lastActivityUpdatedOn ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Sales Cycle Id: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].salesCycleId ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Product Category: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].productCategory  ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Along With Person Name: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].alongWithPersonName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Due Date: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].taskDueDate ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Pin Code: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].postCode ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "District: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].district ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Cluster Name: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].clustureHeadValue ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Region Name: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].branchHeadValue ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Task Owner: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].createdFullName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created By: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].createdBy ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created By: ", value:  StaticMethod.onlyDate(dashboard_view_Controller.callDashboardUserWiseDataList[position].createdOn?? ""),color:AllColors.textColor),
              _buildLabelWithValue(label: "Reporting Manager: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].approvedFullName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Approved On: ", value:  StaticMethod.onlyDate(dashboard_view_Controller.callDashboardUserWiseDataList[position].approvedOn?? ""),color:AllColors.textColor),
              _buildLabelWithValue(label: "Manager Remarks: ", value:  dashboard_view_Controller.callDashboardUserWiseDataList[position].managerRemarks ?? "",color:AllColors.textColor),

              Visibility(
                visible: dashboard_view_Controller
                            .callDashboardUserWiseDataList[position]
                            .taskStatus ==
                        'Rejected'
                    ? true
                    : false,
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
                                .rejectReason ??
                            "",
                        child: Text(
                          dashboard_view_Controller
                                  .callDashboardUserWiseDataList[position]
                                  .methodOfCall ??
                              "",
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
            message: value ?? "",
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
                        Icon(
                          Icons.shield_moon_rounded,
                          color: AllColors.primaryDark1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
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
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            dashboard_view_Controller.callDashboardData();
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
                            dashboard_view_Controller.callDashboardData();
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
                            Get.back();
                          },
                        )),
                      ],
                    ),
                  ),

                  /*Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark, width: 1),
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
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                )),
                            onPressed: () {
                              dashboard_view_Controller
                                  .clearAllFilterController();
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


  RadioGroupDateRangeFilter(BuildContext context) {
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
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Day',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Day',
                      dense: true,
                      groupValue:
                          dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('day');
                        dashboard_view_Controller
                                .filterCustomDateController.value.text =
                            '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.callDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Weakly',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Weakly',
                      dense: true,
                      groupValue:
                          dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('week');
                        dashboard_view_Controller
                                .filterCustomDateController.value.text =
                            '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.callDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Month',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Month',
                      dense: true,
                      groupValue:
                          dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('month');
                        dashboard_view_Controller
                                .filterCustomDateController.value.text =
                            '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.callDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Quarterly',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Quarterly',
                      dense: true,
                      groupValue:
                          dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('quarterly');
                        dashboard_view_Controller
                                .filterCustomDateController.value.text =
                            '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.callDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Financial Year',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Financial Year',
                      dense: true,
                      groupValue:
                          dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('financial');
                        dashboard_view_Controller
                                .filterCustomDateController.value.text =
                            '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.callDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Custom',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Custom',
                      dense: true,
                      groupValue:
                          dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                      },
                    );
                  }),
                  Obx(() {
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
          bindClusterNameFilter(context),
          SizedBox(height: 10),
          bindRegionNameFilter(context),
          SizedBox(height: 10),
          bindAccountOwnerFilter(context),
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
                  colorScheme:
                      ColorScheme.light(primary: AllColors.primaryDark1),
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
            dashboard_view_Controller.filterCustomDateController.value.text =
                '';
            dashboard_view_Controller.formattedStartDate.value = '';
            dashboard_view_Controller.formattedEndDate.value = '';
          }
        },
      ),
    );
  }

  bindTaskStatus(BuildContext context) {
    return Obx(() {
      if(dashboard_view_Controller.task_Status_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1' ){
        dashboard_view_Controller.selectedTaskStatusList.value =
            dashboard_view_Controller.task_Status_controller.value.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      return DropdownSearch<String>.multiSelection(
        items: dashboard_view_Controller.TaskStatusListTypeList,
        itemAsString: (String u) => u,
        selectedItems: dashboard_view_Controller.selectedTaskStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText:
                dashboard_view_Controller.selectedTaskStatusList.isNotEmpty
                    ? "Task Status"
                    : null,
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
          dashboard_view_Controller.selectedTaskStatusList.value = selectedList;
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item),
          ),
        ),
      );
    });
  }

  bindLastActivityStatus(BuildContext context) {
    return Obx(() {
      if (dashboard_view_Controller.lastActivity_Status_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.lastActivity_Status_controller.value.text.split(',');

        dashboard_view_Controller.selectedDSARStatusList.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: dashboard_view_Controller.DSARStatus_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: dashboard_view_Controller.selectedDSARStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText:
                dashboard_view_Controller.selectedDSARStatusList.isNotEmpty
                    ? "Last Activity Status"
                    : null,
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
          dashboard_view_Controller.selectedDSARStatusList.value = selectedList;
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }

  bindTypeCallFilter(BuildContext context) {
    return Obx(() {
      if (dashboard_view_Controller.typeOfCall_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.typeOfCall_controller.value.text.split(',');

        dashboard_view_Controller.selectedTypeCallList.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: dashboard_view_Controller.TypeCall_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: dashboard_view_Controller.selectedTypeCallList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.selectedTypeCallList.isNotEmpty ? "Type Of Call" : null,
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
          dashboard_view_Controller.selectedTypeCallList.value = selectedList;
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }

  bindCustomerNameFilter(BuildContext context) {
    return Obx(() {
      if (dashboard_view_Controller.CustomerName_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.CustomerName_controller.value.text.split(',');

        dashboard_view_Controller.SelectedAccount_Master_list.value =
            List.generate(nameList.length, (index) {
              return AccountMasterModel(
                accountName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<AccountMasterModel>.multiSelection(
        items: dashboard_view_Controller.Account_Master_list,
        itemAsString: (AccountMasterModel u) => u.accountName ?? "",
        selectedItems: dashboard_view_Controller.SelectedAccount_Master_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText:
                dashboard_view_Controller.SelectedAccount_Master_list.isNotEmpty
                    ? "Customer Name"
                    : null,
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.accountName ?? ""),
          ),
        ),
      );
    });
  }

  Widget bindAccountOwnerFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });

    return Obx(() {
      if (dashboard_view_Controller.AccountOwner_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.AccountOwner_controller.value.text.split(',');

        dashboard_view_Controller.SelectedEmployee_Member_list.value =
            List.generate(nameList.length, (index) {
              return EmployeeMemberModel(
                fullName: nameList[index].trim(),
              );
            });
      }
      final selected = dashboard_view_Controller.SelectedEmployee_Member_list;
      final selectedText = selected.isEmpty
          ? null
          : selected.map((e) => e.fullName).join(', ');

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
              final tempSelected = <EmployeeMemberModel>[];
              tempSelected.addAll(dashboard_view_Controller.SelectedEmployee_Member_list);

              List<EmployeeMemberModel> allItems =
                  dashboard_view_Controller.employee_Member_list;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? allItems
                    : allItems
                    .where((c) =>
                    (c.fullName ?? "").toLowerCase().contains(query))
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
                                  'Task Owner',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
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
                              ? const Center(child: Text('No record found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.fullName ?? "") ==
                                  (item.fullName ?? ""));
                              return CheckboxListTile(
                                title: Text(item.fullName ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) =>
                                      (s.fullName ?? "") ==
                                          (item.fullName ?? ""));
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
                                  onPressed: () {
                                    dashboard_view_Controller.SelectedEmployee_Member_list.assignAll(tempSelected);
                                    dashboard_view_Controller.AccountOwner_controller.value.text =
                                        tempSelected.map((e) => e.fullName).join(', ');

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Done'),
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
            labelText: selectedText != null
                ?"Task Owner":"", // 👈 Label restored here
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
                  "Task Owner",
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

  /*bindAccountOwnerFilter(BuildContext context) {
    return Obx(() {
      return DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: dashboard_view_Controller.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName ?? "",
        selectedItems: dashboard_view_Controller.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller
                    .SelectedEmployee_Member_list.isNotEmpty
                ? "Account Owner"
                : null,
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.fullName ?? ""),
          ),
        ),
      );
    });
  }*/

  bindProductCategoryFilter(BuildContext context) {
    return Obx(() {
      if (dashboard_view_Controller.ProductCategory_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.ProductCategory_controller.value.text.split(',');

        dashboard_view_Controller.SelectedProductCategory_list.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: dashboard_view_Controller.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: dashboard_view_Controller.SelectedProductCategory_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller
                    .SelectedProductCategory_list.isNotEmpty
                ? "Product Category"
                : null,
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.categoryName ?? ""),
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

              List<ClusterModal> allItems =
                  dashboard_view_Controller.clusterGetByEmailList;

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
                                      fontSize: 16, fontWeight: FontWeight.w600),
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

                                    dashboard_view_Controller.filterDataChecker.value='';
                                    dashboard_view_Controller.SelectedCluster_list.assignAll(tempSelected);
                                    dashboard_view_Controller.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join(', ');
                                    dashboard_view_Controller.getRegionsWithClusterFilterGetByEmail();

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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
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

  /*bindClusterNameFilter(BuildContext context) {
    return Obx(() {
      return DropdownSearch<ClusterModal>.multiSelection(
        items: dashboard_view_Controller.clusterGetByEmailList,
        itemAsString: (ClusterModal u) => u.geoValue ?? "",
        selectedItems: dashboard_view_Controller.SelectedCluster_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedCluster_list.isNotEmpty
                ? "Cluster Name"
                : null,
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
          dashboard_view_Controller.SelectedCluster_list.value = selectedList;
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.geoValue ?? ""),
          ),
        ),
      );
    });
  }

  bindRegionNameFilter(BuildContext context) {
    return Obx(() {
      return DropdownSearch<RegionWithClusterFilterModal>.multiSelection(
        items: dashboard_view_Controller.regionwithclusterGetByEmailList,
        itemAsString: (RegionWithClusterFilterModal u) => u.geoValue ?? "",
        selectedItems: dashboard_view_Controller.SelectedRegion_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedRegion_list.isNotEmpty
                ? "Region Name"
                : null,
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
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.geoValue ?? ""),
          ),
        ),
      );
    });
  }*/
}
