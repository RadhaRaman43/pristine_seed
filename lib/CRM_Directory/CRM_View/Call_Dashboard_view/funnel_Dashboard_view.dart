
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_store_plus/media_store_plus.dart';
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
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class FunnelDashboardView extends StatelessWidget{
  FunnelDashboardView({super.key});

  final dashboard_view_Controller = Get.put(FunnelDashboardVm());
  SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  final GlobalKey _chartKey = GlobalKey();

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayCommitStatusForOption(String option) =>
      option;

  final NumberFormat formatter = NumberFormat.decimalPattern('en_IN');

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
                            RepaintBoundary(
                              key: _chartKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Active Funnel',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){
                                          dashboard_view_Controller.onRefereshMethod();
                                        },
                                        child: Icon(Icons.refresh),
                                      ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Obx((){
                                    return Container(
                                      //width: 90,
                                      margin: EdgeInsets.only(left: 0,right: 10),
                                      decoration: BoxDecoration(
                                        color: AllColors.grayColor,
                                        border: Border.all(
                                          color: AllColors.grayColor, // Set the border color here
                                          width: 1.0, // Adjust the border width if necessary
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Total :- ',
                                            style: GoogleFonts.poppins(
                                              color: AllColors.blackColor,
                                              fontSize: AllFontSize.twelve,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${formatter.format(double.tryParse(dashboard_view_Controller.totalFunnelPrice.value) ?? 0)}',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: AllFontSize.twelve,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),

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
                                                    '₹ ${formatter.format(double.tryParse(dashboard_view_Controller.totalSuspectPrice.value) ?? 0)}',
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
                                                    '₹ ${formatter.format(double.tryParse(dashboard_view_Controller.totalProspectPrice.value) ?? 0)}',
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
                                                    '₹ ${formatter.format(double.tryParse(dashboard_view_Controller.totalProposePrice.value) ?? 0)}',
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
                                  }),
                                  Obx(() {
                                    return BindDashboardFunnelChartData(context);
                                  }),
                                ],
                              ),
                            ),
                        ),

                        /*Obx(() {
                          return BindDashboardFunnelChartData(context);
                        }),*/
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
    String Status =  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].salesCycleApprovalStatus??"";
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
                    message: dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
                        .salesCycleStatus??"",
                    child: Text(
                      dashboard_view_Controller
                          .funnelDashboardUserWiseDataList[position]
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
                    saleCycleController.ProductCategoryWiseAmtGet(0, dashboard_view_Controller.funnelDashboardUserWiseDataList[position].salesCycleId!);
                    saleCycleController.pageNumber = 0;
                    saleCycleController.filterQuoteAcceptedFlag.value="";
                    saleCycleController.clearAllFieldOfFilter();
                    saleCycleController.getsalesCycleData(saleCycleController.pageNumber, dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
                        .salesCycleId!, "ViewHeader", "FromFunnelDashboard");
                  },
                  child: Icon(Icons.remove_red_eye, size: 30,color: AllColors.textColor,))
            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Sales Cycle Id: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].salesCycleId??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Task Id: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].taskId??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Accepted: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].quoteAccepted??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Approval Status: ", value:  Status,color:getStatusColor(Status)),
              _buildLabelWithValue(label: "Customer Name: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].accountName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Customer Code: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].accountCode??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Account Owner: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].accountOwnerFullName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Estimate Amount: ", value: "₹ ${
                    dashboard_view_Controller
                        .numberFormatWithComma(dashboard_view_Controller
                            .funnelDashboardUserWiseDataList[position]
                            .estimatedAmount)
                        .toString()
                  }",color:AllColors.textColor),
              _buildLabelWithValue(label: "Contact Name: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].contactName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Product Category: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].productCategory??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Purchase Process: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].purchaseProcess??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Company Profile Type: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].companyProfileType??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Is Commit : ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].commit==1?"Yes":"No",color:AllColors.textColor),
              _buildLabelWithValue(label: "Is Solution Accepted: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].isSolutionAccepted==1?"Yes":"No"??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Pin Code: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].postCode??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "District: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].district??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Cluster Name: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].clustureHeadValue??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Region Name: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].branchHeadValue??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Sales Cycle Owner: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].salesCycleOwnerName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Expected Closure Date: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].estClosureDate??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created By: ", value:  dashboard_view_Controller.funnelDashboardUserWiseDataList[position].createdFullName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created On: ", value: StaticMethod.onlyDate( dashboard_view_Controller.funnelDashboardUserWiseDataList[position].createdOn??""),color:AllColors.textColor),
              _buildLabelWithValue(label: "Reporting Manager: ", value: dashboard_view_Controller.funnelDashboardUserWiseDataList[position].approvedFullName??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Approved On: ", value: StaticMethod.onlyDate( dashboard_view_Controller.funnelDashboardUserWiseDataList[position].approvedOn??""),color:AllColors.textColor),

              Visibility(
                visible: dashboard_view_Controller.funnelDashboardUserWiseDataList[position]
                    .salesCycleApprovalStatus == 'Rejected' ? true : false,
                child: _buildLabelWithValue(label: "Rejected Reason: ", value: dashboard_view_Controller.funnelDashboardUserWiseDataList[position].rejectReason??"",color:AllColors.textColor),

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
                        SizedBox(width: 5,),
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
                            dashboard_view_Controller.funnelDashboardData();
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
                            dashboard_view_Controller.funnelDashboardData();
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
            dashboard_view_Controller.filterCustomDateController.value.text = '$startDate - $endDate';
          } else {
            dashboard_view_Controller.filterCustomDateController.value.text = '';
            dashboard_view_Controller.formattedStartDate.value = '';
            dashboard_view_Controller.formattedEndDate.value = '';
          }
        },
      ),
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

          dashboard_view_Controller.filter_created_on_cont.value.text = '$startDate @ $endDate';
        } else {

          dashboard_view_Controller.filter_created_on_cont.value.text="";
        }
      },
    );
  }

  bindSalesStageStatus(BuildContext context) {
    return Obx((){
      if(dashboard_view_Controller.StageName_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1' ){
        dashboard_view_Controller.selectedSalesStageStatusList.value =
            dashboard_view_Controller.StageName_controller.value.text
                .split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
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
            return Text("Sales Cycle Stage",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            //child: Text(dashboard_view_Controller.filterDataChecker.value=='1'?dashboard_view_Controller.StageName_controller.value.text:selectedItems.map((e) => e).join(', '),
            child: Text(selectedItems.map((e) => e).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<String> selectedList) {
          dashboard_view_Controller.selectedSalesStageStatusList.value = selectedList;
          dashboard_view_Controller.StageName_controller.value.text = selectedList.map((e) => e).join(', ');
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
    return Obx(() {
      if (dashboard_view_Controller.CustomerName_controller.value.text
          .isNotEmpty &&
          dashboard_view_Controller.filterDataChecker.value == '1') {
        List<String> nameList = dashboard_view_Controller
            .CustomerName_controller.value.text.split(',');

        dashboard_view_Controller.SelectedAccount_Master_list.assignAll(
          List.generate(nameList.length, (index) {
            return AccountMasterModel(
              accountName: nameList[index].trim(),
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
        itemAsString: (AccountMasterModel u) => u.accountName ?? "",
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
              selectedItems.map((e) => e.accountName).join(', '),
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
          dashboard_view_Controller.CustomerName_controller.value.text =
              selectedList.map((e) => e.accountName).join(', ');
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
              title: Text(
                item.accountName ?? "",
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              /*trailing: isSelected
                  ? const Icon(Icons.check_box, color: Colors.blue)
                  : const Icon(
                  Icons.check_box_outline_blank, color: Colors.grey),*/
              selected: isSelected,
            );
          },
        ),
      );
    });
  }

/*  bindCustomerNameFilter(BuildContext context) {
    return Obx((){
      if (dashboard_view_Controller.CustomerName_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.CustomerName_controller.value.text.split(',');

        dashboard_view_Controller.SelectedAccount_Master_list.value =
            List.generate(nameList.length, (index) {
              return AccountMasterModel(
                accountName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<AccountMasterModel>.multiSelection(
        asyncItems: (String filter) async {
          return await dashboard_view_Controller.getAccountMaster(filter);
        },
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
          dashboard_view_Controller.SelectedAccount_Master_list.value = selectedList;
          dashboard_view_Controller.CustomerName_controller.value.text =
              selectedList.map((e) => e.accountName).join(', ');
        },

        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          isFilterOnline: true,
          searchDelay: const Duration(milliseconds: 0),
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
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

  }*/

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
      final selectedText = selected.isEmpty ? null : selected.map((e) => e.fullName).join(', ');

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
                final filtered = query.isEmpty ? allItems : allItems.where((c) =>
                    (c.fullName ?? "").toLowerCase().contains(query)).toList();

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
                                  'Select Sale Cycle Owner',
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
                              ? const Center(child: Text('No Record Found!'))
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
                                      (s.fullName ?? "") == (item.fullName ?? ""));
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
                  "Sale Cycle Owner",
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
            labelText: dashboard_view_Controller.SelectedEmployee_Member_list.isNotEmpty?"Sale Cycle Owner":null,
            hintText: "Sale Cycle Owner",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              " Sale Cycle Owner",
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
          dashboard_view_Controller.SelectedProductCategory_list.value = selectedList;
          dashboard_view_Controller.ProductCategory_controller.value.text =
              selectedList.map((e) => e.categoryName).join(', ');
        },

        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
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
                              suffixIcon: searchController.text.isNotEmpty ? IconButton(
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
                          child: filtered.isEmpty ? const Center(child: Text('No clusters found')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) => (s.geoValue ?? "") == (item.geoValue ?? ""));
                              return CheckboxListTile(
                                title: Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) => (s.geoValue ?? "") == (item.geoValue ?? ""));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        // Done button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
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
                                    dashboard_view_Controller.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join(',');
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
                          child: filtered.isEmpty ? const Center(child: Text('No regions found')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                              horizontal: 50.0, vertical: 20),
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
                                    dashboard_view_Controller.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join(',');
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

  bindQuoteSubmitted(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width*.96,
      controller: dashboard_view_Controller.QuoteAccepted_controller.value,
      label: Text("Quote Accepted",
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



