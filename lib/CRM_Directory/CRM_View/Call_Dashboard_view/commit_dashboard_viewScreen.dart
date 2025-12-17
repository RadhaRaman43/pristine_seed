import 'dart:math';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:flutter/rendering.dart';

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
import '../../CRM_VIewModels/Dashboard_VM/commit_dashboard_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class CommitDashboardViewscreen extends StatelessWidget{
  CommitDashboardViewscreen({super.key});

  final dashboard_view_Controller = Get.put(CommitDashboardVm());
  SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  final GlobalKey _chartKey = GlobalKey();

  static String _displayCustomerNeedIdentityStatusForOption(String option) => option;

  static String _displayCommitStatusForOption(String option) => option;

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
              children: [
                Text(
                  'Commit Dashboard',
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
                                  '${dashboard_view_Controller.geoValueName}',
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
          dashboard_view_Controller.commitDashboardData();
        },
      );
    });
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


  Future<String> saveTempImage(var bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File(
        "${tempDir.path}/CallDashboard_${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Widget BindDashboardBarChartData(BuildContext context) {
    /*if (dashboard_view_Controller.isShimmerLoading.value) {
      return BarChartShimmer(context);
    } else*/ if (dashboard_view_Controller.commitDashboardRecordList.isEmpty) {
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
                        String? record = dashboard_view_Controller.commitDashboardRecordList[groupIndex].geoValue == null?dashboard_view_Controller.commitDashboardRecordList[groupIndex].employee : dashboard_view_Controller.commitDashboardRecordList[groupIndex].geoValue;

                        dashboard_view_Controller.geoValueName.value = record??"";
                        if(dashboard_view_Controller.selectedOption == 'Region'){
                          dashboard_view_Controller.RegionNameForApi = record??"";
                        }else if(dashboard_view_Controller.selectedOption == 'Cluster'){
                          dashboard_view_Controller.ClusterNameForApi = record??"";
                        }else if(dashboard_view_Controller.selectedOption == 'Employee'){
                          dashboard_view_Controller.EmployeeEmailIdForApi = dashboard_view_Controller.commitDashboardRecordList[groupIndex].emailId??"";
                        }

                        dashboard_view_Controller.rodName.value = dashboard_view_Controller.geoValueName.value;
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.getDashboardUserWiseData(dashboard_view_Controller.pageNumber);



                        /*switch (rodIndex) {
                          case 0:
                           // dashboard_view_Controller.TypeOfCallForApi = 'Follow-Up Call';

                            break;

                        }*/
                      },
                      touchTooltipData: BarTouchTooltipData(
                        // tooltipBgColor: Colors.lightBlue[50],
                        tooltipPadding: EdgeInsets.all(8),
                        tooltipRoundedRadius: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final record = dashboard_view_Controller.commitDashboardRecordList[group.x.toInt()];
                          String name = dashboard_view_Controller.selectedOption.value == 'Employee'
                              ? record.employee ?? ""
                              : record.geoValue ?? "";

                          String valueLabel;
                          valueLabel = 'Estimated Amount: ${rod.toY.toInt()}';
                          /*switch (rodIndex) {
                            case 0:

                              break;

                            default:
                              valueLabel = 'Value: ${rod.toY.toInt()}';

                          }*/

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
                            // Skip top label
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

  double _calculateMaxY() {
    double max = 0;
    for (var r in dashboard_view_Controller.commitDashboardRecordList) {
      max = [
        max,
        (r.estimatedAmount ?? 0).toDouble(),
      ].reduce((a, b) => a > b ? a : b);
    }

    if (max == 0) return 100; // force 0-100 scale if no data

    // Round up to next multiple of 10
    return ((max / 10).ceil() * 11).toDouble();
  }

  /*double _calculateInterval(double maxY) {
    if (maxY <= 20) return 1;
    if (maxY <= 50) return 5;
    if (maxY <= 100) return 10;
    if (maxY <= 500) return 50;
    if (maxY <= 1000) return 100;
    if (maxY <= 10000) return 1000;
    return (maxY / 10).roundToDouble(); // fallback
  }*/

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


  /// Dynamically create groups of bars
  List<BarChartGroupData> _createBarGroups() {
    return List.generate(dashboard_view_Controller.commitDashboardRecordList.length, (index) {
      final record = dashboard_view_Controller.commitDashboardRecordList[index];
      double Width = 50;
      if(dashboard_view_Controller.userType == 'Frontliners'){
        Width = 85;
      }else if(dashboard_view_Controller.userType == 'Branch Head' && dashboard_view_Controller.selectedOption == 'Region') {
        Width = 85;
      }else{
        Width = 50;
      }
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (record.estimatedAmount ?? 0).toDouble(),
            color: Colors.blue,
            width: Width,
            borderRadius: BorderRadius.zero,
          ),
        ],
        barsSpace: 4, // Set this to 0 for no spacing (single bar effect)
      );
    });
  }

  /// X-axis label widget
  Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 && index < dashboard_view_Controller.commitDashboardRecordList.length) {
      String name = dashboard_view_Controller.selectedOption.value == 'Employee'
          ? dashboard_view_Controller.commitDashboardRecordList[index].employee ?? ""
          : dashboard_view_Controller.commitDashboardRecordList[index].geoValue ?? "";

      double TotalCall = (dashboard_view_Controller.commitDashboardRecordList[index].estimatedAmount!);

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

  /*double _calculateChartWidth() {
    final count = dashboard_view_Controller.commitDashboardRecordList.length;
    final spacingPerBar = 80.0;
    return count * spacingPerBar + 10;
  }*/

  double _calculateChartWidth() {
    final count = dashboard_view_Controller.commitDashboardRecordList.length;

    double barWidth = 20; // your actual bar width in pixels
    double barSpacing = 40; // gap between bars in pixels

    // total width = (bar width + spacing) × count
    return (barWidth + barSpacing) * count;
  }


  Widget BindDashboardWiseDataList(context) {
    if (dashboard_view_Controller.commitDashboardUserWiseDataList.value.isNotEmpty && dashboard_view_Controller.commitDashboardUserWiseDataList.value.length > 0) {
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
          itemCount: dashboard_view_Controller.commitDashboardUserWiseDataList.value.length,
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
    String Status =  dashboard_view_Controller.commitDashboardUserWiseDataList[position].salesCycleApprovalStatus??"";
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
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          onTap: () {

          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Sales Cycle Stage : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Tooltip(
                    message: dashboard_view_Controller.commitDashboardUserWiseDataList[position]
                        .salesCycleStatus??"",
                    child: Text(
                      dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .salesCycleStatus??"",
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
                    saleCycleController.ProductCategoryWiseAmtGet(0, dashboard_view_Controller.commitDashboardUserWiseDataList[position].salesCycleId!);
                    saleCycleController.pageNumber = 0;
                    saleCycleController.filterQuoteAcceptedFlag.value="";
                    saleCycleController.clearAllFieldOfFilter();
                    saleCycleController.getsalesCycleData(saleCycleController.pageNumber, dashboard_view_Controller.commitDashboardUserWiseDataList[position]
                        .salesCycleId!, "ViewHeader", "FromCommitDashboard");
                  },
                  child: Icon(Icons.remove_red_eye, size: 30,color: AllColors.textColor,))

            ],
          ),
          subtitle: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales Cycle Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .salesCycleId??"",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Task Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .taskId??"",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quote Accepted: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .quoteAccepted??"",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Approval Status: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: Status,
                      child: Text(
                        Status,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: getStatusColor(Status),
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .accountName ?? "",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
                            .accountName ??
                            "",
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          .commitDashboardUserWiseDataList[position]
                          .contactName!,
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          .commitDashboardUserWiseDataList[position]
                          .contactName!,
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cluster Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .clustureHeadValue??"",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
                            .clustureHeadValue??"",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Region Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .branchHeadValue??"",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
                            .branchHeadValue??"",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Is Commit : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .commit.toString() == '1'?'Yes':'No',
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
                            .commit.toString() == '1'?'Yes':'No',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Solution Accepted : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .isSolutionAccepted.toString() == '1'?'Yes':'No',
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
                            .isSolutionAccepted.toString() == '1'?'Yes':'No',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          .commitDashboardUserWiseDataList[position]
                          .createdFullName??"" +
                          "| ${StaticMethod.dateTimeToDate(
                              dashboard_view_Controller
                                  .commitDashboardUserWiseDataList[position]
                                  .createdOn??"")}",
                      child: Text(
                        dashboard_view_Controller
                            .commitDashboardUserWiseDataList[position]
                            .createdFullName??"" +
                            "| ${StaticMethod.dateTimeToDate(
                                dashboard_view_Controller
                                    .commitDashboardUserWiseDataList[position]
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected Closure Date : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Tooltip(
                      message: dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .estClosureDate,
                      child: Text(" ${dashboard_view_Controller
                          .commitDashboardUserWiseDataList[position]
                          .estClosureDate ??
                          ""}",
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
                visible: dashboard_view_Controller.commitDashboardUserWiseDataList[position]
                    .salesCycleApprovalStatus == 'Rejected' ? true : false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            .commitDashboardUserWiseDataList[position]
                            .rejectReason??"",
                        child: Text(
                          dashboard_view_Controller
                              .commitDashboardUserWiseDataList[position]
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
                              dashboard_view_Controller.commitDashboardData();
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
                              dashboard_view_Controller.commitDashboardData();
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
                        dashboard_view_Controller.commitDashboardData();
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
                        dashboard_view_Controller.commitDashboardData();
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
                        dashboard_view_Controller.commitDashboardData();
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
                        dashboard_view_Controller.commitDashboardData();
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
                        dashboard_view_Controller.commitDashboardData();
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
          bindProductCategoryFilter(context),
          SizedBox(height: 10),
          bindIsCommitDropDown(context),
          SizedBox(height: 10),
          bindClusterNameFilter(context),
          SizedBox(height: 10),
          bindRegionNameFilter(context),
          SizedBox(height: 10),
          bindAccountOwnerFilter(context),
          SizedBox(height: 10),
          bindFilterCreatedOn(context),



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
        "is Commit",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w600),
      ),
      initialSelection: 'ALL',
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

  bindFilterCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: dashboard_view_Controller.filter_created_on_cont.value,
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

          dashboard_view_Controller.filter_created_on_cont.value.text = '$startDate - $endDate';
        } else {

          dashboard_view_Controller.filter_created_on_cont.value.text="";
        }
      },
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

  Widget bindAccountOwnerFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });

    return Obx(() {
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
                                  'Sales Cycle Owner',
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
                              ? const Center(child: Text('No clusters found'))
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
                                    dashboard_view_Controller.SelectedEmployee_Member_list
                                        .assignAll(tempSelected);
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
            labelText:selectedText != null
                ?  "Sales Cycle Owner": "", // 👈 Label restored here
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
  /*bindAccountOwnerFilter(BuildContext context) {
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

  }*/

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

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = dashboard_view_Controller.clusterGetByEmailList;
      if (availableItems.isNotEmpty &&
          dashboard_view_Controller.SelectedCluster_list.isEmpty) {
        dashboard_view_Controller.SelectedCluster_list.assignAll(availableItems);
        dashboard_view_Controller.clusterName_controller.value.text =
            availableItems.map((e) => e.geoValue).join(', ');
        dashboard_view_Controller.getRegionsWithClusterFilterGetByEmail();
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
                                  onPressed: () {
                                    dashboard_view_Controller.SelectedCluster_list
                                        .assignAll(tempSelected);
                                    dashboard_view_Controller
                                        .clusterName_controller.value.text =
                                        tempSelected
                                            .map((e) => e.geoValue)
                                            .join(', ');
                                    dashboard_view_Controller
                                        .getRegionsWithClusterFilterGetByEmail();

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
      if (availableItems.isNotEmpty &&
          dashboard_view_Controller.SelectedRegion_list.isEmpty) {
        dashboard_view_Controller.SelectedRegion_list.assignAll(availableItems);
        dashboard_view_Controller.RegionName_controller.value.text =
            availableItems.map((e) => e.geoValue).join(', ');

      }
    });
    return Obx(() {
      final selected = dashboard_view_Controller.SelectedRegion_list;
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
              final tempSelected = <RegionWithClusterFilterModal>[];
              tempSelected.addAll(dashboard_view_Controller.SelectedRegion_list);

              final allItems =
                  dashboard_view_Controller.regionwithclusterGetByEmailList;

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
                                  'Select Regions',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: AllColors.primaryDark1),
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
                                  onPressed: () {
                                    dashboard_view_Controller.SelectedRegion_list
                                        .assignAll(tempSelected);
                                    dashboard_view_Controller.RegionName_controller
                                        .value.text =
                                        tempSelected
                                            .map((e) => e.geoValue)
                                            .join(', ');
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

 /* bindClusterNameFilter(BuildContext context) {
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

  }*/


}