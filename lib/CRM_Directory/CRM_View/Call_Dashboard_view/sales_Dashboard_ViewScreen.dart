import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_VIewModels/Dashboard_VM/Sales_Dashboard_Vm.dart';

class SalesDashboardViewscreen extends StatelessWidget{
  SalesDashboardViewscreen({super.key});

  final dashboard_view_Controller = Get.put(SalesDashboardVm());
  Size size=Get.size;

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
                'Sales Dashboard',
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
        body: SingleChildScrollView(
          child: Column(
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
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 10,right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AllColors.grayColor, // Set the border color here
                    width: 1.0, // Adjust the border width if necessary
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: dashboard_view_Controller.ClusterName_Controller.value,
                        decoration: InputDecoration(
                            hintText: "Cluster Name",
                            labelText: "Cluster Name",
                            //suffixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten,
                                horizontal: AllFontSize.ten),
          
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
          
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: dashboard_view_Controller.RegionName_Controller.value,
                        decoration: InputDecoration(
                            hintText: "Region Name",
                            labelText: "Region Name",
                            //suffixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten,
                                horizontal: AllFontSize.ten),
          
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
          
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: dashboard_view_Controller.SalesPersonName_Controller.value,
                        decoration: InputDecoration(
                            hintText: "Sales Person Name",
                            labelText: "Sales Person Name",
                            //suffixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten,
                                horizontal: AllFontSize.ten),
          
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
          
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: dashboard_view_Controller.SalesPersonER_Code_Controller.value,
                        decoration: InputDecoration(
                            hintText: "Sales Person ER Code",
                            labelText: "Sales Person ER Code",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten,
                                horizontal: AllFontSize.ten),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
          
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: dashboard_view_Controller.PeriodFrom_Controller.value,
                        decoration: InputDecoration(
                            hintText: "Period From",
                            labelText: "Period From",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten,
                                horizontal: AllFontSize.ten),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
          
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AllColors.grayColor, // Set the border color here
                          width: 1.0, // Adjust the border width if necessary
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: dashboard_view_Controller.PeriodTo_Controller.value,
                        decoration: InputDecoration(
                            hintText: "Period To",
                            labelText: "Period To",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten,
                                horizontal: AllFontSize.ten),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
          
                      ),
                    ),
          
                    SizedBox(height: 10,),
          
                    Card(
                      color: AllColors.whiteColor,
                      elevation: 10,
                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 5),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              /*border: Border.all(
                          color: AllColors.blackColor, // Set the border color here
                        ),*/
                                borderRadius: BorderRadius.circular(10.0),
                                color: AllColors.textColor
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.task, color: AllColors.whiteColor,),
                                ),
                                Text(
                                  "CRM Tasks",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Obx(
                                      () {
                                    return IconButton(
                                      onPressed: () {
                                        dashboard_view_Controller.toggleCrtd();
                                        if (dashboard_view_Controller
                                            .isExpandCrtd.value ==
                                            true) {
                                          print(
                                              "If......${dashboard_view_Controller.isExpandCrtd.value}");
                                        } else {
                                          print(
                                              "else......${dashboard_view_Controller.isExpandCrtd.value}");
                                        }
                                      },
                                      icon: Icon(
                                        dashboard_view_Controller
                                            .isExpandCrtd.value
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 25,
                                        color: AllColors.whiteColor,
                                      ),
                                    );
                                  },
                                )
          
                              ],
                            ),
                          ),
                          Obx(() {
                            return CRMTaskDetailCard(context);
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
          
                    Card(
                      color: AllColors.whiteColor,
                      elevation: 10,
                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 5),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AllColors.textColor
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.auto_graph, color: AllColors.whiteColor,),
                                ),
                                Text(
                                  "Funnel",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Obx(
                                      () {
                                    return IconButton(
                                      onPressed: () {
                                        dashboard_view_Controller.toggleFunnelCrtd();
                                        if (dashboard_view_Controller
                                            .isExpandFunnel.value ==
                                            true) {
                                          print(
                                              "If......${dashboard_view_Controller.isExpandCrtd.value}");
                                        } else {
                                          print(
                                              "else......${dashboard_view_Controller.isExpandCrtd.value}");
                                        }
                                      },
                                      icon: Icon(
                                        dashboard_view_Controller
                                            .isExpandFunnel.value
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 25,
                                        color: AllColors.whiteColor,
                                      ),
                                    );
                                  },
                                )
          
                              ],
                            ),
                          ),
                          Obx(() {
                            return FunnelDetailCard(context);
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),

                    Card(
                      color: AllColors.whiteColor,
                      elevation: 10,
                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 5),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AllColors.textColor
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.business, color: AllColors.whiteColor,),
                                ),
                                Text(
                                  "Business Central Booking",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Obx(
                                      () {
                                    return IconButton(
                                      onPressed: () {
                                        dashboard_view_Controller.toggleBussinessCrtd();
                                        if (dashboard_view_Controller
                                            .isExpandBussiness.value ==
                                            true) {
                                          print(
                                              "If......${dashboard_view_Controller.isExpandBussiness.value}");
                                        } else {
                                          print(
                                              "else......${dashboard_view_Controller.isExpandBussiness.value}");
                                        }
                                      },
                                      icon: Icon(
                                        dashboard_view_Controller
                                            .isExpandBussiness.value
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 25,
                                        color: AllColors.whiteColor,
                                      ),
                                    );
                                  },
                                )

                              ],
                            ),
                          ),
                          Obx(() {
                            return BusinessCentreBookingCard(context);
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),

                    Card(
                      color: AllColors.whiteColor,
                      elevation: 10,
                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 5),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AllColors.textColor
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.list_alt_outlined, color: AllColors.whiteColor,),
                                ),
                                Text(
                                  "Collection",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Obx(
                                      () {
                                    return IconButton(
                                      onPressed: () {
                                        dashboard_view_Controller.toggleCollectionCrtd();
                                        if (dashboard_view_Controller
                                            .isExpandCollection.value ==
                                            true) {
                                          print(
                                              "If......${dashboard_view_Controller.isExpandBussiness.value}");
                                        } else {
                                          print(
                                              "else......${dashboard_view_Controller.isExpandBussiness.value}");
                                        }
                                      },
                                      icon: Icon(
                                        dashboard_view_Controller
                                            .isExpandCollection.value
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 25,
                                        color: AllColors.whiteColor,
                                      ),
                                    );
                                  },
                                )

                              ],
                            ),
                          ),
                          Obx(() {
                            return CollectionCard(context);
                          }),
                        ],
                      ),
                    ),
          
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget CRMTaskDetailCard(BuildContext context) {
    if(dashboard_view_Controller.salesDashboardList.isNotEmpty){
      return   Visibility(
        visible: dashboard_view_Controller.isExpandCrtd.value,
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              ListItemBind("Existing Accounts :",dashboard_view_Controller.salesDashboardList[0].existingAccount ),
              SizedBox(height: 3,),
              ListItemBind("New Account Created :",dashboard_view_Controller.salesDashboardList[0].newAccount ),
              SizedBox(height: 3,),
              ListItemBind("Total Accounts :",dashboard_view_Controller.salesDashboardList[0].totalAccount ),
              SizedBox(height: 3,),
              ListItemBind("Acc. Covered in C/M :",dashboard_view_Controller.salesDashboardList[0].accountCoveredCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Acc. Covered in P/M :",dashboard_view_Controller.salesDashboardList[0].accountCoveredPreviousMonth ),
              SizedBox(height: 3,),
              ListItemBind("Fresh Acc. Covered in C/M :",dashboard_view_Controller.salesDashboardList[0].freshAccountCoveredCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Total Acc. Covered :",dashboard_view_Controller.salesDashboardList[0].totalAccountCovered ),
              SizedBox(height: 3,),
              ListItemBind("New Call :", dashboard_view_Controller.salesDashboardList[0].newCall),
              SizedBox(height: 3,),
              ListItemBind("Follow Up Call :", dashboard_view_Controller.salesDashboardList[0].followUpCall),
              SizedBox(height: 3,),
              ListItemBind("Payment Call :", dashboard_view_Controller.salesDashboardList[0].paymentCall),
              SizedBox(height: 3,),
              ListItemBind("Total Calls :", dashboard_view_Controller.salesDashboardList[0].totalCall),
              SizedBox(height: 3,),
              ListItemBind("Total Order :", dashboard_view_Controller.salesDashboardList[0].totalOrders),
              SizedBox(height: 3,),
              ListItemBind("Call Rate :", dashboard_view_Controller.salesDashboardList[0].callRate),
              SizedBox(height: 3,),
              ListItemBind("Call Rate Target Vs Ach. :", dashboard_view_Controller.salesDashboardList[0].callRateTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("New Call :", dashboard_view_Controller.salesDashboardList[0].newCall),
              SizedBox(height: 3,),
              ListItemBind("New Call Target Vs Ach. :", dashboard_view_Controller.salesDashboardList[0].newCallTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("Strike Rate: :", dashboard_view_Controller.salesDashboardList[0].strikeRate),
              SizedBox(height: 3,),
              ListItemBind("Strike Rate Target Vs Ach. :", dashboard_view_Controller.salesDashboardList[0].strikeRateTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("DSAR % :", dashboard_view_Controller.salesDashboardList[0].dsarPer),
              SizedBox(height: 3,),
              ListItemBind("DSAR  Target Vs Ach. :", dashboard_view_Controller.salesDashboardList[0].dsarTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("Average Order Size :", dashboard_view_Controller.salesDashboardList[0].avgOrderSize),
              SizedBox(height: 3,),
              ListItemBind("Target Vs Ach. :", dashboard_view_Controller.salesDashboardList[0].targetAchievement),
              SizedBox(height: 3,),
              ListItemBind("Business Tour Plan (No of Days) :", dashboard_view_Controller.salesDashboardList[0].businessTourDays),
              SizedBox(height: 3,),


            ],
          ),
        ),
      );
    }else{
      return  Obx(() {
        return Visibility(
          visible: dashboard_view_Controller.loading.value,
          child: SizedBox()
        );
      });
    }

  }

  Widget FunnelDetailCard(BuildContext context) {
    if(dashboard_view_Controller.salesDashboardList.isNotEmpty){
      return   Visibility(
        visible: dashboard_view_Controller.isExpandFunnel.value,
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Text("C/M Funnel",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].currentMonthPropose ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].currentMonthProspect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].currentMonthPropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].currentMonthTotalFunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),
              Text("C/F/M Funnel",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].currentFinancialYearSuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].currentFinancialYearProspect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].currentFinancialYearPropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].currentFinancialYearTotalFunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),
              Text("Quarter 1",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].firstQuaterSuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].firstQuaterProspect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].firstQuaterPropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].firstQuaterTotalFunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),

              Text("Quarter 2 ",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].secondQuaterSuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].secondQuaterProspect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].secondQuaterPropose),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].secondQuaterTotalFunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),

              Text("Quarter 3 ",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].thirdQuaterSuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].thirdQuaterProspect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].thirdQuaterPropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].thirdQuaterTotalFunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),

              Text("Quarter 4 ",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].fourthQuaterSuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].fourthQuaterProspect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].fourthQuaterPropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].fourthQuaterTotalFunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),

              Text("Month wise total funnel",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 70,
                  child: MonthWiseDataFunnel(context)),
              SizedBox(height: 3,),
              ListItemBind("New Prospects Generated in C/M :",dashboard_view_Controller.salesDashboardList[0].newProspectsGeneratedCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Carry Forward Prospects From P/M :",dashboard_view_Controller.salesDashboardList[0].carryForwardProspectsPreviousMonths ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Won :",dashboard_view_Controller.salesDashboardList[0].previousMonthOrderWon ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Lost :",dashboard_view_Controller.salesDashboardList[0].previousMonthOrderLost ),
              SizedBox(height: 3,),
              ListItemBind("C/M Order Won :",dashboard_view_Controller.salesDashboardList[0].currentMonthOrderWon ),
              SizedBox(height: 3,),
              ListItemBind("P/M Order Lost :",dashboard_view_Controller.salesDashboardList[0].previousMonthOrderLost ),
              SizedBox(height: 3,),
              ListItemBind("Order Lost FY :",dashboard_view_Controller.salesDashboardList[0].orderLostFy ),
              SizedBox(height: 3,),
              ListItemBind("Order Won FY :",dashboard_view_Controller.salesDashboardList[0].orderWonFy ),
              SizedBox(height: 3,),







            ],
          ),
        ),
      );
    }else{
      return  Obx(() {
        return Visibility(
            visible: dashboard_view_Controller.loading.value,
            child: SizedBox()
        );
      });
    }

  }

  Widget MonthWiseDataFunnel(BuildContext context){
    ScrollController scrollController = ScrollController();
    if(dashboard_view_Controller.monthWiseTotalFunnelList.isNotEmpty){
      return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dashboard_view_Controller.monthWiseTotalFunnelList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindDataListView(context, index);
          });
    }
    else {
      return SizedBox();
    }

  }

  Widget BindDataListView(BuildContext context, int pos){
    return  Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dashboard_view_Controller.monthWiseTotalFunnelList[pos].monthName??"",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${dashboard_view_Controller.monthWiseTotalFunnelList[pos].monthYearValue??""}',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget ListItemBind(String Tag, dynamic Value){
    return Row(
      children: [
        Text(Tag,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Text(
          "${Value}",
          style: GoogleFonts.poppins(
            color: AllColors.textColor,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget BusinessCentreBookingCard(BuildContext context) {
    if(dashboard_view_Controller.salesDashboardList.isNotEmpty){
      return   Visibility(
        visible: dashboard_view_Controller.isExpandBussiness.value,
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              SizedBox(height: 5,),
              ListItemBind("Commitment Prev. Month :",dashboard_view_Controller.salesDashboardList[0].commitmentPreMonth ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Prev. Month :",dashboard_view_Controller.salesDashboardList[0].actualBookingPrevMonth ),
              SizedBox(height: 3,),
              ListItemBind("Booking Ach. Prev. Month (%) :",dashboard_view_Controller.salesDashboardList[0].bookingAchiveCurrentMonthPer ),
              SizedBox(height: 3,),
              ListItemBind("Booking Commitment C/M :",dashboard_view_Controller.salesDashboardList[0].bookingCommitmentCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking C/M :",dashboard_view_Controller.salesDashboardList[0].actualBookingCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Booking Ach. C/M (%):",dashboard_view_Controller.salesDashboardList[0].bookingAchiveCurrentMonthPer ),
              SizedBox(height: 3,),
              ListItemBind("Booking AO C/M :",dashboard_view_Controller.salesDashboardList[0].bookingAoCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("AO Vs Booking Ach. C/M (%):",dashboard_view_Controller.salesDashboardList[0].aoVsBookingAchiveCurrentMonthPer ),
              SizedBox(height: 3,),
              ListItemBind("Booking AO Current FY:",dashboard_view_Controller.salesDashboardList[0].bookingAoCurrentFy ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Current FY:",dashboard_view_Controller.salesDashboardList[0].actualBookingCurrentFy ),
              SizedBox(height: 3,),
              ListItemBind("AO Vs Booking Ach. FY (%):",dashboard_view_Controller.salesDashboardList[0].aoVsBookingAchiveFyPer ),
              SizedBox(height: 3,),
              ListItemBind("Order Over 15/20 Lakhs C/M:",dashboard_view_Controller.salesDashboardList[0].ordersAbove15LakhCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Order Over 15/20 Lakhs FY:",dashboard_view_Controller.salesDashboardList[0].ordersAbove15LakhFy ),
              SizedBox(height: 3,),

              Text("Month wise commitment",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  height: 70,
                  child: MonthWiseCommitment(context)),
              Divider(
                height: 1, thickness: 2, color: Colors.grey,
              ),
              SizedBox(height: 5,),
              Text("Month wise  AO Vs Booking Ach",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  height: 70,
                  child: MonthWiseAOVsBookingAch(context)),
              SizedBox(height: 3,),


            ],
          ),
        ),
      );
    }else{
      return  Obx(() {
        return Visibility(
            visible: dashboard_view_Controller.loading.value,
            child: SizedBox()
        );
      });
    }

  }

  Widget MonthWiseCommitment(BuildContext context){
    ScrollController scrollController = ScrollController();
    if(dashboard_view_Controller.monthWiseCommitmentList.isNotEmpty){
      return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dashboard_view_Controller.monthWiseCommitmentList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindDataCommitmentListView(context, index);
          });
    }
    else {
      return SizedBox();
    }

  }

  Widget BindDataCommitmentListView(BuildContext context, int pos){
    return  Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dashboard_view_Controller.monthWiseCommitmentList[pos].monthName??"",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${dashboard_view_Controller.monthWiseCommitmentList[pos].monthYearValue??""}',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget MonthWiseAOVsBookingAch(BuildContext context){
    ScrollController scrollController = ScrollController();
    if(dashboard_view_Controller.monthWiseAoVsBookingList.isNotEmpty){
      return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dashboard_view_Controller.monthWiseAoVsBookingList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindDataAOvsBookingListView(context, index);
          });
    }
    else {
      return SizedBox();
    }

  }

  Widget BindDataAOvsBookingListView(BuildContext context, int pos){
    return  Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dashboard_view_Controller.monthWiseAoVsBookingList[pos].monthName??"",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${dashboard_view_Controller.monthWiseAoVsBookingList[pos].monthYearActualBookingValue??""}',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget CollectionCard(BuildContext context) {
    if(dashboard_view_Controller.salesDashboardList.isNotEmpty){
      return   Visibility(
        visible: dashboard_view_Controller.isExpandCollection.value,
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              SizedBox(height: 3,),
              ListItemBind("Prev. Month Collection Commitment:",dashboard_view_Controller.salesDashboardList[0].prevMonthCollectionCommitment ),
              SizedBox(height: 3,),
              ListItemBind("Prev. Month Collection (Actual) :",dashboard_view_Controller.salesDashboardList[0].prevMonthCollectionActual ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach. :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanVsAchievementPer ),
              SizedBox(height: 3,),
              ListItemBind("Collection Commitment (This Month) :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionCommitment ),
              SizedBox(height: 3,),
              ListItemBind("Actual Collection This Month  :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionActual ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach. (% C/M) :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanVsAchievementPer ),
              SizedBox(height: 3,),
              ListItemBind("Month wise Collection Plan Vs Ach. (%):",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanVsAchievementPer ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach. FY (%):", dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanVsAchievementPer),
              SizedBox(height: 3,),
              ListItemBind("Bank Guarantee :", dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanVsAchievementPer),
              SizedBox(height: 3,),
              ListItemBind("EMSD :", dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanVsAchievementPer),
              SizedBox(height: 3,),
              ListItemBind("Outstanding FY :", dashboard_view_Controller.salesDashboardList[0].totalCall),
              SizedBox(height: 3,),

            ],
          ),
        ),
      );
    }else{
      return  Obx(() {
        return Visibility(
            visible: dashboard_view_Controller.loading.value,
            child: SizedBox()
        );
      });
    }

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
                              dashboard_view_Controller.salesDashboardData();
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
                              dashboard_view_Controller.salesDashboardData();
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

  RadioGroupDateRangeFilter(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          /*Container(
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
          ),*/
          filterWithCustomDate(context),
          /*SizedBox(height: 10),
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
          bindAccountOwnerFilter(context),*/
          SizedBox(height: 10),
          bindClusterNameFilter(context),
          SizedBox(height: 10),
          bindRegionNameFilter(context),
        ],
      ),
    );
  }

  filterWithCustomDate(BuildContext context) {
    return TextField(
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
    );
  }

  bindClusterNameFilter(BuildContext context) {
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
          dashboard_view_Controller.clusterNameFilter_controller.value.text =
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
          dashboard_view_Controller.RegionNameFilter_controller.value.text =
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
  }



}