
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';

class SalesAdviseHeaderLineScreen extends StatelessWidget{
  var saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sale Advise(${saleCycleController.quoteHeaderdata[0].quoteId.toString()})',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),

          ),
          drawer: CustomDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Visibility(
                  visible: saleCycleController.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              Expanded(
                child: Container(
                  child: ListView(children: [

                    Obx(() {
                      return BindSalesAdviseHeaderData(context);
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sale Advise Line Details",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.eighteen,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ActionChip(
                            label: Text(
                              "Complete",
                              style: GoogleFonts.poppins(
                                color: AllColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {

                            },
                            backgroundColor: AllColors.primaryDark1,
                            shape: StadiumBorder(
                              side: BorderSide.none,
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: AllColors.bluegrayColor,
                    ),
                    Center(
                      child: Divider(
                        height: 1,
                        color: AllColors.lightgreyColor,
                      ),
                    ),

                    /*Obx(() {
                      return bindQuoteItemList(context);
                    }),*/
                    Center(
                        child: Divider(
                          height: 1,
                          color: AllColors.primaryDark1,
                        )),
                  ]),
                ),
              ),
            ],
          )),
    );
  }


  Widget BindSalesAdviseHeaderData(BuildContext context) {
    String? dateTimeCreatedOn = StaticMethod.dateTimeToDate(
        saleCycleController.salesAdviseHeaderLineList[0].createdOn ?? "");
    String? dateTimeApprovedOn = StaticMethod.dateTimeToDate(
        saleCycleController.salesAdviseHeaderLineList[0].approvedOn ?? "");
    String? expectedclosuredate = StaticMethod.convertDateFormat1(
        saleCycleController.salesAdviseHeaderLineList[0].expClosureDate ?? "");
    String? quoteValidityDate = StaticMethod.convertDateFormat1(
        saleCycleController.salesAdviseHeaderLineList[0].quoteValidity ?? "");
    String? regretOn = StaticMethod.dateTimeToDate(
        saleCycleController.salesAdviseHeaderLineList[0].regretOn ?? "");
    String saleCycleQuoteStatus =
        saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase() ?? "";
    Color getStatusColor(String status) {
      switch (status) {
        case "draft":
          return Colors.red[900]!;
        case 'regret':
          return Colors.red;
        case 'rejected':
          return Colors.red;
        case 'approved':
          return Colors.green;
        case 'won':
          return Colors.green;
        case 'pending for approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColors.grayColor, // Set the border color here
                width: 1.0, // Adjust the border width if necessary
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Sales Advise Header',
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sales Cycle Id",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.salesAdviseHeaderLineList[0].salesCycleId ??
                            "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact Name',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        saleCycleController.salesAdviseHeaderLineList[0].contactName ??
                            "",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Category",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .4,
                        child: Tooltip(
                          message: saleCycleController
                              .salesAdviseHeaderLineList[0].productCategory ??
                              "",
                          child: Text(
                            saleCycleController
                                .salesAdviseHeaderLineList[0].productCategory!,
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quote Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].salesAdviceStatus ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].salesAdviceStatus ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: getStatusColor(saleCycleQuoteStatus),
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expected Closure Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        expectedclosuredate.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quote Validity",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .3,
                        child: Tooltip(
                          message: quoteValidityDate.toString(),
                          child: Text(
                            quoteValidityDate.toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quote Commit",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteCommit
                                .toString() ==
                                '1'
                                ? 'Yes'
                                : 'No',
                            child: Text(
                              saleCycleController.salesAdviseHeaderLineList[0].quoteCommit
                                  .toString() ==
                                  '1'
                                  ? 'Yes'
                                  : 'No',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quote Total Amt.",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteTotalAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].quoteTotalAmount
                                  .toString() ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quote GST Amt.",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteGstAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].quoteGstAmount
                                  .toString() ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quote Gross Amt.",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteGrossAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].quoteGrossAmount
                                  .toString() ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Created By",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * .4,
                        child: Tooltip(
                          message: saleCycleController
                              .salesAdviseHeaderLineList[0].createdFullName ??
                              "",
                          child: Text(
                            saleCycleController
                                .salesAdviseHeaderLineList[0].createdFullName ??
                                "",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Created on",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        dateTimeCreatedOn.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}