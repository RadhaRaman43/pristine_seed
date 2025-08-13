
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class SalesCycleScreen extends StatelessWidget{
  SalesCycleScreen({super.key});

  SalesCycleVm salesCycleController=Get.put(SalesCycleVm());
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());

  static String _displaySaleCycleStatusForOption(String option) =>
      option;

  static String _displayApprovalStatusForOption(String option) =>
      option;

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                  'Sales Cycle',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  /*salesCycleController.SaleCycleStatusController.value.text = 'All';
                  salesCycleController.ApprovalStatusController.value.text = 'All';*/
                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh:salesCycleController.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:salesCycleController.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
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
                              backgroundColor:
                              salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Open"
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Open',
                                style: GoogleFonts.poppins(
                                  color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Open"
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                salesCycleController.filterQuoteAcceptedFlag.value = 'Open';
                                salesCycleController.quoteAcceptedForFilterOnSaleCycle.value="Open";
                                salesCycleController.pageNumber=0;
                                salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "",'',);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Won"

                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Won',
                                style: GoogleFonts.poppins(
                                  color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Won"
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                salesCycleController.filterQuoteAcceptedFlag.value = 'Won';
                                salesCycleController.quoteAcceptedForFilterOnSaleCycle.value = "Won";
                                salesCycleController.pageNumber=0;
                                salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "",'',);
                              },
                            );
                          }),
                          SizedBox(width: 8), // optional spacing between chips
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Loss"
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Loss',
                                style: GoogleFonts.poppins(
                                  color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Loss"
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                salesCycleController.filterQuoteAcceptedFlag.value = 'Loss';
                                salesCycleController.quoteAcceptedForFilterOnSaleCycle.value="Loss";
                                salesCycleController.pageNumber=0;
                                salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "",'',);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                              backgroundColor:salesCycleController.quoteAcceptedForFilterOnSaleCycle.value==""
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'All',
                                style: GoogleFonts.poppins(
                                  color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value==""
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                salesCycleController.quoteAcceptedForFilterOnSaleCycle.value="";
                                salesCycleController.filterQuoteAcceptedFlag.value = '';
                                salesCycleController.pageNumber=0;
                                salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "",'',);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Obx(() {
                      return BindCustomerListView(context);
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

  Widget BindCustomerListView(context) {

    if (salesCycleController.saleCycleList.value.isNotEmpty && salesCycleController.saleCycleList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (salesCycleController.total_rows_sales /
              salesCycleController.rowsPerPage)
              .toInt();
          if ((salesCycleController.total_rows_sales %
              salesCycleController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${salesCycleController.pageNumber} ${salesCycleController.total_rows_sales} ${salesCycleController.rowsPerPage} ${total_page}");

          /*if (salesCycleController.pageNumber + 1 != total_page) {
            salesCycleController.getsalesCycleData(salesCycleController.pageNumber +1, "", "", "Sales");
            this.salesCycleController.pageNumber += 1;
          }*/

          if (salesCycleController.pageNumber + 1 < total_page) {
            salesCycleController.getsalesCycleData(salesCycleController.pageNumber + 1, "", "", "Sales");
            salesCycleController.pageNumber += 1;
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
          itemCount: salesCycleController.saleCycleList.value.length,
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
    var createdOn=StaticMethod.dateTimeToDate(salesCycleController.saleCycleList[position].createdOn??"");
    var approvedOn=StaticMethod.dateTimeToDate(salesCycleController.saleCycleList[position].approvedOn??"");
    String saleCycleStatus = salesCycleController.saleCycleList[position].salesCycleApprovalStatus??"";
    String saleQuoteAccepted= salesCycleController.saleCycleList[position].quoteAccepted?.toLowerCase()??"";
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

    Color getQouteAcceptedColor(String status) {
      switch (status) {
        case 'open'||'won' :
          return Colors.blueAccent;
        case 'loss' :
          return AllColors.redColor;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            salesCycleController.extClosureStartToEnd.value="";
            salesCycleController.filter.value = "Customer Need Identity";
            salesCycleController.clearSaleProductListController();
          salesCycleController.salesCycleId.value=salesCycleController.saleCycleList[position].salesCycleId!;
          salesCycleController.pageNumber=0;
          salesCycleController.getsalesCycleData(salesCycleController.pageNumber, salesCycleController.saleCycleList[position].salesCycleId!, "ViewHeader", 'Sales');
          salesCycleController.itemCategorySelectedlist.value = [];
          salesCycleController.getPurchaseProcessApi();
          salesCycleController.getPurchaseTimeFrameApi();
          salesCycleController.getItemCategoryMstApi(salesCycleController.saleCycleList[position].salesCycleId! ,salesCycleController.saleCycleList[position].taskId! );
          salesCycleController.ProductCategoryWiseAmtGet(0, salesCycleController.saleCycleList[position].salesCycleId!);
          salesCycleController.pageNumber=0;
          salesCycleController.getSaleCycleProductByIdList(salesCycleController.pageNumber,salesCycleController.saleCycleList[position].salesCycleId!);
          //salesCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(salesCycleController.pageNumber,salesCycleController.saleCycleList[position].salesCycleId!);
          salesCycleController.clearAllFieldOfQuoteFilter();

          },
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelWithValue(
                label: "Sales Cycle Stage : ",
                value: salesCycleController.saleCycleList[position].salesCycleStatus,
                //width: size.width * 0.33,
                color: Colors.blue,
              ),
              _buildLabelWithValue(
                label: "Sales Cycle Id: ",
                value: salesCycleController.saleCycleList[position].salesCycleId,
              ),
              _buildLabelWithValue(
                label: "Task Id : ",
                value: salesCycleController.saleCycleList[position].taskId,
                //width: size.width * 0.36,
              ),
              _buildLabelWithValue(
                label: "Quote Accepted: ",
                value: salesCycleController.saleCycleList[position].quoteAccepted,
                color: getQouteAcceptedColor(saleQuoteAccepted),
              ),
              _buildLabelWithValue(
                label: "Approval Status : ",
                value: salesCycleController.saleCycleList[position].salesCycleApprovalStatus,
               // width: size.width * 0.36,
                color: getStatusColor(saleCycleStatus),
              ),
              _buildClickableLabel(
                label: "Customer Name : ",
                value: salesCycleController.saleCycleList[position].accountName,
                width: size.width * 0.4,
                onTap: () {
                  account_vm_controller.view = 'FromSaleCycleMainScreen';
                  contact_vm_controller.view = 'FromSaleCycleMainScreen';
                  account_vm_controller.getAccMasterBuyCodeApi(
                    salesCycleController.saleCycleList[position].accountCode!,
                  );
                },
              ),
              _buildLabelWithValue(
                label: "Customer Code : ",
                value: salesCycleController.saleCycleList[position].accountCode,
                //width: size.width * 0.4,
              ),
              _buildLabelWithValue(
                label: "Sales Cycle Owner : ",
                value: salesCycleController.saleCycleList[position].salesCycleOwnerName,
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Contact Name : ",
                value: salesCycleController.saleCycleList[position].contactName,
                //width: size.width * 0.4,
              ),
              _buildLabelWithValue(
                label: "Product Category : ",
                value: salesCycleController.saleCycleList[position].productCategory,
                //width: size.width * 0.35,
              ),
              _buildLabelWithValue(
                label: "Purchase Process : ",
                value: salesCycleController.saleCycleList[position].purchaseProcess,
                //width: size.width * 0.35,
              ),
              _buildLabelWithValue(
                label: "Company Pro. Type : ",
                value: salesCycleController.saleCycleList[position].companyProfileType,
                //width: size.width * 0.3,
              ),
              _buildLabelWithValue(
                label: "Is Commit : ",
                value: salesCycleController.saleCycleList[position].commit==1?"Yes":"No",
                //width: size.width * 0.4,
              ),
             /* _buildLabelWithValue(
                label: "Is Infra Lead : ",
                value: salesCycleController.saleCycleList[position].isInfraLead == 1 ? "Yes" : "No",
              ),*/
              _buildLabelWithValue(
                label: "Solution Accepted : ",
                value: salesCycleController.saleCycleList[position].isSolutionAccepted == 1 ? "Yes" : "No",
              ),


              /*_buildLabelWithValue(
                label: "Proposed Solution: ",
                value: salesCycleController.saleCycleList[position].proposedSolution,
              ),*/
              _buildLabelWithValue(
                label: "Pin Code : ",
                value: salesCycleController.saleCycleList[position].postCode,
              ),

              _buildLabelWithValue(
                label: "District : ",
                value: salesCycleController.saleCycleList[position].district,
              ),
              /*_buildLabelWithValue(
                label: "FrontLiner Value : ",
                value: salesCycleController.saleCycleList[position].frontlinerValue,
              ),*/
              _buildLabelWithValue(
                label: "Region Name : ",
                value: salesCycleController.saleCycleList[position].branchHeadValue,
              ),
              /*_buildLabelWithValue(
                label: "Zone Head Value: ",
                value: salesCycleController.saleCycleList[position].zoneHeadValue,
              ),*/
              _buildLabelWithValue(
                label: "Cluster Name : ",
                value: salesCycleController.saleCycleList[position].clustureHeadValue,
              ),

              _buildLabelWithValue(
                label: "Created By : ",
                value: salesCycleController.saleCycleList[position].createdFullName,
                //width: size.width * 0.4,
              ),
              _buildLabelWithValue(
                label: "Approved By : ",
                value: salesCycleController.saleCycleList[position].approvedBy == ""
                    ? ""
                    : salesCycleController.saleCycleList[position].approvedFullName,
                //width: size.width * 0.4,
              ),
              _buildLabelWithValue(
                label: "Exp. Closure Date : ",
                value: salesCycleController.saleCycleList[position].estClosureDate,
                //width: size.width * 0.3,
              ),
              _buildLabelWithValue(
                label: "Created On: ",
                value: createdOn,
                //: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Approved/Rejected On: ",
                value: approvedOn,
                //width: size.width * 0.4,
              ),

              _buildLabelWithValue(
                label: "Reject Reason : ",
                value: salesCycleController.saleCycleList[position].rejectReason,
                //width: size.width * 0.4,
              ),
            ],
          ),

        //todo commented by nirupma
          /*Column(
            children: [
              Row(
                children: [
                  Text(
                    "Sales Cycle Status : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .33,
                    child: Tooltip(
                      message: salesCycleController.saleCycleList[position].salesCycleStatus?? "",
                      child: Text(
                        salesCycleController
                            .saleCycleList[position]
                            .salesCycleStatus ?? "",
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
              Row(
                children: [
                  Text(
                    "Sales Cycle Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    salesCycleController.saleCycleList[position].salesCycleId ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Approval Status : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .36,
                    child: Tooltip(
                      message: salesCycleController
                          .saleCycleList[position]
                          .salesCycleApprovalStatus ?? "",
                      child: Text(salesCycleController
                          .saleCycleList[position]
                          .salesCycleApprovalStatus ?? "",
                        style: GoogleFonts.poppins(
                            color: getStatusColor(saleCycleStatus),
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,

                      ),

                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    child: Container(
                      width: size.width * .4,
                      child: Tooltip(
                        message: salesCycleController
                            .saleCycleList[position].accountName?? "",
                        child: Text(
                          salesCycleController
                              .saleCycleList[position]
                              .accountName ??
                              "" ,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,),
                        ),
                      ),
                    ),
                    onTap: (){
                      account_vm_controller.view='FromSaleCycleMainScreen';
                      contact_vm_controller.view='FromSaleCycleMainScreen';
                      account_vm_controller.getAccMasterBuyCodeApi(salesCycleController
                          .saleCycleList[position]
                          .accountCode!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Contact Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: salesCycleController
                          .saleCycleList[position]
                          .contactName ?? "",
                      child: Text(
                        salesCycleController
                            .saleCycleList[position]
                            .contactName ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Product Category : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message: salesCycleController
                          .saleCycleList[position]
                          .productCategory ?? "",
                      child: Text(
                        salesCycleController
                            .saleCycleList[position]
                            .productCategory ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Is Infra Lead : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    salesCycleController
                        .saleCycleList[position]
                        .isInfraLead==1?"Yes":"No",
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Created By : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: salesCycleController
                          .saleCycleList[position]
                          .createdFullName?? "",
                      child: Text(
                          salesCycleController
                              .saleCycleList[position]
                              .createdFullName ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Manager Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: salesCycleController
                          .saleCycleList[position]
                          .approvedFullName.toString(),
                      child: Text(salesCycleController
                          .saleCycleList[position]
                          .approvedBy==""?"":
                        salesCycleController
                            .saleCycleList[position]
                            .approvedFullName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Remarks : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: salesCycleController
                          .saleCycleList[position]
                          .salesCycleRemarks ?? "",
                      child: Text(salesCycleController
                          .saleCycleList[position]
                          .salesCycleRemarks ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),*/
          trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
      ),
    );
  }

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
    Color color = AllColors.textColor,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
       /* width != null
            ? Container(
          width: width,
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
        )
            :*/ Flexible(
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

  Widget _buildClickableLabel({
    required String label,
    required String? value,
    required VoidCallback onTap,
    double? width,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            child: Tooltip(
              message: value ?? "",
              child: Text(
                value ?? "",
                overflow: TextOverflow.ellipsis,
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
        ),
      ],
    );
  }


  void showFilterBottomSheet(BuildContext context) {
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
                        Icon(Icons.shield_moon_rounded, color: AllColors.primaryDark1,),
                        SizedBox(width: 5,),
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              bindSaleCycleIdDropDown(context),
                              SizedBox(
                                height: 5,
                              ),
                              Obx((){
                                return Visibility(
                                  visible: salesCycleController.filterQuoteAcceptedFlag.value=='',
                                    child:Column(
                                  children: [
                                    bindQuoteAccepted(context),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ) );
                              }),

                              bindTaskId(),
                              SizedBox(
                                height: 5,
                              ),
                              bindSaleCycleStatusDropDown(context),
                              SizedBox(
                                height: 10,
                              ),
                              bindApprovalStatusDropDown(context),
                              SizedBox(
                                height: 10,
                              ),

                              TextField(
                                controller: salesCycleController.accountNameController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Customer Name',
                                    hintText: 'Customer Name',
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
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              TextField(
                                controller: salesCycleController.accountCodeController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Customer Code',
                                    hintText: 'Customer Code',
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
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              bindSaleCycleOwner(),
                              SizedBox(
                                height: 10,
                              ),

                              bindProductCategory(),
                              SizedBox(
                                height: 10,
                              ),

                              bindPurchaseProcess(),
                              SizedBox(
                                height: 10,
                              ),


                              bindCompProfileTypeDropDown(),
                              SizedBox(
                                height: 10,
                              ),

                              bindIsCommintdrpdown(context),
                              SizedBox(
                                height: 10,
                              ),

                              bindSolutionAccepted(context),
                              SizedBox(
                                height: 10,
                              ),
                            /*  bindProposedSolution(context),
                              SizedBox(
                                height: 10,
                              ),*/


                              bindPostalCode(),
                              SizedBox(
                                height: 10,
                              ),
                              bindDistrict(),
                              SizedBox(
                                height: 10,
                              ),


                             /* bindFrontLinerValue(),
                              SizedBox(
                                height: 10,
                              ),*/
                              bindBranchHead(),
                              SizedBox(
                                height: 10,
                              ),
                             /* bindZoneHead(),
                              SizedBox(
                                height: 10,
                              ),*/
                              bindClusterHead(),
                              SizedBox(
                                height: 10,
                              ),
                              bindCreatedBy(),
                              SizedBox(
                                height: 10,
                              ),

                              bindExpectedClosureDate(context),
                              SizedBox(
                                height: 10,
                              ),

                              bindCreatedOn(context),
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.primaryDark,
                                  width: 1),
                            )),
                            onPressed: () {
                              Get.back();
                              salesCycleController.pageNumber = 0;
                              salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "","","");
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
                              Get.back();
                              salesCycleController.clearAllFieldOfFilter();
                              salesCycleController.pageNumber=0;
                              salesCycleController.getsalesCycleData(salesCycleController.pageNumber,"","","");

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

 /* void showFilterBottomSheet(BuildContext context) {
    salesCycleController.pageNumber = 0;
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
                    Icon(Icons.shield_moon_rounded, color: AllColors.primaryDark1,),
                    SizedBox(width: 5,),
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
                        SizedBox(
                          height: 5,
                        ),
                        bindSaleCycleStatusDropDown(context),

                        SizedBox(
                          height: 10,
                        ),
                        bindSaleCycleIdDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        bindApprovalStatusDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        TextField(
                          controller: salesCycleController.accountNameController.value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
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
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        TextField(
                          controller: salesCycleController.contactNameController.value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              labelText: 'Contact Name',
                              hintText: 'Contact Name',
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
                        ),

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
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark,
                                      width: 1),
                                )),
                                onPressed: () {
                                  Get.back();
                                  salesCycleController.pageNumber = 0;
                                  salesCycleController.getsalesCycleData(salesCycleController.pageNumber, '', '', '');
                                  //TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.SaleCycleActive_Controller.text, '', '', TaskMaster_page_controller.Task_status_controller.text.toString());


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

                                  Get.back();
                                  salesCycleController.accountNameController.value.clear();
                                  salesCycleController.contactNameController.value.clear();
                                  salesCycleController.SaleCycleStatusController.value.clear();
                                  salesCycleController.ApprovalStatusController.value.clear();
                                  salesCycleController.saleCycleController.value.clear();
                                  salesCycleController.pageNumber = 0;
                                  salesCycleController.getsalesCycleData(salesCycleController.pageNumber, '', '', '');
                                  

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
  }*/

  Widget bindSaleCycleStatusDropDown(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: salesCycleController.SaleCycleStatusController.value,
        label: Text(
          "Sales Cycle Stage",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
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
          salesCycleController.SaleCycleStatusController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
          /*print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');*/

        },
        dropdownMenuEntries:
        salesCycleController.SaleCycleStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );

    return Autocomplete<String>(
      displayStringForOption: _displaySaleCycleStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return salesCycleController.SaleCycleStatusList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return salesCycleController.SaleCycleStatusList
            .where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        // Update the TextField with the selected
        salesCycleController.SaleCycleStatusController.value.text =
            _displaySaleCycleStatusForOption(selection).toString();
        //print('IsActive.....${TaskMaster_page_controller.Task_status_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = salesCycleController.SaleCycleStatusController.value
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Sale Cycle Status',
              labelText: 'Sale Cycle Status',
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
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width*.9,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option =
                  suggestions.elementAt(index);
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

  Widget bindApprovalStatusDropDown(BuildContext context){
    return Container(
      padding: const EdgeInsets.only( right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: salesCycleController.ApprovalStatusController.value,
        label: Text(
          "Approval Status",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
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
          salesCycleController.ApprovalStatusController.value.text =
              _displayApprovalStatusForOption(selection!)
                  .toString();
          /*print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');*/

        },
        dropdownMenuEntries:
        salesCycleController.ApprovalStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
    //todo commented by nirupma because dropdown is not working properly
   /* return Autocomplete<String>(
      displayStringForOption: _displayApprovalStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return salesCycleController.ApprovalStatusList;
        }
        return salesCycleController.ApprovalStatusList
            .where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        // Update the TextField with the selected
        salesCycleController.ApprovalStatusController.value.text =
            _displayApprovalStatusForOption(selection).toString();
        //print('IsActive.....${TaskMaster_page_controller.Task_status_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = salesCycleController.ApprovalStatusController.value
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Approval Status',
              labelText: 'Approval Status',
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
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width*.9,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option =
                  suggestions.elementAt(index);
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
    );*/
  }

 Widget bindSaleCycleIdDropDown(BuildContext context) {
  return  TextField(
     controller: salesCycleController.saleCycleController.value,
     decoration: InputDecoration(
         contentPadding: EdgeInsets.symmetric(
             vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
         labelText: 'Sale Cycle Id',
         hintText: 'Sale Cycle Id',
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



  bindTaskId() {
    return TextField(
      controller: salesCycleController.filterTask_Id_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Task Id',
          hintText: 'Task Id',
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

  bindCompProfileTypeDropDown() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesCycleController.companyProfileTypeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Company Profile Type',
          hintText: 'Company Profile Type',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindPostalCode() {
    return TextField(
      controller: salesCycleController.postalCodeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Pin Code',
          hintText: 'Pin Code',
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

  bindDistrict() {
    return TextField(
      controller: salesCycleController.district_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'District',
          hintText: 'District',
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

  bindCreatedBy() {
    return TextField(
      controller: salesCycleController.createdByController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Created By',
          hintText: 'Created By',
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

/*  bindFrontLinerValue() {
    return TextField(
      controller: salesCycleController.frontliner_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }*/

  bindClusterHead() {
    return TextField(
      controller: salesCycleController.cluster_head_value_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  /*bindZoneHead() {
    return TextField(
      controller: salesCycleController.zone_head_value_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }*/

  bindBranchHead() {
    return TextField(
      controller: salesCycleController.branch_head_value_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindSaleCycleOwner() {
    return TextField(
      controller: salesCycleController.salesCycleOwnerController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Sales Cycle Owner',
          hintText: 'Sales Cycle Owner',
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

  bindProductCategory() {
    return TextField(
      controller: salesCycleController.productCategoryController.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindPurchaseProcess() {
    return TextField(
      controller: salesCycleController.purchaseProcessController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Purchase Process',
          hintText: 'Purchase Process',
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

  Widget bindSolutionAccepted(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( bottom: 10, right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: salesCycleController.solutionAcceptedController.value,
        label: Text(
          "Solution Accepted",
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
          salesCycleController.solutionAcceptedController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!)
                  .toString();
          print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');

        },
        dropdownMenuEntries:
        salesCycleController.customerNeedIdentityList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindIsCommintdrpdown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size.width-15,
      controller: salesCycleController.isCommitController.value,
      label: Text(
        "Is Commit",
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
        salesCycleController.isCommitController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!)
                .toString();
      },
      dropdownMenuEntries:
      salesCycleController.customerNeedIdentityList.map<
          DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );
  }

  Widget bindProposedSolution(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesCycleController.proposedSolutionController.value,
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



  bindExpectedClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesCycleController.filterExpectedClosuredateController
          .value,
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
          salesCycleController.extClosureStartToEnd.value="$startDate@$endDate";
          salesCycleController.filterExpectedClosuredateController.value.text = '$startDate - $endDate';
        } else {
          salesCycleController.filterExpectedClosuredateController.value.text = '';
          salesCycleController.extClosureStartToEnd.value="";
        }
      },
    );
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: salesCycleController.filterExpectedClosuredateController
            .value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
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
            salesCycleController.filterExpectedClosuredateController.value.text =
                outputFormat.format(date);
          else
            salesCycleController.filterExpectedClosuredateController.value.text =
            "";
        }


    );
  }

 /* bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: salesCycleController.createdOnCnontroller.value,
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
            salesCycleController.createdOnCnontroller.value.text =
                outputFormat.format(date);
          else
            salesCycleController.createdOnCnontroller.value.text =
            "";
        }


    );
  }*/
  bindCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesCycleController.createdOnCnontroller.value,
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
          salesCycleController.createdOnStartToEnd.value="$startDate@$endDate";
          salesCycleController.createdOnCnontroller.value.text = '$startDate - $endDate';
        } else {
          salesCycleController.createdOnCnontroller.value.text = '';
          salesCycleController.createdOnStartToEnd.value="";
        }
      },
    );
  }

  bindQuoteAccepted(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: salesCycleController.filterQuoteAcceptedController.value,
        label: Text(
          "Select Quote Accepted",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
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
          if(selection=="Open"){
            salesCycleController.filterQuoteAcceptedFlag.value = 'Open';
          }
          else if(selection=="Won"){
            salesCycleController.filterQuoteAcceptedFlag.value = 'Won';
          }
          else if(selection=="Loss"){
            salesCycleController.filterQuoteAcceptedFlag.value = 'Loss';
          }else{
            salesCycleController.filterQuoteAcceptedFlag.value = '';
          }
          salesCycleController.filterQuoteAcceptedController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        salesCycleController.qouteAcceptedList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }




}