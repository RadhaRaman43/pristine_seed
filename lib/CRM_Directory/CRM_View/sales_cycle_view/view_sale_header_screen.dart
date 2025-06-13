import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sale_cycle_modal/productCategoryWiseAmtModel.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import '../../../component/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class ViewSaleHeaderScreen extends StatelessWidget {
  ViewSaleHeaderScreen({super.key});

  final saleCycleController = Get.put(SalesCycleVm());
  final TaskMaster_page_controller = Get.put(Taskmastervm());
  final accountMaster_page_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final quoteApprovalController = Get.put(QuoteApprovalListVm());

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  static String _displayPurchaseProcessForOption(CustomList option) =>
      option.value!;

  static String _displayPurchaseTimeFrameForOption(CustomList option) =>
      option.value!;

  static String _displayDecisionMakerForOption(String option) => option;

  Size size = Get.size;

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('fromPageNameSales.....${saleCycleController.FromPage}');
        if (saleCycleController.FromPage == 'Sales') {
          print('Yaha Se1...');
          saleCycleController.clearAllFieldOfFilter();
          /*  saleCycleController.accountNameController.value.clear();
          //saleCycleController.contactNameController.value.clear();
          saleCycleController.ApprovalStatusController.value.clear();*/
          saleCycleController.pageNumber = 0;
          saleCycleController.filterQuoteAcceptedFlag.value = "Open";
          saleCycleController.getsalesCycleData(
              saleCycleController.pageNumber, "", "", 'Sales');
          Get.toNamed(RoutesName.salesCycleScreen);
        } else if (saleCycleController.FromPage == 'Task') {
          TaskMaster_page_controller.getTaskMaster(
              0,
              TaskMaster_page_controller.is_Active.toString(),
              TaskMaster_page_controller.Task_Master_list[0].taskId,
              '',
              'GET FROM TASK ID',
              TaskMaster_page_controller.date_filter,
              TaskMaster_page_controller.is_done.value);
          Get.toNamed(RoutesName.taskMasterDetails_screen);
        } else if (saleCycleController.FromPage == "QuoteApprovalPage") {
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteApprovalListScreen);
        } else if (saleCycleController.FromPage == "FromTaskScreen") {
          Get.offAllNamed(RoutesName.taskMaster_screen);
        } else if (saleCycleController.FromPage == "FromDashboard") {
          Get.toNamed(RoutesName.AccountDashboardDataSales_Screen);
        } else {
          saleCycleController.clearAllFieldOfFilter();
          saleCycleController.filterQuoteAcceptedFlag.value = "Open";
          //saleCycleController.getsalesCycleData(0, "", "",'');
          Get.toNamed(RoutesName.salesCycleScreen);
        }
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
                      'View Sales',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '(${saleCycleController.saleCycleList[0].salesCycleId.toString()})',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Obx(() {
                  return Visibility(
                    visible: saleCycleController
                            .saleCycleList[0].actualSalesCycleApprovalStatus
                            ?.toLowerCase() ==
                        'rejected' &&  saleCycleController
                        .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase(),
                    child: GestureDetector(
                      onTap: () {
                        saleCycleController.reOpenRemarksController.value.text =
                            "";
                        reOpenSalesCycle(
                            context, saleCycleController.saleCycleList[0]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7.0),
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.lock_open,
                          color: AllColors.whiteColor,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AllColors.whiteColor)),
                      ),
                    ),
                  );
                })
                /*Obx((){
              return Visibility(
                 visible:saleCycleController.saleCycleList[0].createdBy==saleCycleController.email &&
                     saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE" &&
                     saleCycleController.FromPage == 'Sales' &&
                     saleCycleController.saleCycleList[0].isReadySendForApproval==1 &&
                     saleCycleController.saleCycleList[0].isSalesCycleClosed!=1?true:false,
                 child: GestureDetector(
                   onTap: (){
                     saleCycleController.updateQuoteAccetedCycleController.value.clear();
                     saleCycleController.saleCycleController.value.clear();
                     saleCycleController.isChooseQuote.value = false;
                     saleCycleController.isApprove.value=false;
                     saleCycleController.isReject.value=false;
                     saleCycleController.isCheck.value = -1;
                     saleCycleController.checkBoxValues.updateAll((key, value) => false);
                     saleCycleController.Quote_Selected_list.clear();
                     saleCycleController.showDialogForsalescycleUpdate(context, saleCycleController.saleCycleList[0]);

                     //showDialogForHeaderUpdate(context);
                   },
                   child: Container(
                     child: Padding(
                       padding: const EdgeInsets.all(7.0),
                       child: Icon(Icons.update, color: AllColors.whiteColor,),
                     ),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         border: Border.all(color: AllColors.whiteColor)
                     ),
                   ),
                 ),
               );
             }),
              Obx((){
                return Visibility(
                  visible:saleCycleController.saleCycleList[0].createdBy==saleCycleController.email &&
                      saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT" &&
                      saleCycleController.FromPage == 'Sales' &&
                      saleCycleController.saleCycleList[0].isReadySendForApproval==1 &&
                      saleCycleController.saleCycleList[0].isSalesCycleClosed!=1?true:false,
                  child: GestureDetector(
                    onTap: (){
                      saleCycleController.updateQuoteAccetedCycleController.value.clear();
                      saleCycleController.saleCycleController.value.clear();
                      saleCycleController.isChooseQuote.value = false;
                      saleCycleController.isApprove.value=false;
                      saleCycleController.isReject.value=false;
                      saleCycleController.isCheck.value = -1;
                      saleCycleController.checkBoxValues.updateAll((key, value) => false);
                      saleCycleController.Quote_Selected_list.clear();
                      saleCycleController.showDialogForSalesCyclePurchaseUpdate(context, saleCycleController.saleCycleList[0]);

                      //showDialogForHeaderUpdate(context);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Icon(Icons.update, color: AllColors.whiteColor,),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AllColors.whiteColor)
                      ),
                    ),
                  ),
                );
              })*/
              ],
            ),
            actions: [
              Obx(() {
                return Visibility(
                  visible:saleCycleController
                      .saleCycleList[0].salesCycleStatus?.toLowerCase()=="suspect" && saleCycleController
                      .saleCycleList[0].quoteAccepted?.toLowerCase()=="loss"?false:true,
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      List<PopupMenuEntry> items = [];
                      // Conditionally add the first item
                      //if (saleCycleController.saleCycleList[0].salesCycleStatus == "Prospect") {
                      if (saleCycleController
                          .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase() &&
                          saleCycleController.saleCycleList[0]
                                  .actualSalesCycleApprovalStatus
                                  ?.toLowerCase() ==
                              "pending for approval"  &&
                      saleCycleController.saleCycleList[0]
                          .salesCycleStatus
                          ?.toLowerCase() !=
                      "rejected" &&  saleCycleController.saleCycleList[0]
                          .quoteAccepted
                          ?.toLowerCase() ==
                          "open") {
                        items.add(
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.update, color: Colors.black),
                                Text(' Update Sales Cycle Details'),
                              ],
                            ),
                            onTap: () {
                              saleCycleController
                                  .updateQuoteAccetedCycleController.value
                                  .clear();
                              saleCycleController.saleCycleController.value
                                  .clear();
                              saleCycleController.isChooseQuote.value = false;
                              saleCycleController.isApprove.value = false;
                              saleCycleController.isReject.value = false;
                              saleCycleController.isCheck.value = -1;
                              saleCycleController.checkBoxValues
                                  .updateAll((key, value) => false);
                              saleCycleController.Quote_Selected_list.clear();

                              saleCycleController
                                      .closureDateController.value.text =
                                  saleCycleController
                                      .saleCycleList[0].estClosureDate
                                      .toString();
                              saleCycleController
                                  .identifyDecisionMakerController
                                  .value
                                  .text = saleCycleController
                                          .saleCycleList[0].isDecisionMaker ==
                                      1
                                  ? "Yes"
                                  : "No";
                              saleCycleController.purchaseProcessController
                                  .value.text = saleCycleController
                                      .saleCycleList[0].purchaseProcess ??
                                  "";
                              saleCycleController.purchasTimeFrameController
                                  .value.text = saleCycleController
                                      .saleCycleList[0].purchaseTimeFrame ??
                                  "";
                              saleCycleController
                                      .salesCycleOwnerController.value.text =
                                  "${saleCycleController.saleCycleList[0].createdFullName}(${saleCycleController.saleCycleList[0].salesCycleOwner})";
                              saleCycleController
                                      .updatesalesCycleBudgetAmountController
                                      .value
                                      .text =
                                  saleCycleController
                                      .saleCycleList[0].budgetAmount
                                      .toString();
                              saleCycleController.saleCycleOwnerSelected.value =
                                  saleCycleController
                                          .saleCycleList[0].salesCycleOwner ??
                                      "";
                              showDialogForSalesCyclePurchaseUpdate(context,
                                  saleCycleController.saleCycleList[0]);
                            },
                          ),
                        );
                      }

                      //todo comment code -it is visible on suspect and propose case
                      /* if (saleCycleController.saleCycleList[0].salesCycleStatus
                          ?.toLowerCase() != "prospect") {
                        items.add(
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.contacts, color: Colors.black),
                                Text(' Mark Won / Loss'),
                              ],
                            ),
                            onTap: () {
                              saleCycleController
                                  .updateQuoteAccetedCycleController.value
                                  .clear();
                              saleCycleController.saleCycleController.value
                                  .clear();
                              saleCycleController.isChooseQuote.value = false;
                              saleCycleController.isApprove.value = false;
                              saleCycleController.isReject.value = false;
                              saleCycleController.isCheck.value = -1;
                              saleCycleController.checkBoxValues.updateAll((key,
                                  value) => false);
                              saleCycleController.Quote_Selected_list.clear();
                              if (saleCycleController.saleCycleList[0]
                                  .salesCycleStatus != "Propose") {
                                saleCycleController
                                    .updateQuoteAccetedCycleController.value
                                    .text = "LOSS";
                                saleCycleController.isReject.value = true;
                              }
                              saleCycleController.showDialogForsalescycleUpdate(
                                  context,
                                  saleCycleController.saleCycleList[0]);
                            },
                          ),
                        );
                      }*/
                      // Always add the second item
                      if (saleCycleController.saleCycleList[0].salesCycleStatus
                              ?.toLowerCase() !=
                          "suspect") {
                        items.add(
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: AllColors.blackColor,
                                ),
                                Text(' Competitor Details'),
                              ],
                            ),
                            onTap: () {
                              saleCycleController.pageNumber = 0;
                              saleCycleController
                                  .clearSaleProductListController();
                              saleCycleController.getSaleCycleProductByIdList(
                                  saleCycleController.pageNumber,
                                  saleCycleController
                                      .saleCycleList[0].salesCycleId!);
                              bindListBottomSheet(context);
                            },
                          ),
                        );
                      }
                      if (saleCycleController.saleCycleList[0].quoteAccepted
                              ?.toLowerCase() ==
                          "open"&& saleCycleController.saleCycleList[0].quoteAccepted
                          ?.toLowerCase() !=
                          "rejected") {
                        items.add(
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.contacts, color: Colors.black),
                                Text(' Update Sales Cycles'),
                              ],
                            ),
                            onTap: () {
                              saleCycleController.updateQuoteAccetedCycleController.value.clear();
                              saleCycleController.saleCycleController.value.clear();
                              saleCycleController.isChooseQuote.value = false;
                              saleCycleController.isApprove.value = false;
                              saleCycleController.isReject.value = false;
                              saleCycleController.isCheck.value = -1;
                              saleCycleController.checkBoxValues.updateAll((key, value) => false);
                              saleCycleController.Quote_Selected_list.clear();
                              if (saleCycleController.saleCycleList[0].salesCycleStatus != "Propose") {
                                saleCycleController.updateQuoteAccetedCycleController.value.text = "LOSS";
                                saleCycleController.isReject.value = true;
                              }
                              saleCycleController.showDialogForsalescycleUpdate(context, saleCycleController.saleCycleList[0]);
                            },
                          ),
                        );
                      }

                      return items;
                    },
                  ),
                );
              })
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
                child: ListView(children: [
                  Obx(() {
                    return BindSalesData(context);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return bindsaleStatus(context);
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: saleCycleController
                                  .saleCycleList[0].salesCycleStatus!
                                  .toLowerCase() ==
                              "suspect"
                          ? true
                          : false,
                      child: Container(
                        child: Column(
                          children: [
                            bindClosureDate(context),
                            SizedBox(
                              height: 10,
                            ),
                            bindIdentifyDecisionMaker(context),
                            SizedBox(
                              height: 10,
                            ),
                            /* bindSaleCycleCommit(context),
                            SizedBox(height: 10,),*/
                            bindPurchaseProcessDropDown(context),
                            SizedBox(
                              height: 10,
                            ),
                            bindPurchaseTimeFrameDropDown(context),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: (saleCycleController.saleCycleList[0]
                                                  .quoteAccepted
                                                  ?.toUpperCase() ==
                                              "OPEN" &&
                                          saleCycleController.saleCycleList[0]
                                                  .salesCycleStatus!
                                                  .toUpperCase() ==
                                              "SUSPECT" &&
                                          saleCycleController.saleCycleList[0]
                                                  .isReadySendForApproval ==
                                              1) &&
                                      !(saleCycleController.FromPage.value ==
                                          "FromDashboard")
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    child: IgnorePointer(
                                      ignoring: saleCycleController
                                                  .saleCycleList[0]
                                                  .isReadySendForApproval ==
                                              0
                                          ? true
                                          : false,
                                      child: DefaultButton(
                                        press: () {
                                          saleCycleController
                                              .salesCycleMstUpdateApiHit(
                                                  saleCycleController
                                                      .saleCycleList[0],
                                                  saleCycleController
                                                      .proposedSolutionController
                                                      .value
                                                      .text,
                                                  "",
                                                  "",
                                                  "",
                                                  "save");
                                          //saleCycleController.ProductCategoryWiseAmtCreateApiHit(0);
                                        },
                                        text: "Save",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            bindProductCategoryDropDown(context),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //bindBudgetAmount(context),
                                bindExpectedAmount(context),
                                Visibility(
                                  visible: saleCycleController.saleCycleList[0]
                                                  .quoteAccepted
                                                  ?.toUpperCase() !=
                                              "OPEN" ||
                                      saleCycleController
                                          .saleCycleList[0].isReadySendForApproval==0 ||
                                          saleCycleController.saleCycleList[0]
                                                  .salesCycleApprovalStatus
                                                  ?.toLowerCase() ==
                                              "rejected" ||
                                          (saleCycleController.FromPage.value ==
                                              "FromDashboard")
                                      ? false
                                      : true,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    width: size.width / 2,
                                    child: IgnorePointer(
                                      /* ignoring: (saleCycleController
                                            .saleCycleList[0].quoteAccepted
                                            ?.toUpperCase() == "LOSS") ||
                                            (saleCycleController
                                                .saleCycleList[0]
                                                .isReadySendForApproval == 0 &&
                                                (saleCycleController.FromPage
                                                    .value == 'FromTaskScreen'
                                                )) ||
                                            saleCycleController.FromPage
                                                .value == 'Task' ||
                                            saleCycleController.FromPage
                                                .value == 'FromTaskScreen'
                                            ? true
                                            : false,*/
                                      ignoring: ( saleCycleController
                                          .saleCycleList[0].createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase() ||
                                              saleCycleController
                                                      .saleCycleList[0]
                                                      .quoteAccepted
                                                      ?.toUpperCase() !=
                                                  "OPEN")
                                          ? true
                                          : false,
                                      child: DefaultButton(
                                        press: () {
                                          if (saleCycleController
                                                  .productCategoryController
                                                  .value
                                                  .text
                                                  .isEmpty ||
                                              saleCycleController
                                                      .productCategoryController
                                                      .value
                                                      .text ==
                                                  "") {
                                            Utils.showErrorToastification(
                                                "Product Category",
                                                "Please select product category");
                                            return;
                                          }
                                          if (saleCycleController
                                                  .expectedAmountController
                                                  .value
                                                  .text
                                                  .isEmpty ||
                                              saleCycleController
                                                      .expectedAmountController
                                                      .value
                                                      .text ==
                                                  "") {
                                            Utils.showErrorToastification(
                                                "Expected Amount",
                                                "Please enter expected amount");
                                            return;
                                          }

                                          saleCycleController
                                              .ProductCategoryWiseAmtCreateApiHit(
                                                  0);
                                        },
                                        text: "Add",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BindAmmountTable(context),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: saleCycleController
                                  .saleCycleList[0].salesCycleStatus!
                                  .toUpperCase() ==
                              "PROSPECT"
                          ? true
                          : false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() {
                                return ActionChip(
                                  elevation: 2,
                                  padding: EdgeInsets.only(
                                      right: 15, top: 2, left: 10, bottom: 2),
                                  backgroundColor:
                                      saleCycleController.filter.value ==
                                              'Sales cycle'
                                          ? AllColors.primaryDark1
                                          : AllColors.grayColor,
                                  shadowColor: Colors.black,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: AllColors.grayColor)),
                                  label: Text('Sales Cycle Products',
                                      style: GoogleFonts.poppins(
                                        color:
                                            saleCycleController.filter.value ==
                                                    'Sales cycle'
                                                ? AllColors.whiteColor
                                                : AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  onPressed: () {
                                    saleCycleController.filter.value =
                                        'Sales cycle';
                                  }, //Text
                                );
                              }),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Obx(() {
                                return ActionChip(
                                  elevation: 2,
                                  padding: EdgeInsets.only(
                                      right: 15, top: 2, left: 15, bottom: 2),
                                  backgroundColor:
                                      saleCycleController.filter.value ==
                                              'Solution Accepted'
                                          ? AllColors.primaryDark1
                                          : AllColors.grayColor,
                                  shadowColor: Colors.black,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: AllColors.grayColor)),
                                  label: Text('Solution Accepted',
                                      style: GoogleFonts.poppins(
                                        color:
                                            saleCycleController.filter.value ==
                                                    'Solution Accepted'
                                                ? AllColors.whiteColor
                                                : AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  onPressed: () {
                                    saleCycleController.filter.value =
                                        'Solution Accepted';
                                  }, //Text
                                );
                              }),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Obx(() {
                                return Visibility(
                                  visible: (saleCycleController.saleCycleList[0]
                                      .createdBy?.toLowerCase()==saleCycleController.email.toLowerCase() &&
                                      saleCycleController.filter.value ==
                                              'Sales cycle' &&
                                          saleCycleController.saleCycleList[0]
                                                  .quoteAccepted
                                                  ?.toLowerCase() ==
                                              'open') &&
                                      !(saleCycleController.saleCycleList[0]
                                              .actualSalesCycleApprovalStatus
                                              ?.toLowerCase() ==
                                          'rejected') &&
                                      !(saleCycleController.FromPage.value ==
                                          "FromDashboard"),
                                  child: CircleAvatar(
                                    child: InkWell(
                                      onTap: () {
                                        String ProductCategory =
                                            saleCycleController.saleCycleList[0]
                                                    .productCategoryCode ??
                                                "";
                                        String PipeProdCate =
                                            ProductCategory.replaceAll(
                                                ', ', '|');
                                        saleCycleController.pageNumberForItem =
                                            0;
                                        saleCycleController
                                            .itemMstGetBySalesIdApiHit(
                                                saleCycleController
                                                    .pageNumberForItem,
                                                saleCycleController
                                                    .saleCycleList[0]
                                                    .salesCycleId,
                                                PipeProdCate);
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Obx(() {
                                return Visibility(
                                  visible: saleCycleController.filter.value ==
                                      'Sales cycle',
                                  child: CircleAvatar(
                                    child: InkWell(
                                      onTap: () {
                                        showFilterBottomSheet(context);
                                      },
                                      child: Icon(Icons.filter_alt_rounded),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: saleCycleController
                          .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()&&
                              saleCycleController
                                      .saleCycleList[0].salesCycleStatus!
                                      .toUpperCase() ==
                                  "PROSPECT" /*saleCycleController.saleCycleList[0]
                              .approvedBy?.toLowerCase() !=
                              saleCycleController.email.toLowerCase()*/
                              &&
                              saleCycleController.filter.value ==
                                  'Solution Accepted'
                          ? true
                          : false,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                /*child: Visibility(
                                          visible: saleCycleController
                                              .saleCycleList[0]
                                              .salesCycleStatus!
                                              .toUpperCase() == "PROSPECT"
                                              ? true
                                              : false,*/
                                Obx(() {
                                  return bindCustomerNeedIdentity(context);
                                }),
                                SizedBox(
                                  width: 10,
                                ),
                                Obx(() {
                                  return Expanded(
                                      child: Visibility(
                                          visible: saleCycleController
                                              .ischangeNeedIdentity.value,
                                          child:
                                              bindSolutionAccepted(context)));
                                })
                              ],
                            ),
                          ),
                          Obx(() {
                            return Visibility(
                                visible: (saleCycleController.saleCycleList[0]
                                                .salesCycleStatus!
                                                .toUpperCase() ==
                                            "PROSPECT") &&
                                        (saleCycleController
                                                .ischangeNeedIdentity.isFalse ||
                                            saleCycleController
                                                .ischangesolutionAccepted
                                                .isFalse)
                                    ? true
                                    : false,
                                child: bindSolutionRejectedRemarks(context));
                          }),
                          /*   Obx(() {
                                return Visibility(
                                    visible: saleCycleController
                                        .saleCycleList[0].salesCycleStatus!
                                        .toUpperCase() == "PROSPECT" &&
                                        saleCycleController.ischangeNeedIdentity
                                            .value &&
                                        saleCycleController
                                            .ischangesolutionAccepted.value &&
                                        (saleCycleController
                                            .ischangeNeedIdentity.value &&
                                            saleCycleController
                                                .ischangesolutionAccepted.value)
                                        ? true
                                        : false,
                                    child: BindProposedSolution(context));
                              }),*/
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                        visible: saleCycleController
                                        .saleCycleList[0].salesCycleStatus!
                                        .toUpperCase() ==
                                    "PROSPECT" &&
                                saleCycleController.filter.value ==
                                    'Sales cycle'
                            ? true
                            : false,
                        child: Column(
                          children: [
                            bindSalesCycleProductData(context, "Add"),
                            Visibility(
                                visible: saleCycleController
                                        .get_SalesCycleProductById_List.length >
                                    0,
                                child: Column(
                                  children: [
                                    Center(
                                        child: Divider(
                                      height: 1,
                                      color: AllColors.primaryDark1,
                                    )),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                "Qty: ",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.textColor,
                                                  fontSize:
                                                      AllFontSize.sisxteen,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              Text(
                                                saleCycleController
                                                            .get_SalesCycleProductById_List
                                                            .length >
                                                        0
                                                    ? (saleCycleController
                                                                .get_SalesCycleProductById_List[
                                                                    0]
                                                                .productTotalQty ==
                                                            null
                                                        ? "0"
                                                        : saleCycleController
                                                            .get_SalesCycleProductById_List[
                                                                0]
                                                            .productTotalQty
                                                            .toString())
                                                    : "",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.sisxteen,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Price: ",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.textColor,
                                                  fontSize:
                                                      AllFontSize.sisxteen,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              Text(
                                                saleCycleController
                                                        .get_SalesCycleProductById_List
                                                        .isNotEmpty
                                                    ? (saleCycleController
                                                                .get_SalesCycleProductById_List[
                                                                    0]
                                                                .productTotalAmount ==
                                                            null
                                                        ? "0"
                                                        : saleCycleController
                                                            .get_SalesCycleProductById_List[
                                                                0]
                                                            .productTotalAmount
                                                            .toString())
                                                    : "",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.sisxteen,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ));
                  }),
                  Obx(() {
                    return Visibility(
                      visible: saleCycleController
                                  .saleCycleList[0].salesCycleStatus!
                                  .toUpperCase() ==
                              "PROPOSE"
                          ? true
                          : false,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Visibility(
                                visible: saleCycleController
                                    .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase(),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        bindQuoteSubmitted(context),
                                        bindIsCommit(context)
                                        //bindConfirmDecisionDate(context)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        bindConfirmExpectedRevenue(context),
                                        Visibility(
                                          visible: saleCycleController
                                              .saleCycleList[0]
                                              .isReadySendForApproval ==
                                              0 || saleCycleController
                                                          .saleCycleList[0]
                                                          .quoteAccepted
                                                          ?.toUpperCase() !=
                                                      "OPEN" ||
                                                  saleCycleController
                                                          .FromPage.value ==
                                                      "FromDashboard"
                                              ? false
                                              : true,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 5, 15, 10),
                                            width: size.width / 2,
                                            child: IgnorePointer(
                                              ignoring: (saleCycleController
                                                          .saleCycleList[0]
                                                          .isReadySendForApproval ==
                                                      0)
                                                  ? true
                                                  : false,
                                              /* ignoring: (saleCycleController
                                                      .saleCycleList[0].quoteAccepted
                                                      ?.toUpperCase() == "LOSS") ||
                                                      (saleCycleController
                                                          .saleCycleList[0]
                                                          .isReadySendForApproval == 0 &&
                                                          (saleCycleController.FromPage
                                                              .value == 'FromTaskScreen'
                                                          )) ||
                                                      saleCycleController.FromPage
                                                          .value == 'Task' ||
                                                      saleCycleController.FromPage
                                                          .value == 'FromTaskScreen'
                                                      ? true
                                                      : false,*/
                                              child: DefaultButton(
                                                press: () {
                                                  showProposeConfirmationDialog(
                                                      context,
                                                      saleCycleController
                                                              .saleCycleList[0]
                                                              .salesCycleId ??
                                                          "");
                                                },
                                                text: "Save",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Quote List",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.eighteen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialogForFilter(context);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Icon(
                                              Icons.filter_alt_rounded,
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
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Visibility(
                                        visible:  saleCycleController
                                            .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase() &&
                                                saleCycleController
                                                        .saleCycleList[0]
                                                        .quoteAccepted
                                                        ?.toUpperCase() ==
                                                    "OPEN" &&
                                                !(saleCycleController
                                                        .FromPage.value ==
                                                    "FromDashboard")
                                            ? true
                                            : false,
                                        child: GestureDetector(
                                          onTap: () {
                                            saleCycleController
                                                .clearAllFieldOfQuoteFilter();
                                            saleCycleController.contactCode
                                                .value = saleCycleController
                                                    .saleCycleList[0]
                                                    .contactCode ??
                                                "";
                                            saleCycleController.accountCode
                                                .value = saleCycleController
                                                    .saleCycleList[0]
                                                    .accountCode ??
                                                "";
                                            saleCycleController
                                                .accountNameController
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .accountName ??
                                                "";
                                            saleCycleController
                                                .contactNameController
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .contactName ??
                                                "";
                                            saleCycleController
                                                .ApprovalStatusController
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .salesCycleApprovalStatus ??
                                                "";
                                            saleCycleController
                                                .expectedClosuredateController
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .estClosureDate ??
                                                "";
                                            saleCycleController
                                                .contactQuoteCommitController
                                                .value
                                                .text = "No";
                                            saleCycleController
                                                .selectedItem.value = -1;
                                            saleCycleController
                                                .shippingController
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingAddress ??
                                                "";
                                            saleCycleController
                                                .shippingAddress2Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingAddress2 ??
                                                "";
                                            saleCycleController
                                                .Shipping_PostCode_Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingPostCode ??
                                                "";
                                            saleCycleController
                                                .Shipping_City_Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingCity ??
                                                "";
                                            saleCycleController
                                                .Shipping_District_Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingDistrict ??
                                                "";
                                            saleCycleController
                                                .Shipping_State_Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingStateName ??
                                                "";
                                            saleCycleController
                                                .Shipping_phone_Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingPhoneNo ??
                                                "";
                                            saleCycleController
                                                .Shipping_email_Controller
                                                .value
                                                .text = saleCycleController
                                                    .saleCycleList[0]
                                                    .shippingEmailId ??
                                                "";
                                            saleCycleController
                                                .itemCategorySelectedlist
                                                .value = [];
                                            saleCycleController
                                                .getItemCategoryMstApi(
                                                    saleCycleController
                                                        .saleCycleList[0]
                                                        .salesCycleId!,
                                                    saleCycleController
                                                        .saleCycleList[0]
                                                        .taskId!);
                                            Get.toNamed(RoutesName
                                                .salesCycleCreateQuoteScreen);
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.add,
                                                color: AllColors.primaryDark1,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: AllColors
                                                        .primaryDark1)),
                                          ),
                                        ),
                                      ),
                                    ],
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
                            //SizedBox(height: 10,),
                            Obx(() {
                              return bindQuoteData(context);
                            }),
                          ],
                        ),
                      ),
                    );
                  })
                ]),
              ),
              Obx(() {
                return Visibility(
                    visible: ( saleCycleController
                        .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase() &&
                                (saleCycleController
                                        .saleCycleList[0].salesCycleStatus!
                                        .toLowerCase() ==
                                    "prospect")) &&
                            saleCycleController.saleCycleList[0].quoteAccepted
                                    ?.toUpperCase() !=
                                "LOSS" &&
                            !(saleCycleController.FromPage.value ==
                                "FromDashboard")
                        ? true
                        : false,
                    child: Stack(
                      children: [
                        Obx(() {
                          return Visibility(
                            visible: ((saleCycleController.saleCycleList[0]
                                                .actualSalesCycleApprovalStatus
                                                ?.toLowerCase() ==
                                            "pending") &&
                                        (saleCycleController.saleCycleList[0]
                                                .isReadySendForApproval ==
                                            1) &&
                                        (saleCycleController
                                                .ischangeNeedIdentity.value &&
                                            saleCycleController
                                                .ischangesolutionAccepted
                                                .value)) &&
                                    saleCycleController.filter.value ==
                                        'Solution Accepted'
                                ? true
                                : false,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AllColors.primaryDark1,
                                  ),
                                ),
                                onPressed: () {
                                  saleCycleController.purchaseProcessController
                                      .value.text = "";
                                  saleCycleController
                                      .solutionRejectedRemarkController
                                      .value
                                      .text = "";
                                  saleCycleController
                                      .getSalesCycleMstUpdateProposedSolution(
                                          saleCycleController.saleCycleList[0],
                                          "Approved");
                                  /* saleCycleController.salesCycleMstUpdateApiHit(
                                    saleCycleController.saleCycleList[0],
                                    saleCycleController
                                        .proposedSolutionController.value.text,
                                    "", "", "", "Approved");*/
                                },
                                child: Container(
                                  width: size.width,
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      style: GoogleFonts.poppins(
                                        color: AllColors.whiteColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return Visibility(
                            visible: /*(saleCycleController.saleCycleList[0]
                              .salesCycleStatus?.toLowerCase() == "prospect") &&*/
                                (saleCycleController
                                                .ischangeNeedIdentity.isFalse ||
                                            saleCycleController
                                                .ischangesolutionAccepted
                                                .isFalse) &&
                                        (saleCycleController.saleCycleList[0]
                                                .actualSalesCycleApprovalStatus
                                                ?.toLowerCase() !=
                                            "rejected") &&
                                        saleCycleController.filter.value ==
                                            'Solution Accepted'
                                    ? true
                                    : false,
                            /* visible:saleCycleController.saleCycleList[0].salesCycleStatus=="Prospect" &&
                 saleCycleController.ischangeNeedIdentity.value && saleCycleController.ischangesolutionAccepted.value?false:true,*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AllColors.redColor,
                                  ),
                                ),
                                onPressed: () {
                                  /*saleCycleController.salesCycleMstUpdateApiHit(
                                    saleCycleController.saleCycleList[0],
                                    "", "", "", "", "Rejected");*/
                                  saleCycleController
                                      .getSalesCycleMstUpdateProposedSolution(
                                          saleCycleController.saleCycleList[0],
                                          "Rejected");
                                },
                                child: Container(
                                  width: size.width,
                                  child: Center(
                                    child: Text(
                                      'Reject',
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ));
              }),
              Wrap(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: (saleCycleController.saleCycleList[0]
                                      .actualSalesCycleApprovalStatus
                                      ?.toUpperCase() !=
                                  "rejected" &&
                              saleCycleController.saleCycleList[0].quoteAccepted
                                      ?.toUpperCase() !=
                                  "LOSS" &&
                              saleCycleController
                                      .saleCycleList[0].salesCycleStatus!
                                      .toUpperCase() ==
                                  "SUSPECT" &&
                              saleCycleController.saleCycleList[0]
                                      .isReadySendForApproval ==
                                  1)
                          ? true
                          : false,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: DefaultButton(
                          press: () {
                            if (saleCycleController.budgetAmountList.isEmpty ||
                                saleCycleController.budgetAmountList.length <=
                                    0) {
                              Utils.showErrorToastification("Error!",
                                  "Please add at least one product category");
                              return;
                            }

                            openConfirmationDialog(
                                context,
                                saleCycleController.saleCycleList[0],
                                "Pending For Approval",
                                "Approve");
                          },
                          text: "Send For Approval",
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: saleCycleController
                                  .saleCycleList[0].isReadyForApprove ==
                              1
                          ? true
                          : false,
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DefaultButton(
                                text: "Approve",
                                press: () {
                                  openConfirmationDialog(
                                      context,
                                      saleCycleController.saleCycleList[0],
                                      "Approved",
                                      "Approve");
                                },
                              ),
                            ),
                            SizedBox(width: size.width * .02),
                            Expanded(
                              child: DefaultButton(
                                text: "Reject",
                                press: () {
                                  openConfirmationDialog(
                                      context,
                                      saleCycleController.saleCycleList[0],
                                      "Rejected",
                                      "Reject");
                                },
                              ),
                            ),
                            // }),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ],
          )),
    );
  }

  Widget bindsaleStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: new BoxDecoration(
                    color: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "SUSPECT"
                        ? Colors.lightBlue
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "1",
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: AllFontSize.ten,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Suspect",
                  style: GoogleFonts.poppins(
                    color: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "SUSPECT"
                        ? AllColors.primaryDark1
                        : Colors.blueGrey,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: size.width * .09,
                  height: 1,
                  color: AllColors.lightgreyColor,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: new BoxDecoration(
                    color: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "PROSPECT"
                        ? Colors.lightBlue
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "2",
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: AllFontSize.ten,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Prospect",
                  style: GoogleFonts.poppins(
                    color: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "PROSPECT"
                        ? AllColors.primaryDark1
                        : Colors.blueGrey,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: size.width * .09,
                  height: 1,
                  color: AllColors.lightgreyColor,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: new BoxDecoration(
                    color: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "PROPOSE"
                        ? Colors.lightBlue
                        : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "3",
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: AllFontSize.ten,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Propose",
                  style: GoogleFonts.poppins(
                    color: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "PROPOSE"
                        ? AllColors.primaryDark1
                        : Colors.blueGrey,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bindClosureDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: IgnorePointer(
        ignoring: saleCycleController.FromPage.value == "FromDashboard",
        child: TextField(
          cursorColor: AllColors.primaryDark1,
          /* readOnly: (saleCycleController.saleCycleList[0].quoteAccepted ==
              "LOSS" ||
              saleCycleController.saleCycleList[0].isReadySendForApproval == 0 &&
                  (saleCycleController.FromPage.value == 'Sales'
                      || saleCycleController.FromPage.value == 'FromTaskScreen' ||
                      saleCycleController.FromPage.value == 'Task'))
              || (saleCycleController.FromPage.value == 'Task') ||
              (saleCycleController.FromPage.value == 'FromTaskScreen')
              ? true
              : false,*/
          readOnly: ( saleCycleController
              .saleCycleList[0].createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase() ||
                      (saleCycleController.saleCycleList[0]
                                  .actualSalesCycleApprovalStatus
                                  ?.toLowerCase() !=
                              'pending' &&
                          saleCycleController.saleCycleList[0].salesCycleStatus
                                  ?.toLowerCase() ==
                              'suspect') ||
                      saleCycleController.saleCycleList[0].quoteAccepted
                              ?.toLowerCase() ==
                          "loss") &&
                  !(saleCycleController.FromPage.value == "FromDashboard")
              ? true
              : false,
          controller: saleCycleController.closureDateController.value,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Select Estimated Closure Date',
              labelText: 'Estimated Closure Date',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.fourtine),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          onTap: () async {
            if (saleCycleController.saleCycleList[0].quoteAccepted != "LOSS" &&
                saleCycleController.saleCycleList[0].isReadySendForApproval ==
                    1) {
              DateTime? initialDate;
              if (saleCycleController
                  .closureDateController.value.text.isNotEmpty) {
                initialDate = DateFormat('yyyy-MM-dd').parse(
                  saleCycleController.closureDateController.value.text,
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
                      primaryColor: AllColors.primaryDark1,
                      // Header background color
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
                saleCycleController.closureDateController.value.text =
                    outputFormat.format(date);
              /* else
               saleCycleController.closureDateController.value.text = "";*/
            }
          },
        ),
      ),
    );
  }

  bindBudgetAmount(BuildContext context) {
    print(
        "fgdsgh ${saleCycleController.saleCycleList[0].isReadySendForApproval} ${saleCycleController.FromPage.value}");
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
      width: size.width / 2,
      child: TextField(
        readOnly:
            (saleCycleController.saleCycleList[0].isReadySendForApproval == 0)
                ? true
                : false,
        cursorColor: AllColors.primaryDark1,
        controller: saleCycleController.budgetAmountController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Enter Budget Amount',
            labelText: 'Budget Amount',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.fourtine),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );
  }

  void openConfirmationAmtDeleteDialog(BuildContext context, int? Id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: Icon(
                  Icons.delete_forever,
                  color: AllColors.lightredColor,
                )),
                SizedBox(
                  width: 5,
                ),
                Text('Delete !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                /*height: size.height*.21,
                width: size.width*4,*/
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Do you want to delete this product category?',
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
                            saleCycleController
                                .ProductCategoryWiseAmtDeleteApiHit(Id!);
                            Get.back();
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
          );
        });
  }

  void openConfirmationDialog(BuildContext context,
      SalesCycleModal saleCycleList, String payloadMessage, String message) {
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
                Text('Confirmation !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                /*height: size.height*.21,
                width: size.width*4,*/
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Do you want to ${message} this sales cycle ?',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      color: AllColors.primaryDark1,
                    )),
                SizedBox(height: 10),
                Obx(() {
                  return Visibility(
                      visible: payloadMessage == "Rejected" ? true : false,
                      child: bindRejectreason(context));
                }),
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
                            print("message ...${payloadMessage}");
                            if (payloadMessage == "Pending For Approval") {
                              saleCycleController.salesCycleMstUpdateApiHit(
                                  saleCycleList,
                                  saleCycleController
                                      .proposedSolutionController.value.text,
                                  "",
                                  "",
                                  "",
                                  "Pending For Approval");
                            } else {
                              saleCycleController.salesCycleMstApprovereject(
                                  saleCycleList,
                                  saleCycleController
                                      .rejectReasonController.value.text,
                                  payloadMessage);
                            }
                            Get.back();
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
          );
        });
  }

  Widget bindRejectreason(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.rejectReasonController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Enter Reject Reason',
          labelText: 'Reject Reason',
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

  /*Widget bindQuoteRejectreason(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.quoteRejectReasonController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Reject Reason',
          labelText: 'Quote Reject Reason',
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
  }*/

  Widget bindQuoteSubmitted(BuildContext context) {
    return IgnorePointer(
      ignoring: saleCycleController.FromPage.value == "FromDashboard",
      child: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: DropdownMenu<String>(
          width: MediaQuery.of(context).size.width / 2 - 16,
          controller: saleCycleController.QuoteSubmittedController.value,
          label: Text(
            "Quote Submitted",
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

          //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
          enabled:
          saleCycleController
              .saleCycleList[0].isReadySendForApproval==0 ||
                      saleCycleController
                              .saleCycleList[0].actualSalesCycleApprovalStatus
                              ?.toLowerCase() ==
                          "rejected" ||
                      saleCycleController.saleCycleList[0].quoteAccepted
                              ?.toUpperCase() !=
                          "OPEN"
                  /*| | saleCycleController.FromPage != 'Sales'*/ ? false
                  : true,
          onSelected: (String? selection) {
            print(selection);

            saleCycleController.QuoteSubmittedController.value.text =
                _displayCustomerNeedIdentityStatusForOption(selection!)
                    .toString();
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
      ),
    );
  }

  /*Widget bindConfirmDecisionDate(BuildContext context) {
    return IgnorePointer(
      ignoring: saleCycleController.FromPage.value=="FromDashboard",
      child: Container(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: DropdownMenu<String>(
          width: MediaQuery
              .of(context)
              .size
              .width / 2 - 16,
          controller: saleCycleController.ConfirmDecisionDateController.value,
          label: Text(
            "Confirm Decision Date",
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w700),
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

          //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
          enabled: saleCycleController.saleCycleList[0].approvedBy
              ?.toLowerCase() == saleCycleController.email.toLowerCase() ||
              saleCycleController.saleCycleList[0].actualSalesCycleApprovalStatus
                  ?.toLowerCase() == "rejected" ||
              saleCycleController.saleCycleList[0].quoteAccepted?.toUpperCase() ==
                  "LOSS"
             */ /* || saleCycleController.FromPage != 'Sales'*/ /* ? false : true,
          onSelected: (String? selection) {
            print(selection);

            saleCycleController.ConfirmDecisionDateController.value.text =
                _displayCustomerNeedIdentityStatusForOption(selection!)
                    .toString();

          },

          dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<
              DropdownMenuEntry<String>>((String e) {
            return DropdownMenuEntry<String>(
                value: e, label: e!, style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  AllColors.primaryDark1),));
          }).toList(),
        ),
      ),
    );
  }*/

  Widget bindIsCommit(BuildContext context) {
    return IgnorePointer(
      ignoring: saleCycleController.FromPage.value == "FromDashboard",
      child: Container(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: DropdownMenu<String>(
          width: MediaQuery.of(context).size.width / 2 - 16,
          controller: saleCycleController.isCommitController.value,
          label: Text(
            "Is Commit",
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

          //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
          enabled:
          saleCycleController
              .saleCycleList[0].isReadySendForApproval==0 ||
                      saleCycleController
                              .saleCycleList[0].actualSalesCycleApprovalStatus
                              ?.toLowerCase() ==
                          "rejected" ||
                      saleCycleController.saleCycleList[0].quoteAccepted
                              ?.toUpperCase() !=
                          "OPEN"
                  ? false
                  : true,
          onSelected: (String? selection) {
            print(selection);
            saleCycleController.isCommitController.value.text =
                _displayCustomerNeedIdentityStatusForOption(selection!)
                    .toString();
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
      ),
    );
  }

  Widget bindConfirmExpectedRevenue(BuildContext context) {
    return IgnorePointer(
      ignoring: saleCycleController.FromPage.value == "FromDashboard",
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          bottom: 10,
        ),
        child: DropdownMenu<String>(
          width: saleCycleController.saleCycleList[0].quoteAccepted
                          ?.toUpperCase() !=
                      "OPEN" ||
              saleCycleController.FromPage.value == "FromDashboard"
              || saleCycleController.saleCycleList[0].isReadySendForApproval==0
          ? size.width - 20
              : size.width / 2 - 16,
          controller:
              saleCycleController.ConfirmExpectedRevenueController.value,
          label: Text(
            "Confirm Expected Revenue",
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

          //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
          enabled:
          saleCycleController
              .saleCycleList[0].isReadySendForApproval==0 ||
                      saleCycleController
                              .saleCycleList[0].actualSalesCycleApprovalStatus
                              ?.toLowerCase() ==
                          "rejected" ||
                      saleCycleController.saleCycleList[0].quoteAccepted
                              ?.toUpperCase() !=
                          "OPEN"
                  /*|| saleCycleController.FromPage != 'Sales'*/ ? false
                  : true,
          onSelected: (String? selection) {
            print(selection);

            saleCycleController.ConfirmExpectedRevenueController.value.text =
                _displayCustomerNeedIdentityStatusForOption(selection!)
                    .toString();
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
      ),
    );
  }

  showProposeConfirmationDialog(context, String SalesId) {
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
                Text('Send!',
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
                  Text('Do you want to want to save Details ?',
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
                          Get.back();
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
                          saleCycleController
                              .UpdateProposeConfirmDecisionApiHit(SalesId);
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

  Widget bindCustomerNeedIdentity(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width / 2 - 16,
        controller: saleCycleController.customerNeedIdetityController.value,
        label: Text(
          "Customer Need Identity",
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

        //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
        enabled:
            ( saleCycleController.saleCycleList[0]
                .createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase() ||
                        saleCycleController
                                .saleCycleList[0].actualSalesCycleApprovalStatus
                                ?.toLowerCase() ==
                            "rejected" ||
                        saleCycleController.saleCycleList[0].quoteAccepted
                                ?.toUpperCase() !=
                            "OPEN") ||
                    (saleCycleController.FromPage.value == "FromDashboard")
                /* || saleCycleController.FromPage != 'Sales'*/ ? false
                : true,
        onSelected: (String? selection) {
          print(selection);

          saleCycleController.customerNeedIdetityController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!)
                  .toString();
          print(
              'IsActive.....${saleCycleController.customerNeedIdetityController.value.text}');
          if (saleCycleController.customerNeedIdetityController.value.text ==
              "Yes") {
            print(
                'IsActive.....${saleCycleController.customerNeedIdetityController.value.text}');
            saleCycleController.ischangeNeedIdentity.value = true;
          } else {
            saleCycleController.ischangeNeedIdentity.value = false;
          }
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

  Widget bindSolutionAccepted(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width * .94 / 2 - 30,
        controller: saleCycleController.solutionAcceptedController.value,
        label: Text(
          "Solution Accepted",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
        //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
        enabled:
            ( saleCycleController.saleCycleList[0]
                .createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase()||
                        saleCycleController
                                .saleCycleList[0].actualSalesCycleApprovalStatus
                                ?.toLowerCase() ==
                            "rejected" ||
                        saleCycleController.saleCycleList[0].quoteAccepted
                                ?.toUpperCase() ==
                            "LOSS") ||
                    (saleCycleController.FromPage.value == "FromDashboard")
                /*|| saleCycleController.FromPage != 'Sales'*/ ? false
                : true,
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.solutionAcceptedController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!)
                  .toString();
          print(
              'IsActive.....${saleCycleController.solutionAcceptedController.value.text}');
          if (saleCycleController.solutionAcceptedController.value.text ==
              "Yes") {
            saleCycleController.ischangesolutionAccepted.value = true;
          } else {
            saleCycleController.ischangesolutionAccepted.value = false;
          }
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

/*  Widget BindProposedSolution(BuildContext context) {
    print("");
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
      child: TextField(
        //readOnly: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?true:false,
        readOnly: (saleCycleController.saleCycleList[0].approvedBy
            ?.toLowerCase() == saleCycleController.email.toLowerCase() ||
            saleCycleController.saleCycleList[0].actualSalesCycleApprovalStatus
                ?.toLowerCase() == "rejected" ||
            saleCycleController.saleCycleList[0].quoteAccepted?.toUpperCase() ==
                "LOSS" ) || (saleCycleController.FromPage.value=="FromDashboard")? true : false,
        cursorColor: AllColors.primaryDark1,
        controller: saleCycleController.proposedSolutionController.value,
        maxLength: 500,
        maxLines: 2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
            hintText: 'Proposed Solution',
            labelText: 'Proposed Solution',
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
            )
        ),
      ),
    );
  }*/

  Widget BindSalesData(BuildContext context) {
    String? dateTimeCreatedOn = StaticMethod.dateTimeToDate(
        saleCycleController.saleCycleList[0].createdOn ?? "");
    String? dateTimeApprovedOn = StaticMethod.dateTimeToDate(
        saleCycleController.saleCycleList[0].approvedOn ?? "");
    String? expClosureDate = StaticMethod.convertDateFormat1(
        saleCycleController.saleCycleList[0].estClosureDate ?? "");
    String saleCycleStatus =
        saleCycleController.saleCycleList[0].salesCycleApprovalStatus ?? "";
    Color getStatusColor(String status) {
      switch (status) {
        case 'PENDING' || 'Pending':
          return Colors.red[900]!;
        case 'Rejected' || 'rejected':
          return AllColors.redColor;
        case 'APPROVED' || 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL' || 'Pending For Approval':
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
                labelText: 'Sales Details',
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
                    children: [
                      Text(
                        "Task ID",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      /*InkWell(
                        onTap: () {
                          accountMaster_page_controller.view = 'Sales';
                          TaskMaster_page_controller.getTaskMaster(
                              0,
                              TaskMaster_page_controller.is_Active.toString(),
                              saleCycleController.saleCycleList[0].taskId,
                              '',
                              'GET FROM TASK ID',
                              TaskMaster_page_controller.date_filter,
                              TaskMaster_page_controller.is_done.value);
                          Get.toNamed(RoutesName.taskMasterDetails_screen);
                        },
                        child:
                        Text(
                          saleCycleController.saleCycleList[0].taskId ?? "",
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ),*/
                      Text(
                        saleCycleController.saleCycleList[0].taskId ?? "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          //decorationStyle: TextDecorationStyle.wavy,
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
                        "Account Name",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        child: Container(
                          width: size.width * .4,
                          child: Tooltip(
                            message: saleCycleController
                                    .saleCycleList[0].accountName ??
                                "",
                            child: Text(
                              saleCycleController
                                      .saleCycleList[0].accountName ??
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
                          accountMaster_page_controller.view =
                              'FromSaleDetailsScreen';
                          contact_vm_controller.view = 'FromSaleDetailsScreen';

                          accountMaster_page_controller.getAccMasterBuyCodeApi(
                              saleCycleController
                                  .saleCycleList[0].accountCode!);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        'Contact Name',
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
                                  .saleCycleList[0].contactName ??
                              "",
                          child: Text(
                            saleCycleController.saleCycleList[0].contactName ??
                                "",
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
                    children: [
                      Text(
                        "Product Category",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            width: size.width * .4,
                            child: Tooltip(
                              message: saleCycleController
                                      .saleCycleList[0].productCategory ??
                                  "",
                              child: Text(
                                saleCycleController
                                    .saleCycleList[0].productCategory!,
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
                          SizedBox(
                            width: 2,
                          ),
                          Visibility(
                            visible: saleCycleController.FromPage.value ==
                                        "FromDashboard" ||
                                saleCycleController
                                    .saleCycleList[0].isReadySendForApproval==0 ||
                                    saleCycleController
                                            .saleCycleList[0].quoteAccepted
                                            ?.toLowerCase() !=
                                        'open' ||
                                    saleCycleController.saleCycleList[0]
                                            .actualSalesCycleApprovalStatus
                                            ?.toLowerCase() ==
                                        'rejected'
                                ? false
                                : true,
                            child: InkWell(
                                onTap: () {
                                  saleCycleController
                                      .itemCategorySelectedlist.value = [];
                                  for (int i = 0;
                                      i <
                                          saleCycleController
                                              .productCategoryList.length;
                                      i++) {
                                    if (saleCycleController
                                            .productCategoryList[i]
                                            .isSelected ==
                                        1) {
                                      saleCycleController
                                          .itemCategorySelectedlist
                                          .add(saleCycleController
                                              .productCategoryList[i]);
                                      //TaskMaster_page_controller.Item_Category_code_list.add(TaskMaster_page_controller.Item_Category_master_list[i].categoryCode!);

                                      print(
                                          'LIstSIze.....${saleCycleController.itemCategorySelectedlist.length}');
                                    } else {
                                      print('NoLIstSIze.....');
                                    }
                                  }
                                  saleCycleController
                                      .productCategoryController.value
                                      .clear();
                                  showProductCatDialog(context);
                                },
                                child: Icon(Icons.add)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Sales Cycle Stage",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.saleCycleList[0].salesCycleStatus ??
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
                    children: [
                      Text(
                        "Sale Cycle Approval Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * .29,
                        child: Tooltip(
                          message: saleCycleController
                                  .saleCycleList[0].salesCycleApprovalStatus ??
                              "",
                          child: Text(
                            saleCycleController.saleCycleList[0]
                                    .salesCycleApprovalStatus ??
                                "",
                            style: GoogleFonts.poppins(
                              color: getStatusColor(saleCycleStatus),
                              /*  color: saleCycleController
                                  .saleCycleList[0]
                                  .salesCycleApprovalStatus
                                  ?.toLowerCase() == "rejected" ? AllColors
                                  .redColor : AllColors.textColor,*/
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        "Sales Cycle Remarks",
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
                                  .saleCycleList[0].salesCycleRemarks ??
                              "",
                          child: Text(
                            saleCycleController
                                    .saleCycleList[0].salesCycleRemarks ??
                                "",
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
                                  .saleCycleList[0].createdFullName ??
                              "",
                          child: Text(
                            saleCycleController
                                    .saleCycleList[0].createdFullName ??
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
                    children: [
                      Text(
                        "Created on",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
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
                  Row(
                    children: [
                      Text(
                        "Sales Cycle Owner",
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
                                  .saleCycleList[0].salesCycleOwnerName ??
                              "",
                          child: Text(
                            saleCycleController
                                    .saleCycleList[0].salesCycleOwnerName ??
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
                    children: [
                      Text(
                        "Manager Name",
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
                                    .saleCycleList[0].approvedFullName ??
                                '',
                            child: Text(
                              saleCycleController
                                      .saleCycleList[0].approvedFullName ??
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
                        "Approved On",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        dateTimeApprovedOn.toString(),
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
                        "Reject Reason",
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
                              .saleCycleList[0].rejectReason!
                              .toString(),
                          child: Text(
                            saleCycleController.saleCycleList[0].rejectReason ??
                                "",
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        "Budget Amount",
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
                              .saleCycleList[0].budgetAmount
                              .toString(),
                          child: Text(
                            saleCycleController.saleCycleList[0].budgetAmount
                                .toString(),
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
                    children: [
                      Text(
                        "Expected Amount",
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
                          message: saleCycleController.budgetAmountList.isEmpty
                              ? saleCycleController
                                  .saleCycleList[0].estBudgetAmount!
                                  .toString()
                              : saleCycleController
                                  .budgetAmountList[0].totalEstimatedAmount,
                          child: Text(
                            saleCycleController.budgetAmountList.isEmpty
                                ? saleCycleController
                                    .saleCycleList[0].estBudgetAmount!
                                    .toString()
                                : saleCycleController.budgetAmountList[0]
                                        .totalEstimatedAmount ??
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
                    children: [
                      Text(
                        "Est. Closure Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        expClosureDate.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  /* SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "No. of Quotation",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                            .saleCycleList[0]
                            .noOfQuotation.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Identify Decision Maker",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.saleCycleList[0].isDecisionMaker ==
                                0
                            ? 'No'
                            : 'Yes',
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
                        "Purchase Process",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.saleCycleList[0].purchaseProcess ==
                                null
                            ? ""
                            : saleCycleController
                                .saleCycleList[0].purchaseProcess
                                .toString(),
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
                        "Purchase Time Frame",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                                    .saleCycleList[0].purchaseTimeFrame ==
                                null
                            ? " "
                            : saleCycleController
                                .saleCycleList[0].purchaseTimeFrame
                                .toString(),
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
                        "Sales Cycle Commit",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.saleCycleList[0].commit == 0
                            ? 'No'
                            : 'Yes',
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

                  Visibility(
                    // visible: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT" || saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"?true:false,
                    visible: true,
                    child: Row(
                      children: [
                        Text(
                          "Product Category Amt.",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            ShowProductCategoryTable(
                                context, saleCycleController.budgetAmountList);
                            //showInfraLeadDetails(context, saleCycleController.saleCycleList);
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
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Visibility(
                    visible: saleCycleController
                                .saleCycleList[0].salesCycleStatus!
                                .toUpperCase() ==
                            "PROPOSE"
                        ? true
                        : false,
                    child: Row(
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
                            saleCycleController
                                .clearSaleProductListController();
                            saleCycleController.pageNumber = 0;
                            saleCycleController.getSaleCycleProductByIdList(
                                saleCycleController.pageNumber,
                                saleCycleController
                                    .saleCycleList[0].salesCycleId!);
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
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Customer Need Identity",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                                    .saleCycleList[0].isCustomerNeedIdentify ==
                                0
                            ? "No"
                            : "Yes",
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
                        "Solution Accepted",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                                    .saleCycleList[0].isSolutionAccepted ==
                                0
                            ? "No"
                            : "Yes",
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
                  //todo commited by nirupma Proposed solution
                  /* Row(
                    children: [
                      Text(
                        "Proposed Solution",
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
                              .saleCycleList[0]
                              .proposedSolution.toString(),
                          child: Text(saleCycleController
                              .saleCycleList[0]
                              .proposedSolution == null ? "" :
                          saleCycleController
                              .saleCycleList[0]
                              .proposedSolution.toString(),
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 3,
                  ),*/

                  Row(
                    children: [
                      Text(
                        "Quote Accepted",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          saleCycleController.quoteWonList.length > 0
                              ? ShowQuoteWon(context)
                              : "";
                        },
                        child: Container(
                          width: size.width * .4,
                          child: Tooltip(
                            message: saleCycleController
                                    .saleCycleList[0].quoteAccepted ??
                                "",
                            child: Text(
                              saleCycleController
                                      .saleCycleList[0].quoteAccepted ??
                                  "",
                              style: GoogleFonts.poppins(
                                color: saleCycleController
                                            .saleCycleList[0].quoteAccepted
                                            ?.toLowerCase() ==
                                        "loss"
                                    ? AllColors.redColor
                                    : Colors.blueAccent,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Visibility(
                    visible:
                        saleCycleController.saleCycleList[0].salesCycleStatus ==
                                'Propose'
                            ? true
                            : false,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Quote Submitted",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleController
                                          .saleCycleList[0].quoteSubmitted ==
                                      1
                                  ? 'Yes'
                                  : 'No',
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        /* Row(
                          children: [
                            Text(
                              "Confirm Decision Date",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(saleCycleController
                                .saleCycleList[0]
                                .confirmDecisionDate == 1?'Yes':'No',
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),*/
                        Row(
                          children: [
                            Text(
                              "Confirm Expected Revenue",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleController.saleCycleList[0]
                                          .confirmExpectedRevenue ==
                                      1
                                  ? 'Yes'
                                  : 'No',
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "Competitor Name",
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
                              .saleCycleList[0].competitorName
                              .toString(),
                          child: Text(
                            saleCycleController
                                        .saleCycleList[0].competitorName ==
                                    null
                                ? ""
                                : saleCycleController
                                    .saleCycleList[0].competitorName
                                    .toString(),
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        "Quote Reject Reason",
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
                              .saleCycleList[0].quoteRejectedReason
                              .toString(),
                          child: Text(
                            saleCycleController
                                        .saleCycleList[0].quoteRejectedReason ==
                                    null
                                ? ""
                                : saleCycleController
                                    .saleCycleList[0].quoteRejectedReason
                                    .toString(),
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  /* Obx((){
                    return Visibility(
                      visible: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT" || saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"?true:false,
                        child:
                        SizedBox(
                          height: 3,
                        ),);
                  }),*/

               /*   Row(
                    children: [
                      Text(
                        "Is Infra Lead",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          //todo comment infra lead details dialog
*//*showInfraLeadDetails(
                              context, saleCycleController.saleCycleList);*//*
                          *//*TaskMaster_page_controller.userRegionUpdateController.text=saleCycleController.saleCycleList[0].userRegion??"";
                          TaskMaster_page_controller.userClusterUpdateController.text=saleCycleController.saleCycleList[0].userClusture??"";*//*

                          for (int i = 0;
                              i <
                                  TaskMaster_page_controller
                                      .userGeoHierarchyy.length;
                              i++) {
                            if (TaskMaster_page_controller
                                    .userGeoHierarchyy[i].myLevel ==
                                1) {
                              TaskMaster_page_controller
                                      .userRegionUpdateController.text =
                                  TaskMaster_page_controller
                                      .userGeoHierarchyy[i - 1].geoValue!;
                              TaskMaster_page_controller
                                      .userClusterUpdateController.text =
                                  TaskMaster_page_controller
                                      .userGeoHierarchyy[i - 2].geoValue!;
                            }
                          }
                          print(
                              "userRegion...${TaskMaster_page_controller.userRegionUpdateController.text}...usercluster..${TaskMaster_page_controller.userClusterUpdateController.text}");
                          if (saleCycleController
                                  .saleCycleList[0].isInfraLead ==
                              1) {
                            TaskMaster_page_controller.isInfraYes.value = true;
                            TaskMaster_page_controller
                                .isInfraLeadUpdateController.value.text = "Yes";
                            //TaskMaster_page_controller.viewAllDetailsOfTaskUpdateInfra();
                          } else {
                            TaskMaster_page_controller.isInfraYes.value = false;
                            TaskMaster_page_controller
                                .isInfraLeadUpdateController.value.text = "No";
                          }
                          TaskMaster_page_controller.getItemCategoryMstApiHit(
                              saleCycleController.saleCycleList[0].taskId,
                              saleCycleController.saleCycleList[0].infraLeadNo,
                              saleCycleController
                                  .saleCycleList[0].salesCycleId!);
                          Get.toNamed(RoutesName.updateTaskMstInfraScreen);
                        },
                        child: Text(
                          saleCycleController.saleCycleList[0].isInfraLead == 1
                              ? "Yes"
                              : "No",
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
                  SizedBox(
                    height: 3,
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bindSalesCycleProductData(BuildContext context, String flag) {
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
        },*/
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
                    "open",
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

            /* Text(
              saleCycleController
                  .get_SalesCycleProductById_List[index]
                  .itemCode ?? "",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),*/
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
        ),*/
      ),
    );
  }

  Widget bindQuoteData(BuildContext context) {
    print("Lengh${saleCycleController.quoteList.value.length}");
    if (saleCycleController.quoteList.value.isNotEmpty &&
        saleCycleController.quoteList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          int total_page =
              (saleCycleController.total_rows / saleCycleController.rowsPerPage)
                  .toInt();
          if ((saleCycleController.total_rows %
                  saleCycleController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${saleCycleController.pageNumberForQuote} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
          if (saleCycleController.pageNumberForQuote + 1 < total_page) {
            saleCycleController.getQuoteHeaderData(
                saleCycleController.pageNumberForQuote + 1,
                saleCycleController.saleCycleList[0].salesCycleId!,
                '');
            saleCycleController.pageNumberForQuote += 1;
          }
        }
      });
      return Obx(
        () {
          return Container(
            height: size.height / 2,
            child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.only(bottom: 10),
                separatorBuilder: (context, index) => Divider(
                      height: .05,
                      color: Colors.transparent,
                    ),
                shrinkWrap: true,
                itemCount: saleCycleController.quoteList.value.length,
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
    String? expClosureDate = StaticMethod.convertDateFormat1(
        saleCycleController.quoteList[index].expClosureDate ?? "");
    String? quoteValidity = StaticMethod.convertDateFormat1(
        saleCycleController.quoteList[index].quoteValidity ?? "");
    String saleCycleStatus =
        saleCycleController.quoteList[index].quoteStatus ?? "";
    Color getStatusColor(String status) {
      switch (status) {
        case 'DRAFT' || "Draft":
          return Colors.red[900]!;
        case 'REGRET' || 'Regret':
          return Colors.red;
        case 'Rejected':
          return Colors.red;
        case 'Approved':
          return Colors.green;
        case 'WON':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }

    String? dateCreatedOn = StaticMethod.dateTimeToDate(
        saleCycleController.quoteList[index].createdOn ?? "");
    return Card(
      //margin: EdgeInsets.all(5),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Quote Id : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].quoteId ?? "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: saleCycleController.saleCycleList[0].quoteAccepted
                      ?.toUpperCase() ==
                      "LOSS"
                      ? false
                      : true,
                  child: Container(
                    child: Visibility(
                      visible: saleCycleController
                          .saleCycleList[0].isReadySendForApproval ==
                          1 &&
                          saleCycleController
                              .saleCycleList[0].isSalesCycleClosed !=
                              1
                          ? true
                          : false,
                      child: InkWell(
                          onTap: () {
                            showConfirmationDialog(context,
                                saleCycleController.quoteList[index].quoteId ?? "");
                          },
                          child: Icon(
                            Icons.add_chart,
                            color: Colors.blueAccent,
                            size: 30,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      saleCycleController.quoteId.value =
                      saleCycleController.quoteList[index].quoteId!;
                      saleCycleController.getQuoteHeaderInformation(
                          saleCycleController.quoteList[index].quoteId, "");
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.blueAccent,
                      size: 30,
                    )),
              ],
            ),

          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quote Version : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (saleCycleController.quoteList[index].quoteVersion
                      .toString()),
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
                  "Product Category : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  //width: size.width * .4,
                  child: Tooltip(
                    message:
                        saleCycleController.quoteList[index].productCategory ??
                            "",
                    child: Text(
                      saleCycleController.quoteList[index].productCategory ??
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
                  "Quote Status : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].quoteStatus ?? "",
                  style: GoogleFonts.poppins(
                    color: getStatusColor(saleCycleStatus),
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
                  "Quote Validity : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  quoteValidity.toString(),
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
                  "Exp Closure Date : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  expClosureDate.toString(),
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
                  "Quote Total Amount : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].quoteTotalAmount
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
                  "Quote GST Amount : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].quoteGstAmount
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
                  "Quote Gross Amount : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].quoteGrossAmount
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
                  "Account Code : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].accountCode ?? "",
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
                  "Account Name : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  //width: size.width * .4,
                  child: Tooltip(
                    message:
                        saleCycleController.quoteList[index].accountName ?? "",
                    child: Text(
                      saleCycleController.quoteList[index].accountName ?? "",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "RH approval : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                /*Text(
                  saleCycleController
                      .quoteList[index]
                      .rh??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CBH Approval: ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                /* Text(
                  saleCycleController
                      .quoteList[index]
                      .accountName??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category Approval: ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                /*Text(
                  saleCycleController
                      .quoteList[index]
                      .accountName??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gm Approval : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                /*Text(
                  saleCycleController
                      .quoteList[index]
                      ??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
              ],
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "FrontLiner value : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                 // width: size.width * .4,
                  child: Tooltip(
                    message:
                        saleCycleController.quoteList[index].frontlinerValue ??
                            "",
                    child: Text(
                      saleCycleController.quoteList[index].frontlinerValue ??
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
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Region Name : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  //width: size.width * .4,
                  child: Tooltip(
                    message:
                        saleCycleController.quoteList[index].branchHeadValue ??
                            "",
                    child: Text(
                      saleCycleController.quoteList[index].branchHeadValue ??
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
         /*   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Zone Head value : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                 // width: size.width * .4,
                  child: Tooltip(
                    message:
                        saleCycleController.quoteList[index].zoneHeadValue ??
                            "",
                    child: Text(
                      saleCycleController.quoteList[index].zoneHeadValue ?? "",
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
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Clusture Name : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  //width: size.width * .4,
                  child: Tooltip(
                    message: saleCycleController
                            .quoteList[index].clustureHeadValue ??
                        "",
                    child: Text(
                      saleCycleController.quoteList[index].clustureHeadValue ??
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
                  "Created By :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController.quoteList[index].createdFullName ?? "",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Is Active : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  saleCycleController.quoteList[index].isActive == 0
                      ? "No"
                      : "Yes",
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
       /* trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: saleCycleController.saleCycleList[0].quoteAccepted
                          ?.toUpperCase() ==
                      "LOSS"
                  ? false
                  : true,
              child: Container(
                child: Visibility(
                  visible: saleCycleController
                                  .saleCycleList[0].isReadySendForApproval ==
                              1 &&
                          saleCycleController
                                  .saleCycleList[0].isSalesCycleClosed !=
                              1
                      ? true
                      : false,
                  child: InkWell(
                      onTap: () {
                        showConfirmationDialog(context,
                            saleCycleController.quoteList[index].quoteId ?? "");
                      },
                      child: Icon(
                        Icons.add_chart,
                        color: Colors.blueAccent,
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  saleCycleController.quoteId.value =
                      saleCycleController.quoteList[index].quoteId!;
                  saleCycleController.getQuoteHeaderInformation(
                      saleCycleController.quoteList[index].quoteId, "");
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.blueAccent,
                )),
          ],
        ),*/
      ),
    );
  }

  Widget bindQuoteWonData(BuildContext context) {
    print("Lengh${saleCycleController.quoteWonList.value.length}");
    if (saleCycleController.quoteWonList.value.isNotEmpty &&
        saleCycleController.quoteWonList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      /*scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (saleCycleController.total_rows /
              saleCycleController.rowsPerPage)
              .toInt();
          if ((saleCycleController.total_rows %
              saleCycleController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${saleCycleController.pageNumberForQuote} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
          if (saleCycleController.pageNumberForQuote + 1 < total_page) {
            //saleCycleController.getQuoteWonData(pageNumberForQuote,saleCycleList[0].salesCycleId!);
            saleCycleController.getQuoteWonData(saleCycleController.pageNumberForQuote + 1,saleCycleController.salesCycleId.value);
            saleCycleController.pageNumberForQuote += 1;
          }
        }
      });*/
      return Obx(
        () {
          return Container(
            height: size.height / 2,
            child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.only(bottom: 10),
                separatorBuilder: (context, index) => Divider(
                      height: .05,
                      color: Colors.transparent,
                    ),
                shrinkWrap: true,
                itemCount: saleCycleController.quoteWonList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return bindQuoteWonListView(context, index);
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

  Widget bindQuoteWonListView(BuildContext context, int index) {
    // String? expClosureDate=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].expClosureDate ?? "");
    //String? quoteValidity=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].quoteValidity ?? "");
    //String saleCycleStatus = saleCycleController.quoteList[index].quoteStatus??"";
    /*Color getStatusColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.yellow[700]!;
        case 'WON':
          return Colors.red;
        case 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }*/
    // String? dateCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteList[index].createdOn??"");
    return Card(
      //margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          saleCycleController.quoteId.value =
              saleCycleController.quoteList[index].quoteId!;
          saleCycleController.getQuoteHeaderInformation(
              saleCycleController.quoteList[index].quoteId, "");
        },
        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title: Row(
          children: [
            Text(
              "Quote Id : ",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              saleCycleController.quoteWonList[index].quoteId ?? "",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        /*subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Quote Version : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (saleCycleController
                      .quoteList[index]
                      .quoteVersion.toString()) ,
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
                  "Product Category : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  width: size.width*.4,
                  child: Tooltip(
                    message:  saleCycleController
                        .quoteList[index]
                        .productCategory ?? "",
                    child: Text(
                      saleCycleController
                          .quoteList[index]
                          .productCategory ??"",
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

              children: [
                Text(
                  "Quote Status : ",
                  style: GoogleFonts.poppins(
                    color:AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteStatus??"",
                  style: GoogleFonts.poppins(
                    color: getStatusColor(saleCycleStatus),
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Validity : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  quoteValidity.toString(),
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
                       "Contact Person Name : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .contactName??"",
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
                  "Expected Closure Date : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  expClosureDate.toString(),
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
                  "Quote Total Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteTotalAmount.toString()??"",
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
                  "Quote Gross Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteGrossAmount.toString()??"",
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
                  "Quote Gross Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteGrossAmount.toString()??"",
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
                  "Created By :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .createdFullName??"",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Is Active : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  saleCycleController
                      .quoteList[index]
                      .isActive==0?"No":"Yes",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),*/
        trailing: InkWell(
            onTap: () {
              saleCycleController.quoteId.value =
                  saleCycleController.quoteList[index].quoteId!;
              saleCycleController.getQuoteHeaderInformation(
                  saleCycleController.quoteList[index].quoteId, "");
            },
            child: Icon(
              Icons.remove_red_eye,
              color: Colors.blueAccent,
            )),
      ),
    );
  }

  showConfirmationDialog(context, String quoteId) {
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
            content: Wrap(children: [
              Column(
                children: [
                  Text(
                      'Do you want to Create Duplicate Header of this Quote Id ?',
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
                          Get.back();
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
                          saleCycleController.QuoteHeaderDupicateCreate(
                              quoteId);
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

  showSalesProductConfirmationDialog(context, String SalesId, int LineNo) {
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
                Text('Delete!',
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
                  Text('Do you want to delete this sales line ?',
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
                          Get.back();
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
                          saleCycleController.SalesCycleLineDeleteApiHit(
                              LineNo, SalesId);
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

  /*showWonLossConfirmationDialog(context, SalesCycleModal saleCycleList){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to update Sales Cycle ?',
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
                            onPressed: ()  {
                              Get.back();
                              */
  /*saleCycleController.salesCycleMstUpdateApiHit(saleCycleList,
                                  saleCycleController.proposedSolutionController.value.text, saleCycleController.updateQuoteAccetedCycleController.value.text
                                  , saleCycleController.competitorNameController.value.text, saleCycleController.quoteRejectReasonController.value.text, "");
*/
/*

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
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
                            onPressed: ()  {
                              saleCycleController.salesCycleMstUpdateApiHit(saleCycleList,
                                  saleCycleController.proposedSolutionController.value.text, saleCycleController.updateQuoteAccetedCycleController.value.text
                                  , "", "", "");
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
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
  }*/

/*
  void showDialogForsalescycleUpdate(BuildContext context, SalesCycleModal saleCycleList, ) {
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update Sales Cycles',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                */
/*height: size.height*.3,
                width: size.width*4,*/
  /*

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     bindUpdateSalesCycle(context),

                    SizedBox(height: 10,),

                    Obx(() {
                      return Visibility(

                        //visible: saleCycleController.selectedQuotationIdController.value.text.isNotEmpty,
                          visible: saleCycleController.isApprove.value,
                          child: selectedQuotation(context));

                    }),
                    SizedBox(height: 10,),

                    Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: saleCycleController.isChooseQuote.value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                saleCycleController.pageNumberForQuote = 0;
                                saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, "Approved");
                                */
/*Get.toNamed(RoutesName.approvedQuotationListScreen)?.then((_) {
                                  print('Reopen Dialog');
                                  // Reopen the dialog when coming back from the other page
                                  showDialogForsalescycleUpdate(context, saleCycleList);
                                });*/
  /*

                               // navigateAndShowDialog(context, saleCycleList);
                                Get.toNamed(RoutesName.approvedQuotationListScreen);

                              //  showApprovedQuotation(context);


                              },
                              child: Container(
                                child: Text('Choose Quotation',
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
                    Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: saleCycleController.isApprove.value,
                           // visible: saleCycleController.selectedQuotationIdController.value.text == '' ? false:true,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                navigator?.pop(context);
                                showWonLossConfirmationDialog(context, saleCycleList);

                              },
                              child: Container(
                                child: Text('Approve',
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
                    Obx((){
                      return   Visibility(
                        visible: saleCycleController.isReject.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            competitorname( context),
                            SizedBox(height: 10),
                            bindQuoteRejectreason(context),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      AllColors.redColor,
                                    ),
                                  ),
                                  onPressed: ()  {
                                    if(saleCycleController.competitorNameController.value.text.isEmpty){
                                      Utils.showErrorToastification('Error', 'Please Enter Competitor Name');
                                      return;
                                    }else if(saleCycleController.quoteRejectReasonController.value.text.isEmpty){
                                      Utils.showErrorToastification('Error', 'Please Enter Reject Reason Name');
                                      return;
                                    }
                                    showWonLossConfirmationDialog(context, saleCycleList);

                                    },
                                  child: Container(
                                    child: Text('Reject',
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
                )
            ),
          );

        });
  }
*/

  /* Widget selectedQuotation(BuildContext context) {
    return  TextField(
      readOnly: true,
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.selectedQuotationIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Selected Quotation',
          labelText: 'Selected Quotation',
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
  }*/

  /*Widget competitorname(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.competitorNameController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
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
          )
      ),
    );
  }*/

  Widget filterWithQuoteId(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.filterQuoteIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Id',
          labelText: 'Quote Id',
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

/*  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_moon_rounded,
                        color: AllColors.lightredColor,),
                      SizedBox(width: 5,),
                      Text(
                          'Filter',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.twenteetwo,
                            fontWeight: FontWeight.w700,
                            color: AllColors.primaryDark1,
                          )),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel, color: AllColors.lightredColor,)
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey,),
                SingleChildScrollView(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            filterWithQuoteId(context),
                            SizedBox(height: 10),
                            filterWithQuoteStatus(context),
                            SizedBox(height: 10),
                            filterWithQuoteValidity(context),
                            SizedBox(height: 10),
                            filterWithQuoteClosureDate(context),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all<Color>(
                                        AllColors.redColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      try {
                                        saleCycleController
                                            .filterQuoteIdController.value
                                            .clear();
                                        saleCycleController
                                            .filterQuoteStatusController.value
                                            .clear();
                                        saleCycleController
                                            .filterExpectedClosuredateController
                                            .value.clear();
                                        saleCycleController
                                            .filterQuoteValidityController.value
                                            .clear();
                                        saleCycleController.getQuoteHeaderData(
                                            saleCycleController
                                                .pageNumberForQuote,
                                            saleCycleController.salesCycleId
                                                .value, '');
                                        Navigator.pop(context);
                                      } catch (e) {
                                        print("Exception..${e.toString()}");
                                      }
                                    },
                                    child: Container(
                                      child: Text('Clear',
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
                                      backgroundColor: MaterialStateProperty
                                          .all<Color>(
                                        AllColors.greenblue,
                                      ),
                                    ),
                                    onPressed: () {
                                      saleCycleController.getQuoteHeaderData(
                                          saleCycleController
                                              .pageNumberForQuote,
                                          saleCycleController.salesCycleId
                                              .value, '');
                                      Navigator.pop(context);
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
                                ),
                              ],
                            )


                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
          );
        });
  }*/

  filterWithQuoteStatus(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.filterQuoteStatusController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
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
  }

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:saleCycleController.filterQuoteValidityController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Quote Validity Start Date -End Date',
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
          saleCycleController.quoteValidityStartToEnd.value="$startDate@$endDate";
          saleCycleController.filterQuoteValidityController.value.text = '$startDate - $endDate';
        } else {
          saleCycleController.filterQuoteValidityController.value.text = '';
          saleCycleController.quoteValidityStartToEnd.value="";
        }
      },
    );
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: saleCycleController.filterQuoteValidityController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            suffixIcon: Icon(Icons.calendar_month),
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
          DateTime ending_date = new DateTime(2200);
          DateTime start_date = new DateTime(1900);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  // Header background color
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
            saleCycleController.filterQuoteValidityController.value.text =
                outputFormat.format(date);
          else
            saleCycleController.filterQuoteValidityController.value.text = "";
        });
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:saleCycleController.filterExpectedClosuredateController
          .value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Expected Closure Start Date -End Date',
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
          saleCycleController.extClosureStartToEnd.value="$startDate@$endDate";
          saleCycleController.filterExpectedClosuredateController.value.text = '$startDate - $endDate';
        } else {
          saleCycleController.filterExpectedClosuredateController.value.text = '';
          saleCycleController.extClosureStartToEnd.value="";
        }
      },
    );
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller:
            saleCycleController.filterExpectedClosuredateController.value,
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
          DateTime start_date = new DateTime(1900);
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  // Header background color
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
            saleCycleController.filterExpectedClosuredateController.value.text =
                outputFormat.format(date);
          else
            saleCycleController.filterExpectedClosuredateController.value.text =
                "";
        });
  }

  Widget bindIdentifyDecisionMaker(BuildContext context) {
    return IgnorePointer(
      /*ignoring: (saleCycleController.saleCycleList[0].quoteAccepted
          ?.toUpperCase() == "LOSS" ||
          saleCycleController.saleCycleList[0].isReadySendForApproval == 0 &&
              (saleCycleController.FromPage.value == 'Sales'
                  || saleCycleController.FromPage.value == 'FromTaskScreen' ||
                  saleCycleController.FromPage.value == 'Task'))
          || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval ==
                  0 /*saleCycleController.saleCycleList[0].createdBy != saleCycleController.email*/ ||
              (saleCycleController
                          .saleCycleList[0].actualSalesCycleApprovalStatus
                          ?.toLowerCase() !=
                      'pending' &&
                  saleCycleController.saleCycleList[0].salesCycleStatus
                          ?.toLowerCase() ==
                      'suspect') ||
              saleCycleController.saleCycleList[0].quoteAccepted
                      ?.toLowerCase() ==
                  "loss")
          ? true
          : false,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: double.infinity,
        child: DropdownMenu<String>(
          width: size.width - 30,
          controller: saleCycleController.identifyDecisionMakerController.value,
          label: Text(
            "Identify Decision Maker",
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
          enabled: (saleCycleController.FromPage.value != "FromDashboard"),
          onSelected: (String? selection) {
            print(selection);
            saleCycleController.identifyDecisionMakerController.value.text =
                _displayDecisionMakerForOption(selection!).toString();
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
      ),
    );
  }
/*
  Widget bindSaleCycleCommit(BuildContext context) {
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval ==
          0 && (saleCycleController.FromPage.value == 'Sales'
          || saleCycleController.FromPage.value == 'FromTaskScreen' ||
          saleCycleController.FromPage.value == 'Task'))
          || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: double.infinity,
        child: DropdownMenu<String>(
          width: size.width - 30,
          controller: saleCycleController.saleCycleCommitController.value,
          label: Text(
            "Sales Cycle Commit",
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
            saleCycleController.saleCycleCommitController.value.text =
                _displayDecisionMakerForOption(selection!).toString();
          },

          dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<
              DropdownMenuEntry<String>>((String e) {
            return DropdownMenuEntry<String>(
                value: e, label: e!, style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  AllColors.primaryDark1),));
          }).toList(),
        ),
      ),
    );
  }*/

  Widget bindPurchaseProcessDropDown(context) {
    return IgnorePointer(
      /*ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval ==
          0 &&
          (saleCycleController.FromPage.value == 'Sales' ||
              saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
      ignoring:
          ( saleCycleController
              .saleCycleList[0].isReadySendForApproval==0||
                  (saleCycleController
                              .saleCycleList[0].actualSalesCycleApprovalStatus
                              ?.toLowerCase() !=
                          'pending' &&
                      saleCycleController.saleCycleList[0].salesCycleStatus
                              ?.toLowerCase() ==
                          'suspect') ||
                  saleCycleController.saleCycleList[0].quoteAccepted
                          ?.toLowerCase() ==
                      "loss")
              ? true
              : false,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Autocomplete<CustomList>(
          displayStringForOption: _displayPurchaseProcessForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return saleCycleController.get_PurchaseProcess_list.value;
              // return const Iterable<VehicleTypeResponse>.empty();
            }
            return saleCycleController.get_PurchaseProcess_list
                .where((CustomList option) {
              return option.value
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
          },
          onSelected: (CustomList selection) {
            saleCycleController.purchaseProcessController.value.text =
                _displayPurchaseProcessForOption(selection).toString();
            saleCycleController.purchaseProcessController.value.text =
                selection.value ?? "";
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController controller,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              readOnly: (saleCycleController.FromPage.value == "FromDashboard") ? true : false,
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text =
                    saleCycleController.purchaseProcessController.value.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: AllColors.primaryDark1,
                    onPressed: () {
                      if (focusNode.hasFocus) {
                        focusNode.unfocus();
                      } else {
                        focusNode.requestFocus();
                      }
                    },
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Purchase Process',
                  labelText: 'Purchase Process',
                  hintStyle: GoogleFonts.poppins(
                      color: AllColors.lightblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.ten),
                  labelStyle: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<CustomList> onSelected,
              Iterable<CustomList> suggestions) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 4.0,
                child: Container(
                  width: size.width * .8,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final CustomList option = suggestions.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            option.value.toString(),
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
        ),
      ),
    );
  }

  Widget bindPurchaseTimeFrameDropDown(context) {
    return IgnorePointer(
      /*ignoring: (saleCycleController.saleCycleList[0].quoteAccepted
          ?.toUpperCase() == "LOSS") ||
          (saleCycleController.saleCycleList[0].isReadySendForApproval == 0 &&
              (saleCycleController.FromPage.value == 'Sales' ||
                  saleCycleController.FromPage.value == 'FromTaskScreen'
              )) || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
      ignoring:
          ( saleCycleController
              .saleCycleList[0].isReadySendForApproval==0 ||
                  (saleCycleController
                              .saleCycleList[0].actualSalesCycleApprovalStatus
                              ?.toLowerCase() !=
                          'pending' &&
                      saleCycleController.saleCycleList[0].salesCycleStatus
                              ?.toLowerCase() ==
                          'suspect') ||
                  saleCycleController.saleCycleList[0].quoteAccepted
                          ?.toLowerCase() ==
                      "loss")
              ? true
              : false,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Autocomplete<CustomList>(
          displayStringForOption: _displayPurchaseTimeFrameForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return saleCycleController.get_PurchaseTimeFrame_list.value;
              // return const Iterable<VehicleTypeResponse>.empty();
            }
            return saleCycleController.get_PurchaseTimeFrame_list
                .where((CustomList option) {
              return option.value
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
          },
          onSelected: (CustomList selection) {
            saleCycleController.purchasTimeFrameController.value.text =
                _displayPurchaseTimeFrameForOption(selection).toString();
            saleCycleController.purchasTimeFrameController.value.text =
                selection.value ?? "";
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController controller,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              readOnly: saleCycleController.FromPage.value == "FromDashboard"
                      ? true
                      : false,
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text =
                    saleCycleController.purchasTimeFrameController.value.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: AllColors.primaryDark1,
                    onPressed: () {
                      if (focusNode.hasFocus) {
                        focusNode.unfocus();
                      } else {
                        focusNode.requestFocus();
                      }
                    },
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Purchase Time Frame',
                  labelText: 'Purchase Time Frame',
                  hintStyle: GoogleFonts.poppins(
                      color: AllColors.lightblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.ten),
                  labelStyle: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<CustomList> onSelected,
              Iterable<CustomList> suggestions) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 4.0,
                child: Container(
                  width: size.width * .8,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final CustomList option = suggestions.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            option.value.toString(),
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
        ),
      ),
    );
  }

  Widget bindProductCategoryDropDown(context) {
    return IgnorePointer(
      /*ignoring: (saleCycleController.saleCycleList[0].quoteAccepted
          ?.toUpperCase() == "LOSS") ||
          (saleCycleController.saleCycleList[0].isReadySendForApproval == 0 &&
              (*/ /*saleCycleController.FromPage.value == 'Sales'*/ /* saleCycleController
                  .FromPage.value == 'FromTaskScreen'
              )) || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
      /*ignoring: saleCycleController.saleCycleList[0]
          .salesCycleStatus!.toLowerCase()!="suspect" || (saleCycleController.saleCycleList[0].createdBy != saleCycleController.email || saleCycleController.saleCycleList[0].quoteAccepted
          ?.toUpperCase() == "LOSS") ? true : false,*/
      ignoring:saleCycleController.saleCycleList[0].createdBy?.toLowerCase() !=
          saleCycleController.email.toLowerCase() || saleCycleController.saleCycleList[0].quoteAccepted
              ?.toLowerCase() !=
              "open" ||saleCycleController.saleCycleList[0].salesCycleApprovalStatus
          ?.toLowerCase() ==
          "rejected" ||saleCycleController.FromPage.value == "FromDashboard"
       ,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: size.width,
        child: Autocomplete<ItemCategoryMstModel>(
          displayStringForOption: _displayItemCatMasterForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return saleCycleController.itemCategorySelectedlist.value;
              // return const Iterable<VehicleTypeResponse>.empty();
            }
            return saleCycleController.itemCategorySelectedlist
                .where((ItemCategoryMstModel option) {
              return option.categoryName
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
          },
          onSelected: (ItemCategoryMstModel selection) {
            saleCycleController.productCategoryController.value.text =
                _displayItemCatMasterForOption(selection).toString();
            saleCycleController.ProductCategoryCode.value =
                selection.categoryCode ?? "";

            /*if (!saleCycleController.itemCategorySelectedlist.contains(selection)) {
              saleCycleController.itemCategorySelectedlist.add(selection);
              Utils.showToastification('Success', 'Add Successfully');
            }else{
              Utils.showErrorToastification('Error', 'Already Selected');
            }
            print("list${saleCycleController.itemCategorySelectedlist.length}");*/
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController controller,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              onTap: () {
                controller.clear();
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text =
                    saleCycleController.productCategoryController.value.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: AllColors.primaryDark1,
                    onPressed: () {
                      if (focusNode.hasFocus) {
                        focusNode.unfocus();
                      } else {
                        focusNode.requestFocus();
                      }
                    },
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Product Category',
                  labelText: 'Product Category',
                  hintStyle: GoogleFonts.poppins(
                      color: AllColors.lightblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.ten),
                  labelStyle: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
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
                  width: size.width * .5,
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
        ),
      ),
    );
  }

  Widget bindExpectedAmount(BuildContext context) {
    return IgnorePointer(
      ignoring:saleCycleController.saleCycleList[0].createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase()
         || saleCycleController.saleCycleList[0].quoteAccepted
                  ?.toUpperCase() !=
              "OPEN" ||
          saleCycleController.saleCycleList[0].actualSalesCycleApprovalStatus
                  ?.toLowerCase() ==
              "rejected" ||
          (saleCycleController.FromPage.value == "FromDashboard"),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
        width: size.width / 2,
        child: TextField(
          /*readOnly: saleCycleController.saleCycleList[0].quoteAccepted
              ?.toUpperCase() == "LOSS" ||
              (saleCycleController.saleCycleList[0].isReadySendForApproval == 0 &&
                  (*/ /*saleCycleController.FromPage.value == 'Sales' */ /* saleCycleController
                      .FromPage.value == 'FromTaskScreen'
                      || saleCycleController.FromPage.value == 'Task')) ||
              saleCycleController.FromPage.value == 'Task' ||
              saleCycleController.FromPage.value == 'FromTaskScreen'
              ? true
              : false,*/

          /* readOnly: saleCycleController.saleCycleList[0]
              .salesCycleStatus!.toLowerCase()!="suspect" || (saleCycleController.saleCycleList[0].createdBy != saleCycleController.email ||
              saleCycleController.saleCycleList[0].quoteAccepted?.toUpperCase() == "LOSS") ? true : false,*/
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.expectedAmountController.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Enter Expected Amount',
              labelText: 'Expected Amount',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.fourtine),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),
      ),
    );
  }

  Widget BindAmmountTable(BuildContext context) {
    if (saleCycleController.budgetAmountList.isNotEmpty) {
      return BindTableDate(context);
    } else {
      return Container(
        //decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            //Image(image: AssetImage("assets/images/no_results_found.jpg"), height: 450,width: 350,),
            Text(
              '',
              style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    }
  }

  Widget BindTableDate(BuildContext context) {
    return Container(
        // padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Obx(() {
      return IgnorePointer(
          /*ignoring: (saleCycleController.saleCycleList[0]
                  .isReadySendForApproval == 0 &&
                  (*/ /*saleCycleController.FromPage.value == 'Sales' || */ /*saleCycleController
                      .FromPage.value == 'FromTaskScreen'
                  )) || saleCycleController.FromPage.value == 'Task' ||
                  saleCycleController.FromPage.value == 'FromTaskScreen'
                  ? true
                  : false,*/
          ignoring:
              ( saleCycleController
                  .saleCycleList[0].createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase() ||
                      saleCycleController.saleCycleList[0].quoteAccepted
                              ?.toUpperCase() !=
                          "OPEN")
                  ? true
                  : false,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Divider(
                height: 1,
                color: AllColors.lightgreyColor,
              )),
              Table(
                columnWidths: {
                  0: FixedColumnWidth(size.width * 0.4),
                  1: FixedColumnWidth(size.width * 0.3),
                  2: FixedColumnWidth(size.width * 0.3),
                },
                border: TableBorder.symmetric(
                    inside: BorderSide(
                        width: 1.0, color: AllColors.lightgreyColor)),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Product\nCategory",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Expected\nAmount",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Action",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Divider(
                  height: 1,
                  color: AllColors.lightgreyColor,
                ),
              ),
              Container(
                height: saleCycleController.budgetAmountList.length > 4
                    ? size.height * 0.2
                    : null,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(size.width * 0.4),
                      1: FixedColumnWidth(size.width * 0.3),
                      2: FixedColumnWidth(size.width * 0.3),
                    },
                    border: TableBorder.symmetric(
                        inside: BorderSide(
                            width: 1.0, color: AllColors.lightgreyColor)),
                    //border: TableBorder.all(color: AllColors.lightgreyColor, ),
                    children: saleCycleController.budgetAmountList.map((user) {
                      return TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Text(
                            user.productCategoryName.toString(),
                            style: TextStyle(color: AllColors.primaryDark1),
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Text(
                              user.estimatedAmount.toString(),
                              style: TextStyle(color: AllColors.primaryDark1),
                            ),
                          ),
                          onTap: () {
                            if (!(saleCycleController.FromPage.value ==
                                    "FromDashboard") &&
                                saleCycleController
                                        .saleCycleList[0].quoteAccepted
                                        ?.toUpperCase() ==
                                    "OPEN" &&
                                saleCycleController.saleCycleList[0]
                                        .actualSalesCycleApprovalStatus
                                        ?.toLowerCase() !=
                                    "rejected" && saleCycleController.saleCycleList[0]
                                .createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()) {
                              saleCycleController.ProductCategoryCode.value =
                                  user.productCategory!;
                              saleCycleController.budgetAmountController.value
                                  .text = user.budgetAmount.toString();
                              saleCycleController.expectedAmountController.value
                                  .text = user.estimatedAmount.toString();
                              UpdateEstimatedAmountDailog(context, user.id);
                              print('id....Selected...${user.id}');
                            }
                          },
                        ),
                        Visibility(
                          visible: /*saleCycleController.saleCycleList[0]
                                      .salesCycleStatus!.toLowerCase()=="suspect" */
                              saleCycleController.saleCycleList[0]
                                              .salesCycleApprovalStatus
                                              ?.toLowerCase() ==
                                          "rejected" ||
                                      saleCycleController
                                              .saleCycleList[0].quoteAccepted
                                              ?.toUpperCase() !=
                                          "OPEN" ||
                                  saleCycleController
                                      .saleCycleList[0].createdBy?.toLowerCase()!=saleCycleController.email.toLowerCase() ||
                                      (saleCycleController.FromPage.value ==
                                          "FromDashboard")
                                  ? false
                                  : true,
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 50),
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                            onTap: () {
                              saleCycleController.ProductCategoryCode.value =
                                  user.productCategory!;
                              // saleCycleController.expectedAmountController.value.text = user.estimatedAmount.toString();
                              // saleCycleController.budgetAmountController.value.text = user.budgetAmount.toString();
                              openConfirmationAmtDeleteDialog(context, user.id);
                              print('id....Selected...${user.id}');
                            },
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              Center(
                child: Divider(
                  height: 1,
                  color: AllColors.lightgreyColor,
                ),
              ),
              Table(
                columnWidths: {
                  0: FixedColumnWidth(size.width * 0.4),
                  1: FixedColumnWidth(size.width * 0.3),
                  2: FixedColumnWidth(size.width * 0.3),
                },
                border: TableBorder.symmetric(
                    inside: BorderSide(
                        width: 1.0, color: AllColors.lightgreyColor)),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Total Amount",
                          style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          saleCycleController
                              .budgetAmountList[0].totalEstimatedAmount
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Divider(
                  height: 1,
                  color: AllColors.lightgreyColor,
                ),
              ),
              SizedBox(
                height: 5,
              )

              /* Expanded(
               child: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child: Container(
                   margin: EdgeInsets.only(bottom: 20),
                   child: Table(
                     columnWidths: {
                       0: FixedColumnWidth(size.width*0.4),
                       1: FixedColumnWidth(size.width*0.3),
                       2: FixedColumnWidth(size.width*0.3),
                     },
                     border: TableBorder.all(color: AllColors.lightgreyColor, ),
                     children: saleCycleController.budgetAmountList.map((user) {
                       return TableRow(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                             child: Text(
                               user.productCategoryName.toString(),
                               style: TextStyle(color: AllColors.primaryDark1),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                             child: Text(
                               user.estimatedAmount.toString(),
                               style: TextStyle(color: AllColors.primaryDark1),
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                             child: Text(
                               user.budgetAmount.toString(),
                               style: TextStyle(color: AllColors.primaryDark1),
                             ),
                           ),
                         ],
                       );
                     }).toList(),
                   ),
                 ),
               ),
             ),*/
            ],
          )

          /*DataTable(
         // headingRowColor: WidgetStateProperty.all(Colors.blue[100]),
         columnSpacing: 30,
         decoration: BoxDecoration(
           border: Border(
             right: BorderSide(
               color: Colors.grey,
               width: 0.5,
             ),
             left: BorderSide(
               color: Colors.grey,
               width: 0.5,
             ),
             bottom: BorderSide(
               color: Colors.grey,
               width: 0.5,
             ),
           ),
         ),
         columns: [
           DataColumn(label: Text('Product\nCategory')),
           DataColumn(label: Text('Budget\nAmount')),
           DataColumn(label: Text('Expected\nAmount'),),
         ],
         rows: [
           ...saleCycleController.budgetAmountList.map((e) => DataRow(cells: [
              DataCell(
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                  e.productCategoryName.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w300,)))),
              DataCell(
                InkWell(
                  onTap: (){
                    saleCycleController.ProductCategoryCode.value = e.productCategory!;
                    saleCycleController.expectedAmountController.value.text = e.estimatedAmount.toString();
                    saleCycleController.budgetAmountController.value.text = e.budgetAmount.toString();
                    UpdateBudgetAmountDailog(context, e.id);
                    print('id....Selected...${e.id}');
                  },
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(e.budgetAmount.toString(),
                         style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontWeight: FontWeight.w300,))),
                )),

              DataCell(
                InkWell(
                  onTap: (){
                    saleCycleController.ProductCategoryCode.value = e.productCategory!;
                    saleCycleController.budgetAmountController.value.text = e.budgetAmount.toString();
                    saleCycleController.expectedAmountController.value.text = e.estimatedAmount.toString();
                    UpdateEstimatedAmountDailog(context, e.id);
                    print('id....Selected...${e.id}');
                  },
                  child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(e.estimatedAmount.toString(),
                    style:GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w300,) ,
                  )),
                )),
            ])),
           DataRow(cells: [
             DataCell(Container(
                 alignment: AlignmentDirectional.centerStart,
                 child: Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, color: AllColors.blackColor)))), // Empty cells for the total row
             DataCell(Container(
                 alignment: AlignmentDirectional.centerStart,
                 child: Text('${saleCycleController.budgetAmountList[0].totalBudgetAmount}', style: TextStyle(fontWeight: FontWeight.bold, color: AllColors.blackColor)))),
             DataCell(
                 Container(
                     alignment: AlignmentDirectional.centerStart,
                     child: Text('${saleCycleController.budgetAmountList[0].totalEstimatedAmount}', style: TextStyle(fontWeight: FontWeight.bold, color: AllColors.blackColor)))),
           ]),
         ],
              ),*/
          );
    }));
  }

  bindSolutionRejectedRemarks(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
      child: TextField(
        readOnly:
            ( saleCycleController
                .saleCycleList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()||
                        saleCycleController
                                .saleCycleList[0].actualSalesCycleApprovalStatus
                                ?.toLowerCase() ==
                            "rejected" ||
                        saleCycleController.saleCycleList[0].quoteAccepted
                                ?.toUpperCase() ==
                            "LOSS") ||
                    (saleCycleController.FromPage.value == "FromDashboard")
                ? true
                : false,
        //readOnly: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?true:false,
        cursorColor: AllColors.primaryDark1,
        controller: saleCycleController.solutionRejectedRemarkController.value,
        maxLength: 500,
        maxLines: 2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
            hintText: 'Solution Rejected Remarks',
            labelText: 'Solution Rejected Remarks',
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
      ),
    );
  }

  //todo Infra details commented by nirupma
  /* void showInfraLeadDetails(BuildContext context,
      RxList<SalesCycleModal> saleCycleList) {
    Size size = Get.size;
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: size.height / 2,
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
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Infra Lead Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close, color: AllColors.primaryDark1,)),
                    )

                  ],
                ),
              ),
              Center(child: Divider(height: 1, color: AllColors.primaryDark1,)),
              // Obx(() {
              //  return
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "User Region",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].userRegion ?? "",
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
                              "User Cluster",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].userClusture ?? "",
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
                              "Project Value",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].projectValue.toString(),
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
                              "Exp Date of Order",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].expectedDateOfOrder ?? "",
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
                              "Drawing Collected",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].drawingCollected == 1
                                  ? "Yes"
                                  : "No",
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
                              "Proposal Submitted",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].proposalSubmitted == 1
                                  ? "Yes"
                                  : "No",
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
                              "Inaugration Date of Project",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].inaugrationDateOfProject ?? "",
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
                              "Architect",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].architect ?? "",
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
                              "Executive Engineer",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].executiveEngineer ?? "",
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
                              "Name of Infra Department",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].nameOfInfraDepartment ?? "",
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
                              "Name of Agency Contactor",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].nameOfAgencyContrator ?? "",
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
                              "Expected Revenue",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].expectedRevenue.toString(),
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
                              "Value Of Quote",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].valueOfQuote.toString(),
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
                              "Expected Date Of Completion",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].expectedDateOfCompletion ?? "",
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
                ),
              ),


              //  })
            ],
          ),
        );
      },
    );
  }*/

  void ShowProductCategoryTable(BuildContext context,
      RxList<ProductCategoryWiseAmtModel> budgetAmountList) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure minimal height
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
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Product Category Table",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: AllColors.primaryDark1,
                          )),
                    )
                  ],
                ),
              ),
              Center(
                  child: Divider(
                height: 1,
                color: AllColors.primaryDark1,
              )),
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        bindProductCategoryDropDown(context),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //bindBudgetAmount(context),
                            bindExpectedAmount(context),
                            Visibility(
                              visible: saleCycleController
                                              .saleCycleList[0].quoteAccepted!
                                              .toLowerCase() !=
                                          "open" ||
                                      saleCycleController.saleCycleList[0]
                                              .salesCycleApprovalStatus!
                                              .toLowerCase() ==
                                          "rejected" ||
                                      (saleCycleController.FromPage.value ==
                                          "FromDashboard") ||
                                  saleCycleController
                                      .saleCycleList[0].isReadySendForApproval==0
                                  ? false
                                  : true,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                width: size.width / 2 - 20,
                                child: IgnorePointer(
                                  ignoring: (saleCycleController
                                              .saleCycleList[0]
                                              .isReadySendForApproval ==
                                          0)
                                      ? true
                                      : false,
                                  child: DefaultButton(
                                    press: () {
                                      if (saleCycleController
                                              .productCategoryController
                                              .value
                                              .text
                                              .isEmpty ||
                                          saleCycleController
                                                  .productCategoryController
                                                  .value
                                                  .text ==
                                              "") {
                                        Utils.showErrorToastification(
                                            "Product Category",
                                            "Please select product category");
                                        return;
                                      }
                                      /* if(saleCycleController.budgetAmountController.value.text.isEmpty || saleCycleController.budgetAmountController.value.text == "" ){
                              Utils.showErrorToastification("Budget Amount", "Please enter budget amount");
                              return;
                            }*/
                                      if (saleCycleController
                                              .expectedAmountController
                                              .value
                                              .text
                                              .isEmpty ||
                                          saleCycleController
                                                  .expectedAmountController
                                                  .value
                                                  .text ==
                                              "") {
                                        Utils.showErrorToastification(
                                            "Expected Amount",
                                            "Please enter expected amount");
                                        return;
                                      }

                                      saleCycleController
                                          .ProductCategoryWiseAmtCreateApiHit(
                                              0);
                                    },
                                    text: "Save",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            // height: 300,
                            child: Obx(() {
                              return BindAmmountTable(context);
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void ShowQuoteWon(BuildContext context) {
    // Size size=Get.size;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          /* width: double.infinity,
          height: size.height/2,*/
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Quote Won List",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: AllColors.primaryDark1,
                          )),
                    )
                  ],
                ),
              ),
              Center(
                  child: Divider(
                height: 1,
                color: AllColors.primaryDark1,
              )),
              Container(
                width: double.infinity,
                child: bindQuoteWonData(context),
              )
            ],
          ),
        );
      },
    );
  }

  UpdateproductCategoryDailog(context, int? id) {
    // saleCycleController.budgetAmountController.value.clear();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Product Category',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              /*height: size.height*.15,
              width: size.width*4,*/
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
                  bindProductCategoryDropDown(context),
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
                          saleCycleController
                              .ProductCategoryWiseAmtCreateApiHit(id!);
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
                          saleCycleController.productCategoryController.value
                              .clear();
                          saleCycleController.budgetAmountController.value
                              .clear();
                          saleCycleController.expectedAmountController.value
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

  UpdateBudgetAmountDailog(context, int? id) {
    // saleCycleController.budgetAmountController.value.clear();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Budget Amount',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              /*height: size.height*.15,
              width: size.width*4,*/
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
                    //padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      controller:
                          saleCycleController.budgetAmountController.value,
                      decoration: InputDecoration(
                          hintText: "Enter Budget Amount",
                          labelText: "Enter Budget Amount",
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
                          saleCycleController
                              .ProductCategoryWiseAmtCreateApiHit(id!);
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
                          saleCycleController.productCategoryController.value
                              .clear();
                          saleCycleController.budgetAmountController.value
                              .clear();
                          saleCycleController.expectedAmountController.value
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

  UpdateEstimatedAmountDailog(context, int? id) {
    //saleCycleController.expectedAmountController.value.clear();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Expected Amount',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              /*height: size.height*.15,
              width: size.width*4,*/
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
                    //padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      controller:
                          saleCycleController.expectedAmountController.value,
                      decoration: InputDecoration(
                          hintText: "Enter Expected Amount",
                          labelText: "Enter Expected Amount",
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
                          saleCycleController
                              .ProductCategoryWiseAmtCreateApiHit(id!);
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
                          saleCycleController.productCategoryController.value
                              .clear();
                          saleCycleController.budgetAmountController.value
                              .clear();
                          saleCycleController.expectedAmountController.value
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

  showProductCatDialog(context) {
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
                  bindItemCategoryDropDown(context),
                  SizedBox(
                    height: 65,
                  ),
                  Obx(() {
                    return Visibility(
                      visible:
                          saleCycleController.itemCategorySelectedlist.length >
                                  0
                              ? true
                              : false,
                      child: Wrap(
                        spacing: 8.0,
                        children: saleCycleController.itemCategorySelectedlist
                            .map((category) {
                          return Chip(
                            label: Text(category.categoryName ?? ""),
                            onDeleted: () {
                              saleCycleController.itemCategorySelectedlist
                                  .remove(category);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(
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
                          saleCycleController.TaskSaleCatCreateApiHit(
                              saleCycleController
                                  .saleCycleList[0].salesCycleId!,
                              saleCycleController.saleCycleList[0].taskId!);
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

  Widget bindItemCategoryDropDown(context) {
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemCatMasterForOption,
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
            _displayItemCatMasterForOption(selection).toString();
        print(
            'Controller.....${saleCycleController.productCategoryController.value.text}');
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

  void showDialogForSalesCyclePurchaseUpdate(
    BuildContext context,
    SalesCycleModal saleCycleList,
  ) {
    showDialog(
        // barrierDismissible: false,
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
                  child: Tooltip(
                    message: "Update Sales Cycles Details",
                    child: Text(
                      'Update Sales Cycles Details',
                      style: GoogleFonts.poppins(
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700,
                        color: AllColors.primaryDark1,
                      ),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bindUpdateSalesClosureDate(context),
                  SizedBox(
                    height: 10,
                  ),
                  bindUpdateSalesBudgetAmount(context),
                  SizedBox(
                    height: 10,
                  ),
                  bindUpdateSalesIdentifyDecisionMaker(context),
                  SizedBox(
                    height: 10,
                  ),
                  /* bindSaleCycleCommit(context),
                  SizedBox(height: 10,),*/
                  bindUpdateSalesPurchaseProcessDropDown(context),
                  SizedBox(
                    height: 10,
                  ),
                  bindUpdateSalesPurchaseTimeFrameDropDown(context),
                  SizedBox(
                    height: 10,
                  ),
                  bindSalesCycleOwner(context),
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
                      //saleCycleController.SalesCycleMstPurchaseByUpdateAPI(saleCycleList);
                      saleCycleController.salesCycleMstUpdateApiHit(
                          saleCycleList, "", "", "", "", "");
                      Get.back();
                      // pageNumberForQuote = 0;
                      //getQuoteHeaderData(pageNumberForQuote,salesCycleId.value, "Approved");
                      // Get.toNamed(RoutesName.approvedQuotationListScreen);
                    },
                    child: Container(
                      width: size.width,
                      child: Center(
                        child: Text(
                          'UPDATE',
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

  Widget bindUpdateSalesClosureDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        cursorColor: AllColors.primaryDark1,
        /* readOnly: saleCycleController.saleCycleList[0]
            .isReadySendForApproval == 0
            (saleCycleController.FromPage.value == 'Sales'
                || saleCycleController.FromPage.value == 'FromTaskScreen' ||
                saleCycleController.FromPage.value == 'Task')
            ? true
            : false,*/
        controller: saleCycleController.closureDateController.value,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_month),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Select Estimated Closure Date',
            labelText: 'Estimated Closure Date',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.fourtine),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
        onTap: () async {
          /*if (saleCycleController.saleCycleList[0].isReadySendForApproval ==
              1) {*/
          DateTime? initialDate;
          if (saleCycleController.closureDateController.value.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              saleCycleController.closureDateController.value.text,
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
                  primaryColor: AllColors.primaryDark1,
                  // Header background color
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
            saleCycleController.closureDateController.value.text =
                outputFormat.format(date);
        },
      ),
    );
  }

  Widget bindUpdateSalesIdentifyDecisionMaker(BuildContext context) {
    // return IgnorePointer(
    //ignoring: saleCycleController.saleCycleList[0].isReadySendForApproval ==*
    /*&& (saleCycleController.FromPage.value == 'Sales'
          || saleCycleController.FromPage.value == 'FromTaskScreen' ||
          saleCycleController.FromPage.value == 'Task'))
          || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      // margin: const EdgeInsets.only(left: 15.0,),
      // width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width - 150,
        controller: saleCycleController.identifyDecisionMakerController.value,
        label: Text(
          "Identify Decision Maker",
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
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.identifyDecisionMakerController.value.text =
              _displayDecisionMakerForOption(selection!).toString();
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

/*  Widget bindUpdateSalesSaleCycleCommit(BuildContext context) {
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval ==
          0 && (saleCycleController.FromPage.value == 'Sales'
          || saleCycleController.FromPage.value == 'FromTaskScreen' ||
          saleCycleController.FromPage.value == 'Task'))
          || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        // width: double.infinity,
        child: DropdownMenu<String>(
          width: size.width - 170,
          controller: saleCycleController.saleCycleCommitController.value,
          label: Text(
            "Sales Cycle Commit",
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
            saleCycleController.saleCycleCommitController.value.text =
                _displayDecisionMakerForOption(selection!).toString();
          },

          dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<
              DropdownMenuEntry<String>>((String e) {
            return DropdownMenuEntry<String>(
                value: e, label: e!, style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  AllColors.primaryDark1),));
          }).toList(),
        ),
      ),
    );
  }*/

  Widget bindUpdateSalesPurchaseProcessDropDown(context) {
    // return IgnorePointer(
    //ignoring: saleCycleController.saleCycleList[0].isReadySendForApproval ==0
    /*&&
          (saleCycleController.FromPage.value == 'Sales' ||
              saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Autocomplete<CustomList>(
        displayStringForOption: _displayPurchaseProcessForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return saleCycleController.get_PurchaseProcess_list.value;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return saleCycleController.get_PurchaseProcess_list
              .where((CustomList option) {
            return option.value
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (CustomList selection) {
          saleCycleController.purchaseProcessController.value.text =
              _displayPurchaseProcessForOption(selection).toString();
          saleCycleController.purchaseProcessController.value.text =
              selection.value ?? "";
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            /* readOnly: saleCycleController.saleCycleList[0]
                  .isReadySendForApproval == 0 &&
                  (saleCycleController.FromPage.value == 'Sales' ||
                      saleCycleController.FromPage.value == 'FromTaskScreen'
                  )) || saleCycleController.FromPage.value == 'Task' ||
                  saleCycleController.FromPage.value == 'FromTaskScreen'
                  ? true
                  : false,*/
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = saleCycleController.purchaseProcessController.value.text,
            focusNode: focusNode,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: () {
                    if (focusNode.hasFocus) {
                      focusNode.unfocus();
                    } else {
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Purchase Process',
                labelText: 'Purchase Process',
                hintStyle: GoogleFonts.poppins(
                    color: AllColors.lightblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.ten),
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.fourtine),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<CustomList> onSelected,
            Iterable<CustomList> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width * .6,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final CustomList option = suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.value.toString(),
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
      ),
    );
  }

  Widget bindUpdateSalesPurchaseTimeFrameDropDown(context) {
    // return IgnorePointer(
    // ignoring: saleCycleController.saleCycleList[0].isReadySendForApproval ==0
    /*&&
          (saleCycleController.FromPage.value == 'Sales' ||
              saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Autocomplete<CustomList>(
        displayStringForOption: _displayPurchaseTimeFrameForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return saleCycleController.get_PurchaseTimeFrame_list.value;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return saleCycleController.get_PurchaseTimeFrame_list
              .where((CustomList option) {
            return option.value
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (CustomList selection) {
          saleCycleController.purchasTimeFrameController.value.text =
              _displayPurchaseTimeFrameForOption(selection).toString();
          saleCycleController.purchasTimeFrameController.value.text =
              selection.value ?? "";
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            /*readOnly: saleCycleController.saleCycleList[0]
                  .isReadySendForApproval == 0 &&
                  (saleCycleController.FromPage.value == 'Sales' ||
                      saleCycleController.FromPage.value == 'FromTaskScreen'
                  )) || saleCycleController.FromPage.value == 'Task' ||
                  saleCycleController.FromPage.value == 'FromTaskScreen'
                  ? true
                  : false,*/

            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text =
                  saleCycleController.purchasTimeFrameController.value.text,
            focusNode: focusNode,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: () {
                    if (focusNode.hasFocus) {
                      focusNode.unfocus();
                    } else {
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Purchase Time Frame',
                labelText: 'Purchase Time Frame',
                hintStyle: GoogleFonts.poppins(
                    color: AllColors.lightblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.ten),
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.fourtine),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<CustomList> onSelected,
            Iterable<CustomList> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width * .6,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final CustomList option = suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.value.toString(),
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
      ),
    );
  }

  bindSalesCycleOwner(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        readOnly: true,
        cursorColor: AllColors.primaryDark1,
        controller: saleCycleController.salesCycleOwnerController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
            hintText: 'Sales Cycle Owner',
            labelText: 'Sales Cycle Owner',
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
      ),
    );
  }

  bindUpdateSalesBudgetAmount(BuildContext context) {
    // return IgnorePointer(
    /*ignoring: saleCycleController.saleCycleList[0].isReadySendForApproval ==
          0 &&
          (saleCycleController.FromPage.value == 'Sales' ||
              saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen' ? true : false,*/
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        keyboardType: TextInputType.number,
        /*readOnly: saleCycleController.saleCycleList[0]
              .isReadySendForApproval == 0 &&
              (saleCycleController.FromPage.value == 'Sales' ||
                  saleCycleController.FromPage.value == 'FromTaskScreen'
              )) || saleCycleController.FromPage.value == 'Task' ||
              saleCycleController.FromPage.value == 'FromTaskScreen'
              ? true
              : false,*/
        cursorColor: AllColors.primaryDark1,
        controller:
            saleCycleController.updatesalesCycleBudgetAmountController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
            hintText: 'Budget Amount',
            labelText: 'Budget Amount',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );
  }

  void bindListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      "Sales Cycle Products",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  //todo comment code of mark loss btn of case of prospect
                  /*  Visibility(
                        visible: saleCycleController.saleCycleList[0].salesCycleStatus != 'Propose',
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          child: GestureDetector(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AllColors.primaryDark),
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Optional: border radius
                                  ),
                                ),
                                onPressed: () {
                                  showConfirmationDialogForMarkLoss(context,saleCycleController.saleCycleList[0]);
                                },
                                child: Text("Mark Loss",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),),
                              )
                          ),
                        ),
                      ),*/

                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      child: InkWell(
                        onTap: () {
                          showDialogSalesCycleProductFilter(context);
                        },
                        child: Icon(Icons.filter_alt_rounded),
                      ),
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
                return bindSalesCycleProductData(context, "Update");
              }),
            )),
            Obx(() {
              return Column(
                children: [
                  Center(
                      child: Divider(
                    height: 1,
                    color: AllColors.primaryDark1,
                  )),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 20),
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
                              "Qty: ",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              saleCycleController.get_SalesCycleProductById_List
                                          .length >
                                      0
                                  ? (saleCycleController
                                              .get_SalesCycleProductById_List[0]
                                              .productTotalQty ==
                                          null
                                      ? "0"
                                      : saleCycleController
                                          .get_SalesCycleProductById_List[0]
                                          .productTotalQty
                                          .toString())
                                  : "",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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
                            Text(
                              saleCycleController.get_SalesCycleProductById_List
                                          .length >
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
                                  : "",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
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
            /* title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Filter List ',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),*/
            content: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
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
                            SizedBox(
                              height: 10,
                            ),
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
                            EditCompetitorName(context),
                            SizedBox(
                              height: 5,
                            ),
                            EditLossReason(context),
                            SizedBox(
                              height: 5,
                            ),
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
                                    saleCycleController
                                        .getSaleCycleProductByIdList(
                                            saleCycleController.pageNumber,
                                            saleCycleController.saleCycleList[0]
                                                .salesCycleId!);
                                    Get.back();
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
                                            saleCycleController.saleCycleList[0]
                                                .salesCycleId!);
                                    Get.back();
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
            }),
          );
        });
  }

  void showDialogSalesCycleProductModify(BuildContext context, int position) {
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
                Text(
                    'Update (${saleCycleController.get_SalesCycleProductById_List[position].itemCode})',
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
                  EditCompetitorName(context),
                  SizedBox(height: 10),
                  EditCompetitorPrice(context),
                  SizedBox(
                    height: 10,
                  ),
                  EditLossReason(context),
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
                      saleCycleController.getSalesProductLineCompetitorCreate(
                          saleCycleController.saleCycleList[0].salesCycleId!,
                          "line",
                          saleCycleController.get_SalesCycleProductById_List,
                          position);
                      Get.back();
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
              );
            })),
          );
        });
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

  Widget EditCompetitorPrice(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      cursorColor: AllColors.primaryDark1,
      controller:
          saleCycleController.updateCompetitorPriceProductController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
          hintText: 'Competitor Price',
          labelText: 'Competitor Price',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
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

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure minimal height
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
                      "Filter ",
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
                          height: 10,
                        ),
                        EditCompetitorName(context),
                        SizedBox(
                          height: 10,
                        ),
                        EditLossReason(context),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
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
                                          color: AllColors.primaryDark,
                                          width: 1),
                                    )),
                                onPressed: () {
                                  saleCycleController.pageNumber = 0;
                                  saleCycleController
                                      .getSaleCycleProductByIdList(
                                          saleCycleController.pageNumber,
                                          saleCycleController
                                              .saleCycleList[0].salesCycleId!);
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
                                  saleCycleController.pageNumber = 0;
                                  saleCycleController
                                      .clearSaleProductListController();
                                  saleCycleController
                                      .getSaleCycleProductByIdList(
                                          saleCycleController.pageNumber,
                                          saleCycleController
                                              .saleCycleList[0].salesCycleId!);
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
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
/*
  void showConfirmationDialogForMarkLoss(BuildContext context, SalesCycleModal saleCycleList) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Loss',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to Mark Loss?',
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
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
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
                              saleCycleController.filterQuoteAcceptedFlag.value == 'Loss';
                              saleCycleController.getSalesCycleMstUpdateSuspect(saleCycleList,
                                  saleCycleController.updateQuoteAccetedCycleController.value.text
                                  ,saleCycleController.competitorNameController.value.text, saleCycleController.quoteRejectReasonController.value.text);

                            */ /*  saleCycleController
                                  .getSalesProductLineCompetitorCreate(
                                  saleCycleController.saleCycleList[0]
                                      .salesCycleId!, "All",
                                  saleCycleController
                                      .get_SalesCycleProductById_List, 0);*/ /*
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center ,
                              child: Text('Confirm',
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
  }*/

  void updateQtySalesCycleProduct(BuildContext context, int position) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Qty (${saleCycleController.get_SalesCycleProductById_List[position].itemCode})',
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
                          saleCycleController.SalesCycleLineCreateApiHit(
                              saleCycleController
                                  .get_SalesCycleProductById_List[position]
                                  .itemCode!,
                              saleCycleController
                                  .get_SalesCycleProductById_List[position]
                                  .salesCycleId!,
                              saleCycleController
                                  .get_SalesCycleProductById_List[position]
                                  .lineNo!,
                              "Update");
                          Get.back();
                          /*  saleCycleController
                              .ProductCategoryWiseAmtCreateApiHit(id!);
                          Get.back();*/
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

  void showDialogForFilter(BuildContext context) {
    // accountMaster_page_controller.IsActive_controller.clear();
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
                          "Quote Filter ",
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
                              filterWithQuoteId(context),
                              SizedBox(height: 10),
                              filterWithQuoteStatus(context),
                              SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10),
                              TextField(
                                controller: saleCycleController
                                    .accountNameController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten,
                                        horizontal: AllFontSize.ten),
                                    labelText: 'Account Name',
                                    hintText: 'Account Name',
                                    hintStyle: GoogleFonts.poppins(
                                        color: AllColors.lightblackColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: AllFontSize.ten),
                                    labelStyle: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AllFontSize.sisxteen),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    )),
                                cursorColor: AllColors.primaryDark1,
                                onChanged: (value) {
                                  // Handle the text field value changes if needed
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: saleCycleController
                                    .accountCodeController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten,
                                        horizontal: AllFontSize.ten),
                                    labelText: 'Account Code',
                                    hintText: 'Account Code',
                                    hintStyle: GoogleFonts.poppins(
                                        color: AllColors.lightblackColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: AllFontSize.ten),
                                    labelStyle: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AllFontSize.sisxteen),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    )),
                                cursorColor: AllColors.primaryDark1,
                                onChanged: (value) {
                                  // Handle the text field value changes if needed
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteRhApproval(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuotecnhApproval(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteCategoryApproval(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteGmApproval(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteProductCategory(),
                              SizedBox(
                                height: 10,
                              ),
                             /* filterWithQuoteFrontLinerValue(),
                              SizedBox(
                                height: 10,
                              ),*/
                              filterWithQuoteBranchHead(),
                              SizedBox(
                                height: 10,
                              ),
                             /* filterWithQuoteZoneHead(),
                              SizedBox(
                                height: 10,
                              ),*/
                              filterWithQuoteClusterHead(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteCreatedOn(context),
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
                              saleCycleController.pageNumberForQuote = 0;
                              saleCycleController.getQuoteHeaderData(
                                saleCycleController.pageNumberForQuote,
                                saleCycleController
                                    .saleCycleList[0].salesCycleId!,
                                "",
                              );
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
                              saleCycleController.clearAllFieldOfQuoteFilter();
                              saleCycleController.pageNumberForQuote = 0;
                              //saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,"","");
                              saleCycleController.getQuoteHeaderData(
                                saleCycleController.pageNumberForQuote,
                                saleCycleController
                                    .saleCycleList[0].salesCycleId!,
                                "",
                              );
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

  filterWithQuoteProductCategory() {
    return TextField(
      controller: saleCycleController.productCategoryController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Product Category',
          hintText: 'Product Category',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

/*  filterWithQuoteFrontLinerValue() {
    return TextField(
      controller: saleCycleController.frontliner_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'FrontLiner Value',
          hintText: 'FrontLiner Value',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }*/

  filterWithQuoteClusterHead() {
    return TextField(
      controller: saleCycleController.cluster_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Cluster Name',
          hintText: 'Cluster Name',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  /*filterWithQuoteZoneHead() {
    return TextField(
      controller: saleCycleController.zone_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Zone Head Value',
          hintText: 'Zone Head Value',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }*/

  filterWithQuoteBranchHead() {
    return TextField(
      controller: saleCycleController.branch_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Region Name',
          hintText: 'Region Name',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.createdOnCnontroller.value,
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
          saleCycleController.createdOnStartToEnd.value = "$startDate@$endDate";
          saleCycleController.createdOnCnontroller.value.text =
              '$startDate - $endDate';
        } else {
          saleCycleController.createdOnCnontroller.value.text = '';
          saleCycleController.createdOnStartToEnd.value = "";
        }
      },
    );
  }

  /* filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: saleCycleController.createdOnCnontroller.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Created On',
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
            )
        ),
        onTap: () async {
          DateTime start_date = new DateTime(1900);
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
                  colorScheme: ColorScheme.light(
                      primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            saleCycleController.createdOnCnontroller.value.text =
                outputFormat.format(date);
          else
            saleCycleController.createdOnCnontroller.value.text =
            "";
        }


    );
  }*/

  filterWithQuoteRhApproval() {
    return TextField(
      controller: saleCycleController.rh_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Rh Approval',
          hintText: 'Rh Approval',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuotecnhApproval() {
    return TextField(
      controller: saleCycleController.cbh_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'CBH Approval',
          hintText: 'CbH Approval',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuoteCategoryApproval() {
    return TextField(
      controller: saleCycleController.category_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Category Approval',
          hintText: 'Category Approval',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuoteGmApproval() {
    return TextField(
      controller: saleCycleController.gm_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Gm Approval',
          hintText: 'Gm Approval',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  void reOpenSalesCycle(
    BuildContext context,
    SalesCycleModal saleCycleList,
  ) {
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
                    'Reopen Sales Cycle',
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
                  bindOpenRemarks(context),
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
                          context, saleCycleList.salesCycleId!);
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

  bindOpenRemarks(BuildContext context) {
    return TextField(
      maxLines: 3,
      maxLength: 500,
      controller: saleCycleController.reOpenRemarksController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Reopen Remarks*',
          hintText: 'Reopen Remarks*',
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

  showDialogConfirmation(context, String SalesId) {
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
                  Text('Do you want to Reopen this sales cycle?',
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
                          Get.back();
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
                          saleCycleController.getSalesCycleMstRejectReopen(
                              SalesId,
                              saleCycleController
                                  .reOpenRemarksController.value.text);
                          Get.back();
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
}
