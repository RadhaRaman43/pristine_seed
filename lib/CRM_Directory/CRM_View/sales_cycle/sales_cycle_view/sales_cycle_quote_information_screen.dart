import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../../component/back_button.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../utils/app_utils.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../../CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/pending_Draft_Quote_vm.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class QuoteInformationScreen extends StatelessWidget {
  QuoteInformationScreen({super.key});
  final saleCycleController = Get.put(SalesCycleVm());
  final accountMaster_page_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final address_vm_controller = Get.put(Addressmastervm());
  final quoteApprovalController = Get.put(QuoteApprovalListVm());
  final pendingDraftQuoteController=Get.put(PendingDraftQuoteVm("APPROVED & REJECTED"));
  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayStatusForOption(String option) => option;
  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Satus ${saleCycleController.quoteApprovalPage.value}");
        if (saleCycleController.quoteApprovalPage.value == "Quote Approval List") {
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteApprovalListScreen);
        }
        else if (saleCycleController.quoteApprovalPage.value == "Quote RH Approval List") {
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteRHApprovalListScreen);
        }
        else if (saleCycleController.quoteApprovalPage.value == "Quote CBH Approval List") {
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteCBHApprovalListScreen);
        }
        else if (saleCycleController.quoteApprovalPage.value == "Quote GM Approval List") {
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteGMApprovalListScreen);
        }else if (saleCycleController.quoteApprovalPage.value == "pendingDraftQuote") {
          pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
          pendingDraftQuoteController.pageNumberForQuote =0;
          pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "PENDING & PENDING FOR APPROVAL");
          Get.offNamed(RoutesName.pendingDraftQuoteScreen);
        }
        else if (saleCycleController.quoteApprovalPage.value == "approvedRejectedQuote") {
          pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
          pendingDraftQuoteController.pageNumberForQuote =0;
          pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "APPROVED & REJECTED");
          Get.offNamed(RoutesName.approvedRejectedQuoteScreen);
        }else if (saleCycleController.quoteApprovalPage.value == "AllQuoteList") {
          pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
          pendingDraftQuoteController.pageNumberForQuote =0;
          pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "All");
          Get.offNamed(RoutesName.allQuoteScreenScreen);
        }
        else if (saleCycleController.quoteApprovalPage.value == "ALLQuoteLineItems") {
          pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
          pendingDraftQuoteController.pageNumberForQuote =0;
          pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLQuoteLineItems");
          Get.offNamed(RoutesName.allQuoteLineItemScreen);
        }
        else if(saleCycleController.quoteApprovalPage.value=="FromAllSPRMapping"){
          pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
          pendingDraftQuoteController.pageNumberForQuote =0;
          //pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLSPRMAPPING");
          print("FromAllSPRMapping.....");
          Get.offNamed(RoutesName.allSPRMappingScreen);
        }
        else if (saleCycleController.quoteApprovalPage.value == "approvedQuotationScreen") {
          saleCycleController.pageNumberForQuote = 0;
          saleCycleController.getQuoteHeaderData(
              saleCycleController.pageNumberForQuote,
              saleCycleController.salesCycleId.value,
              "Approved");
          Get.toNamed(RoutesName.approvedQuotationListScreen);
        } else if (saleCycleController.quoteApprovalPage.value ==
            "QuoteDashboard") {
          Get.toNamed(RoutesName.AccountDashboardDataQuotation_Screen);
        }
        else {
          saleCycleController.clearAllFieldOfQuoteFilter();
          //saleCycleController.clearAllFieldOfFilter();
          saleCycleController.pageNumber = 0;
          saleCycleController.pageNumberForQuote = 0;
          saleCycleController.filterQuoteAcceptedFlag.value = "";
          saleCycleController.getsalesCycleData(
              saleCycleController.pageNumber,
              saleCycleController.quoteHeaderdata[0].salesCycleId!,
              "",
              saleCycleController.FromPage.value);

          /*saleCycleController.getQuoteHeaderData(
              saleCycleController.pageNumberForQuote,
              saleCycleController.quoteHeaderdata[0].salesCycleId!,
              '');*/
          Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
        }
        // saleCycleController.FromPage="Sales";
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
                      'Quote(${saleCycleController.quoteHeaderdata[0].quoteId.toString()})',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            actions: [
              Obx(() {
                return Visibility(
                  visible: saleCycleController.quoteHeaderdata[0].quoteStatus!.toLowerCase() != 'draft' && saleCycleController.isHeadofficePermission !="1",
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.black,
                              ),
                              Text('Quote Report'),
                            ],
                          ),
                          onTap: () {
                            showDialoGWithWithoudQuoteReport(context);
                            //saleCycleController.reportDownload("quoteReport");
                          },
                        ),
                        /*if (saleCycleController.isHeadofficePermission != 0 &&
                            saleCycleController.quoteHeaderdata[0].isSpr == 1)*/
                        /*if(saleCycleController.isHeadofficePermission != 0 &&
                            saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase()=="approved")*/
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.black,
                                ),
                                Text('Quote Spr Report'),
                              ],
                            ),
                            onTap: () {
                              saleCycleController.reportSprDownload(
                                  "quoteSprReport", saleCycleController.quoteHeaderdata[0].quoteId!);
                            },
                          ),
                      ];
                    },
                  ),
                );
              }),
            ],
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
                    /*visible: saleCycleController.FromPage=="QuoteApprovalPage" ||
                          saleCycleController.quoteApprovalPage.value=="quoteApprovalScreen"?true:false,*/
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx((){
                            return Visibility(
                              visible:  /*((saleCycleController.quoteHeaderdata[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase() ||
                                  saleCycleController.isAdminWritePermission=="1")&&
                                  saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase()=="rejected") || (saleCycleController
                                  .quoteHeaderdata[0].quoteStatus?.toLowerCase()=="approved"   && saleCycleController.isAdminWritePermission=="1")&&
                                  saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase()=="open" */
                              //todo by radha raman
                              saleCycleController.isAdminWritePermission=="1" &&
                            (saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase()=="rejected" ||
                                saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase()=="approved") &&
                                  saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase()=="open"
                              ,
                              child: Tooltip(
                                message: "Reopen",
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: AllColors.primaryDark1)
                                  ),
                                  child:  GestureDetector(
                                    onTap: () {
                                      saleCycleController.reOpenRemarksController.value.text = "";
                                      reOpenSalesCycle(context);
                                      //showDialogForHeaderUpdate(context);
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Icon(Icons.lock_open, size: 20,),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                              color: AllColors.primaryDark1)),
                                    ),
                                  ),

                                ),
                              ),);
                          }),
                          Obx(()
                          {
                            return Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Visibility(
                                visible:saleCycleController
                                    .quoteHeaderdata[0].quoteAccepted?.toLowerCase()=="open" && saleCycleController
                                    .quoteHeaderdata[0].quoteStatus?.toLowerCase()!="rejected" && ((saleCycleController.showApprovalBtn.value )||
                                    (saleCycleController.isAdminWritePermission=="0"&&
                                        saleCycleController.showApprovalBtn.value && saleCycleController
                                        .quoteHeaderdata[0].isReadyForApprove==1) ||
                                    (saleCycleController.isAdminWritePermission=="1" && saleCycleController
                                        .quoteHeaderdata[0].quoteStatus?.toLowerCase()=="pending for approval" && saleCycleController
                                        .quoteHeaderdata[0].isReadyForApprove==1)),

                               /* visible:saleCycleController
                                    .quoteHeaderdata[0].quoteStatus?.toLowerCase()=="pending for approval"
                                && saleCycleController
                                        .quoteHeaderdata[0].isReadyForApprove==1 && saleCycleController
                                    .quoteHeaderdata[0].quoteAccepted?.toLowerCase()=="open" && (saleCycleController.showApprovalBtn.value|| saleCycleController.isAdminWritePermission=="1")
                                    ? true
                                    : false,*/
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ActionChip(
                                        label: Text(
                                          "Approve/Reject",
                                          style: GoogleFonts.poppins(
                                             color: AllColors.whiteColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onPressed: () {
                                          saleCycleController.quoteStatusController.value.clear();
                                          saleCycleController.rejectreasonQuoteController.value.clear();
                                          saleCycleController
                                              .managerRemarksController.value
                                              .clear();
                                          saleCycleController.isReject.value =
                                              false;
                                          saleCycleController.isApprove.value =
                                              false;
                                          showdialogForApproval(context);
                                        },
                                        backgroundColor: AllColors.primaryDark1,
                                        shape: StadiumBorder(
                                          side: BorderSide.none,
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          }),
                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() == "open" &&
                                        saleCycleController.quoteHeaderdata[0].isReadySendForApproval == 1 ? true : false,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: DefaultButton(
                                          press: () {
                                            saleCycleController.BusinessTerm.value = false;
                                            saleCycleController.clearBusinessTerm();
                                            Get.toNamed(RoutesName.UpdateBussinessTermPage);
                                            //openConfirmationDialog(context,   'Do you want to send this Quote for Approval?', "");
                                          },
                                          text: "Send For Approval",
                                        ),
                                        width: size.width * .5,
                                        //margin: EdgeInsets.only(right: 10),
                                      ),
                                    ]),
                              ),
                            );
                          }),

                          //todo mark quotation work is done by nirupma

                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible:(saleCycleController.userType?.toLowerCase()=='bh' ||
                                    saleCycleController.email.toLowerCase()==saleCycleController.quoteHeaderdata[0].createdBy?.toLowerCase())
                                    && saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() == 'approved' &&
                                    saleCycleController.quoteHeaderdata[0].quoteStatusWon?.toLowerCase() == 'open',
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child:  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AllColors.primaryDark1
                                    ),
                                    onPressed: () {
                                      saleCycleController.quotationWonLossController.value.text='WON';
                                      saleCycleController.reasonQuotationVisibilty.value=false;
                                      saleCycleController
                                          .quotationReasonController.value.text="";
                                      showDialogquotationWonLoss(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Mark Quotation Won',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.whiteColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          Obx(() {
                            print("quote accepted ${saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() != "loss"}");
                           return Visibility(
                              visible: saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() != "loss"&&
                                  saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() != "won"&&(
                                  (saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() == "draft" &&
                                      saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() == "open"&&
                                      saleCycleController.quoteHeaderdata[0].isReadySendForApproval == 1)
                                      || saleCycleController.isAdminWritePermission=="1"
                                      || ((saleCycleController.userType.toLowerCase()=="ch"||saleCycleController.userType.toLowerCase()=="bh"||
                                          saleCycleController.userType.toLowerCase()=="gm") &&
                                      saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() == "pending for approval")) ? true : false,
                              child: GestureDetector(
                                onTap: () {
                                  saleCycleController.updateQuoteShippingAddressConfirmation.value.text='No';
                                  saleCycleController.bindAddress();
                                  Get.toNamed(RoutesName.updateQuoteHeaderScreen);
                                  //showDialogForHeaderUpdate(context);
                                },
                                child: Container(
                                  child: Tooltip(
                                    message: 'Update Quote Header',
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Icon(
                                        Icons.update,
                                        color: AllColors.primaryDark1,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: AllColors.primaryDark1)),
                                ),
                              ),
                            );
                          }),
                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: saleCycleController.quoteHeaderdata[0].quoteStatus!.toLowerCase() == 'draft' ? false : true,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RoutesName.approvalPersonList);
                                    saleCycleController.getApprovalPersonList(saleCycleController.quoteHeaderdata[0].quoteId ?? "");
                                    // Get.offAllNamed(RoutesName.approvalPersonList);
                                  },
                                  child: Tooltip(
                                    message: 'View Approver Persons',
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: AllColors.primaryDark1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Icon(Icons.groups,size: 20,),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          Visibility(
                            visible: saleCycleController.isAdminWritePermission=="1",
                            child: ActionChip(
                            label: Text(
                              "Move To Draft",
                              style: GoogleFonts.poppins(
                                color: AllColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              moveToDraftDialog(context);
                            },
                            backgroundColor: AllColors.primaryDark1,
                            shape: StadiumBorder(
                              side: BorderSide.none,
                            ),
                          ),)
                        ],
                      ),
                    ),
                    Obx(() {
                      return BindSalesData(context);
                    }),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quote Item List",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.eighteen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Obx(() {
                              return Visibility(
                                visible: saleCycleController.quoteHeaderdata[0].createdBy?.toLowerCase() ==
                                            saleCycleController.email.toLowerCase() &&
                                        saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() == "draft" &&
                                        saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() == 'open'
                                    ? true : false,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Obx(() {
                                      String ProductCategory = saleCycleController.quoteHeaderdata[0].productCategoryCode ?? "";
                                      String PipeProdCate = ProductCategory.replaceAll(', ', '|');
                                      return GestureDetector(
                                        onTap: () {
                                          saleCycleController.pageNumber = 0;
                                          saleCycleController.itemMstGetByQuoteIdApiHit(0,
                                              saleCycleController.quoteHeaderdata[0].quoteId, "Add", PipeProdCate);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Icon(
                                              Icons.add,
                                              color: AllColors.primaryDark1,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              border: Border.all(
                                                  color:
                                                  AllColors.primaryDark1)),
                                        ),
                                      );
                                    }),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                        child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AllColors.primaryDark),
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        showFetchSalesProductConfirmationDialog(
                                            context,
                                            saleCycleController.quoteHeaderdata[0].salesCycleId ?? "",
                                            saleCycleController.quoteHeaderdata[0].quoteId ?? "");
                                      },
                                      child: Text(
                                        "Fetch Sales Product",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(height: 1, color: AllColors.bluegrayColor,),
                    Center(
                      child: Divider(
                        height: 1,
                        color: AllColors.lightgreyColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              "Total",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            VerticalDivider(
                              width: 20, // total space taken
                              thickness: 1,
                              color: AllColors.lightgreyColor,
                            ),
                        Obx(() {
                          final bool showGM = saleCycleController.isAdminWritePermission == "1" ||
                                  saleCycleController.userType.toLowerCase() == "gm"||saleCycleController.GmApproveDetail.value;
                          final bool showbh=saleCycleController.userType?.toLowerCase()=='bh' ||
                              saleCycleController.userType?.toLowerCase()=='ch'||
                              saleCycleController.userType?.toLowerCase()=='gm'||
                              saleCycleController.isAdminWritePermission.value=="1";

                          final data = saleCycleController.quoteHeaderdata[0];

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              defaultColumnWidth: const FixedColumnWidth(130),
                              border: TableBorder.symmetric(
                                inside: BorderSide(
                                  width: 1,
                                  color: AllColors.lightgreyColor,
                                ),
                              ),
                              children: [
                                TableRow(
                                  children: [
                                    tableHeaderCell("Qty"),

                                    if(showbh)tableHeaderCell("BM %"),

                                    tableHeaderCell("Appr Amt Per Unit"),
                                    tableHeaderCell("Sales Credit"),
                                    tableHeaderCell("Total Approved Price"),

                                    if (showGM) tableHeaderCell("GM %"),
                                    if (showGM) tableHeaderCell("GM Amt"),
                                    if (showGM) tableHeaderCell("GM Total Amt"),

                                    tableHeaderCell("GST Amount"),
                                    tableHeaderCell("Total Amount"),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    tableValueCell(data.quoteTotalQty?.toInt()),
                                    if(showbh)tableValueCell(data.quoteTotalBmPerAverage),
                                    tableValueCell(
                                      "₹ ${saleCycleController.numberFormatWithComma(
                                        data.quoteApprovedAmtPerUnit,
                                      )}",
                                    ),
                                    tableValueCell(data.quoteSalesCreditAverage),
                                    tableValueCell(
                                      "₹ ${saleCycleController.numberFormatWithComma(
                                        data.quoteTotalApprovedDiscountAmount,
                                      )}",
                                    ),

                                    if (showGM)
                                      tableValueCell(data.quoteTotalGmPerAverage),
                                    if (showGM)
                                      tableValueCell(
                                        "₹ ${saleCycleController.numberFormatWithComma(
                                          data.quoteTotalGmDiscountAmount,
                                        )}",
                                      ),
                                    if (showGM)
                                      tableValueCell(
                                        "₹ ${saleCycleController.numberFormatWithComma(
                                          data.quoteNewTotalGmDiscountAmount,
                                        )}",
                                      ),

                                    tableValueCell(
                                      "₹ ${saleCycleController.numberFormatWithComma(
                                        data.quoteGstAmount,
                                      )}",
                                    ),
                                    tableValueCell(
                                      "₹ ${saleCycleController.numberFormatWithComma(
                                        data.quoteGrossAmount,
                                      )}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),

                        ],
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                        height: 1,
                        color: AllColors.lightgreyColor,
                      ),
                    ),
                    Obx(() {
                      return bindQuoteItemList(context);
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

  Widget tableHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AllColors.textColor,
          fontSize: AllFontSize.sisxteen,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget tableValueCell(dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value?.toString() ?? "0",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.sisxteen,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget tableCellValue(dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value?.toString() ?? '0',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.fourtine,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget bindQuoteItemList(BuildContext context) {
    if (saleCycleController.quoteLinedata.value.isNotEmpty &&
        saleCycleController.quoteLinedata.value.length > 0) {
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
                itemCount: saleCycleController.quoteLinedata.value.length,
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
    //String? dateCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteList[index].createdOn??"");
    int gstPer=(saleCycleController.quoteLinedata[index].sgstPer?.toInt()??0)+
        (saleCycleController.quoteLinedata[index].cgstPer?.toInt()??0)+
        (saleCycleController.quoteLinedata[index].igstAmt?.toInt()??0);
    return InkWell(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Item Name : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Flexible(
                      child: Tooltip(
                        message: "${saleCycleController.quoteLinedata[index].itemName ?? ""} "
                            "(${saleCycleController.quoteLinedata[index].itemCode ?? ""})",
                        child: Text("${saleCycleController.quoteLinedata[index].itemName ?? ""} "
                            "(${saleCycleController.quoteLinedata[index].itemCode ?? ""})",
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
              ),
              Visibility(
                visible: saleCycleController.isAdminWritePermission=='1' && saleCycleController
                    .quoteHeaderdata[0].quoteStatus?.toLowerCase()=="pending for approval",
                  child: InkWell(
                    onTap: () {
                      showDialogForDelete(context, index);
                    },
                    child:
                    Icon(Icons.delete, color: Colors.red, size: 27),
                  ),),

              const SizedBox(
                width: 10,
              ),

                 Visibility(
                  visible:(saleCycleController.showBranchHead.value ||
                      saleCycleController.showClusterHead.value ||
                      saleCycleController.showGeneralManager.value || saleCycleController.isAdminWritePermission=='1') && saleCycleController
                      .quoteHeaderdata[0].quoteStatus?.toLowerCase()=="pending for approval" && saleCycleController
                      .quoteHeaderdata[0].quoteAccepted?.toLowerCase()=="open",
                  child: GestureDetector(
                      onTap: () {
                        saleCycleController.bmDiscountPerController.value.text =
                            saleCycleController
                                        .quoteLinedata[index].bmDiscountPer ==
                                    null
                                ? "0"
                                : saleCycleController
                                    .quoteLinedata[index].bmDiscountPer
                                    .toString();
                        saleCycleController.salesCreditPerContoller.value.text =
                            saleCycleController
                                        .quoteLinedata[index].salesCredit ==
                                    null
                                ? "0"
                                : saleCycleController
                                    .quoteLinedata[index].salesCredit
                                    .toString();
                        saleCycleController.updateDiscountAmountController.value
                            .text = saleCycleController
                                    .quoteLinedata[index].approvedDiscountPer ==
                                null
                            ? "0"
                            : saleCycleController
                                .quoteLinedata[index].approvedDiscountPer
                                .toString();
                        showDialogForGmBmDiscount(context, index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Tooltip(
                            message: "Update Bm Discount %",
                            child: Icon(
                              Icons.update,
                              color: AllColors.textColor,
                            )),
                      )),
                )

            ],
          ),
          subtitle: Column(
            children: [
              SizedBox(height: 6,),
              Row(
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          bindData("Qty : ",(saleCycleController.quoteLinedata[index].qty?.toInt()).toString(),context),
                          bindData( "LSP :","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].listSellingPrice).toString()}",context),
                          Obx(() {
                            return Visibility(
                              visible: saleCycleController.userType?.toLowerCase()=='bh' ||
                                  saleCycleController.userType?.toLowerCase()=='ch'||
                                  saleCycleController.isAdminWritePermission=="1" ||
                                  saleCycleController.userType?.toLowerCase()=='gm',
                              child: bindData("MAP : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController
                                  .quoteLinedata[index].minimalAcceptablePrice).toString()}",context),
                            );
                          }),
                          /*Obx(() {
                            return Visibility(
                              visible:
                                  saleCycleController.showGeneralManager.value,
                              child: bindData( "MAP:","₹ ${
                                  saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].minimalAcceptablePrice).toString()}",context),

                            );
                          }),*/
                          bindData( "Seeking % : ",saleCycleController.quoteLinedata[index].discountPer.toString(),context),
                          bindData( "Seeking Amt P/U : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].discountAmtPerUnit).toString()}",context),
                          Obx((){
                            return Visibility(
                              visible: saleCycleController.userType?.toLowerCase()=='bh' ||
                                  saleCycleController.userType?.toLowerCase()=='ch'||
                                  saleCycleController.userType?.toLowerCase()=='gm'||
                                  saleCycleController.isAdminWritePermission.value=="1",
                            /*  visible: saleCycleController.showBranchHead.value ||
                                  saleCycleController.showClusterHead.value || saleCycleController.isAdminWritePermission.value=="1",*/
                              child:  bindData( "BTP : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.
                              quoteLinedata[index].branchTransferPrice).toString()}",context),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible:
                              saleCycleController.userType?.toLowerCase()=='gm' || saleCycleController.isAdminWritePermission=="1",
                              child:  bindData( "Std Cost : ","₹ ${
                                  saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].standardCost).toString()}",context),
                            );
                          }),
                          bindData( "Approved Dis. % :",saleCycleController.quoteLinedata[index].approvedDiscountPer.toString(),context),
                          bindData( "Appr. Amt P/U : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].approvedAmountPerUnit).toString()}",context),
                          bindData( "Sales Credit % : ",saleCycleController.quoteLinedata[index].salesCredit.toString(),context),
                          Obx((){
                            return Visibility(
                              visible: saleCycleController.readMoreList[index],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: saleCycleController.userType?.toLowerCase()=='gm' || saleCycleController.isAdminWritePermission=="1" ||
                                          saleCycleController.GmApproveDetail.value,
                                      child: Column(
                                        children: [
                                          bindData( "Gm % : ",saleCycleController.quoteLinedata[index].gmDiscountPer.toString(),context),
                                          bindData( "Gm Amt : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].gmDiscountAmount).toString()}",context),
                                          bindData( "Gm Total Amt : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].gmTotalDiscountAmount).toString()}",context),
                                        ],
                                      ),
                                    ),

                                  bindData("Total App. Price : ",saleCycleController.quoteLinedata[index].approvedAmount == null ? "0"
                                      : "₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].approvedAmount).toString()
                                  }",context),
                                  bindData("Price P/U : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].quoteLinePrice).toString()}",context),
                                  bindData("Total Seeking Price : ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].discountAmt).toString()}",context),
                                   Visibility(
                                      visible: saleCycleController.userType?.toLowerCase()=='bh' ||
                                          saleCycleController.userType?.toLowerCase()=='ch'||
                                          saleCycleController.userType?.toLowerCase()=='gm'||
                                          saleCycleController.isAdminWritePermission.value=="1",
                                      child:  bindData( "Bm % : ",saleCycleController.quoteLinedata[index].bmDiscountPer.toString(),context),
                                    ),


                                  bindData("GST % : ",(gstPer.toInt()).toString(),context),
                                  bindData( "GST Amt.: ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].gstAmount).toString()}" ,context),
                                  bindData( "Total Amt.: ","₹ ${saleCycleController.numberFormatWithComma(saleCycleController.quoteLinedata[index].grossAmount).toString()}" ,context),
                                  bindData("Item Desc : ",saleCycleController.quoteLinedata[index].itemDescription ?? "",context),
                                  bindData("Category Name : ",saleCycleController.quoteLinedata[index].categoryName ?? "",context),
                                ],
                              ),
                            );
                          }),
                          Obx((){
                           return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                    visible: !saleCycleController.readMoreList[index],
                                    child: GestureDetector(
                                      onTap: (){
                                        saleCycleController.readMoreList[index] = true;
                                      },
                                      child: Row(
                                        children: [
                                          Text('Read More ',
                                            style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Icon(Icons.keyboard_arrow_down,   color: Colors.blue,),
                                        ],
                                      ),
                                    )),


                                Visibility(visible: saleCycleController.readMoreList[index],
                                    child: GestureDetector(
                                      onTap: (){
                                        saleCycleController.readMoreList[index] = false;
                                      },
                                      child: Row(
                                        children: [
                                          Text('Read Less ',
                                            style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Icon(Icons.keyboard_arrow_up,   color: Colors.blue,)
                                        ],
                                      ),
                                    )
                                )
                              ],
                            );
                          })
                        ],
                      )),
                  SizedBox(width: 5,),

                ],
              ),
              Obx(() {
                return Visibility(
                  //visible:saleCycleController.quoteHeaderdata[0].createdBy==saleCycleController.email && saleCycleController.quoteHeaderdata[0].quoteStatus=="Pending"?true:false,
                  //visible:saleCycleController.quoteHeaderdata[0].quoteStatus=="Pending"?true:false,
                  visible: saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() == "draft" &&
                          saleCycleController.quoteHeaderdata[0].quoteAccepted?.toLowerCase() == "open" &&
                      saleCycleController.quoteHeaderdata[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()
                      ? true : false,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            saleCycleController.updateItemDescriptionController.value.text =
                                saleCycleController.quoteLinedata[index].itemName.toString() +
                                "(${saleCycleController.quoteLinedata[index].itemCode})";
                            saleCycleController.updateItemDescription2Controller.value.text =
                                saleCycleController.quoteLinedata[index].itemDescription.toString();
                            saleCycleController.qtyUpdateLineController.value.text =
                                (saleCycleController.quoteLinedata[index].qty?.toInt())==0?"":
                                (saleCycleController.quoteLinedata[index].qty?.toInt()).toString();
                            saleCycleController.updateUnitPriceController.value.text =
                                saleCycleController.quoteLinedata[index].unitPrice.toString();
                            saleCycleController.updateManualPriceController.value.text =
                                saleCycleController.quoteLinedata[index].quoteLinePrice.toString();


                            saleCycleController.updateDiscountPerController.value.text =
                                saleCycleController.quoteLinedata[index].discountPer ==0?"":
                                saleCycleController.quoteLinedata[index].discountPer.toString();

                            saleCycleController.updateDiscountAmountController.value.text =
                                saleCycleController.quoteLinedata[index].approvedDiscountPer.toString();
                            saleCycleController.gmDiscountPerContoller.value.text =
                                saleCycleController.quoteLinedata[index].gmDiscountPer.toString();
                            saleCycleController.salesCreditPerContoller.value.text =
                                saleCycleController.quoteLinedata[index].salesCredit.toString();
                            saleCycleController.updateAmountController.value.text =
                                saleCycleController.quoteLinedata[index].mrpPrice.toString();
                            saleCycleController.updateTaxPerLineController.value.text =
                                saleCycleController.quoteLinedata[index].sgstPer.toString();
                            saleCycleController.updateTaxAmountLineController.value.text =
                                saleCycleController.quoteLinedata[index].sgstAmt.toString();
                            saleCycleController.updateGrossAmountLineController.value.text =
                                saleCycleController.quoteLinedata[index].grossAmount.toString();
                            /*saleCycleController.warrentyPeriodController.value.text= saleCycleController.quoteLinedata[index]
                                .warrantyPeriod.toString();
                            saleCycleController.deliveryWeeksController.value.text= saleCycleController.quoteLinedata[index]
                                .deliveryInWeeks.toString();*/
                            saleCycleController.routingForQuoteUpdate.value="Quote";
                            saleCycleController.index.value = index;
                            Get.toNamed(RoutesName.updatequoteLineData);
                          },
                          child:
                              Icon(Icons.update, color: Colors.blue, size: 30),
                        ),
                        InkWell(
                          onTap: () {
                            showDialogForCreateDuplicate(context, index ,"Create Duplicate",'Do you want to Create Duplicate Line of this Quote?');
                          },
                          child: Icon(
                            Icons.add_chart,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialogForDelete(context, index);
                          },
                          child:
                              Icon(Icons.delete, color: Colors.red, size: 30),
                        ),
                      ]),
                );
              }),
              SizedBox(
                height: 6,
              ),
            ],
          ),
         /* leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${srNo}",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w800,
                ),
              ),
              VerticalDivider(
                color: Colors.grey,
              )
            ],
          ),*/
        ),
      ),
    );
  }
  Widget bindData(String fixData,String value,BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(fixData,
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w500,

            ),
          ),
          SizedBox(width: 10,),
          Flexible(
            child: Tooltip(
              message: value,
              child: Text(value,
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
    );
  }

  Widget BindSalesData(BuildContext context) {
    String? dateTimeCreatedOn = StaticMethod.dateTimeToDate(
        saleCycleController.quoteHeaderdata[0].createdOn ?? "");
    String? dateTimeApprovedOn = StaticMethod.dateTimeToDate(
        saleCycleController.quoteHeaderdata[0].approvedOn ?? "");
    String? expectedclosuredate = StaticMethod.convertDateFormat1(
        saleCycleController.quoteHeaderdata[0].expClosureDate ?? "");
    String? quoteValidityDate = StaticMethod.convertDateFormat1(
        saleCycleController.quoteHeaderdata[0].quoteValidity ?? "");
    String? regretOn = StaticMethod.dateTimeToDate(
        saleCycleController.quoteHeaderdata[0].regretOn ?? "");
    String saleCycleQuoteStatus =
        saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() ?? "";
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
                labelText: 'Quote Information',
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
                  _buildLabelWithValue(
                    label: "Sales Cycle Id",
                    value: saleCycleController.quoteHeaderdata[0].salesCycleId ?? "",
                    color: AllColors.textColor,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Customer Name",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: size.width * .4,
                          child: Tooltip(
                            message: saleCycleController
                                    .quoteHeaderdata[0].accountName ??
                                "",
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0].accountName ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                color: Colors.blueAccent,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          accountMaster_page_controller.view = 'FromquoteInformationScreen';
                          contact_vm_controller.view = 'FromquoteInformationScreen';
                          accountMaster_page_controller.getAccMasterBuyCodeApi(saleCycleController.quoteHeaderdata[0].accountCode!);
                        },
                      ),
                    ],
                  ),

                  _buildLabelWithValue(
                    label: "Customer Code",
                    value: saleCycleController.quoteHeaderdata[0].accountCode ?? "",
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Contact Name",
                    value: saleCycleController.quoteHeaderdata[0].contactName ?? "",
                    color: AllColors.textColor,
                  ),
                  Visibility(
                    visible:true  /*saleCycleController.quoteHeaderdata[0].parentProductCategoryCode==null ||
                        saleCycleController.quoteHeaderdata[0].parentProductCategoryCode==""*/,
                    child:
                  _buildLabelWithValue(
                      label: "Product Category",
                      value: saleCycleController.quoteHeaderdata[0].productCategory

                          ?? "",
                      color: AllColors.textColor,
                      context: context
                  ),),


                  _buildLabelWithValue(
                    label: "P. Product Category",
                    value: saleCycleController.quoteHeaderdata[0].parentProductCategoryCode ?? "",
                    color: AllColors.textColor,
                    context: context
                  ),


                  _buildLabelWithValue(
                    label: "Quote Status",
                    value: saleCycleController.quoteHeaderdata[0].quoteStatus ?? "",
                    color: getStatusColor(saleCycleQuoteStatus),
                  ),

                  _buildLabelWithValue(
                    label: "Expected Closure Date",
                    value: expectedclosuredate.toString(),
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Validity",
                    value: quoteValidityDate.toString(),
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Version",
                    value: saleCycleController.quoteHeaderdata[0].quoteVersion.toString() ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Kind Attention",
                    value: saleCycleController.quoteHeaderdata[0].kindAttention ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Terms & Condition",
                    value: saleCycleController.quoteHeaderdata[0].termsAndCondition ?? '',
                    color: AllColors.textColor,
                  ),

                  Row(
                    children: [
                      Text(
                        "Sales Product List",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          saleCycleController.clearSaleProductListController();
                          saleCycleController.pageNumber = 0;


                          saleCycleController.getSaleCycleProductByIdList(
                              saleCycleController.pageNumber,
                              saleCycleController
                                  .quoteHeaderdata[0].salesCycleId!);
                          /*  saleCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(
                              saleCycleController.pageNumber,
                              saleCycleController
                                  .quoteHeaderdata[0].salesCycleId!);*/
                          bindListBottomSheet(context);
                        },
                        child: Text(
                          'View',
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),

                  _buildLabelWithValue(
                    label: "Installation Charges",
                    value: saleCycleController.quoteHeaderdata[0].installationCharges == null ? "" : saleCycleController.quoteHeaderdata[0].installationCharges.toString(),
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Other Charges",
                    value: saleCycleController.quoteHeaderdata[0].otherCharges == null ? "" : saleCycleController.quoteHeaderdata[0].otherCharges.toString(),
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Warranty Period",
                    value: saleCycleController.quoteHeaderdata[0].warrantyPeriod ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Delivery In Weeks",
                    value: saleCycleController.quoteHeaderdata[0].deliveryInWeeks ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Advance Payment %",
                    value: saleCycleController.quoteHeaderdata[0].advancePaymentPer == null
                        ? "" : saleCycleController.quoteHeaderdata[0].advancePaymentPer.toString(),
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Advance Payment Amt",
                    value:saleCycleController.quoteHeaderdata[0].advancePaymentAmt == null?"":" ₹ ${saleCycleController.numberFormatWithComma(
                        saleCycleController.quoteHeaderdata[0].advancePaymentAmt).toString()}",
                    //value: saleCycleController.quoteHeaderdata[0].advancePaymentAmt == null ? "" : saleCycleController.quoteHeaderdata[0].advancePaymentAmt.toString(),
                    color: AllColors.textColor,
                  ),


                  _buildLabelWithValue(
                    label: "FrontLiner Remarks",
                    value: saleCycleController.quoteHeaderdata[0].otherRemarks ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Accepted",
                    value: saleCycleController.quoteHeaderdata[0].quoteAccepted ?? '',
                    color: AllColors.textColor,
                  ),


                  _buildLabelWithValue(
                    label: "Quote Commit",
                    value: saleCycleController.quoteHeaderdata[0].quoteCommit.toString() == '1' ? 'Yes' : 'No',
                    color: saleCycleController.quoteHeaderdata[0].quoteCommit.toString() == '1'?AllColors.greenblue:AllColors.redColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Total Amt.",
                    value:" ₹ ${saleCycleController.numberFormatWithComma(
                        saleCycleController.quoteHeaderdata[0].quoteTotalAmount).toString()}",
                    //value: saleCycleController.quoteHeaderdata[0].quoteTotalAmount.toString() ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote GST Amt.",
                    value:" ₹ ${saleCycleController.numberFormatWithComma(
                        saleCycleController.quoteHeaderdata[0].quoteGstAmount).toString()}",
                    //value:  saleCycleController.quoteHeaderdata[0].quoteGstAmount.toString() ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Gross Amt.",
                    value:" ₹ ${saleCycleController.numberFormatWithComma(
                        saleCycleController.quoteHeaderdata[0].quoteGrossAmount).toString()}",
                    //value: saleCycleController.quoteHeaderdata[0].quoteGrossAmount.toString() ?? "",
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Created By",
                    value: saleCycleController.quoteHeaderdata[0].createdFullName ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Created on",
                    value: dateTimeCreatedOn.toString(),
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Cluster",
                    value: saleCycleController.quoteHeaderdata[0].clustureHeadValue ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Region",
                    value: saleCycleController.quoteHeaderdata[0].branchHeadValue ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Reject Reason",
                    value: saleCycleController.quoteHeaderdata[0].rejectReason ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Status Won",
                    value: saleCycleController.quoteHeaderdata[0].quoteStatusWon ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Quote Won Name",
                    value: saleCycleController.quoteHeaderdata[0].quoteWonName ?? '',
                    color: AllColors.textColor,
                  ),

                  _buildLabelWithValue(
                    label: "Loss Reason",
                    value: saleCycleController.quoteHeaderdata[0].lossReason ?? '',
                    color: AllColors.textColor,
                  ),
                  _buildLabelWithValue(
                    label: "Won By",
                    value: saleCycleController.quoteHeaderdata[0].wonBy ?? '',
                    color: AllColors.textColor,
                  ),
                  _buildLabelWithValue(
                    label: "Won On",
                    value: saleCycleController.quoteHeaderdata[0].wonOn ?? '',
                    color: AllColors.textColor,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
    Color color = AllColors.textColor,
    BuildContext? context,
  }) {
    return Row(
      children: [
        Text(
          "$label : ",
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Tooltip(
              message: value ?? "",
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
        ),

        if (label == "P. Product Category" &&
            saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() == "draft" &&
            saleCycleController.isHeadofficePermission != "1")
          InkWell(
            onTap: () {
              saleCycleController.itemCategorySelectedlist.clear();
              String codes = saleCycleController.quoteHeaderdata[0].parentProductCategoryCode ?? "";
              if (codes.isNotEmpty) {
                saleCycleController.itemCategorySelectedlist.value = codes
                    .split(',')
                    .map((e) => ItemCategoryMstModel(
                  parentCategoryCode: e.trim(),
                )).toList();
              }
              /*for (var item in saleCycleController.parentProductCategoryList) {
                if (item.isSelected == 1) {
                  saleCycleController.itemCategorySelectedlist.add(item);
                }
              }*/
              saleCycleController.productCategoryController.value.clear();
              if(saleCycleController.quoteHeaderdata[0].isMultiParentCategory==1){
                saleCycleController.IsMultiParentCategory_controller.value.text="Yes";
                saleCycleController.IsMultiParentCategory.value=true;
              }
              else{
                saleCycleController.IsMultiParentCategory_controller.value.text = "No";
                saleCycleController.IsMultiParentCategory.value=false;
              }
              showProductCatDialog(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Icon(Icons.add),
            ),
          ),
        if(label == "Product Category" &&
            saleCycleController.quoteHeaderdata[0].quoteStatus?.toLowerCase() ==
                "draft" &&
            saleCycleController.isHeadofficePermission != "1")
          InkWell(
              onTap: () {
                saleCycleController.itemCategorySelectedlist.value = [];
                for (int i = 0; i < saleCycleController.productCategoryList.length; i++) {
                  if (saleCycleController.productCategoryList[i].isSelected == 1) {
                    saleCycleController.itemCategorySelectedlist.add(saleCycleController.productCategoryList[i]);
                    //TaskMaster_page_controller.Item_Category_code_list.add(TaskMaster_page_controller.Item_Category_master_list[i].categoryCode!);

                    print(
                        'LIstSIze.....${saleCycleController.itemCategorySelectedlist.length}');
                  } else {
                    print('NoLIstSIze.....');
                  }
                }
                saleCycleController.productCategoryController.value.clear();
                showProductCategoryDialog(context);
              },
              child: Icon(Icons.add)),


      ],
    );
  }
  showProductCatDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Parent Product Category',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              //height: size.height*.3,
              width: size.width * 4,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Wrap(
                spacing: 0,
                runSpacing: 10,
                children: [
                  bindIsMultiParentCategoryDropDown(context),
                  const  SizedBox(height: 10,),
                  Obx((){
                    return Visibility(visible: saleCycleController.showMultiParentCategory.value,
                      child:  bindItemCategoryDropDown(context),);
                  }),
                  const  SizedBox(height: 15,),
                  //bindItemCategoryDropDown(context),
                  const SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible:
                      saleCycleController.itemCategorySelectedlist.length > 0 ? true : false,
                      child: Wrap(
                        spacing: 8.0,
                        children: saleCycleController.itemCategorySelectedlist.map((category) {
                          return Chip(
                            label: Text(category.parentCategoryCode ?? ""),
                            onDeleted: () {
                              saleCycleController.itemCategorySelectedlist.remove(category);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  //const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          //saleCycleController.ProductCatCreateSaleCycleInfApiHit(saleCycleController.quoteHeaderdata[0].quoteId.toString());
                          saleCycleController.QuoteHeaderParentCategoryUpdate(saleCycleController.quoteHeaderdata[0].quoteId.toString());
                          //saleCycleController.ProductCatCreateApiHit(saleCycleController.quoteHeaderdata[0].quoteId.toString(),"");
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            'Save' ,
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
  showProductCategoryDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Product Category',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              //height: size.height*.3,
              width: size.width * 4,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Wrap(
                children: [
                  //bindItemCategoryDropDown(context),
                  bindItemProducrtCategoryDropDown(context),
                  const SizedBox(
                    height: 65,
                  ),
                  Obx(() {
                    return Visibility(
                      visible:
                      saleCycleController.itemCategorySelectedlist.length > 0 ? true : false,
                      child: Wrap(
                        spacing: 8.0,
                        children: saleCycleController.itemCategorySelectedlist
                            .map((category) {
                          return Chip(
                            label: Text(category.categoryName ?? ""),
                            onDeleted: () {
                              saleCycleController.itemCategorySelectedlist.remove(category);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.ProductCatCreateSaleCycleInfApiHit(saleCycleController.quoteHeaderdata[0].quoteId.toString());
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
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
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  bindIsMultiParentCategoryDropDown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width,
      controller: saleCycleController.IsMultiParentCategory_controller.value,
      label: Text("Rate Contract Only",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w600),
      ),
      initialSelection: saleCycleController.IsMultiParentCategory_controller.value.text,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,

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
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
      ),
      onSelected: (String? selection) {
        print(selection);
        saleCycleController.IsMultiParentCategory_controller.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        if( saleCycleController.IsMultiParentCategory_controller.value.text=="Yes"){
          saleCycleController.productCategoryController.value.text="";
          saleCycleController.itemCategorySelectedlist.value=[];
          saleCycleController.IsMultiParentCategory.value=true;
          saleCycleController.showMultiParentCategory.value=false;
          saleCycleController.showMultiParentCategory.value=true;
        }
        else{
          saleCycleController.productCategoryController.value.text="";
          saleCycleController.itemCategorySelectedlist.value=[];
          saleCycleController.IsMultiParentCategory.value=false;
          saleCycleController.showMultiParentCategory.value=false;
          saleCycleController.showMultiParentCategory.value=true;
        }
      },
      menuStyle:  MenuStyle(
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.of(context).size.width * 0.7, 100), // 👈 same width
        ),
      ),
      dropdownMenuEntries: ["Yes","No"].map<DropdownMenuEntry<String>>((String e) {
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
  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.parentCategoryCode!;

  static String _displayItemProductCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  Widget bindItemProducrtCategoryDropDown(context) {
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemProductCatMasterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.productCategoryList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return saleCycleController.productCategoryList
            .where((ItemCategoryMstModel option) {
          return option.categoryName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstModel selection) {
        // Update the TextField with the selected
        saleCycleController.productCategoryController.value.text =
            _displayItemProductCatMasterForOption(selection).toString();
        print('Controller.....${saleCycleController.productCategoryController.value.text}');
        if (!saleCycleController.itemCategorySelectedlist.contains(selection)) {
          //TaskMaster_page_controller.Item_Category_code_list.add(selection.categoryCode!);
          saleCycleController.itemCategorySelectedlist.add(selection);
          //Utils.showToastification('Success', 'Add Successfully');
        } else {
          Utils.showErrorToastification('Error', 'Already Selected');
        }
        saleCycleController.productCategoryController.value.clear();
        // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextField(
            onTap: () {
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = saleCycleController.productCategoryController.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Product Category',
              labelText: 'Product Category',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
          Iterable<ItemCategoryMstModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width * .7,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ItemCategoryMstModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.categoryName.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bindItemCategoryDropDown(context) {
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemCatMasterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.parentProductCategoryList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return saleCycleController.parentProductCategoryList
            .where((ItemCategoryMstModel option) {
          return option.parentCategoryCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstModel selection) {
        // Update the TextField with the selected
        print("length---${saleCycleController.itemCategorySelectedlist.length}");
        saleCycleController.productCategoryController.value.text =
            _displayItemCatMasterForOption(selection).toString();
        if (saleCycleController.IsMultiParentCategory.value) {
          bool alreadyExists = saleCycleController.itemCategorySelectedlist.any(
                (item) => item.parentCategoryCode == selection.parentCategoryCode,
          );

          if (!alreadyExists) {
            saleCycleController.itemCategorySelectedlist.add(selection);
          }
          /*if (!saleCycleController.itemCategorySelectedlist.contains(selection)) {
            saleCycleController.itemCategorySelectedlist.add(selection);
            //Utils.showToastification('Success', 'Add Successfully');
          }*/else{
            Utils.showErrorToastification('Error', 'Already Selected');
          }
        }
        else{
          saleCycleController.productCategoryController.value.text =
              _displayItemCatMasterForOption(selection).toString();
          saleCycleController.itemCategorySelectedlist.value=[];
          saleCycleController.itemCategorySelectedlist.add(selection);
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextField(
            onTap: () {
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = saleCycleController.productCategoryController.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AllColors.primaryDark1), // Change the color to green
              ),
              suffixIcon: InkWell(
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Parent Product Category',
              labelText: 'Parent Product Category',
              labelStyle: TextStyle(color:AllColors.blackColor),
              border: OutlineInputBorder(

                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
          Iterable<ItemCategoryMstModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width * .7,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ItemCategoryMstModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.parentCategoryCode.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
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
                  Text('Do you want to delete this Quote Line?',
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
                              Navigator.pop(context);
                              //Get.back();
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
                              saleCycleController.quoteLineDeleteApiHit(
                                  saleCycleController
                                      .quoteLinedata[index].lineNo!,
                                  saleCycleController.quoteApprovalPage.value,  saleCycleController.quoteHeaderdata[0].salesCycleId??"", saleCycleController.quoteHeaderdata[0].quoteId??"");
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

/*  Future showDialogForCreateDuplicate(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Create Duplicate",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                  *//* height: size.height*.21,
                  width: size.width*4,*//*
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Do you want to Create Duplicate Line of this Quote?',
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
                              saleCycleController
                                  .quoteLineCreateDuplicateApiHit(
                                      saleCycleController
                                          .quoteLinedata[index].lineNo!);
                              //Get.back();
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
  }*/

  Widget bindRejectreason(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      maxLines: 2,
      maxLength: 500,
      inputFormatters: [
        LengthLimitingTextInputFormatter(500),
      ],
      controller: saleCycleController.rejectreasonQuoteController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.twelve, horizontal: AllFontSize.ten),
          hintText: 'Enter Reject Reason',
          labelText: 'Reject Reason',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }


 /* Future showDialogForHeaderUpdate(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Update Quote Header",
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite, // important
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// 🔹 Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                          visible:
                          saleCycleController.isAdminWritePermission == "1" ||
                              saleCycleController.userType.toLowerCase() == "branch head" ||
                              saleCycleController.userType.toLowerCase() == "cluster head" ||
                              saleCycleController.userType.toLowerCase() == "general manager",
                          child: bindCharges(context),
                        ),
                        SizedBox(height: 10),
                        bindShippingAddress(context),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

                /// 🔹 Fixed buttons at bottom
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DefaultButton(
                            press:(){
                              address_vm_controller.FromPage.value="SalesCycleQuotation";
                              address_vm_controller.clearController();
                              address_vm_controller.account_code_controller.text=saleCycleController.quoteHeaderdata[0].accountCode??"";
                              address_vm_controller.account_name_controller.text=saleCycleController.quoteHeaderdata[0].accountName??"";
                              //address_vm_controller.gst_registration_type_controller.value.text = 'UnRegistered';
                              address_vm_controller.getGeoPostalCodeApi(50, '');
                              Get.toNamed(RoutesName.addNewAddress_screen);
                            },
                            text:
                            'Add New',
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: DefaultButton(
                            press: (){
                              saleCycleController.pageNumber = 0;
                              saleCycleController.getAddressMasterList(
                                  saleCycleController.pageNumber,
                                  saleCycleController.accountCode.value);
                              saleCycleController.showConsigneeAddressList(
                                  context, saleCycleController.address_master_list,saleCycleController.accountCode.value);
                            },
                            text: 'Change ',

                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.quoteHeaderUpdateApiHit(saleCycleController.quoteHeaderdata[0].quoteId!);
                          //Get.back();
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Text(
                            'Update Quote',
                            style: GoogleFonts.poppins(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
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
      },
    );
  }*/


  bindInputData(BuildContext context,String levelText, TextEditingController controller, Widget suffixIcon) {
    if(levelText=="Warranty Period"){
      controller.text='12';
    }
    else if(levelText=="Quote Amount"){
      double totAmount = saleCycleController.quoteHeaderdata[0].quoteTotalAmount!;
      //saleCycleController.quoteTotAmountController.value.text = totAmount.toString();
      controller.text = totAmount.toString();
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        readOnly:levelText=="Quote Amount" || levelText=='Pending Quote Amount' ||
            levelText=='Final Quote Amount'?true:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: levelText,
            labelText: levelText,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.fourtine),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onChanged: (text) {

          if(levelText=='Installation Charges' ||levelText=='Other Charges'){
            saleCycleController.calculateFinalAmt();
          }
          if(levelText=='Advc. Payment Amount'){
            calculatePer();
          }
          if(levelText=='Advc. Payment Percentage' || levelText=='Quote Amount'){
            checkPertageValue(context);
          }


        },
      ),
    );
  }



  checkPertageValue(BuildContext context) {
    final text = saleCycleController.advncPaymentPerController.value.text;
    final percentageValue = int.tryParse(text);
    if (percentageValue == null) {
      saleCycleController.advncPaymentAmountController.value.clear();
    } else if (percentageValue > 100) {
      print("hhhh${percentageValue}");
      Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
    } else if(percentageValue <= 100){
      final advanceAmt = (saleCycleController.quoteHeaderdata[0].quoteTotalAmount! * percentageValue) / 100;
      saleCycleController.advncPaymentAmountController.value.text = advanceAmt.toString();
      final parts=saleCycleController.advncPaymentAmountController.value.text.split('.');
      if(parts.length==2 && parts[1].length>4){
        String trimmed = '${parts[0]}.${parts[1].substring(0, 4)}';
        saleCycleController.advncPaymentAmountController.value.text=trimmed;
        saleCycleController.advncPaymentAmountController.value.selection =
            TextSelection.fromPosition(TextPosition(offset: trimmed.length));
      }
    }

    double? advcAmount = double.tryParse(saleCycleController.advncPaymentAmountController.value.text);
    double? finalAmount = double.tryParse(saleCycleController.finalAmountController.value.text);
    if (advcAmount == null) {
      advcAmount = 0.0;
    }
    double totAmount = finalAmount! - advcAmount;
    saleCycleController.pendingAmountController.value.text = totAmount.toString();
  }

  void calculatePer() {
    if(saleCycleController.advncPaymentAmountController.value.text.isEmpty){
      saleCycleController.advncPaymentPerController.value.clear();
    }else{
      final text = double.parse(saleCycleController.advncPaymentAmountController.value.text);
      double percantage=0.0;
      if(saleCycleController.quoteTotAmountController.value.text.isNotEmpty){
        percantage=(text/double.parse(saleCycleController.quoteTotAmountController.value.text))*100;
        print("Percentage.${percantage}");
      }
      if(percantage<=100){
        saleCycleController.advncPaymentPerController.value.text = percantage.toStringAsFixed(2);
      }else if(text>100){
        Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
      }
      /*else{
        Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
      }*/

    }
  }

  Widget bindTermCondition(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),

      child: Obx(() {
        return TextField(
          readOnly:  saleCycleController.BusinessTerm.value,
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.termConditionController.value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Term & Condition',
              labelText: 'Term & Condition',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.sisxteen),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
          ),
        );

      }),
    );
  }

  Widget updateQuoteValidity(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.updateQuoteValidityController.value,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Quote Validity',
              labelText: 'Quote Validity',
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
              )),
          onTap: () async {
            DateTime? initialDate;
            if (saleCycleController
                .updateQuoteValidityController.value.text.isNotEmpty) {
              initialDate = DateFormat('yyyy-MM-dd').parse(
                saleCycleController.updateQuoteValidityController.value.text,
              );
              // Ensure initialDate is not before firstDate
              if (initialDate.isBefore(DateTime.now())) {
                initialDate = DateTime.now();
              }
            } else {
              initialDate = DateTime.now();
            }
            DateTime ending_date = new DateTime(2200);
            FocusScope.of(context).requestFocus(new FocusNode());
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime.now(),
              lastDate: ending_date,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor:
                        AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme:
                        ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.updateQuoteValidityController.value.text =
                  outputFormat.format(date);
            /* else
              saleCycleController.updateQuoteValidityController.value.text = "";*/
          }),
    );
  }

  Widget updateExpectedClosureDate(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
          cursorColor: AllColors.primaryDark1,
          controller:
              saleCycleController.updateExpectedClosureDateController.value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              suffixIcon: Icon(Icons.calendar_month),
              hintText: 'Expected Closure Date',
              labelText: 'Expected Closure Date',
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
              )),
          onTap: () async {
            DateTime? initialDate;
            if (saleCycleController
                .updateExpectedClosureDateController.value.text.isNotEmpty) {
              initialDate = DateFormat('yyyy-MM-dd').parse(
                saleCycleController
                    .updateExpectedClosureDateController.value.text,
              );
              // Ensure initialDate is not before firstDate
              if (initialDate.isBefore(DateTime.now())) {
                initialDate = DateTime.now();
              }
            } else {
              initialDate = DateTime.now();
            }
            DateTime ending_date = new DateTime(2200);
            FocusScope.of(context).requestFocus(new FocusNode());
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime.now(),
              lastDate: ending_date,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor:
                        AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme:
                        ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.updateExpectedClosureDateController.value
                  .text = outputFormat.format(date);
            /*else
              saleCycleController.updateExpectedClosureDateController.value.text = "";*/
          }),
    );
  }

  /* Widget quoteCommitDropDown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownMenu<String>(
        width: size.width-130,
        controller: saleCycleController.quoteCommitController.value,
        label: Text(
          "Quote Commit",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
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
        enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.quoteCommitController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        },

        dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }*/

  Widget bindActive(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownMenu<String>(
        width: size.width - 155,
        controller: saleCycleController.activeController.value,
        label: Text("Active",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),
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
        //enabled: saleCycleController.quoteHeaderdata[0].isReadySendForApproval != 1 ? false : true,
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.activeController.value.text = _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        },
        dropdownMenuEntries: saleCycleController.customerNeedIdentityList
            .map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e,
              label: e!,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(AllColors.primaryDark1),
              ));
        }).toList(),
      ),
    );
  }

  /*Future showDialogForRegretHeaderUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: AlertDialog(
              title: Text("Update",   style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
              ),),
              content: Container(
                  height: size.height*.21,
                  width: size.width*4,
                  child: Column(
                    children: [
                      Text(
                          'Do you really want to Mark Header Regret?',
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
                                onPressed: ()  {
                                  Get.back();
                                },
                                child: Container(
                                  child: Text('Cancel',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.greenblue,
                                  ),
                                ),
                                onPressed: ()  {
                                  saleCycleController.quoteHeaderMarkRegretApiHit();
                                  Get.back();
                                },
                                child: Container(
                                  child: Text('Confirm',
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
                  )
              ),
            ),
          );

        });
  }*/

  /* Future updateDropdownForHeaderRegret(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: AlertDialog(
              title: Text("Regret",   style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
              ),),
              content: Container(
                  height: size.height*.21,
                  width: size.width*4,
                  child: Column(
                    children: [
                      bindRegretheaderreason(context),
                      SizedBox(height: 10,),
                      Container(
                        width: size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AllColors.greenblue,
                            ),
                          ),
                          onPressed: ()  {
                            if(saleCycleController.regretReasonHeaderController.value.text.isEmpty || saleCycleController.regretReasonHeaderController.value.text==null)
                            {
                              Utils.sanckBarError("Error !", "Please Type Regret Reason");
                            }
                            else{
                              showDialogForRegretHeaderUpdate(context);
                            }

                            // saleCycleController.quoteLineMarkRegretApiHit(saleCycleController.quoteLinedata[index].lineNo!);
                            */ /* Get.back();
                            Get.back();*/ /*
                          },
                          child: Container(
                            child: Text('Submit',
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
                  )
              ),
            ),
          );

        });
  }*/
  Widget bindCharges(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AllColors.grayColor, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'General',
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
            updateQuoteValidity(context),
            const SizedBox(height: 10),
            updateExpectedClosureDate(context),
            const SizedBox(height: 10),
            bindInputData(context,'Installation Charges',saleCycleController.installationChargesController.value,Icon(Icons.currency_rupee)),
            const SizedBox(height: 10),
            bindInputData(context,'Other Charges',saleCycleController.otherChargesController.value,Icon(Icons.currency_rupee)),
            const SizedBox(height: 10),
            bindInputData(context,'Warranty Period',saleCycleController.warrentyPeriodController.value,Container(padding: EdgeInsets.only(right: 15, top: 10),
              child: Text('Months', style: GoogleFonts.poppins(color: AllColors.blackColor, fontSize: AllFontSize.sisxteen, fontWeight: FontWeight.w500,),),)),
            const SizedBox(height: 10),
            bindInputData(context,'Delivery In Weeks',saleCycleController.deliveryWeeksController.value,Container(padding: EdgeInsets.only(right: 15, top: 10),
              child: Text('Weeks', style: GoogleFonts.poppins(color: AllColors.blackColor, fontSize: AllFontSize.sisxteen, fontWeight: FontWeight.w500,),),)),
            const SizedBox(height: 10),
            bindInputData(context,'Advc. Payment Percentage',saleCycleController.advncPaymentPerController.value,Icon(Icons.percent)),
            const SizedBox(height: 10),
            bindInputData(context,'Advc. Payment Amount',saleCycleController.advncPaymentAmountController.value,Icon(Icons.currency_rupee)),
            const SizedBox(height: 10),
            bindInputData(context,'Quote Amount',saleCycleController.quoteTotAmountController.value,Icon(Icons.currency_rupee)),
            const SizedBox(height: 10),
            bindInputData(context,'Final Quote Amount',saleCycleController.finalAmountController.value,Icon(Icons.currency_rupee)),
            const SizedBox(height: 10),
            bindInputData(context,'Pending Quote Amount',saleCycleController.pendingAmountController.value,Icon(Icons.currency_rupee)),
            const SizedBox(height: 10),
            bindTermCondition(context),
            const SizedBox(height: 10),
            bindActive(context),
            const SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }


  bindShippinbAddressData(BuildContext context, String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: hintText,
            //suffixIcon: Icon(Icons.email),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Widget bindKindAttention(BuildContext context) {
    return TextField(
      onChanged: (value){
        final words = value.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).toList();

        if (words.length > 500) {
          final limitedText = words.take(500).join(' ');
          saleCycleController.kindAttentionController.value.text = limitedText;
          saleCycleController.kindAttentionController.value.selection =
              TextSelection.fromPosition(TextPosition(offset: limitedText.length));
        }
      },
      maxLength: 500,
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.kindAttentionController.value,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Kind Attention*',
          labelText: 'Kind Attention*',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget bindShippingAddress(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AllColors.grayColor, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
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
            bindShippinbAddressData(context,"Address",saleCycleController.shippingController.value),
          /*  Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController.shippingController.value,
                decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "Address",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),*/
            const SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
            const SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
            const SizedBox(height: 15,),
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
            const SizedBox(height: 15,),
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
            const SizedBox(height: 15,),
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
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  void openConfirmationDialog(
      BuildContext context, String message, String flag) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AllColors.lightredColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message,
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
                            Navigator.pop(context);
                           // Get.back();
                          },
                          child: Container(
                            child: Text(
                              'Cancel',
                              /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
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
                            if (flag == "Approved") {
                              saleCycleController.quoteApprovalRejectApiHit(
                                  flag,
                                  saleCycleController
                                      .quoteHeaderdata[0].quoteId!);
                            } else if (flag == "Rejected") {
                              saleCycleController.quoteApprovalRejectApiHit(
                                  flag,
                                  saleCycleController
                                      .quoteHeaderdata[0].quoteId!);
                            } else {
                              saleCycleController.quoteSendForApprovalApiHit();
                            }

                            //Get.back();
                            Navigator.pop(context);
                            Get.back();
                          },
                          child: Container(
                            //width: 80,
                            //alignment: Alignment.center,
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
          );
        });
  }

  void showdialogForApproval(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AllColors.lightredColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Update Quote',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bindDropDownOfRejectAndApprove(context),
                SizedBox(height: 10),
                Obx(() {
                  return Visibility(
                      visible: saleCycleController.isApprove.value,
                      child: managerRemarksField(context));
                }),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: saleCycleController.isApprove.value,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AllColors.greenblue,
                            ),
                          ),
                          onPressed: () {
                            openConfirmationDialog(
                                context,
                                "Do you want to Update this Sales Cycle?",
                                "Approved");
                          },
                          child: Container(
                            child: Text(
                              'Approve',
                              style: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: saleCycleController.isReject.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        bindRejectreason(context),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AllColors.redColor,
                                ),
                              ),
                              onPressed: () {
                                openConfirmationDialog(
                                    context,
                                    "Do you want to Update this Sales Cycle?",
                                    "Rejected");
                              },
                              child: Container(
                                child: Text(
                                  'Reject',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            )),
          );
        });
  }

  Future moveToDraftDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Move To Draft",
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
                      Text('Do you want to move this quote ?',
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
                                  Navigator.pop(context);
                                  //Get.back();
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
                                  saleCycleController.QuoteMstStatusChangeToDraft(saleCycleController.quoteHeaderdata[0].quoteId ?? "");
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


  Widget managerRemarksField(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.managerRemarksController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Manager Remarks',
          labelText: 'Manager Remarks',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  showFetchSalesProductConfirmationDialog(
      context, String SalesId, String QuoteId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AllColors.lightredColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Fetch!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(children: [
              Column(
                children: [
                  Text('Do you want to Fetch Sales Product ?',
                      style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1,
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.lightredColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          //Get.back();
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.greenblue,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.FetchSalesProductApiHit(
                              SalesId, QuoteId);
                          Navigator.pop(context);
                          //Get.back();
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ]),
          );
        });
  }

  Widget bindDropDownOfRejectAndApprove(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayCustomerNeedIdentityStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.statusList.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return saleCycleController.statusList.value.where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        saleCycleController.quoteStatusController.value.text =
            _displayStatusForOption(selection!).toString();
        print(
            'IsActive.....${saleCycleController.quoteStatusController.value.text}');
        if (saleCycleController.quoteStatusController.value.text == "Approve") {
          saleCycleController.isApprove.value = true;
          saleCycleController.isReject.value = false;
        } else if (saleCycleController.quoteStatusController.value.text ==
            "Reject") {
          saleCycleController.isReject.value = true;
          saleCycleController.isApprove.value = false;
        } else {
          saleCycleController.isApprove.value = false;
          saleCycleController.isReject.value = false;
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: () {
            saleCycleController.quoteStatusController.value.clear();
          },
          onChanged: (value) {
            if (saleCycleController.quoteStatusController.value.text ==
                "Approve") {
              saleCycleController.isApprove.value = true;
              saleCycleController.isReject.value = false;
            } else if (saleCycleController.quoteStatusController.value.text ==
                "Reject") {
              saleCycleController.isReject.value = true;
              saleCycleController.isApprove.value = false;
            } else {
              saleCycleController.isApprove.value = false;
              saleCycleController.isReject.value = false;
            }
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = saleCycleController.quoteStatusController.value.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Quote Status',
              labelText: 'Quote Status',
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width * .62,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    /*return DropdownMenu<String>(
    width: size.width*.67,
    controller: saleCycleController.quoteStatusController.value,
    label: Text(
      "Quote Status",
      style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.fourtine,
          fontWeight: FontWeight.w500),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: AllColors.primaryDark1,),
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
      saleCycleController.quoteStatusController.value.text =
          _displayStatusForOption(selection!).toString();
      print('IsActive.....${saleCycleController.quoteStatusController.value.text}');
      if(saleCycleController.quoteStatusController.value.text=="Approve"){
        saleCycleController.isApprove.value=true;
        saleCycleController.isReject.value=false;
      }
      else if(saleCycleController.quoteStatusController.value.text=="Reject"){
        saleCycleController.isReject.value=true;
        saleCycleController.isApprove.value=false;
      }
      else{
        saleCycleController.isApprove.value=false;
        saleCycleController.isReject.value=false;
      }
    },

    dropdownMenuEntries: saleCycleController.statusList.value.map<DropdownMenuEntry<String>>((String e) {
      return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
    }).toList(),
  );*/
  }

/*
  void showDialogforUpdateLine(BuildContext context, int index) {
    int srNo=index+1;
    showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(
           title:
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: AllColors.lightredColor,),
                    SizedBox(width: 5,),
                    Text(
                        'Update Sr. No. ${srNo}',
                        style: GoogleFonts.poppins(
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                          color: AllColors.primaryDark1,
                        ))
                  ],
                ),

            content: Container(
                height: size.height*.54,
                width: size.width*4,
                child: Expanded(
                  child: Column(
                    children: [
                      updateItemDescriptionLine(context, index),
                      SizedBox(height: 10),
                      updateqtyLine(context, index),
                      SizedBox(height: 10),
                      updateManualPriceLine(context, index),
                      SizedBox(height: 10),
                      updateDiscountPerLine(context, index),
                      SizedBox(height: 10),
                      updateDiscountPerLine(context, index),
                      SizedBox(height: 10),
                      updateDiscountPerLine(context, index),
                      SizedBox(height: 10),
                      updateDiscountPerLine(context, index),
                      SizedBox(height: 10),



                    ],
                  ),
                )
            ),

          );
        });
  }*/

  void bindListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    child: CircleBackButton(
                      press: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Sales Product List : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    child: InkWell(
                      onTap: () {
                        showDialogSalesCycleProductFilter(context);
                      },
                      child: Icon(Icons.filter_alt_rounded),
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: Divider(
              height: 1,
              color: AllColors.primaryDark1,
            )),
            Expanded(child: SingleChildScrollView(
              child: Obx(() {
                return bindSalesCycleProductData(
                  context,
                );
              }),
            )),
            Center(
                child: Divider(
              height: 1,
              color: AllColors.primaryDark1,
            )),


            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total ",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Qty : ",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Obx((){
                        return Text(
                          saleCycleController
                              .get_SalesCycleProductById_List.length >
                              0
                              ? (saleCycleController
                              .get_SalesCycleProductById_List[0]
                              .productTotalQty ==
                              null
                              ? "0"
                              :( saleCycleController
                              .get_SalesCycleProductById_List[0]
                              .productTotalQty?.toInt())
                              .toString())
                              : "",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Price: ",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Obx((){
                        return   Text(
                          saleCycleController
                              .get_SalesCycleProductById_List.length >
                              0
                              ? (saleCycleController
                              .get_SalesCycleProductById_List[0]
                              .productTotalAmount ==
                              null
                              ? "0"
                              : saleCycleController
                              .get_SalesCycleProductById_List[0]
                              .productTotalAmount
                              .toString())
                              : "0",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      })

                    ],
                  ),
                ],
              ),
            )
          ],
        ));
      },
    );
  }

  void showDialogSalesCycleProductFilter(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AllColors.lightredColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Filter List ',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            filterWithItemCode(context),
                            SizedBox(
                              height: 5,
                            ),
                            filterItemDescription(context),
                            SizedBox(
                              height: 5,
                            ),
                            filterWithCategoryName(context),
                            SizedBox(
                              height: 5,
                            ),
                           /* EditCompetitorName(context),
                            SizedBox(
                              height: 5,
                            ),
                            EditLossReason(context),
                            SizedBox(
                              height: 5,
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AllColors.redColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    saleCycleController.pageNumber = 0;
                                    saleCycleController
                                        .clearSaleProductListController();
                                   /* saleCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(
                                        saleCycleController.pageNumber,
                                        saleCycleController
                                            .quoteHeaderdata[0].salesCycleId!);*/
                                    saleCycleController
                                        .getSaleCycleProductByIdList(
                                            saleCycleController.pageNumber,
                                            saleCycleController
                                                .quoteHeaderdata[0]
                                                .salesCycleId!);
                                    Navigator.pop(context);
                                   // Get.back();
                                  },
                                  child: Text(
                                    'Reset',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AllColors.greenblue,
                                    ),
                                  ),
                                  onPressed: () {
                                    saleCycleController.pageNumber = 0;
                                    saleCycleController
                                        .getSaleCycleProductByIdList(
                                            saleCycleController.pageNumber,
                                            saleCycleController
                                                .quoteHeaderdata[0]
                                                .salesCycleId!);


                                 /*   saleCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(
                                        saleCycleController.pageNumber,
                                        saleCycleController
                                            .quoteHeaderdata[0].salesCycleId!);*/
                                   // Get.back();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            })),
          );
        });
  }

  Widget filterWithItemCode(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.itemCodeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Item Code',
          labelText: 'Item Code',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  Widget filterItemDescription(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.updateItemDescriptionController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Item Description',
          labelText: 'Item Description',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  Widget filterWithCategoryName(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.categoryNameController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Category Name',
          labelText: 'Category Name',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  Widget EditLossReason(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.updateLossReasonProductController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
          hintText: 'Loss Reason',
          labelText: 'Loss Reason',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  Widget EditCompetitorName(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:
          saleCycleController.updateCompetitorNameProductController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
          hintText: 'Competitor Name',
          labelText: 'Competitor Name',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  Widget bindSalesCycleProductData(BuildContext context) {
    print(
        "Lengh${saleCycleController.get_SalesCycleProductById_List.value.length}");
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
              saleCycleController.quoteHeaderdata[0].salesCycleId!,
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
                  return bindSaleCycleProductListView(context, index);
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

  Widget bindSaleCycleProductListView(BuildContext context, int index) {
    String? dateCreatedOn = StaticMethod.convertDateFormat1(
        saleCycleController.get_SalesCycleProductById_List[index].createdOn ??
            "");
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title: Row(
          children: [
            Text(
              "Item Code : ",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              saleCycleController
                      .get_SalesCycleProductById_List[index].itemCode ??
                  "",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
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
                 // width: size.width * .4,
                  child: Tooltip(
                    message: saleCycleController
                            .get_SalesCycleProductById_List[index]
                            .itemDescription ??
                        "",
                    child: Text(
                      saleCycleController.get_SalesCycleProductById_List[index]
                              .itemDescription ??
                          "",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category Name : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index].categoryName
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
                  "Qty : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (saleCycleController.get_SalesCycleProductById_List[index].qty?.toInt())
                      .toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),



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
            ),*/

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "LSP : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text("₹ ${saleCycleController.numberFormatWithComma(
                    saleCycleController.get_SalesCycleProductById_List[index].mrpPrice).toString()}",
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
                Text("₹ ${saleCycleController.numberFormatWithComma(
                    saleCycleController.get_SalesCycleProductById_List[index].totalPrice).toString()}",
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
                      .get_SalesCycleProductById_List[index].createdFullName
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
                    Container(
                      width: size.width * 0.5,
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
                      saleCycleController.get_SalesCycleProductById_List[index]
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
                    Container(
                      width: size.width * 0.5,
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
                    Container(
                      width: size.width * 0.5,
                      child: Tooltip(
                        message: saleCycleController
                                .get_SalesCycleProductById_List[index].lossOn ??
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
                    Container(
                      width: size.width * 0.5,
                      child: Tooltip(
                        message: saleCycleController
                                .get_SalesCycleProductById_List[index].lossBy ??
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
      ),
    );
  }

  void showDialogForGmBmDiscount(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Quote Item Update",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    bindApprovedDiscountPer(context),
                    SizedBox(height: 10),
                  /*  Obx(() {
                      return Visibility(
                          visible: saleCycleController.showGeneralManager.value,
                          child: bindGmDiscountPer(context));
                    }),*/
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return Visibility(
                          visible: saleCycleController.isAdminWritePermission=="1" ||
                              saleCycleController.showGeneralManager.value,
                          child:  bindSalesCreditPer(context));
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AllColors.redColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                           // Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
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
                            saleCycleController.index.value = index;
                            saleCycleController.quoteLineCreateFunction(
                                saleCycleController
                                    .quoteLinedata[index].itemCode!,
                                "BmGMUpdate");
                            //Get.back();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Update',
                            style: GoogleFonts.poppins(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }

  bindApprovedDiscountPer(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      keyboardType: TextInputType.number,
      controller: saleCycleController.updateDiscountAmountController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Approved Discount %',
          labelText: 'Approved Discount %',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }


  bindSalesCreditPer(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.salesCreditPerContoller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Sales Credit %',
          labelText: 'Sales Credit %',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }
  void showDialoGWithWithoudQuoteReport(BuildContext context) {
    showDialog(
        context: context,
        builder: (
            BuildContext context,
            ) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Download Report",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.eighteen,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: (){
                            saleCycleController.reportwithDownload();
                            Navigator.pop(context);
                            //Get.back();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.download_for_offline_outlined, color: AllColors.blackColor,),
                              SizedBox(width: 10),
                              Text(
                                "Download With Disc.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(height: 5),

                        GestureDetector(
                          onTap: (){
                            saleCycleController.reportDownload("quoteReport");
                            //Get.back();
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.download_for_offline_outlined,color: AllColors.blackColor,),
                              SizedBox(width: 10),
                              Text(
                                "Download Without Disc.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }
  void reOpenSalesCycle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AllColors.lightredColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: size.width * 0.5,
                  child: Text(
                    'Reopen Quote',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ),
                    //overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bindTextField(context,saleCycleController.reOpenRemarksController.value,'Reopen Remarks*' ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AllColors.greenblue,
                      ),
                    ),
                    onPressed: () {
                      showDialogConfirmation(
                          context);
                    },
                    child: Container(
                      width: size.width,
                      child: Center(
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
                  ),
                ],
              ),
            ),
          );
        });
  }

  showDialogConfirmation(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AllColors.lightredColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Re-Open',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(children: [
              Column(
                children: [
                  Text('Do you want to Reopen this Quotation?',
                      style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1,
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.lightredColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          //Get.back();
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.greenblue,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.getquotationMstRejectReopen(
                              saleCycleController
                                  .quoteHeaderdata[0].quoteId??"",
                              saleCycleController
                                  .reOpenRemarksController.value.text);
                          //Get.back();
                          Navigator.pop(context);
                          Get.back();
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ]),
          );
        });
  }


  void showDialogquotationWonLoss(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, color: AllColors.lightredColor),
              SizedBox(width: 5),
              Text(
                'Update Quotation',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bindQuoteWonLoss(context),
                  SizedBox(height: 10),
                  Visibility(
                    visible:
                    saleCycleController.reasonQuotationVisibilty.value,
                    child: bindTextField(
                      context,
                      saleCycleController.quotationReasonController.value,
                      'Quote Loss Reason',
                    ),
                  ),

                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            saleCycleController.reasonQuotationVisibilty.value
                                ? AllColors.redColor
                                : AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          if (saleCycleController.reasonQuotationVisibilty.value && saleCycleController
                              .quotationReasonController.value.text
                              .isEmpty ) {
                            Utils.sanckBarError(
                                'Error', 'Please Enter Quote Reason');
                            return;
                          }
                          showDialogForCreateDuplicate(context,0,'Update', 'Do you want to mark won ?');



                        },
                        child: Text(
                          saleCycleController.reasonQuotationVisibilty.value
                              ? 'Loss'
                              : 'Won',
                          style: GoogleFonts.poppins(
                            color:
                            saleCycleController.reasonQuotationVisibilty.value
                                ? AllColors.blackColor
                                : AllColors.whiteColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }



  Widget bindQuoteWonLoss(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayCustomerNeedIdentityStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.quoteAcceptedList;
        }
        return saleCycleController.quoteAcceptedList.where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        saleCycleController.quotationWonLossController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!)
                .toString();
        if(saleCycleController.quotationWonLossController.value.text.toUpperCase() == 'LOSS'){
          saleCycleController.reasonQuotationVisibilty.value=true;
        }
        else{
          saleCycleController
              .quotationReasonController.value.text="";
          saleCycleController.reasonQuotationVisibilty.value=false;
        }
        /*saleCycleController.reasonQuotationVisibilty.value =
            saleCycleController.quotationWonLossController.value.text.toUpperCase() == 'LOSS';*/
        FocusNode().unfocus();
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController controller,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = saleCycleController.quotationWonLossController.value.text,
          focusNode: focusNode,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Quote Accepted',
              labelText: 'Quote Accepted',
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              //width: size.width * .5,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

/*  Widget bindQuoteWonLoss(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<String>(
        controller: saleCycleController.quotationWonLossController.value,
        label: Text(
          "Quote Accepted",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
        ),
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
          saleCycleController.quotationWonLossController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
          saleCycleController.reasonQuotationVisibilty.value =
              saleCycleController.quotationWonLossController.value.text == 'LOSS';
          print("${saleCycleController.reasonQuotationVisibilty.value}..${saleCycleController.quotationWonLossController.value.text}");
        },
        dropdownMenuEntries: saleCycleController.quoteAcceptedList
            .map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e,
              label: e!,
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(AllColors.primaryDark1),
              ));
        }).toList(),
      ),
    );
  }*/


  bindTextField(BuildContext context, TextEditingController controller, String labelText) {
    return TextField(
      maxLines: labelText=='Quote Loss Reason'?2:3,
      maxLength: 500,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: labelText,
          hintText: labelText,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      cursorColor: AllColors.primaryDark1,
    );
  }

  Future showDialogForCreateDuplicate(BuildContext context, int index, String headerMessege, String lineMessage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                headerMessege,
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                /* height: size.height*.21,
                  width: size.width*4,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(lineMessage,
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
                                  Navigator.pop(context);
                                 // Get.back();
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
                                  if(headerMessege=='Update'){
                                    saleCycleController.getQuoteHeaderUpdateMarkWon(saleCycleController
                                        .quoteHeaderdata[0].quoteId??'');
                                    Navigator.pop(context);
                                  }else{
                                    saleCycleController
                                        .quoteLineCreateDuplicateApiHit(
                                        saleCycleController
                                            .quoteLinedata[index].lineNo!);
                                  }


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

}
