/*


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../view/custom_drawer.dart';

class QuoteApproveRejectScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title:Row(
              children: [
                Text(
                  "Quote Approval/Reject List",
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  //showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh:refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:salesCyclePendingForApprovalController.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Obx(() {
                      return bindSalesCycleProductData(context);
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),);
  }

  Widget bindSalesCycleProductData(BuildContext context) {
    if (saleCycleController.get_SalesCycleProductById_List.value.isNotEmpty &&
        saleCycleController.get_SalesCycleProductById_List.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          int total_page = (saleCycleController.total_rows_sale_cyle_item /
              saleCycleController.rowsPerPage)
              .toInt();
          if ((saleCycleController.total_rows_sale_cyle_item %
              saleCycleController.rowsPerPage) >
              0) total_page += 1;

          //print(
          //"last index ${saleCycleController.pageNumberForQuote} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
          if (saleCycleController.pageNumber + 1 < total_page) {
            saleCycleController.getSaleCycleProductByIdList(
              saleCycleController.pageNumber + 1,
              saleCycleController.salesCycleId.value,
            );
            saleCycleController.pageNumber += 1;
          }
        }
      });
      return Obx(
            () {
          return Container(
            height: size.height / 2,
            child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.only(bottom: 50),
                separatorBuilder: (context, index) => Divider(
                  height: .05,
                  color: Colors.transparent,
                ),
                shrinkWrap: true,
                itemCount: saleCycleController
                    .get_SalesCycleProductById_List.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return bindSaleCycleProductListView(context, index, flag);
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

  Widget bindSaleCycleProductListView(
      BuildContext context, int index, String flag) {
    String? dateCreatedOn = StaticMethod.convertDateFormat1(
        saleCycleController.get_SalesCycleProductById_List[index].createdOn ??
            "");
    return Card(
      child: ListTile(
        */
/*onTap: () {
          if (flag == "Update") {
            saleCycleController.updateCompetitorNameProductController.value
                .text =
                saleCycleController.get_SalesCycleProductById_List[index]
                    .competitorName ?? "";
            saleCycleController.updateCompetitorPriceProductController.value
                .text =
                (saleCycleController.get_SalesCycleProductById_List[index]
                    .competitorPrice ?? 0).toString();
            saleCycleController.updateLossReasonProductController.value.text =
                saleCycleController.get_SalesCycleProductById_List[index]
                    .lossReason ?? "";
            showDialogSalesCycleProductModify(context, index);
          }
        },*//*

        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Item Code:  ${saleCycleController.get_SalesCycleProductById_List[index].itemCode ?? ""}",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
            Spacer(),

            Visibility(
              visible: flag == "Update" &&
                  saleCycleController.saleCycleList[0].salesCycleStatus
                      ?.toLowerCase() !=
                      "suspect" &&   saleCycleController.saleCycleList[0].quoteAccepted
                  ?.toLowerCase() == "open" &&  saleCycleController
                  .saleCycleList[0].actualSalesCycleApprovalStatus
                  ?.toLowerCase() !=
                  "rejected" ,
              child: GestureDetector(
                onTap: () {
                  saleCycleController.updateCompetitorNameProductController
                      .value.text = saleCycleController
                      .get_SalesCycleProductById_List[index]
                      .competitorName ??
                      "";
                  saleCycleController.updateCompetitorPriceProductController
                      .value.text = (saleCycleController
                      .get_SalesCycleProductById_List[index]
                      .competitorPrice ??
                      0)
                      .toString();
                  saleCycleController.updateLossReasonProductController.value
                      .text = saleCycleController
                      .get_SalesCycleProductById_List[index].lossReason ??
                      "";
                  showDialogSalesCycleProductModify(context, index);
                },
                child: Icon(
                  Icons.update_outlined,
                  color: AllColors.textColor,
                ),
              ),
            ),
            Visibility(
                visible: !(saleCycleController.FromPage.value ==
                    "FromDashboard") &&
                    flag == "Add" &&
                    saleCycleController
                        .saleCycleList[0].actualSalesCycleApprovalStatus
                        ?.toLowerCase() !=
                        "rejected" && saleCycleController
                    .saleCycleList[0].quoteAccepted
                    ?.toLowerCase() ==
                    "open" && saleCycleController
                    .saleCycleList[0].createdBy?.toLowerCase() ==
                    saleCycleController.email.toLowerCase(),
                child: GestureDetector(
                  onTap: () {
                    showSalesProductConfirmationDialog(
                      context,
                      saleCycleController
                          .get_SalesCycleProductById_List[index].salesCycleId
                          .toString(),
                      saleCycleController
                          .get_SalesCycleProductById_List[index].lineNo!,
                    );
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: AllColors.redColor,
                  ),
                ))

            */
/* Text(
              saleCycleController
                  .get_SalesCycleProductById_List[index]
                  .itemCode ?? "",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),*//*

          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item Description : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  child: Tooltip(
                    message: saleCycleController
                        .get_SalesCycleProductById_List[index]
                        .itemDescription ??
                        "",
                    child: Text(
                      saleCycleController
                          .get_SalesCycleProductById_List[index]
                          .itemDescription ??
                          "",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category  : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.get_SalesCycleProductById_List[index]
                      .categoryName ??
                      "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Qty : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IgnorePointer(
                  ignoring: flag == "Update" ||
                      saleCycleController
                          .saleCycleList[0].actualSalesCycleApprovalStatus
                          ?.toLowerCase() ==
                          "rejected" || saleCycleController
                      .saleCycleList[0].actualSalesCycleApprovalStatus
                      ?.toLowerCase() !=
                      "open",
                  child: InkWell(
                    onTap: () {
                      saleCycleController.qtyUpdateLineController.value.text =
                      saleCycleController
                          .get_SalesCycleProductById_List[index]
                          .qty ==
                          null
                          ? "0"
                          : saleCycleController
                          .get_SalesCycleProductById_List[index].qty
                          .toString();
                      updateQtySalesCycleProduct(context, index);
                    },
                    child: Text(
                      saleCycleController
                          .get_SalesCycleProductById_List[index].qty
                          .toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                        decoration: flag == "Update" ||
                            saleCycleController.saleCycleList[0]
                                .actualSalesCycleApprovalStatus
                                ?.toLowerCase() ==
                                "rejected" || saleCycleController
                            .saleCycleList[0].actualSalesCycleApprovalStatus
                            ?.toLowerCase() !=
                            "open"
                            ? TextDecoration.none
                            : TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            */
/* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Unit Price : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index]
                      .unitPrice.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),*//*


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Unit Price : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index].mrpPrice
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index].totalPrice
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Line Status : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index].lineStatus ??
                      "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
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
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index].createdBy
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Created On : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  dateCreatedOn.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Competitor Name : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      //width: size.width * 0.4,
                      child: Tooltip(
                        message: saleCycleController
                            .get_SalesCycleProductById_List[index]
                            .competitorName ??
                            "",
                        child: Text(
                          saleCycleController
                              .get_SalesCycleProductById_List[index]
                              .competitorName ??
                              "",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Competitor Price : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      saleCycleController
                          .get_SalesCycleProductById_List[index]
                          .competitorPrice ==
                          null
                          ? ""
                          : saleCycleController
                          .get_SalesCycleProductById_List[index]
                          .competitorPrice
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Loss Reason : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      //width: size.width * 0.5,
                      child: Tooltip(
                        message: saleCycleController
                            .get_SalesCycleProductById_List[index]
                            .lossReason ??
                            "",
                        child: Text(
                          saleCycleController
                              .get_SalesCycleProductById_List[index]
                              .lossReason ??
                              "",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Loss On : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      //width: size.width * 0.5,
                      child: Tooltip(
                        message: saleCycleController
                            .get_SalesCycleProductById_List[index]
                            .lossOn ??
                            "",
                        child: Text(
                          saleCycleController
                              .get_SalesCycleProductById_List[index]
                              .lossOn ??
                              "",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Loss By : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      // width: size.width * 0.5,
                      child: Tooltip(
                        message: saleCycleController
                            .get_SalesCycleProductById_List[index]
                            .lossBy ??
                            "",
                        child: Text(
                          saleCycleController
                              .get_SalesCycleProductById_List[index]
                              .lossBy ??
                              "",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),

        */
/* trailing: Visibility(
          visible: !(saleCycleController.FromPage.value=="FromDashboard") && flag == "Add" && saleCycleController.saleCycleList[0].actualSalesCycleApprovalStatus?.toLowerCase()!="rejected" ,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {
                    showSalesProductConfirmationDialog(
                      context, saleCycleController
                        .get_SalesCycleProductById_List[index]
                        .salesCycleId.toString(), saleCycleController
                        .get_SalesCycleProductById_List[index]
                        .lineNo!,);
                  },
                  child: Icon(Icons.delete_forever, color: Colors.red,)),
            ],
          ),
        ),*//*

      ),
    );
  }
}*/
