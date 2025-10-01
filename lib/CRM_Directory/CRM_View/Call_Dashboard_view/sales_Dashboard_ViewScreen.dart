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
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
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
                                Obx(() {
                                    return IconButton(
                                      onPressed: () {
                                        dashboard_view_Controller.toggleCrtd();
                                        if (dashboard_view_Controller.isExpandCrtd.value == true) {
                                          print("If......${dashboard_view_Controller.isExpandCrtd.value}");
                                        } else {
                                          print("else......${dashboard_view_Controller.isExpandCrtd.value}");
                                        }
                                      },
                                      icon: Icon(
                                        dashboard_view_Controller.isExpandCrtd.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
                                Obx(() {
                                    return IconButton(
                                      onPressed: () {
                                        dashboard_view_Controller.toggleFunnelCrtd();
                                        if (dashboard_view_Controller.isExpandFunnel.value == true) {
                                          print("If......${dashboard_view_Controller.isExpandCrtd.value}");
                                        } else {
                                          print("else......${dashboard_view_Controller.isExpandCrtd.value}");
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
          dashboard_view_Controller.salesDashboardData();
        },
      );
    });
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
              ListItemBind("Acc. Covered in Current Month :",dashboard_view_Controller.salesDashboardList[0].accountCoveredCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Acc. Covered Till Previous Month(Financial Year) :",dashboard_view_Controller.salesDashboardList[0].accountCoveredPreviousMonth ),
              SizedBox(height: 3,),
              ListItemBind("New Acc. Covered in Current Month :",dashboard_view_Controller.salesDashboardList[0].freshAccountCoveredCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Total Acc. Covered :",dashboard_view_Controller.salesDashboardList[0].totalAccountCovered ),
              SizedBox(height: 3,),
              ListItemBind("Working Days :",dashboard_view_Controller.salesDashboardList[0].workingDays ),
              SizedBox(height: 3,),
              ListItemBind("New Call :", dashboard_view_Controller.salesDashboardList[0].newCall),
              SizedBox(height: 3,),
              ListItemBind("Follow Up Call :", dashboard_view_Controller.salesDashboardList[0].followUpCall),
              SizedBox(height: 3,),
              ListItemBind("Payment Call :", dashboard_view_Controller.salesDashboardList[0].paymentCall),
              SizedBox(height: 3,),
              ListItemBind("Total Calls :", dashboard_view_Controller.salesDashboardList[0].totalCall),
              SizedBox(height: 3,),
              ListItemBind("Total Won Order Count(CRM) :", dashboard_view_Controller.salesDashboardList[0].totalOrders),
              SizedBox(height: 3,),
              ListItemBind("Order Value :", dashboard_view_Controller.salesDashboardList[0].ordersValue),
              SizedBox(height: 3,),
              ListItemBind("Call Rate :", dashboard_view_Controller.salesDashboardList[0].callRate),
              SizedBox(height: 3,),
              ListItemBind("Call Rate Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].callRateTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("New Call(%) :", dashboard_view_Controller.salesDashboardList[0].newCall),
              SizedBox(height: 3,),
              ListItemBind("New Call Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].newCallTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("Strike Rate: :", dashboard_view_Controller.salesDashboardList[0].strikeRate),
              SizedBox(height: 3,),
              ListItemBind("Strike Rate Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].strikeRateTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("DSAR % :", dashboard_view_Controller.salesDashboardList[0].dsarPer),
              SizedBox(height: 3,),
              ListItemBind("DSAR  Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].dsarTargetAchieve),
              SizedBox(height: 3,),
              ListItemBind("Average Order Size :", dashboard_view_Controller.salesDashboardList[0].avgOrderSize),
              SizedBox(height: 3,),
              ListItemBind("Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].targetAchievement),
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
                            backgroundColor:dashboard_view_Controller.FilterFunnel.value=="All"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'All',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.FilterFunnel.value=="All"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              dashboard_view_Controller.FilterFunnel.value="All";
                              dashboard_view_Controller.salesDashboardData();
                            },
                          );
                        }),
                        SizedBox(width: 8),
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                            backgroundColor:
                            dashboard_view_Controller.FilterFunnel.value=="Open"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Open',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.FilterFunnel.value=="Open"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              dashboard_view_Controller.FilterFunnel.value="Open";
                              dashboard_view_Controller.salesDashboardData();
                            },
                          );
                        }),
                        SizedBox(width: 8),
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                            backgroundColor:dashboard_view_Controller.FilterFunnel.value=="Won"

                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Won',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.FilterFunnel.value=="Won"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              dashboard_view_Controller.FilterFunnel.value = "Won";
                              dashboard_view_Controller.salesDashboardData();
                              },
                          );
                        }),
                        SizedBox(width: 8), // optional spacing between chips
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                            backgroundColor:dashboard_view_Controller.FilterFunnel.value=="Loss"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Loss',
                              style: GoogleFonts.poppins(
                                color: dashboard_view_Controller.FilterFunnel.value=="Loss"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              dashboard_view_Controller.FilterFunnel.value="Loss";
                              dashboard_view_Controller.salesDashboardData();
                              },
                          );
                        }),
                        SizedBox(width: 8),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text("Current Month Funnel",
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
              Text("Current Financial Year Funnel",
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
              ListItemBind("New Prospects Generated in Current Month :",dashboard_view_Controller.salesDashboardList[0].newProspectsGeneratedCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Carry Forward Prospects From Previous Month :",dashboard_view_Controller.salesDashboardList[0].carryForwardProspectsPreviousMonths ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Won :",dashboard_view_Controller.salesDashboardList[0].previousMonthOrderWon ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Lost :",dashboard_view_Controller.salesDashboardList[0].previousMonthOrderLost ),
              SizedBox(height: 3,),
              ListItemBind("Current Month Order Won :",dashboard_view_Controller.salesDashboardList[0].currentMonthOrderWon ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Lost :",dashboard_view_Controller.salesDashboardList[0].previousMonthOrderLost ),
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
      margin: EdgeInsets.only(left: 10),
      //width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),

      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5),
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
      ),
    );
  }

  Widget ListItemBind(String Tag, dynamic Value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Tooltip(
            message: Tag,
            child: Text(Tag,
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        //Spacer(),
        SizedBox(width: 5,),
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
              ListItemBind("Booking Commitment Current Month :",dashboard_view_Controller.salesDashboardList[0].bookingCommitmentCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Current Month :",dashboard_view_Controller.salesDashboardList[0].actualBookingCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Booking Ach. Current Month (%):",dashboard_view_Controller.salesDashboardList[0].bookingAchiveCurrentMonthPer ),
              SizedBox(height: 3,),
              ListItemBind("Booking AO Current Month :",dashboard_view_Controller.salesDashboardList[0].bookingAoCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("AO Vs Booking Ach. Current Month (%):",dashboard_view_Controller.salesDashboardList[0].aoVsBookingAchiveCurrentMonthPer ),
              SizedBox(height: 3,),
              ListItemBind("Booking AO Current FY:",dashboard_view_Controller.salesDashboardList[0].bookingAoCurrentFy ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Current FY:",dashboard_view_Controller.salesDashboardList[0].actualBookingCurrentFy ),
              SizedBox(height: 3,),
              ListItemBind("AO Vs Booking Ach. FY (%):",dashboard_view_Controller.salesDashboardList[0].aoVsBookingAchiveFyPer ),
              SizedBox(height: 3,),
              ListItemBind("Order Over 15/20 Lakhs Current Month:",dashboard_view_Controller.salesDashboardList[0].ordersAbove15LakhCurrentMonth ),
              SizedBox(height: 3,),
              ListItemBind("Order Over 15/20 Lakhs FY:",dashboard_view_Controller.salesDashboardList[0].ordersAbove15LakhFy ),
              SizedBox(height: 3,),
              Text("Month wise commitment (CRM)",
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
      margin: EdgeInsets.only(left: 10),
      //width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5),
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
      ),
    );
  }

  Widget MonthWiseCollectionPlan(BuildContext context){
    ScrollController scrollController = ScrollController();
    if(dashboard_view_Controller.monthWiseCollectionCommitmentList.isNotEmpty){
      return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dashboard_view_Controller.monthWiseCollectionCommitmentList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindDataMonthWiseCollectionPlan(context, index);
          });
    }
    else {
      return SizedBox();
    }

  }

  Widget BindDataMonthWiseCollectionPlan(BuildContext context, int pos){
    return  Container(
      margin: EdgeInsets.only(left: 10),
      //width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dashboard_view_Controller.monthWiseCollectionCommitmentList[pos].monthName??"",
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Commitment: ${dashboard_view_Controller.monthWiseCollectionCommitmentList[pos].monthYearCollectionCommitmentValue??""}',
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Actual: ${dashboard_view_Controller.monthWiseCollectionCommitmentList[pos].monthYearActualCollectionValue??""}',
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
      margin: EdgeInsets.only(left: 10),
      //width: 90,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5),
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
              '${dashboard_view_Controller.monthWiseAoVsBookingList[pos].monthYearBookingAoValue??""}/ \n ${dashboard_view_Controller.monthWiseAoVsBookingList[pos].monthYearActualBookingValue??""}' ,
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
              ListItemBind("Collection Commitment Previous Month:",dashboard_view_Controller.salesDashboardList[0].prevMonthCollectionCommitment ),
              SizedBox(height: 3,),
              ListItemBind("Actual Collection Previous Month :",dashboard_view_Controller.salesDashboardList[0].prevMonthCollectionActual ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach.(%) :",dashboard_view_Controller.salesDashboardList[0].prevMonthCollectionPlanAchivePer ),
              SizedBox(height: 3,),
              ListItemBind("Collection Commitment Current Month :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionCommitment ),
              SizedBox(height: 3,),
              ListItemBind("Actual Collection This Month  :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionActual ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach.Current Month (%) :",dashboard_view_Controller.salesDashboardList[0].currentMonthCollectionPlanAchivePer ),
              SizedBox(height: 3,),
              Text("Monthwise Collection Plan Vs Ach. (%)",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Container(
                  height: 70,
                  child: MonthWiseCollectionPlan(context)),
              Divider(
                height: 1, thickness: 2, color: Colors.grey,
              ),

              ListItemBind("Collection Plan Vs Ach. Financial Year (%) :","${dashboard_view_Controller.salesDashboardList[0].financialYearCollectionCommitmentVsActualCollectionAchive?[0].financialYearActualCollectionValue}/ "
                  "${dashboard_view_Controller.salesDashboardList[0].financialYearCollectionCommitmentVsActualCollectionAchive?[0].financialYearCollectionCommitmentValue}="
                  "${dashboard_view_Controller.salesDashboardList[0].financialYearCollectionCommitmentVsActualCollectionAchive?[0].financialYearCollectionValuePer}"),
              SizedBox(height: 3,),
              ListItemBind("Total Bank Guarantee :",dashboard_view_Controller.salesDashboardList[0].totalBankGrantee ),
              SizedBox(height: 3,),
              ListItemBind("Total EMSD :",dashboard_view_Controller.salesDashboardList[0].totalEmsd ),
              SizedBox(height: 3,),
              ListItemBind("Due Bank Guarantee :",dashboard_view_Controller.salesDashboardList[0].totalDueBankGrantee ),
              SizedBox(height: 3,),
              ListItemBind("Due Date EMSD :",dashboard_view_Controller.salesDashboardList[0].totalDueEmsd ),
              SizedBox(height: 3,),
              ListItemBind("Outstanding Financial Year :",dashboard_view_Controller.salesDashboardList[0].totalOutstanding ),
              SizedBox(height: 3,),
              ListItemBind("0–30 :",dashboard_view_Controller.salesDashboardList[0].a030 ),
              SizedBox(height: 3,),
              ListItemBind("31–60 :",dashboard_view_Controller.salesDashboardList[0].a3160 ),
              SizedBox(height: 3,),
              ListItemBind("61-90 :",dashboard_view_Controller.salesDashboardList[0].a6190 ),
              SizedBox(height: 3,),
              ListItemBind("91-180 :",dashboard_view_Controller.salesDashboardList[0].a91180 ),
              SizedBox(height: 3,),
              ListItemBind("181-365 :",dashboard_view_Controller.salesDashboardList[0].a181365 ),
              SizedBox(height: 3,),
              ListItemBind("366-Above :",dashboard_view_Controller.salesDashboardList[0].a366Above ),
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
                              dashboard_view_Controller.clearAllFilterController();
                              dashboard_view_Controller.pageNumber = 0;
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
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.salesDashboardData();
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
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.salesDashboardData();
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
                        dashboard_view_Controller.salesDashboardData();
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
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.salesDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Previous Financial Year',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Previous Financial Year',
                      dense: true,
                      groupValue:
                      dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('previousfinancialyear');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.salesDashboardData();
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
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.salesDashboardData();
                        Get.back();
                      },
                    );
                  }),
                  Obx(() {
                    return RadioListTile<String>(
                      title: const Text(
                        'Next Financial Year',
                        style: TextStyle(fontSize: AllFontSize.sisxteen),
                      ),
                      value: 'Next Financial Year',
                      dense: true,
                      groupValue:
                      dashboard_view_Controller.character.value.toString(),
                      onChanged: (value) {
                        dashboard_view_Controller.character.value = value ?? "";
                        dashboard_view_Controller.DateRange('nextfinancialyear');
                        dashboard_view_Controller.filterCustomDateController.value.text =
                        '${dashboard_view_Controller.formattedStartDate} - ${dashboard_view_Controller.formattedEndDate}';
                        dashboard_view_Controller.pageNumber = 0;
                        dashboard_view_Controller.salesDashboardData();
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
          //filterWithCustomDate(context),
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
          SizedBox(height: 10),
          bindEmployeeNameFilter(context),
        ]
      ),
    );
  }

  bindEmployeeNameFilter(BuildContext context) {
    return Obx((){
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: dashboard_view_Controller.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: dashboard_view_Controller.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: dashboard_view_Controller.SelectedEmployee_Member_list.isNotEmpty?"Employee Name":null,
            hintText: "Employee Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Employee Name",
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
          dashboard_view_Controller.SelectedEmployee_Member_list.value = selectedList;
          dashboard_view_Controller.EmployeeNameFilter_controller.value.text = selectedList.map((e) => e.fullName).join(', ');
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