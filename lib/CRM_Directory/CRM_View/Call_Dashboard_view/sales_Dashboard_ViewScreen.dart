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
               // showFilterBottomSheet(context);
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
                                            ? Icons.arrow_drop_down
                                            : Icons.arrow_drop_up,
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
                                            ? Icons.arrow_drop_down
                                            : Icons.arrow_drop_up,
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
    return   Visibility(
      visible: dashboard_view_Controller.isExpandCrtd.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Existing Accounts : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  dashboard_view_Controller
                      .salesDashboardList[0]
                      .existingAccount.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "New Account Created :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  dashboard_view_Controller
                          .salesDashboardList[0]
                          .newAccount.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "Total Accounts :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  dashboard_view_Controller
                      .salesDashboardList[0]
                      .totalAccount.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text("Acc. Covered in C/M :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(

                      dashboard_view_Controller
                          .salesDashboardList[0]
                          .accountCoveredCurrentMonth.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text("Acc. Covered in P/M :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(

                  dashboard_view_Controller
                      .salesDashboardList[0]
                      .accountCoveredPreviousMonth.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),Row(
              children: [
                Text("Fresh Acc. Covered in C/M :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  dashboard_view_Controller
                      .salesDashboardList[0]
                      .freshAccountCoveredCurrentMonth.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),Row(
              children: [
                Text("Total Acc. Covered :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(

                  dashboard_view_Controller
                      .salesDashboardList[0]
                      .totalAccountCovered.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),Row(
              children: [
                Text("Working Days :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  dashboard_view_Controller
                      .salesDashboardList[0]
                      .workingDays.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),

          ],
        ),
      ),
    );
  }


}