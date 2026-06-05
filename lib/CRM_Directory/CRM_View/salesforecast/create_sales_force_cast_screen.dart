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
import '../../CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';

class CreateSalesForceCastScreen extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();
  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:  () async {
      Get.toNamed(RoutesName.SalesForeCastScreen);
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
                    'Create ForceCast List',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              )
          ),
          drawer: CustomDrawer(),
          body:  Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:sales_force_cast_vm.loading.value ,
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
                              backgroundColor: AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(sales_force_cast_vm.month_controller.value.text,
                                  style: TextStyle(
                                    color:  AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                              onPressed: () {
                              },
                            );
                          }),
                          const SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor: AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(sales_force_cast_vm.year_controller.value.text,
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {

                              },
                            );
                          }),
                          const SizedBox(width: 8),
                          ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor: AllColors.bluegrayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text("Get Quote",
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                sales_force_cast_vm.showList.value=true;
                              },
                            ),
                          const SizedBox(width: 8),



                        ],
                      ),
                    ),
                  ),
                ),
                Obx((){
                  return Visibility(
                    visible: sales_force_cast_vm.showList.value,
                    child: Column(
                      children: [
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

                                /*Obx(() {
                                  return */Visibility(
                                    visible: true,
                                    child: ActionChip(
                                      elevation: 2,
                                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                                      backgroundColor: AllColors.grayColor,
                                      shadowColor: Colors.black,
                                      shape: StadiumBorder(
                                        side: BorderSide(color: AllColors.grayColor),
                                      ),
                                      label: Text("Get Quote Item",
                                        style: TextStyle(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onPressed: () {

                                      },
                                    ),
                                  ),
                                //}),

                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //showDialogForFilter(context);
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

                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: AllColors.bluegrayColor,
                        ),
                        //SizedBox(height: 10,),
                        Obx(() {
                          return BindPendingListView(context,);
                        }),
                      ],
                    ),
                  );
                })

              ],
            ),
          ),
        ));
  }

  Widget BindPendingListView(context) {
    if (sales_force_cast_vm.QuoteList.value.isNotEmpty && sales_force_cast_vm.QuoteList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (sales_force_cast_vm.total_rows /
              sales_force_cast_vm.rowsPerPage)
              .toInt();
          if ((sales_force_cast_vm.total_rows %
              sales_force_cast_vm.rowsPerPage) >
              0) total_page += 1;

          // print("last index ${sales_force_cast_vm.pageNumberForQuote} ${sales_force_cast_vm.total_rows} ${sales_force_cast_vm.rowsPerPage} ${total_page}");
          if (sales_force_cast_vm.pageNumberForQuote + 1 < total_page) {
            sales_force_cast_vm.getQuoteList(sales_force_cast_vm.pageNumberForQuote+1,);
            sales_force_cast_vm.pageNumberForQuote += 1;
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
          itemCount: sales_force_cast_vm.QuoteList.value.length,
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
    String? quoteValidityDate=StaticMethod.convertDateFormat1(sales_force_cast_vm.QuoteList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(sales_force_cast_vm.QuoteList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(sales_force_cast_vm.QuoteList[position].createdOn ?? "");
    String saleCycleStatus = sales_force_cast_vm.QuoteList[position].quoteStatus?.toLowerCase()??"";
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
                      message: sales_force_cast_vm.QuoteList[position].quoteId?? "",
                      child: Text(
                        sales_force_cast_vm.QuoteList[position].quoteId?? "",
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
             /* Row(
                children: [
                  Visibility(
                    visible:sales_force_cast_vm.isAdminWritePermission=='1',
                    child: IconButton(
                        onPressed: () {
                          showConfirmCompleteDialog(context, sales_force_cast_vm.QuoteList[position].quoteId?? "" );
                        }, icon: Icon(Icons.delete, color: Colors.red,)),
                  ),

                  Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
                ],
              ),*/
            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Quote Version: ", value:  sales_force_cast_vm.QuoteList[position].quoteVersion.toString(),),
              _buildLabelWithValue(label: "Sales Cycle Id: ", value:  sales_force_cast_vm.QuoteList[position].salesCycleId.toString(),),
              /*_buildLabelOnTap(label: "Sales Cycle Id: ", value:  sales_force_cast_vm.QuoteList[position].salesCycleId ?? "",color:Colors.blueAccent,
                onTap: (){
                  saleCycleController.ProductCategoryWiseAmtGet(0, sales_force_cast_vm.QuoteList[position].salesCycleId!);
                  saleCycleController.pageNumber = 0;
                  saleCycleController.filterQuoteAcceptedFlag.value="";
                  saleCycleController.clearAllFieldOfFilter();
                  saleCycleController.getsalesCycleData(saleCycleController.pageNumber, sales_force_cast_vm.QuoteList[position]
                      .salesCycleId!, "ViewHeader", "FromAllQuotePage");
                },),
              _buildLabelOnTap(label: "Customer Name: ", value:  sales_force_cast_vm.QuoteList[position].accountName ?? "",color:Colors.blueAccent,
                onTap: (){
                  final account_vm_controller = Get.put(Accountmastervm());
                  final contact_vm_controller = Get.put(ContactMasterVM());
                  account_vm_controller.view = 'FromAllQuotePage';
                  contact_vm_controller.view = 'FromAllQuotePage';
                  account_vm_controller.getAccMasterBuyCodeApi(
                      sales_force_cast_vm.QuoteList[position].accountCode!);
                },),*/
              _buildLabelWithValue(label: "Customer Name: ", value:  sales_force_cast_vm.QuoteList[position].accountName ?? "",),
              _buildLabelWithValue(label: "Customer Code: ", value:  sales_force_cast_vm.QuoteList[position].accountCode ?? "",),
              _buildLabelWithValue(label: "Contact Name: ", value:  sales_force_cast_vm.QuoteList[position].contactName ?? "",),
              _buildLabelWithValue(label: "Product Category: ", value:  sales_force_cast_vm.QuoteList[position].productCategory ?? "",),
              _buildLabelWithValue(label: "Parent Product Category: ", value:  sales_force_cast_vm.QuoteList[position].parentProductCategory ?? "",),
              _buildLabelWithValue(label: "Quote Status: ", value:  sales_force_cast_vm.QuoteList[position].quoteStatus ?? "",color:getStatusColor(saleCycleStatus)),
              _buildLabelWithValue(label: "Quote Accepted: ", value:  sales_force_cast_vm.QuoteList[position].quoteAccepted ?? "",),
              _buildLabelWithValue(label: "Quote Validity: ", value:  quoteValidityDate.toString(),color:AllColors.textColor),
              _buildLabelWithValue(label: "Expected Closure Date: ", value: expectedClosuredateDate.toString(),color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Commit: ", value:  sales_force_cast_vm.QuoteList[position].quoteCommit.toString() ?? "",),
              _buildLabelWithValue(label: "Rejected Reason: ", value:  sales_force_cast_vm.QuoteList[position].rejectReason ?? "",),
              _buildLabelWithValue(label: "RH Approval: ", value:  sales_force_cast_vm.QuoteList[position].rhApproval ?? "",),
              _buildLabelWithValue(label: "CBH Approval: ", value:  sales_force_cast_vm.QuoteList[position].cbhApproval ?? "",),
              _buildLabelWithValue(label: "GM  Approval: ", value:  sales_force_cast_vm.QuoteList[position].gmApproval ?? "",),
              _buildLabelWithValue(label: "Cluster Name: ", value:  sales_force_cast_vm.QuoteList[position].clustureHeadValue ?? "",),
              _buildLabelWithValue(label: "Region Name: ", value:  sales_force_cast_vm.QuoteList[position].zoneHeadValue ?? "",),
              _buildLabelWithValue(label: "Is Active: ", value:  sales_force_cast_vm.QuoteList[position].isActive.toString()=="1"? "Yes":"No",),
              _buildLabelWithValue(label: "Installation Charges : ", value:  sales_force_cast_vm.QuoteList[position].installationCharges.toString() ?? "",),
              _buildLabelWithValue(label: "Other Charges : ", value:  sales_force_cast_vm.QuoteList[position].otherCharges.toString() ?? "",),
              _buildLabelWithValue(label: "Warranty Period : ", value:  sales_force_cast_vm.QuoteList[position].warrantyPeriod.toString() ?? "",),
              _buildLabelWithValue(label: "Delivery In Weeks : ", value:  sales_force_cast_vm.QuoteList[position].deliveryInWeeks.toString() ?? "",),
              _buildLabelWithValue(label: "Advance Payment Per : ", value:  sales_force_cast_vm.QuoteList[position].advancePaymentPer.toString() ?? "",),
              _buildLabelWithValue(label: "Advance Payment Amt : ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].advancePaymentAmt).toString() ?? ""}"  ),
              _buildLabelWithValue(label: "Other Remarks : ", value:  sales_force_cast_vm.QuoteList[position].otherRemarks ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Is Spr: ", value:  sales_force_cast_vm.QuoteList[position].isSpr.toString()=="1"? "Yes":"No",color:AllColors.textColor),
              _buildLabelWithValue(label: "Spr No.: ", value:  sales_force_cast_vm.QuoteList[position].sprNo ?? "",color:AllColors.textColor),
              _buildLabelWithValue(label: "Quote Total Amt: ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].quoteTotalAmount).toString() ?? ""}"  ,),
              _buildLabelWithValue(label: "Quote Gross Amt: ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].quoteGrossAmount).toString() ?? ""}"  ,),
              _buildLabelWithValue(label: "Quote Gst Amt: ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].quoteGstAmount).toString() ?? ""}"  ,),
              _buildLabelWithValue(label: "Created By: ", value:  sales_force_cast_vm.QuoteList[position].createdFullName ?? "",),
              _buildLabelWithValue(label: "Created on: ", value: StaticMethod.onlyDate(sales_force_cast_vm.QuoteList[position].createdOn ?? "") ),
              _buildLabelWithValue(label: "Reporting Manager: ", value:  sales_force_cast_vm.QuoteList[position].approvedFullName ?? "",),
              _buildLabelWithValue(label: "Approved on: ", value: StaticMethod.onlyDate(sales_force_cast_vm.QuoteList[position].approvedOn ?? "") ),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLabelWithValue({
    required String label,
    required String? value,
   Color color= AllColors.textColor,

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
}