import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/dashboard_models/SalesDashboard_Model/department_modal.dart';
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
                                    "CRM Funnel",
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
              ListItemBind("Existing Accounts :",dashboard_view_Controller.salesDashboardList[0].existingaccount ),
              SizedBox(height: 3,),
              ListItemBind("New Account Created :",dashboard_view_Controller.salesDashboardList[0].newaccount ),
              SizedBox(height: 3,),
              ListItemBind("Total Accounts :",dashboard_view_Controller.salesDashboardList[0].totalaccount ),
              SizedBox(height: 3,),
              ListItemBind("Acc. Covered in Current Month :",dashboard_view_Controller.salesDashboardList[0].accountcoveredcurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("Acc. Covered Till Previous Month(Financial Year) :",dashboard_view_Controller.salesDashboardList[0].accountcoveredpreviousmonth ),
              SizedBox(height: 3,),
              ListItemBind("New Acc. Covered in Current Month :",dashboard_view_Controller.salesDashboardList[0].freshaccountcoveredcurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("Total Acc. Covered :",dashboard_view_Controller.salesDashboardList[0].totalaccountcovered ),
              SizedBox(height: 3,),
              ListItemBind("Working Days :",dashboard_view_Controller.salesDashboardList[0].workingdays ),
              SizedBox(height: 3,),
              ListItemBind("New Call :", dashboard_view_Controller.salesDashboardList[0].newcall),
              SizedBox(height: 3,),
              ListItemBind("Follow Up Call :", dashboard_view_Controller.salesDashboardList[0].followupcall),
              SizedBox(height: 3,),
              ListItemBind("Payment Call :", dashboard_view_Controller.salesDashboardList[0].paymentcall),
              SizedBox(height: 3,),
              ListItemBind("Total Calls :", dashboard_view_Controller.salesDashboardList[0].totalcall),
              SizedBox(height: 3,),
              ListItemBind("Total Won Order Count(CRM) :", dashboard_view_Controller.salesDashboardList[0].totalorders),
              SizedBox(height: 3,),
              ListItemBind("Order Value :", dashboard_view_Controller.salesDashboardList[0].ordersvalue),
              SizedBox(height: 3,),
              ListItemBind("Call Rate :", dashboard_view_Controller.salesDashboardList[0].callrate),
              SizedBox(height: 3,),
              ListItemBind("Call Rate Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].callratetargetachieve),
              SizedBox(height: 3,),
              ListItemBind("New Call(%) :", dashboard_view_Controller.salesDashboardList[0].newcall),
              SizedBox(height: 3,),
              ListItemBind("New Call Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].newcalltargetachieve),
              SizedBox(height: 3,),
              ListItemBind("Strike Rate: :", dashboard_view_Controller.salesDashboardList[0].strikerate),
              SizedBox(height: 3,),
              ListItemBind("Strike Rate Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].strikeratetargetachieve),
              SizedBox(height: 3,),
              ListItemBind("DSAR % :", dashboard_view_Controller.salesDashboardList[0].dsarper),
              SizedBox(height: 3,),
              ListItemBind("DSAR  Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].dsartargetachieve),
              SizedBox(height: 3,),
              ListItemBind("Average Order Size :", dashboard_view_Controller.salesDashboardList[0].avgordersize),
              SizedBox(height: 3,),
              ListItemBind("Target Vs Ach.(%) :", dashboard_view_Controller.salesDashboardList[0].targetachievement),
              SizedBox(height: 3,),
              ListItemBind("Business Tour Plan (No of Days) :", dashboard_view_Controller.salesDashboardList[0].businesstourdays),
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
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].currentmonthsuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].currentmonthprospect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].currentmonthpropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].currentmonthtotalfunnel ),
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
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].currentfinancialyearsuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].currentfinancialyearprospect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].currentfinancialyearpropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].currentfinancialyeartotalfunnel ),
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
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].firstquatersuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].firstquaterprospect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].firstquaterpropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].firstquatertotalfunnel ),
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
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].secondquatersuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].secondquaterprospect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].secondquaterpropose),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].secondquatertotalfunnel ),
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
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].thirdquatersuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].thirdquaterprospect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].thirdquaterpropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].thirdquatertotalfunnel ),
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
              ListItemBind("Suspect :",dashboard_view_Controller.salesDashboardList[0].fourthquatersuspect ),
              SizedBox(height: 3,),
              ListItemBind("Prospect :",dashboard_view_Controller.salesDashboardList[0].fourthquaterprospect ),
              SizedBox(height: 3,),
              ListItemBind("Propose :",dashboard_view_Controller.salesDashboardList[0].fourthquaterpropose ),
              SizedBox(height: 3,),
              ListItemBind("Total Funnel :",dashboard_view_Controller.salesDashboardList[0].fourthquatertotalfunnel ),
              SizedBox(height: 3,),
              Divider(height: 1, thickness: 2, color: Colors.grey,),
              SizedBox(height: 3,),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Tooltip(
                  message: "Financial Year Total Funnel :",
                  child: Text("Financial Year Total Funnel :",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              //Spacer(),
              SizedBox(width: 5,),
              Text("${dashboard_view_Controller.salesDashboardList[0].totalfunnelfinancialyear??""}",
                style: GoogleFonts.poppins(
                  color: AllColors.textColor,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),



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
              ListItemBind("New Prospects Generated in Current Month :",dashboard_view_Controller.salesDashboardList[0].newprospectsgeneratedcurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("Carry Forward Prospects From Previous Month :",dashboard_view_Controller.salesDashboardList[0].carryforwardprospectspreviousmonths ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Won :",dashboard_view_Controller.salesDashboardList[0].previousmonthorderwon ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Lost :",dashboard_view_Controller.salesDashboardList[0].previousmonthorderlost ),
              SizedBox(height: 3,),
              ListItemBind("Current Month Order Won :",dashboard_view_Controller.salesDashboardList[0].currentmonthorderwon ),
              SizedBox(height: 3,),
              ListItemBind("Previous Month Order Lost :",dashboard_view_Controller.salesDashboardList[0].previousmonthorderlost ),
              SizedBox(height: 3,),
              ListItemBind("Order Lost FY :",dashboard_view_Controller.salesDashboardList[0].orderlostfy ),
              SizedBox(height: 3,),
              ListItemBind("Order Won FY :",dashboard_view_Controller.salesDashboardList[0].orderwonfy ),
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
    print("data....,,,...${dashboard_view_Controller.monthWiseTotalFunnelList[pos]?.monthyearvalue}");
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
              dashboard_view_Controller.monthWiseTotalFunnelList[pos]?.monthname??"",
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${dashboard_view_Controller.monthWiseTotalFunnelList[pos]?.monthyearvalue??""}',
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
              ListItemBind("Commitment Prev. Month :",dashboard_view_Controller.salesDashboardList[0].commitmentpremonth ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Prev. Month :",dashboard_view_Controller.salesDashboardList[0].actualbookingprevmonth ),
              SizedBox(height: 3,),
              ListItemBind("Booking Ach. Prev. Month (%) :",dashboard_view_Controller.salesDashboardList[0].bookingachivecurrentmonthper ),
              SizedBox(height: 3,),
              ListItemBind("Booking Commitment Current Month :",dashboard_view_Controller.salesDashboardList[0].bookingcommitmentcurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Current Month :",dashboard_view_Controller.salesDashboardList[0].actualbookingcurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("Booking Ach. Current Month (%):",dashboard_view_Controller.salesDashboardList[0].bookingachivecurrentmonthper ),
              SizedBox(height: 3,),
              ListItemBind("Booking AO Current Month :",dashboard_view_Controller.salesDashboardList[0].bookingaocurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("AO Vs Booking Ach. Current Month (%):",dashboard_view_Controller.salesDashboardList[0].aovsbookingachivecurrentmonthper ),
              SizedBox(height: 3,),
              ListItemBind("Booking AO Current FY:",dashboard_view_Controller.salesDashboardList[0].bookingaocurrentfy ),
              SizedBox(height: 3,),
              ListItemBind("Actual Booking Current FY:",dashboard_view_Controller.salesDashboardList[0].actualbookingcurrentfy ),
              SizedBox(height: 3,),
              ListItemBind("AO Vs Booking Ach. FY (%):",dashboard_view_Controller.salesDashboardList[0].aovsbookingachivefyper ),
              SizedBox(height: 3,),
              ListItemBind("Order Over 15/20 Lakhs Current Month:",dashboard_view_Controller.salesDashboardList[0].ordersabove15Lakhcurrentmonth ),
              SizedBox(height: 3,),
              ListItemBind("Order Over 15/20 Lakhs FY:",dashboard_view_Controller.salesDashboardList[0].ordersabove15Lakhfy ),
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

              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Tooltip(
                      message: "Financial Year Month Wise Commitment :",
                      child: Text("Financial Year Month Wise Commitment :",
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
                  Text('${dashboard_view_Controller.salesDashboardList[0].totalmonthwisecommitment?[0]?.monthyearvalue??""}',
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Divider(
                height: 1, thickness: 2, color: Colors.grey,
              ),
              SizedBox(height: 5,),

              Text("Month wise Final Booking Commitment",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 5,),
              Container(
                  height: 70,
                  child: bindMonthWiseFinalBookingCommitment(context),),

              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Tooltip(
                      message: "Financial Year Month Wise Final Booking Commitment :",
                      child: Text("Financial Year Month Wise Final Booking Commitment :",
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
                  Text('${dashboard_view_Controller.salesDashboardList[0].totalmonthwisefinalbookingcommitment?[0]?.monthyearvalue??""}',
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

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
              dashboard_view_Controller.monthWiseCommitmentList[pos]?.monthname??"",
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${dashboard_view_Controller.monthWiseCommitmentList[pos]?.monthyearvalue??""}',
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
              dashboard_view_Controller.monthWiseCollectionCommitmentList[pos]?.monthname??"",
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Commitment: ${dashboard_view_Controller.monthWiseCollectionCommitmentList[pos]?.monthyearcollectioncommitmentvalue??""}',
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Actual: ${dashboard_view_Controller.monthWiseCollectionCommitmentList[pos]?.monthyearactualcollectionvalue??""}',
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

  Widget bindMonthWiseFinalBookingCommitment(BuildContext context){
    ScrollController scrollController = ScrollController();
    if(dashboard_view_Controller.monthWiseFinalBookingList.isNotEmpty){
      return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dashboard_view_Controller.monthWiseFinalBookingList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return monthWiseFinalBookingCommitment(context, index);
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
              dashboard_view_Controller.monthWiseAoVsBookingList[pos]?.monthname??"",
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${dashboard_view_Controller.monthWiseAoVsBookingList[pos]?.monthyearbookingaovalue??""}/ \n ${dashboard_view_Controller.monthWiseAoVsBookingList[pos]?.monthyearactualbookingvalue??""}' ,
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
  Widget monthWiseFinalBookingCommitment(BuildContext context, int pos){
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
              dashboard_view_Controller.monthWiseFinalBookingList[pos]?.monthname??"",
              style: GoogleFonts.poppins(
                color: AllColors.blackColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${dashboard_view_Controller.monthWiseFinalBookingList[pos]?.monthyearvalue??""}}' ,
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
              ListItemBind("Collection Commitment Previous Month:",dashboard_view_Controller.salesDashboardList[0].prevmonthcollectioncommitment ),
              SizedBox(height: 3,),
              ListItemBind("Actual Collection Previous Month :",dashboard_view_Controller.salesDashboardList[0].prevmonthcollectionactual ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach.(%) :",dashboard_view_Controller.salesDashboardList[0].prevmonthcollectionplanachiveper ),
              SizedBox(height: 3,),
              ListItemBind("Collection Commitment Current Month :",dashboard_view_Controller.salesDashboardList[0].currentmonthcollectioncommitment ),
              SizedBox(height: 3,),
              ListItemBind("Actual Collection This Month  :",dashboard_view_Controller.salesDashboardList[0].currentmonthcollectionactual ),
              SizedBox(height: 3,),
              ListItemBind("Collection Plan Vs Ach.Current Month (%) :",dashboard_view_Controller.salesDashboardList[0].currentmonthcollectionplanachiveper ),
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

              ListItemBind("Collection Plan Vs Ach. Financial Year (%) :","${dashboard_view_Controller.salesDashboardList[0].financialyearcollectioncommitmentvsactualcollectionachive?[0]?.financialyearactualcollectionvalue}/ "
                  "${dashboard_view_Controller.salesDashboardList[0].financialyearcollectioncommitmentvsactualcollectionachive?[0]?.financialyearcollectioncommitmentvalue}="
                  "${dashboard_view_Controller.salesDashboardList[0].financialyearcollectioncommitmentvsactualcollectionachive?[0]?.financialyearcollectionvalueper}"),
              SizedBox(height: 3,),
              ListItemBind("Total Bank Guarantee :",dashboard_view_Controller.salesDashboardList[0].totalbankgrantee ),
              SizedBox(height: 3,),
              ListItemBind("Total EMSD :",dashboard_view_Controller.salesDashboardList[0].totalemsd ),
              SizedBox(height: 3,),
              ListItemBind("Due Bank Guarantee :",dashboard_view_Controller.salesDashboardList[0].totalduebankgrantee ),
              SizedBox(height: 3,),
              ListItemBind("Due Date EMSD :",dashboard_view_Controller.salesDashboardList[0].totaldueemsd ),
              SizedBox(height: 3,),
              ListItemBind("Outstanding Financial Year :",dashboard_view_Controller.salesDashboardList[0].totaloutstanding ),
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
              ListItemBind("366-Above :",dashboard_view_Controller.salesDashboardList[0].a366above ),
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
                            dashboard_view_Controller.salesDashboardData();
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
                            dashboard_view_Controller.salesDashboardData();
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
            SizedBox(height: 10),
            bindClusterNameFilter(context),
            SizedBox(height: 10),
            bindRegionNameFilter(context),
            SizedBox(height: 10),
            bindDepartmnetIdFilter(context),
            SizedBox(height: 10),
            bindEmployeeNameFilter(context),
          ]
      ),
    );
  }

  Widget bindDepartmnetIdFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
    return Obx(() {
      if (dashboard_view_Controller.DepartmentNameFilter_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.DepartmentNameFilter_controller.value.text.split(',');

        dashboard_view_Controller.SelectDepartment_List.value =
            List.generate(nameList.length, (index) {
              return DepartmnetModal(
                departmentId: nameList[index].trim(),
              );
            });
      }
      final selected = dashboard_view_Controller.SelectDepartment_List;
      final selectedText = selected.isEmpty ? null : selected.map((e) => e.departmentId).join(', ');

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
              final tempSelected = <DepartmnetModal>[];
              tempSelected.addAll(dashboard_view_Controller.SelectDepartment_List);

              List<DepartmnetModal> allItems = dashboard_view_Controller.Department_List;
              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? allItems : allItems.where((c) =>
                    (c.departmentId ?? "").toLowerCase().contains(query)).toList();

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
                                  'Select Department',
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
                              ? const Center(child: Text('No record found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.departmentId ?? "") ==
                                  (item.departmentId ?? ""));
                              return CheckboxListTile(
                                title: Text(item.departmentId ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) =>
                                      (s.departmentId ?? "") ==
                                          (item.departmentId ?? ""));
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
                                    dashboard_view_Controller.SelectDepartment_List.assignAll(tempSelected);
                                    dashboard_view_Controller.DepartmentNameFilter_controller.value.text =
                                        tempSelected.map((e) => e.departmentId).join(', ');

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
                ?"Department Name":"", // 👈 Label restored here
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
                  "Department Name",
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

  Widget bindEmployeeNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
    return Obx(() {
      if (dashboard_view_Controller.EmployeeNameFilter_controller.value.text.isNotEmpty && dashboard_view_Controller.filterDataChecker.value=='1') {
        List<String> nameList = dashboard_view_Controller.EmployeeNameFilter_controller.value.text.split(',');

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
                                  'Select Employee',
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
                                    dashboard_view_Controller.EmployeeNameFilter_controller.value.text = tempSelected.map((e) => e.fullName).join(', ');

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
                ?"Employee Name":"", // 👈 Label restored here
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
                  "Employee Name",
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



}