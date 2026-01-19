import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../constants/static_methods.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/pending_Draft_Quote_vm.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class AllQuoteLineItemScreen extends StatelessWidget{
  AllQuoteLineItemScreen({super.key});
  PendingDraftQuoteVm pendingDraftQuoteController=Get.put(PendingDraftQuoteVm());
  SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());

  static String _displayQuoteStatusForOption(String option) =>
      option;
  static String _displaySaleCycleActiveForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        Get.toNamed(RoutesName.homeScreen);
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
                    "All Quote Line Item List",
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {
                    showDialogForFilter(context);
                  }, icon: Icon(Icons.filter_alt_sharp))
                ],
              )
          ),
          drawer: CustomDrawer(),
          body: RefreshIndicator(
            onRefresh:pendingDraftQuoteController.refreshList,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Obx((){
                    return Visibility(
                      visible:pendingDraftQuoteController.loading.value ,
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
                        return BindPendingListView(context);
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        );
  }

  Widget BindPendingListView(context) {
    if (pendingDraftQuoteController.PendingDraftQuoteList.value.isNotEmpty && pendingDraftQuoteController.PendingDraftQuoteList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (pendingDraftQuoteController.total_rows /
              pendingDraftQuoteController.rowsPerPage)
              .toInt();
          if ((pendingDraftQuoteController.total_rows %
              pendingDraftQuoteController.rowsPerPage) >
              0) total_page += 1;

          // print("last index ${pendingDraftQuoteController.pageNumberForQuote} ${pendingDraftQuoteController.total_rows} ${pendingDraftQuoteController.rowsPerPage} ${total_page}");
          if (pendingDraftQuoteController.pageNumberForQuote + 1 < total_page) {
            pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote+1, "ALLQuoteLineItems");
            pendingDraftQuoteController.pageNumberForQuote += 1;
          }
        }
      });

      return ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          separatorBuilder: (context, index) => Divider(
            height: .05,
            color: Colors.transparent,
          ),
          shrinkWrap: true,
          itemCount: pendingDraftQuoteController.PendingDraftQuoteList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    String? quoteValidityDate=StaticMethod.convertDateFormat1(pendingDraftQuoteController.PendingDraftQuoteList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(pendingDraftQuoteController.PendingDraftQuoteList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(pendingDraftQuoteController.PendingDraftQuoteList[position].createdOn ?? "");
    String saleCycleStatus = pendingDraftQuoteController.PendingDraftQuoteList[position].quoteStatus?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'rejected':
          return Colors.red[600]!;
        case 'approved':
          return Colors.green[700]!;
        case 'draft':
          return Colors.red[900]!;
        case 'pending for approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          onTap: () {
            saleCycleController.quoteId.value =
            pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId!;
            saleCycleController.getApprovalPersonList(pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId??"");
            // saleCycleController.quoteApprovalPage.value="quoteApprovalScreen";
            saleCycleController.getQuoteHeaderInformation(pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId, "ALLQuoteLineItems");
          },
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
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .33,
                    child: Tooltip(
                      message: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId?? "",
                      child: Text(
                        pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color:Colors.blue,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Quote Version: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].quoteVersion.toString(),color:AllColors.textColor),
              _buildLabelOnTap(label: "Sales Cycle Id: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].salesCycleId ?? "",color:Colors.blueAccent,
                onTap: (){
                  saleCycleController.ProductCategoryWiseAmtGet(0, pendingDraftQuoteController.PendingDraftQuoteList[position].salesCycleId!);
                  saleCycleController.pageNumber = 0;
                  saleCycleController.filterQuoteAcceptedFlag.value="";
                  saleCycleController.clearAllFieldOfFilter();
                  saleCycleController.getsalesCycleData(saleCycleController.pageNumber, pendingDraftQuoteController.PendingDraftQuoteList[position]
                      .salesCycleId!, "ViewHeader", "FromALLQuoteLineItems");
                },),
              _buildLabelOnTap(label: "Customer Name: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].accountName ?? "",color:Colors.blueAccent,
                onTap: (){
                  account_vm_controller.view = 'FromALLQuoteLineItems';
                  contact_vm_controller.view = 'FromALLQuoteLineItems';
                  account_vm_controller.getAccMasterBuyCodeApi(
                      pendingDraftQuoteController
                          .PendingDraftQuoteList[position].accountCode!);
                },),
              _buildLabelWithValue(label: "Customer Code: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].accountCode ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Contact Name: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].contactName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Product Category: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].productCategory ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Status: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].quoteStatus ?? "",color:getStatusColor(saleCycleStatus)),
              _buildLabelWithValue(label: "Quote Validity: ", value:  quoteValidityDate.toString(),color:AllColors.textColor),
              _buildLabelWithValue(label: "Expected Closure Date: ", value: expectedClosuredateDate.toString(),color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Commit: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].quoteCommit.toString()=="0"?"No":"Yes" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Rejected Reason: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].rejectReason ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "RH Approval: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].rhApproval ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "CBH Approval: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].cbhApproval ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "GM  Approval: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].gmApproval ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Cluster Name: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].clustureHeadValue ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Region Name: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].zoneHeadValue ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Item Code: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].itemCode ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Item Name: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].itemName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Qty: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].qty.toString() ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "LSP: ", value:  "₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].listSellingPrice.toString() ?? ""}",color:AllColors.textColor),
              _buildLabelWithValue(label: "MAP: ", value:  "₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].minimalAcceptablePrice.toString() ?? ""}",color:AllColors.textColor),
              _buildLabelWithValue(label: "BTP: ", value:  "₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].branchTransferPrice.toString() ?? ""}",color:AllColors.textColor),
              _buildLabelWithValue(label: "BM %: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].bmDiscountPer.toString(),color:AllColors.textColor),
              _buildLabelWithValue(label: "GM %: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].gmDiscountPer.toString(),color:AllColors.textColor),
              _buildLabelWithValue(label: "Standard Cost: ", value:  "₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].standardCost.toString() ?? ""}",color:AllColors.textColor),
              _buildLabelWithValue(label: "Sales Credit: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].salesCredit.toString()??"",color:AllColors.textColor),
              _buildLabelWithValue(label: "Is Active: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].isActive.toString()=="1"? "Yes":"No",color:AllColors.textColor),
              _buildLabelWithValue(label: "Installation Charges : ", value:"₹ ${ pendingDraftQuoteController.PendingDraftQuoteList[position].installationCharges.toString() ?? ""}" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Other Charges : ", value:"₹ ${ pendingDraftQuoteController.PendingDraftQuoteList[position].otherCharges.toString() ?? ""}" ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Warranty Period : ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].warrantyPeriod.toString() ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Delivery In Weeks : ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].deliveryInWeeks.toString() ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Advance Payment Per : ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].advancePaymentPer.toString() ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Advance Payment Amt : ", value:"₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].advancePaymentAmt.toString() ?? ""}"  ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Other Remarks : ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].otherRemarks ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Is Spr: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].isSpr.toString()=="1"? "Yes":"No",color:AllColors.textColor),
              _buildLabelWithValue(label: "Spr No.: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].sprNo ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Total Amt: ", value:"₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].quoteTotalAmount.toString() ?? ""}"  ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Gross Amt: ", value:"₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].quoteGrossAmount.toString() ?? ""}"  ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Gst Amt: ", value:"₹ ${pendingDraftQuoteController.PendingDraftQuoteList[position].quoteGstAmount.toString() ?? ""}"  ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Created By: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].createdFullName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Created on: ", value: StaticMethod.onlyDate(pendingDraftQuoteController.PendingDraftQuoteList[position].createdOn ?? "") ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Updated By: ", value: StaticMethod.onlyDate(pendingDraftQuoteController.PendingDraftQuoteList[position].approvedFullName ?? "") ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Updated on: ", value: StaticMethod.onlyDate(pendingDraftQuoteController.PendingDraftQuoteList[position].updatedOn ?? "") ,color:AllColors.textColor),
              _buildLabelWithValue(label: "Reporting Manager: ", value:  pendingDraftQuoteController.PendingDraftQuoteList[position].approvedFullName ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Approved on: ", value: StaticMethod.onlyDate(pendingDraftQuoteController.PendingDraftQuoteList[position].approvedOn ?? "") ,color:AllColors.textColor),

            ],
          ),
          //trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
        ),
      ),
    );
  }

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    required Color color,

  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Tooltip(
            message: value??"",
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
      ],
    );
  }
  Widget _buildLabelOnTap({
    required String label,
    required String? value,
    required Color color,
    required void Function() onTap,

  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),
        Flexible(
          child: InkWell(
            onTap: onTap,
            child: Tooltip(
              message: value??"",
              child: Text(value??"",
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
                overflow: TextOverflow.ellipsis,

              ),

            ),
          ),
        ),
      ],
    );
  }


  void showDialogForFilter(BuildContext context) {
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
                        Icon(Icons.shield_moon_rounded, color: AllColors.primaryDark1,),
                        SizedBox(width: 5,),
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
                              SizedBox(height: 5,),
                              bindData(context,'Quote Id', pendingDraftQuoteController.filterQuoteIdController.value),
                              SizedBox(height: 10),
                              bindData(context,'Quote Version', pendingDraftQuoteController.filterQuoteVersionController.value),
                              SizedBox(height: 10),
                              bindData(context,'Sale Cycle Id', pendingDraftQuoteController.filterQuoteSaleCycleController.value),
                              SizedBox(height: 10),
                              bindData(context,'Customer Code', pendingDraftQuoteController.accountCodeController.value),
                              SizedBox(height: 10),
                              bindData(context,'Customer Name', pendingDraftQuoteController.accountNameController.value),
                              SizedBox(height: 10,),
                              filterWithQuoteStatus(context),
                              SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10),
                              bindData(context,'Rh Approval', pendingDraftQuoteController.rh_Approval_controller.value),
                              SizedBox(height: 10,),
                              bindData(context,'CBH Approval', pendingDraftQuoteController.cbh_Approval_controller.value),
                              SizedBox(height: 10,),
                              bindData(context,'Category Approval', pendingDraftQuoteController.category_Approval_controller.value),
                              SizedBox(height: 10,),
                              bindData(context,'Gm Approval', pendingDraftQuoteController.gm_Approval_controller.value),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindData(context,'Item Code', pendingDraftQuoteController.itemCodeController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Item Name', pendingDraftQuoteController.itemNameController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Quantity', pendingDraftQuoteController.quantityFilterController.value),
                              SizedBox(height: 10,),
                              bindData(context,'GM Discount %', pendingDraftQuoteController.GmDiscountPerController.value),
                              SizedBox(height: 10,),
                              bindData(context,'BM Discount %', pendingDraftQuoteController.BmDiscountPerController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Sales Credit', pendingDraftQuoteController.SalesCreditController.value),
                              SizedBox(height: 10,),
                              bindData(context,'LSP', pendingDraftQuoteController.LSPFilterController.value),
                              SizedBox(height: 10,),
                              bindData(context,'BTP', pendingDraftQuoteController.BTPFilterController.value),
                              SizedBox(height: 10,),
                              bindData(context,'MAP', pendingDraftQuoteController.MAPFilterController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Standard Cost', pendingDraftQuoteController.StandardCostController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Created By', pendingDraftQuoteController.createdByCnontroller.value),
                              SizedBox(height: 10,),
                              filterWithQuoteCreatedOn(context),
                              SizedBox(height: 10,),
                              bindProductCategory(context),
                              SizedBox(height: 10,),
                              bindProductCategoryTypeDropDown(context),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: _buildButton(
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            pendingDraftQuoteController.clearQuoteLineItemFilterData();
                            pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
                            pendingDraftQuoteController.pageNumberForQuote = 0;
                            pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLQuoteLineItems");
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            pendingDraftQuoteController.pageNumberForQuote = 0;
                            pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLQuoteLineItems");
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            pendingDraftQuoteController.SaveQuoteLineItemFilterData();
                          },
                        )),
                      ],
                    ),
                  ),

                 /* Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.primaryDark,
                                  width: 1),
                            )),
                            onPressed: () {

                              pendingDraftQuoteController.pageNumberForQuote = 0;
                              pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLQuoteLineItems");
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.redColor, width: 1),
                            )),
                            onPressed: () {

                              pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
                              pendingDraftQuoteController.pageNumberForQuote = 0;
                              pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLQuoteLineItems");
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

  bindData(BuildContext context, String labelText, TextEditingController controller,) {
    return TextField(
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }


  bindProductCategory(BuildContext context) {
    return Obx(() {
      if (pendingDraftQuoteController.productCategoryController.value.text.isNotEmpty && pendingDraftQuoteController.filterDataChecker.value=='1') {
        List<String> nameList = pendingDraftQuoteController.productCategoryController.value.text.split('|');
        pendingDraftQuoteController.Selected_Item_Category_master_list_without_task.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: pendingDraftQuoteController.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: pendingDraftQuoteController.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: pendingDraftQuoteController.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
            hintText:  "Product Category" ,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty) {
            return Text(
              "Product Category",
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
              selectedItems.map((e) => e.categoryName).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<ItemCategoryMstModel> selectedList) {
          pendingDraftQuoteController.Selected_Item_Category_master_list_without_task.value = selectedList;
          pendingDraftQuoteController.productCategoryController.value.text =
              selectedList.map((e) => e.categoryName).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
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
            title: Text(item.categoryName ?? ""),
          ),
        ),
      );
    });
  }

  Widget bindProductCategoryTypeDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: pendingDraftQuoteController.product_category_type_Controller.value,
      label: Text(
        "Product Category Type",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.sisxteen,
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
        pendingDraftQuoteController.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: pendingDraftQuoteController.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }

  Widget filterWithQuoteStatus(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: pendingDraftQuoteController.quoteStatusController.value,
        label: Text(
          "Quote Status",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
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


        onSelected: (String? selection) {
          print(selection);
          pendingDraftQuoteController.quoteStatusController.value.text =
              _displayQuoteStatusForOption(selection!)
                  .toString();

        },
        dropdownMenuEntries:
        pendingDraftQuoteController.AllQuoteStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: pendingDraftQuoteController.filterQuoteValidityController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
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
          pendingDraftQuoteController.quoteValidityStartToEnd.value = "$startDate@$endDate";
          pendingDraftQuoteController.filterQuoteValidityController.value.text =
          '$startDate - $endDate';
        } else {
          pendingDraftQuoteController.filterQuoteValidityController.value.text = '';
          pendingDraftQuoteController.quoteValidityStartToEnd.value = "";
        }
      },
    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: pendingDraftQuoteController.filterExpectedClosuredateController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
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
          pendingDraftQuoteController.extClosureStartToEnd.value = "$startDate@$endDate";
          pendingDraftQuoteController.filterExpectedClosuredateController.value.text =
          '$startDate - $endDate';
        } else {
          pendingDraftQuoteController.filterExpectedClosuredateController.value.text = '';
          pendingDraftQuoteController.extClosureStartToEnd.value = "";
        }
      },
    );
  }

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = pendingDraftQuoteController.clusterGetByEmailList;
      if (pendingDraftQuoteController.clusterName_controller.value.text.isNotEmpty && pendingDraftQuoteController.filterDataChecker.value=='1') {
        List<String> nameList = pendingDraftQuoteController.clusterName_controller.value.text.split('|');
        pendingDraftQuoteController.SelectedCluster_list.value =[];
        pendingDraftQuoteController.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && pendingDraftQuoteController.SelectedCluster_list.isEmpty) {
          pendingDraftQuoteController.SelectedCluster_list.assignAll(availableItems);
          pendingDraftQuoteController.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          pendingDraftQuoteController.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = pendingDraftQuoteController.SelectedCluster_list;
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
              tempSelected.addAll(pendingDraftQuoteController.SelectedCluster_list);

              List<ClusterModal> allItems =
                  pendingDraftQuoteController.clusterGetByEmailList;

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
                              ? const Center(child: Text('No clusters found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
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
                              horizontal: 16.0, vertical: 12),
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

                                    pendingDraftQuoteController.filterDataChecker.value='';
                                    pendingDraftQuoteController.SelectedCluster_list.assignAll(tempSelected);
                                    pendingDraftQuoteController.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    pendingDraftQuoteController.getRegionsWithClusterFilterGetByEmail();

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
      final availableItems = pendingDraftQuoteController.regionwithclusterGetByEmailList;
      if (pendingDraftQuoteController.RegionName_controller.value.text.isNotEmpty && pendingDraftQuoteController.filterDataChecker.value=='1') {
        pendingDraftQuoteController.SelectedRegion_list.value=[];
        List<String> nameList = pendingDraftQuoteController.RegionName_controller.value.text.split('|');
        pendingDraftQuoteController.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && pendingDraftQuoteController.SelectedRegion_list.isEmpty) {
          pendingDraftQuoteController.SelectedRegion_list.assignAll(availableItems);
          pendingDraftQuoteController.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${pendingDraftQuoteController.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = pendingDraftQuoteController.SelectedRegion_list;
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
              tempSelected.addAll(pendingDraftQuoteController.SelectedRegion_list);

              final allItems = pendingDraftQuoteController.regionwithclusterGetByEmailList;

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
                          child: filtered.isEmpty
                              ? const Center(child: Text('No regions found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
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
                              horizontal: 16.0, vertical: 12),
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
                                    pendingDraftQuoteController.filterDataChecker.value='';
                                    pendingDraftQuoteController.SelectedRegion_list.assignAll(tempSelected);
                                    pendingDraftQuoteController.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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

  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: pendingDraftQuoteController.createdOnCnontroller.value,
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
          pendingDraftQuoteController.createdOnStartToEnd.value = "$startDate@$endDate";
          pendingDraftQuoteController.createdOnCnontroller.value.text =
          '$startDate - $endDate';
        } else {
          pendingDraftQuoteController.createdOnCnontroller.value.text = '';
          pendingDraftQuoteController.createdOnStartToEnd.value = "";
        }
      },
    );
  }

}