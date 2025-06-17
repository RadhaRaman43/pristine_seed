
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sales_advise_modal/sales_advise_header_line_modal.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';

import '../../../component/default_button.dart';
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
        saleCycleController.pageNumberSalesAdvise=0;
        saleCycleController.getSalesAdviseData(saleCycleController.pageNumberSalesAdvise,
          saleCycleController.quoteHeaderdata[0].salesCycleId??"", saleCycleController.quoteHeaderdata[0].quoteId??"","" );
        Get.toNamed(RoutesName.salesAdviseHeaderScreen);
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
                  'Sales Advise(${saleCycleController.salesAdviseHeaderLineList[0].salesAdviceId.toString()})',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),

                Obx((){
                  return  Visibility(
                    visible: saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft",
                    child: GestureDetector(
                        onTap: (){
                          saleCycleController.bindSalesAdviseAddress(saleCycleController.salesAdviseHeaderLineList[0]);
                          showDialogForAddressUpdate(context);
                        },
                        child: Tooltip(
                            message: "Update Sales Advise Header",
                            child: Icon(Icons.update_sharp))),
                  );
                })




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
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sales Advise Line Details",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.eighteen,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Visibility(
                            visible: saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft",
                            child: ActionChip(
                                label: Text(
                                  "Complete",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  showDialogForComplete(context);
                                },
                                backgroundColor: AllColors.primaryDark1,
                                shape: StadiumBorder(
                                  side: BorderSide.none,
                                ),
                              ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: AllColors.bluegrayColor,
                    ),

                    Obx(() {
                      return bindSalesAdvisItemList(context);
                    }),
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
        case 'completed':
          return Colors.green;
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
                        "Sales Quote Id",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.salesAdviseHeaderLineList[0].quoteId ??
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
                        "Sales Advise Status",
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

  Widget bindSalesAdvisItemList(BuildContext context) {
    if (saleCycleController.salesAdviseLinesDataList.value.isNotEmpty &&
        saleCycleController.salesAdviseLinesDataList.value.length > 0) {
      return Obx(
            () {
          return Container(
            height: size.height / 2,
            child: ListView.separated(
                padding: EdgeInsets.only(bottom: 50),
                separatorBuilder: (context, index) => Divider(
                  height: .05,
                  color: Colors.transparent,
                ),
                shrinkWrap: true,
                itemCount: saleCycleController.salesAdviseLinesDataList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return bindPendingListView(context, index);
                }),
          );
        },
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'No Record Found.',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }


  Widget bindPendingListView(BuildContext context, int index) {
    int srNo = index + 1;
    return InkWell(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Name: ",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Flexible(
               // width: size.width * .4,
                child: Tooltip(
                  message:
                  "${saleCycleController.salesAdviseLinesDataList[index].itemName ?? ""}(${saleCycleController.salesAdviseLinesDataList[index].itemCode})",
                  child: Text(
                    "${saleCycleController.salesAdviseLinesDataList[index].itemName ?? ""}(${saleCycleController.salesAdviseLinesDataList[index].itemCode})",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft",
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      showDialogForDelete(context, index);
                    },
                        icon: Icon(Icons.delete, color: AllColors.redColor, size: 30,)),


                    IconButton(onPressed: (){
                      saleCycleController.qtyUpdateLineController.value.text=saleCycleController.salesAdviseLinesDataList[index].qty.toString();
                      updateQtySalesCycleProduct(context, saleCycleController.salesAdviseLinesDataList[index]);
                    }, icon: Icon(Icons.update_outlined, size: 30, color: AllColors.textColor,)),
                  ],
                ),
              )
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                        width: size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Item Desc: ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: size.width * .2,
                                  child: Tooltip(
                                    message: saleCycleController
                                        .salesAdviseLinesDataList[index].itemDescription ??
                                        "",
                                    child: Text(
                                      (saleCycleController.salesAdviseLinesDataList[index]
                                          .itemDescription ??
                                          ""),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Category: ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  // width: size.width * .16,
                                  child: Tooltip(
                                    message: saleCycleController
                                        .salesAdviseLinesDataList[index].categoryName ??
                                        "",
                                    child: Text(
                                      (saleCycleController
                                          .salesAdviseLinesDataList[index].categoryName ??
                                          ""),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Qty : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController.salesAdviseLinesDataList[index].qty
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Price Per Unit : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController
                                      .salesAdviseLinesDataList[index].quoteLinePrice
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "LSP :",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController.salesAdviseLinesDataList[index].sgstAmt
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  "Seeking % : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController
                                      .salesAdviseLinesDataList[index].discountPer
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Approved Dis. %:",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Tooltip(
                                    message: saleCycleController
                                        .salesAdviseLinesDataList[index].approvedDiscountPer
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .salesAdviseLinesDataList[index].approvedDiscountPer
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(
                        width: size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Text(
                                  "Approved Price :",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Tooltip(
                                    message: saleCycleController
                                        .salesAdviseLinesDataList[index]
                                        .approvedAmount ==
                                        null
                                        ? "0"
                                        : saleCycleController
                                        .salesAdviseLinesDataList[index].approvedAmount
                                        .toString(),
                                    child: Text(
                                      saleCycleController.salesAdviseLinesDataList[index]
                                          .approvedAmount ==
                                          null
                                          ? ""
                                          : saleCycleController
                                          .salesAdviseLinesDataList[index].approvedAmount
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Sales Credit % : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController
                                      .salesAdviseLinesDataList[index].salesCredit
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),


                            Row(
                              children: [
                                Text(
                                  "App. Amt. per Unit : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  child: Tooltip(
                                    message:  saleCycleController
                                        .salesAdviseLinesDataList[index].totalPrice
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .salesAdviseLinesDataList[index].totalPrice
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "GST % :",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController.salesAdviseLinesDataList[index].sgstPer
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "GST Amt.:",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController.salesAdviseLinesDataList[index].gstAmount
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total Amt.: ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController
                                      .salesAdviseLinesDataList[index].totalPrice
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "SPR Required : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  saleCycleController
                                      .salesAdviseLinesDataList[index].isSprRequired
                                      .toString() ==
                                      "1"
                                      ? "Yes"
                                      : "No",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }





  void updateQtySalesCycleProduct(BuildContext context, QuoteItems salesAdviseLinesDataList,  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Qty (${salesAdviseLinesDataList.itemCode})',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller:
                      saleCycleController.qtyUpdateLineController.value,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter Qty",
                          labelText: "Enter Qty",
                          //suffixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AllFontSize.ten,
                              horizontal: AllFontSize.ten),

                          /* focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue)
                           ),*/
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.getSalesAdviseLineUpdate(salesAdviseLinesDataList);
                          Get.back();
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Save' /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.qtyUpdateLineController.value
                              .clear();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
  Future showDialogForDelete(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Delete",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                /*height: size.height*.21,
                  width: size.width*4,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Do you want to delete this Sales Advise Line?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),
                      SizedBox(height: 10),
                      Container(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.lightredColor,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Container(
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.greenblue,
                                  ),
                                ),
                                onPressed: () {
                                  saleCycleController.getSalesAdviseLineDelete(saleCycleController.salesAdviseLinesDataList[index]);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Text(
                                    'Confirm',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  Future showDialogForComplete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Complete",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Do you want to Complete this Sales Advise Line?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),
                      SizedBox(height: 10),
                      Container(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.lightredColor,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Container(
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.greenblue,
                                  ),
                                ),
                                onPressed: () {
                                  saleCycleController.getSalesAdviseHeaderComplete(saleCycleController.salesAdviseLinesDataList[0].salesAdviceId??"");
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  Future showDialogForAddressUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address Update",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.close_outlined, size: 25, color: AllColors.primaryDark1,))
                ],
              ),
              content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        bindShippingAddress(context),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.primaryDark1,
                                  ),
                                ),
                                onPressed: () {
                                  saleCycleController.pageNumber = 0;
                                  saleCycleController.getAddressMasterList(
                                      saleCycleController.pageNumber,
                                      saleCycleController.quoteHeaderdata[0].accountCode!);
                                  saleCycleController.showConsigneeAddressList(
                                      context, saleCycleController.address_master_list);
                                },
                                child: Container(
                                  child: Text(
                                    'Change',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.whiteColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.primaryDark1,
                                  ),
                                ),
                                onPressed: () {
                                  saleCycleController.getSalesAdviseHeaderUpdate(saleCycleController.salesAdviseLinesDataList[0].salesAdviceId??"");
                                  Get.back();
                                },
                                child: Container(
                                  child: Text(
                                    'Update',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.whiteColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget bindShippingAddress(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AllColors.grayColor, // Set the border color here
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Shipping Address',
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController.shippingController.value,
                decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "Address",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                readOnly: true,
                controller:
                saleCycleController.shippingAddress2Controller.value,
                decoration: InputDecoration(
                    hintText: "Address 2",
                    labelText: "Address 2",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),

              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                controller:
                saleCycleController.Shipping_PostCode_Controller.value,
                decoration: InputDecoration(
                    hintText: "Pin Code",
                    labelText: "Pin Code",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController.Shipping_City_Controller.value,
                decoration: InputDecoration(
                    hintText: "City",
                    labelText: "City",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller:
                saleCycleController.Shipping_District_Controller.value,
                decoration: InputDecoration(
                    hintText: "District",
                    labelText: "District",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController.Shipping_State_Controller.value,
                decoration: InputDecoration(
                    hintText: "State",
                    labelText: "State",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),

            /* SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_phone_Controller.value,
                decoration: InputDecoration(
                    hintText: "Phone No.",
                    labelText: "Phone No.",
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

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_email_Controller.value,
                decoration: InputDecoration(
                    hintText: "Email Id",
                    labelText: "Email Id",
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
            ),*/
          ],
        ),
      ),
    );
  }
}