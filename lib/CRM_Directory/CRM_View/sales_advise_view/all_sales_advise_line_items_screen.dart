
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_advise_all_list_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class AllSalesAdviseLineItemsScreen extends StatelessWidget{
  AllSalesAdviseLineItemsScreen({super.key});
  SalesAdviseAllListVm salesAdviseAllVmController=Get.put(SalesAdviseAllListVm());
  //SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  static String _displaySalesAdviseStatusForOption(String option) =>
      option;

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
                  'All Sales Advise Items ',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      showDialogForFilter(context);
                    },
                    child: Icon(Icons.filter_alt_rounded, size: 30,)),

              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: salesAdviseAllVmController.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:salesAdviseAllVmController.loading.value ,
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
    if (salesAdviseAllVmController.salesAdviseList.value.isNotEmpty && salesAdviseAllVmController.salesAdviseList.value.length > 0) {
      print("ghd");
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (salesAdviseAllVmController.total_rows /
              salesAdviseAllVmController.rowsPerPage)
              .toInt();
          if ((salesAdviseAllVmController.total_rows %
              salesAdviseAllVmController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${salesAdviseAllVmController.pageNumber} ${salesAdviseAllVmController.total_rows} ${salesAdviseAllVmController.rowsPerPage} ${total_page}");
          if (salesAdviseAllVmController.pageNumber + 1 < total_page) {
            salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber+1);
            salesAdviseAllVmController.pageNumber += 1;
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
          itemCount: salesAdviseAllVmController.salesAdviseList.value.length,
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
    String? quoteValidityDate=StaticMethod.convertDateFormat1(salesAdviseAllVmController.salesAdviseList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(salesAdviseAllVmController.salesAdviseList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(salesAdviseAllVmController.salesAdviseList[position].createdOn ?? "");
   // String? completedOn=StaticMethod.dateTimeToDate(salesAdviseAllVmController.salesAdviseList[position]. ?? "");
    String saleAdviseStatus = salesAdviseAllVmController.salesAdviseList[position].salesAdviceStatus?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'draft':
          return Colors.red[900]!;
        case 'completed':
          return Colors.green;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Sales Advise Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position].salesAdviceId?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position].salesAdviceId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color:Colors.blue,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),

            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(
                label: "Sales Cycle Id : ",
                value: salesAdviseAllVmController.salesAdviseList[position].salesCycleId,
                //width: size.width * 0.33,
                color: Colors.blue,
              ),
              _buildLabelWithValue(
                label: "Sales Advise Status : ",
                value: salesAdviseAllVmController.salesAdviseList[position].salesAdviceStatus,
                //width: size.width * 0.33,
                color: getStatusColor(saleAdviseStatus),
              ),

              _buildLabelWithValue(
                label: "Quote Id : ",
                value: salesAdviseAllVmController.salesAdviseList[position].quoteId,
              ),
              _buildLabelWithValue(
                label: "Quote Version: ",
                value: salesAdviseAllVmController.salesAdviseList[position].quoteVersion.toString(),
              ),
              _buildLabelWithValue(
                label: "Quote Validity: ",
                value: salesAdviseAllVmController.salesAdviseList[position].quoteValidity.toString(),
              ),
              _buildLabelWithValue(
                label: "Customer Code : ",
                value: salesAdviseAllVmController.salesAdviseList[position].accountCode,
              ),
              _buildLabelWithValue(
                label: "Customer Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position].accountName,
              ),
              _buildLabelWithValue(
                label: "Contact Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position].contactName,
              ),
              _buildLabelWithValue(
                label: "Expected Closure Date : ",
                value:  expectedClosuredateDate,
              ),
              _buildLabelWithValue(
                label: "Sales Advise Total Amt : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .quoteTotalAmount.toString(),
              ),
              _buildLabelWithValue(
                label: "Sales Advise Gst Amt. : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .quoteGstAmount.toString(),
              ),
              _buildLabelWithValue(
                label: "Sales Advise Gross Amt. : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .quoteGrossAmount.toString(),
              ),
              _buildLabelWithValue(
                label: "Created By : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .createdFullName,
              ),
              _buildLabelWithValue(
                label: "Created On : ",
                value: createdOn.toString(),
              ),
              _buildLabelWithValue(
                label: "Region Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position]
                    .zoneHeadValue,
              ),
              _buildLabelWithValue(
                label: "Cluster Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position]
                    .clustureHeadValue,
              ),
              _buildLabelWithValue(
                  label: "Item Code : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .itemCode
              ),
              _buildLabelWithValue(
                  label: "Item Name : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .itemName
              ),
              _buildLabelWithValue(
                  label: "Qty : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .qty.toString()
              ),
              _buildLabelWithValue(
                  label: "LSP : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .listSellingPrice.toString()
              ),
              _buildLabelWithValue(
                  label: "Sales Credit : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .salesCredit.toString()
              ),


            /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales Cycle Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .33,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position].salesCycleId?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position].salesCycleId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales Advise Status: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position].salesAdviceStatus?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position].salesAdviceStatus?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color:getStatusColor(saleAdviseStatus),
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quote Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .33,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position].quoteId?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position].quoteId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quote Version: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    salesAdviseAllVmController.salesAdviseList[position].quoteVersion.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
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
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .35,
                    child: Tooltip(
                      message: quoteValidityDate.toString(),
                      child: Text(
                        quoteValidityDate.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .accountCode  ?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position]
                            .accountCode ??
                            "",
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .accountName  ?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position]
                            .accountName ??
                            "",
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contact Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .4,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .contactName ?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position]
                            .contactName ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected Closure Date: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    expectedClosuredateDate.toString(),
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales Advise Total Amt : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .37,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .quoteTotalAmount.toString(),
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .quoteTotalAmount.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Sales Advise Gst Amt. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    // width: size.width * .4,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .quoteGstAmount.toString(),
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .quoteGstAmount.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Sales Advise Gross Amt. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .35,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .quoteGrossAmount.toString(),
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .quoteGrossAmount.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Created By : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .4,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .createdBy?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position]
                            .createdBy ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Created On : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .4,
                    child: Tooltip(
                      message: createdOn.toString(),
                      child: Text(
                        createdOn.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Region Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .37,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .zoneHeadValue??"",
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .zoneHeadValue??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Cluster Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    // width: size.width * .4,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .clustureHeadValue??"",
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .clustureHeadValue??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Item Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .4,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .itemCode?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position]
                            .itemCode ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Item Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(

                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .itemName?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position]
                            .itemName?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Qty : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .37,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .qty.toString(),
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .qty.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "LSP : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .37,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .listSellingPrice.toString(),
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .listSellingPrice.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
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
                    "Sales Credit : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .37,
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position]
                          .salesCredit.toString(),
                      child: Text(salesAdviseAllVmController.salesAdviseList[position]
                          .salesCredit.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
*/


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Is Spr : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.blackColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(salesAdviseAllVmController.salesAdviseList[position]
                      .isSpr==1?"Yes":"No",
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          //minChildSize: 0.5,
          //maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Padding(
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
                          "Sales Advise Filter ",
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
                              filterWithSalesAdviseId(context),
                              SizedBox(height: 10),
                              filterWithSalesAdviseStatus(context),
                              SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10),
                              TextField(
                                controller: salesAdviseAllVmController
                                    .accountNameController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten,
                                        horizontal: AllFontSize.ten),
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
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    )),
                                cursorColor: AllColors.primaryDark1,

                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: salesAdviseAllVmController
                                    .accountCodeController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten,
                                        horizontal: AllFontSize.ten),
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
                              filterWithQuoteProductCategory(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteBranchHead(),
                              SizedBox(
                                height: 10,
                              ),
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
                              salesAdviseAllVmController.pageNumber=0;
                              salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber);
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
                              salesAdviseAllVmController.clearAllField();
                              salesAdviseAllVmController.pageNumber=0;
                              salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber);
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


  Widget filterWithSalesAdviseId(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesAdviseAllVmController.salesAdviseIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Sales Advise Id',
          labelText: 'Sales Advise Id',
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
      controller:salesAdviseAllVmController.filterQuoteValidityController.value,
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
           initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),
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
          salesAdviseAllVmController.quoteValidityStartToEnd.value="$startDate@$endDate";
          salesAdviseAllVmController.filterQuoteValidityController.value.text = '$startDate - $endDate';
        } else {
          salesAdviseAllVmController.filterQuoteValidityController.value.text = '';
          salesAdviseAllVmController.quoteValidityStartToEnd.value="";
        }
      },
    );

  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesAdviseAllVmController.filterExpectedClosuredateController
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
           initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),
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
          salesAdviseAllVmController.extClosureStartToEnd.value="$startDate@$endDate";
          salesAdviseAllVmController.filterExpectedClosuredateController.value.text = '$startDate - $endDate';
        } else {
          salesAdviseAllVmController.filterExpectedClosuredateController.value.text = '';
          salesAdviseAllVmController.extClosureStartToEnd.value="";
        }
      },
    );

  }

  filterWithSalesAdviseStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: salesAdviseAllVmController.salesAdviseStatusController.value,
        label: Text(
          "Sales Advise Status",
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
          salesAdviseAllVmController.salesAdviseStatusController.value.text =
              _displaySalesAdviseStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        salesAdviseAllVmController.salesAdviseStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  filterWithQuoteProductCategory() {
    return TextField(
      controller: salesAdviseAllVmController.productCategoryController.value,
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



  filterWithQuoteClusterHead() {
    return TextField(
      controller: salesAdviseAllVmController.cluster_head_value_controller.value,
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

  filterWithQuoteBranchHead() {
    return TextField(
      controller: salesAdviseAllVmController.branch_head_value_controller.value,
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

  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesAdviseAllVmController.createdOnCnontroller
          .value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Created On Start Date -End Date',
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
           initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),
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
          salesAdviseAllVmController.createdOnStartToEnd.value="$startDate@$endDate";
          salesAdviseAllVmController.createdOnCnontroller.value.text = '$startDate - $endDate';
        } else {
          salesAdviseAllVmController.createdOnCnontroller.value.text = '';
          salesAdviseAllVmController.createdOnStartToEnd.value="";
        }
      },
    );

  }


  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
    Color color = AllColors.textColor,
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
}