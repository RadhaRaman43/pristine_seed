

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/sale_cycle_modal/sales_cycle_quote_information_modal.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class SalesCycleProductList extends StatelessWidget{
  final saleCycleController = Get.put(SalesCycleVm());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
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
                  'Sales Cycle Products',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),

                Obx((){
                 return Visibility(
                   visible: saleCycleController.salesCycleProductCheckedList.contains(true),
                   child: ActionChip(
                      label: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                          color: AllColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {

                        List<QuoteItems> selectedJsonList = saleCycleController.getSelectedQSalesCycleProductAsJson();
                        if(selectedJsonList.length>0){
                          saleCycleController.getSalesProductLineCompetitorFromCompeMappCreate(
                              saleCycleController.saleCycleList[0].salesCycleId!,
                              saleCycleController.saleCycleList[0].quoteAccepted!,
                              selectedJsonList);
                          //saleCycleController.getSalesAdviceCreate(selectedJsonList,saleCycleController.quoteHeaderdata[0].quoteId??"");
                        }
                      },
                      backgroundColor: AllColors.primaryDark1,
                      shape: StadiumBorder(
                        side: BorderSide.none,
                      ),
                    ),
                 );
                })


              ],
            )
        ),
        drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:saleCycleController.loading.value ,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),

              Obx((){
                bool allSelected = saleCycleController.salesCycleProductCheckedList
                  .every((element) => element == true);
                return Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 10),
                  child: ActionChip(
                    label: Text(
                      allSelected ? "Unselect All" : "Select All",
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      saleCycleController.selectAllSalesCycleProducts(!allSelected);
                    },
                    backgroundColor: AllColors.primaryDark1,
                    shape: StadiumBorder(
                      side: BorderSide.none,
                    ),
                  ),
                );
              }),


              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  child: Obx(() {
                    return bindQuoteItemList(context);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }




  Widget bindQuoteItemList(BuildContext context) {
    if (saleCycleController.quoteLinedata.value.isNotEmpty &&
        saleCycleController.quoteLinedata.value.length > 0) {
      return  ListView.separated(
              padding: EdgeInsets.only(bottom: 50),
              separatorBuilder: (context, index) => Divider(
                height: .05,
                color: Colors.transparent,
              ),
              shrinkWrap: true,
              itemCount: saleCycleController.quoteLinedata.value.length,
              itemBuilder: (BuildContext context, int index) {
                return bindPendingListView(context, index);
              });
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
    return InkWell(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Item Code: ",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    width: size.width * .5,
                    child: Tooltip(
                      message:
                      "${saleCycleController.quoteLinedata[index].itemCode}",
                      child: Text(
                        "${saleCycleController.quoteLinedata[index].itemCode}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Item Name: ",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.twelve,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    //width: size.width * .5,
                    child: Tooltip(
                      message:
                      saleCycleController.quoteLinedata[index].itemName ?? "",
                      child: Text(saleCycleController.quoteLinedata[index].itemName ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.twelve,
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
                                        .quoteLinedata[index].itemDescription ??
                                        "",
                                    child: Text(
                                      (saleCycleController.quoteLinedata[index]
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
                                        .quoteLinedata[index].categoryName ??
                                        "",
                                    child: Text(
                                      (saleCycleController
                                          .quoteLinedata[index].categoryName ??
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
                                  saleCycleController.quoteLinedata[index].qty
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
                                Container(
                                  width: size.width*0.12,
                                  child: Tooltip(
                                    message:  saleCycleController
                                        .quoteLinedata[index].quoteLinePrice
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .quoteLinedata[index].quoteLinePrice
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
                            Obx(() {
                              return Visibility(
                                visible: saleCycleController.showBranchHead.value ||
                                    saleCycleController.showClusterHead.value|| saleCycleController.isAdminWritePermission=="1",
                                child: Row(
                                  children: [
                                    Text(
                                      "MAP:",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * .12,
                                      child: Tooltip(
                                        message: saleCycleController
                                            .quoteLinedata[index]
                                            .minimalAcceptablePrice
                                            .toString(),
                                        child: Text(
                                          saleCycleController.quoteLinedata[index]
                                              .minimalAcceptablePrice
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: AllColors.textColor,
                                            fontSize: AllFontSize.twelve,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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
                                  saleCycleController.quoteLinedata[index].sgstAmt
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Obx((){
                              return Visibility(
                                visible: saleCycleController.showBranchHead.value ||
                                    saleCycleController.showClusterHead.value,
                                child: Row(
                                  children: [
                                    Text(
                                      "BTP : ",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * .1,
                                      child: Tooltip(
                                        message: saleCycleController
                                            .quoteLinedata[index].branchTransferPrice
                                            .toString(),
                                        child: Text(
                                          saleCycleController
                                              .quoteLinedata[index].branchTransferPrice
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: AllColors.textColor,
                                            fontSize: AllFontSize.twelve,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),);
                            }),

                            Obx(() {
                              return Visibility(
                                visible:
                                saleCycleController.showGeneralManager.value,
                                child: Row(
                                  children: [
                                    Text(
                                      "MAP:",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * .12,
                                      child: Tooltip(
                                        message: saleCycleController
                                            .quoteLinedata[index]
                                            .minimalAcceptablePrice
                                            .toString(),
                                        child: Text(
                                          saleCycleController.quoteLinedata[index]
                                              .minimalAcceptablePrice
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: AllColors.textColor,
                                            fontSize: AllFontSize.twelve,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            Obx(() {
                              return Visibility(
                                visible: saleCycleController.showBranchHead.value ||
                                    saleCycleController.showClusterHead.value|| saleCycleController.isAdminWritePermission=="1",
                                child: Row(
                                  children: [
                                    Text(
                                      "Bm % : ",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      saleCycleController
                                          .quoteLinedata[index].bmDiscountPer
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            Obx(() {
                              return Visibility(
                                visible:
                                saleCycleController.showGeneralManager.value || saleCycleController.isAdminWritePermission=="1",
                                child: Row(
                                  children: [
                                    Text(
                                      "Standard Cost : ",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * .12,
                                      child: Tooltip(
                                        message: saleCycleController
                                            .quoteLinedata[index].standardCost
                                            .toString(),
                                        child: Text(
                                          saleCycleController
                                              .quoteLinedata[index].standardCost
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: AllColors.textColor,
                                            fontSize: AllFontSize.twelve,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

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
                                      .quoteLinedata[index].discountPer
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
                                        .quoteLinedata[index].approvedDiscountPer
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .quoteLinedata[index].approvedDiscountPer
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
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                        width: size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Text(
                                  "Appr. Amt per Unit : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  child: Tooltip(
                                    message:  saleCycleController
                                        .quoteLinedata[index].approvedAmountPerUnit
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .quoteLinedata[index].approvedAmountPerUnit
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
                            Obx(() {
                              return Visibility(
                                visible:
                                saleCycleController.showGeneralManager.value || saleCycleController.isAdminWritePermission=="1",
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Gm % : ",
                                          style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.twelve,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          saleCycleController
                                              .quoteLinedata[index].gmDiscountPer
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
                                          "Gm Absolute Amt:",
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
                                                .quoteLinedata[index]
                                                .gmDiscountAmount
                                                .toString(),
                                            child: Text(
                                              saleCycleController
                                                  .quoteLinedata[index]
                                                  .gmDiscountAmount
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
                                          "Gm Total Abs Amt:",
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
                                                .quoteLinedata[index]
                                                .gmTotalDiscountAmount
                                                .toString(),
                                            child: Text(
                                              saleCycleController
                                                  .quoteLinedata[index]
                                                  .gmTotalDiscountAmount
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
                              );
                            }),
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
                                      .quoteLinedata[index].salesCredit
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
                                        .quoteLinedata[index]
                                        .approvedAmount ==
                                        null
                                        ? "0"
                                        : saleCycleController
                                        .quoteLinedata[index].approvedAmount
                                        .toString(),
                                    child: Text(
                                      saleCycleController.quoteLinedata[index]
                                          .approvedAmount ==
                                          null
                                          ? ""
                                          : saleCycleController
                                          .quoteLinedata[index].approvedAmount
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
                                  saleCycleController.quoteLinedata[index].sgstPer
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
                                  saleCycleController.quoteLinedata[index].gstAmount
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
                                      .quoteLinedata[index].totalPrice
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
                                      .quoteLinedata[index].isSprRequired
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
          leading: Obx((){
            return Checkbox(
              value:saleCycleController.salesCycleProductCheckedList[index],
              onChanged: (bool? value)  {
                saleCycleController.toggleCheckboxOfSalesCycleProducts(index);
              },
            );
          })
        ),
      ),
    );
  }
}