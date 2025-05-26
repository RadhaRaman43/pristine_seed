

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import '../../../component/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class QuoteInformationScreen extends StatelessWidget{
  QuoteInformationScreen({super.key});
  final saleCycleController=Get.put(SalesCycleVm());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final quoteApprovalController=Get.put(QuoteApprovalListVm());
  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;


  static String _displayStatusForOption(String option) =>
      option;
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(saleCycleController.quoteApprovalPage.value=="quoteApprovalScreen"){
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteApprovalListScreen);
        }else if(saleCycleController.quoteApprovalPage.value=="approvedQuotationScreen"){
          saleCycleController.pageNumberForQuote = 0;
          saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, "Approved");
          Get.toNamed(RoutesName.approvedQuotationListScreen);
        }else if(saleCycleController.quoteApprovalPage.value=="QuoteDashboard"){
          Get.toNamed(RoutesName.AccountDashboardDataQuotation_Screen);
        }
        else{
          saleCycleController.pageNumber=0;
          saleCycleController.pageNumberForQuote=0;
          saleCycleController.getsalesCycleData(saleCycleController.pageNumber, saleCycleController.quoteHeaderdata[0].salesCycleId!, "", saleCycleController.FromPage.value);
          saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.quoteHeaderdata[0].salesCycleId!, '');
          Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
        }
        // saleCycleController.FromPage="Sales";



        return false;
      }, child: Scaffold(
        appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
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
                visible: saleCycleController.quoteHeaderdata[0].quoteStatus!.toUpperCase()== 'PENDING'?false:true,
                child: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.download, color: Colors.black,),
                            Text('Quote Report'),
                          ],
                        ),
                        onTap: () {
                          saleCycleController.reportDownload("quoteReport");
                        },
                      ),
                      if (saleCycleController.quoteHeaderdata[0].isReadySendForApproval == 0 &&
                          saleCycleController.quoteHeaderdata[0].isSpr == 1)
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.download, color: Colors.black,),
                              Text('Quote Srp Report'),
                            ],
                          ),
                          onTap: () {
                            saleCycleController.reportSprDownload("quoteSprReport",saleCycleController.quoteHeaderdata[0].quoteId!);
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
            Obx((){
              return Visibility(
                visible:saleCycleController.loading.value ,
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.primaryDark1,
                  color: AllColors.textColor,
                ),
              );
            }),
            Expanded(
              child: Container(
                child: ListView(
                    children: [
                      /*visible: saleCycleController.FromPage=="QuoteApprovalPage" ||
                          saleCycleController.quoteApprovalPage.value=="quoteApprovalScreen"?true:false,*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx((){
                            return  Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Visibility(
                                visible: (saleCycleController.FromPage=="QuoteApprovalPage" ||
                                    saleCycleController.quoteApprovalPage.value=="quoteApprovalScreen")?true:false,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ActionChip(
                                        label: Text("Approve", style: GoogleFonts.poppins(
                                          color: AllColors.whiteColor,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                        onPressed: (){
                                          saleCycleController.quoteStatusController.value.clear();
                                          saleCycleController.isReject.value=false;
                                          saleCycleController.isApprove.value=false;
                                          showdialogForApproval(context);
                                        },
                                        backgroundColor: AllColors.primaryDark1,
                                        shape: StadiumBorder(
                                          side: BorderSide.none,
                                        ),
                                      ),
                                     /* ActionChip(
                                        label: Text("Reject", style: GoogleFonts.poppins(
                                          color: AllColors.whiteColor,
                                          fontWeight: FontWeight.w500,
                                        ),),

                                        onPressed: (){
                                          showdialogForApproval(context);
                                          //openConfirmationDialog(context, "Do you want to Update this Sales Cycle?", "Approved");
                                          saleCycleController.quoteStatusController.value.clear();
                                          saleCycleController.rejectreasonQuoteController.value.clear();
                                          saleCycleController.isApprove.value=false;
                                          saleCycleController.isReject.value=false;
                                        },
                                        backgroundColor: AllColors.primaryDark1,
                                        shape: StadiumBorder(
                                          side: BorderSide.none,
                                        ),
                                      ),*/
                                    ]

                                ),),
                            );
                          }),
                          Obx((){
                            return  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: saleCycleController.quoteHeaderdata[0].isReadySendForApproval== 1?true:false,
                                //visible: saleCycleController.quoteHeaderdata[0].isReadySendForApproval== 1?true:false,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: DefaultButton(
                                          press: (){
                                            saleCycleController.BusinessTerm.value = false;
                                            saleCycleController.clearBusinessTerm();
                                            Get.toNamed(RoutesName.UpdateBussinessTermPage);
                                            //openConfirmationDialog(context,   'Do you want to send this Quote for Approval?', "");
                                          },
                                          text: "Sent For Approval",
                                        ),
                                        width: size.width*.49,
                                        //margin: EdgeInsets.only(right: 10),
                                      ),
                                    ]
                                ),),
                            );
                          }),

                          Obx((){
                            return Visibility(
                              visible:saleCycleController.quoteHeaderdata[0].createdBy==saleCycleController.email && saleCycleController.quoteHeaderdata[0].quoteStatus=="Pending" ?true:false,
                              child: GestureDetector(
                                onTap: (){
                                  saleCycleController.accountCode.value=saleCycleController.quoteHeaderdata[0].accountCode??"";
                                  saleCycleController.updateQuoteValidityController.value.text=saleCycleController.quoteHeaderdata[0].quoteValidity!;
                                  saleCycleController.updateExpectedClosureDateController.value.text=saleCycleController.quoteHeaderdata[0].expClosureDate!;
                                  //saleCycleController.updatecontactpersonNameController.value.text=saleCycleController.quoteHeaderdata[0].contactPersonName.toString();
                                  saleCycleController.activeController.value.text=saleCycleController.quoteHeaderdata[0].isActive==1?"Yes":"No";
                                  saleCycleController.quoteCommitController.value.text=saleCycleController.quoteHeaderdata[0].quoteCommit==1?"Yes":"No";
                                  saleCycleController.shippingController.value.text=saleCycleController.quoteHeaderdata[0].shippingAddress??"";
                                  saleCycleController.shippingAddress2Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingAddress2??"";
                                  saleCycleController.Shipping_PostCode_Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingPostCode??"";
                                  saleCycleController.Shipping_City_Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingCity??"" ;
                                  saleCycleController.Shipping_District_Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingDistrict??"" ;
                                  saleCycleController.Shipping_State_Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingStateName??"";
                                  saleCycleController.Shipping_phone_Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingPhoneNo??"";
                                  saleCycleController.Shipping_email_Controller.value.text=saleCycleController.quoteHeaderdata[0].shippingEmailId??"";

                                  showDialogForHeaderUpdate(context);
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Icon(Icons.update, color: AllColors.primaryDark1,),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: AllColors.primaryDark1)
                                  ),
                                ),
                              ),
                            );
                          }),
                          /*Obx((){
                              return   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                  visible:  saleCycleController.quoteHeaderdata[0].quoteStatus!.toUpperCase()== 'PENDING'?false:true,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: AllColors.primaryDark1)
                                    ),
                                    child: IconButton(onPressed: (){
                                      saleCycleController.reportDownload();
                                    },
                                        icon: Icon(Icons.cloud_download_rounded)),
                                  ),),
                              );
                            }),*/

                          /*Obx((){
                              return   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                  //visible:  saleCycleController.quoteHeaderdata[0].quoteStatus!.toUpperCase()== 'PENDING'?false:true,
                                  visible:  saleCycleController.quoteHeaderdata[0].isReadySendForApproval== 0?true:false,
                                  child: Tooltip(
                                    message: 'Download Quote Report',
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: AllColors.primaryDark1)
                                      ),
                                      child: IconButton(onPressed: (){
                                        saleCycleController.reportDownload("quoteReport");
                                      },

                                          icon: Icon(Icons.cloud_download_rounded)),
                                    ),
                                  ),),
                              );
                            }),*/
                          /*Obx((){
                              return   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                  visible:  saleCycleController.quoteHeaderdata[0].isReadySendForApproval== 0 && saleCycleController.quoteHeaderdata[0].isSpr==1?true:false,
                                  child: Tooltip(
                                    message: 'Download Quote SPR Report',
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: AllColors.primaryDark1)
                                      ),
                                      child: IconButton(onPressed: (){
                                        saleCycleController.reportSprDownload("quoteSprReport");
                                      },
                                          icon: Icon(Icons.cloud_download_rounded)),
                                    ),
                                  ),),
                              );
                            }),*/

                       /*   Obx((){
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible:  saleCycleController.quoteHeaderdata[0].quoteStatus!.toUpperCase()== 'PENDING'?false:true,
                                //visible:  saleCycleController.quoteHeaderdata[0].isReadySendForApproval== 0?true:false,
                                child: Tooltip(
                                  message: 'View Business Term',
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: AllColors.primaryDark1)
                                    ),
                                    child: IconButton(onPressed: (){
                                      saleCycleController.BusinessTerm.value = true;
                                      saleCycleController.SetBusinessTerm();
                                      saleCycleController.calculateFinalAmt();
                                      Get.toNamed(RoutesName.UpdateBussinessTermPage);
                                      //saleCycleController.getApprovalPersonList(saleCycleController.quoteHeaderdata[0].quoteId??"");
                                      // Get.offAllNamed(RoutesName.approvalPersonList);

                                    },
                                        icon: Icon(Icons.note_alt_rounded)),
                                  ),
                                ),),
                            );
                          }),*/

                          Obx((){
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible:  saleCycleController.quoteHeaderdata[0].quoteStatus!.toUpperCase()== 'PENDING'?false:true,
                                child: Tooltip(
                                  message: 'View Approver Persons',
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: AllColors.primaryDark1)
                                    ),
                                    child: IconButton(onPressed: (){
                                      Get.toNamed(RoutesName.approvalPersonList);
                                      saleCycleController.getApprovalPersonList(saleCycleController.quoteHeaderdata[0].quoteId??"");
                                      // Get.offAllNamed(RoutesName.approvalPersonList);

                                    },
                                        icon: Icon(Icons.groups)),
                                  ),
                                ),),
                            );
                          }),
                        ],
                      ),

                      Obx((){
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
                              Text("Quote Item List", style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.eighteen,
                                fontWeight: FontWeight.w700,
                              ),),

                             Obx((){
                               return  Visibility(
                                 visible: saleCycleController.quoteHeaderdata[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase() && saleCycleController.quoteHeaderdata[0].quoteStatus=="Pending"?true:false,
                                 child: Row(
                                   children: [
                                     SizedBox(width: 10,),
                                     GestureDetector(
                                         child: ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                                             side: const BorderSide(
                                                 color: AllColors.primaryDark),
                                             backgroundColor: Colors.white,
                                             elevation: 0,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(
                                                   8),
                                             ),
                                           ),
                                           onPressed: () {
                                             showFetchSalesProductConfirmationDialog(context, saleCycleController.quoteHeaderdata[0].salesCycleId??"", saleCycleController.quoteHeaderdata[0].quoteId??"");
                                           },
                                           child: Text("Fetch Sales Product",
                                             style: GoogleFonts.poppins(
                                               color: AllColors.primaryDark,
                                               fontSize: AllFontSize.fourtine,
                                               fontWeight: FontWeight.w700,
                                             ),),
                                         )
                                     ),
                                     SizedBox(width: 10,),
                                     Obx((){
                                       String ProductCategory = saleCycleController.quoteHeaderdata[0].productCategoryCode??"";
                                       String PipeProdCate = ProductCategory.replaceAll(', ', '|');
                                       print("${saleCycleController.quoteHeaderdata[0].quoteStatus}");
                                       return   GestureDetector(
                                         onTap: (){
                                           saleCycleController.pageNumber=0;
                                           saleCycleController.itemMstGetByQuoteIdApiHit(0,saleCycleController.quoteHeaderdata[0].quoteId, "Add", PipeProdCate);
                                         },
                                         child: Container(
                                           child: Padding(
                                             padding: const EdgeInsets.all(7.0),
                                             child: Icon(Icons.add, color: AllColors.primaryDark1,),
                                           ),
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(30),
                                               border: Border.all(color: AllColors.primaryDark1)
                                           ),
                                         ),
                                       );
                                     }),
                                   ],
                                 ),
                               );
                             }),
                            ],),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1,color: AllColors.bluegrayColor,),
                      Obx((){
                        return bindQuoteItemList(context);
                      }),
                    ]
                ),
              ),
            ),
          ],)
    ),
    );
  }



  Widget bindQuoteItemList(BuildContext context) {
    if (saleCycleController.quoteLinedata.value.isNotEmpty && saleCycleController.quoteLinedata.value.length > 0) {
      return Obx(() {
        return  Container(
          height: size.height/2,
          child: ListView.separated(
              padding: EdgeInsets.only(bottom: 50),
              separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
              shrinkWrap: true,
              itemCount:saleCycleController.quoteLinedata.value.length,
              itemBuilder: (BuildContext context, int index) {
                return bindPendingListView(context, index);
              }),
        );
      },
      );
    }
    else {
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
    int srNo=index+1;
    //String? dateCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteList[index].createdOn??"");
    return InkWell(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Item Name: ",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: "${ saleCycleController.quoteLinedata[index]
                              .itemName??""}(${saleCycleController.quoteLinedata[index]
                              .itemCode})",
                          child: Text("${ saleCycleController.quoteLinedata[index]
                              .itemName??""}(${saleCycleController.quoteLinedata[index]
                              .itemCode})",
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
              Obx((){
                return Visibility(
                  visible:  saleCycleController.showBranchHead.value ||saleCycleController.showClusterHead.value
                      || saleCycleController.showGeneralManager.value,
                  child: GestureDetector(
                      onTap: (){
                        saleCycleController.bmDiscountPerController.value.text=saleCycleController.quoteLinedata[index]
                            .bmDiscountPer==null?"0":saleCycleController.quoteLinedata[index]
                            .bmDiscountPer.toString();
                        saleCycleController.salesCreditPerContoller.value.text=saleCycleController.quoteLinedata[index]
                            .salesCredit==null?"0":saleCycleController.quoteLinedata[index]
                            .salesCredit.toString();
                        saleCycleController.updateDiscountAmountController.value.text=saleCycleController.quoteLinedata[index]
                            .approvedDiscountPer==null?"0":saleCycleController.quoteLinedata[index]
                            .approvedDiscountPer.toString();
                        showDialogForGmBmDiscount(context, index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Tooltip(
                            message: "Update Bm Discount %",
                            child: Icon(Icons.update, color: AllColors.textColor,)),
                      )
                  ),
                );
              })

            ],
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    width: size.width/2,
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
                              width: size.width*.2,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .itemDescription??"",
                                child: Text(
                                  ( saleCycleController.quoteLinedata[index]
                                      .itemDescription??"") ,
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
                              "Cate. Name: ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: size.width*.16,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .categoryName??"",
                                child: Text(
                                  ( saleCycleController.quoteLinedata[index]
                                      .categoryName??"") ,
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
                              saleCycleController.quoteLinedata[index]
                                  .qty.toString(),
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
                              "Manual Price : ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .quoteLinePrice.toString(),
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
                              "List Selling Pr. :",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .sgstAmt.toString(),
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
                              "Min. Acpt. Amt. :",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Container(
                              width: size.width*.12,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .minimalAcceptablePrice.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .minimalAcceptablePrice.toString(),
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
                        Obx((){
                          return Visibility(
                            visible: saleCycleController.showBranchHead.value,
                            child: Row(
                              children: [
                                Text(
                                  "Branch Tran. Pri. : ",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Container(
                                  width: size.width*.12,
                                  child: Tooltip(
                                    message: saleCycleController.quoteLinedata[index]
                                        .branchTransferPrice.toString(),
                                    child: Text(
                                      saleCycleController.quoteLinedata[index]
                                          .branchTransferPrice.toString(),
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
                        Obx((){
                          return Visibility(
                            visible: saleCycleController.showGeneralManager.value,
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
                                  width: size.width*.12,
                                  child: Tooltip(
                                    message: saleCycleController.quoteLinedata[index]
                                        .standardCost.toString(),
                                    child: Text(
                                      saleCycleController.quoteLinedata[index]
                                          .standardCost.toString(),
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

                      /*  Row(
                          children: [
                            Text(
                              "Brand Transfer RS : ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .branchTransferPrice.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),*/
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
                              saleCycleController.quoteLinedata[index]
                                  .discountPer.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                       /* Row(
                          children: [
                            Text(
                              "Discount % : ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .discountPer.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),*/
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
                                message: saleCycleController.quoteLinedata[index]
                                    .approvedDiscountPer.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .approvedDiscountPer.toString(),
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



                    /*    Row(
                          children: [
                            Text(
                              "Gm Discount Amt:",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Flexible(
                              fit: FlexFit.loose,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .gmDiscountPer.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .gmDiscountPer.toString(),
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
                        ),*/
                       /* Row(
                          children: [
                            Text(
                              "Gm Discount %:",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Flexible(
                              fit: FlexFit.loose,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .gmDiscountPer.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .gmDiscountPer.toString(),
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
                              "Gm Discount Amt:",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Flexible(
                              fit: FlexFit.loose,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .gmDiscountPer.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .gmDiscountPer.toString(),
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
                        ),*/
                      /*  Row(
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
                              width: size.width*.12,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .standardCost.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .standardCost.toString(),
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
                        ),*/
                        /* Row(
                          children: [
                            Text(
                              "Warranty Period : ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Flexible(
                              fit: FlexFit.loose,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .warrantyPeriod.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .warrantyPeriod.toString(),
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
                        ),*/

                      ],
                    ),
                  )),
                  Expanded(child: Container(
                    width: size.width/2,
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
                                message: saleCycleController.quoteLinedata[index]
                                    .approvedAmount==null?"0":saleCycleController.quoteLinedata[index]
                                    .approvedAmount.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .approvedAmount==null?"":saleCycleController.quoteLinedata[index]
                                      .approvedAmount.toString(),
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
                        Obx((){
                          return Visibility(
                            visible: saleCycleController.quoteHeaderdata[0].isReadyForApprove== 1,
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
                                  saleCycleController.quoteLinedata[index]
                                      .bmDiscountPer.toString(),
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

                        Obx((){
                          return Visibility(
                            visible: saleCycleController.showGeneralManager.value,
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
                                      saleCycleController.quoteLinedata[index]
                                          .gmDiscountPer.toString(),
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
                                        message: saleCycleController.quoteLinedata[index]
                                            .gmDiscountAmount.toString(),
                                        child: Text(
                                          saleCycleController.quoteLinedata[index]
                                              .gmDiscountAmount.toString(),
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
                              saleCycleController.quoteLinedata[index]
                                  .salesCredit.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        /*Row(
                          children: [
                            Text(
                              "Discount Amount:",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Flexible(
                              fit: FlexFit.loose,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .discountAmt.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .discountAmt.toString(),
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
                        ),*/
                        Row(
                          children: [
                            Text(
                              "Amount : ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .totalPrice.toString(),
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
                              "GST % :",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .sgstPer.toString(),
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
                              "GST Amount:",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              saleCycleController.quoteLinedata[index]
                                  .gstAmount.toString(),
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
                              saleCycleController.quoteLinedata[index]
                                  .totalPrice.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),



                        /*    Visibility(
                          visible:  saleCycleController.quoteHeaderdata[0].isReadyForApprove== 1?true:false,
                          child: Row(
                            children: [
                              Text(
                                "Br. Tnsfr. Pr.: ",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              Text(
                                saleCycleController.quoteLinedata[index]
                                    .branchTransferPrice.toString(),
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),*/




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
                              saleCycleController.quoteLinedata[index]
                                  .isSprRequired.toString() == "1" ? "Yes":"No",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        /*Row(
                          children: [
                            Text(
                              "Delivery In Weeks : ",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Flexible(
                              fit: FlexFit.loose,
                              child: Tooltip(
                                message: saleCycleController.quoteLinedata[index]
                                    .deliveryInWeeks.toString(),
                                child: Text(
                                  saleCycleController.quoteLinedata[index]
                                      .deliveryInWeeks.toString(),
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
                        ),*/
                      ],
                    ),
                  )),
                ],
              ),
              SizedBox(height: 6,),
              Obx((){
                return Visibility(
                  //visible:saleCycleController.quoteHeaderdata[0].createdBy==saleCycleController.email && saleCycleController.quoteHeaderdata[0].quoteStatus=="Pending"?true:false,
                  visible:saleCycleController.quoteHeaderdata[0].quoteStatus=="Pending"?true:false,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            saleCycleController.updateItemDescriptionController.value.text=  saleCycleController.quoteLinedata[index].itemName.toString()+ "(${saleCycleController.quoteLinedata[index].itemCode})";
                            saleCycleController.updateItemDescription2Controller.value.text=  saleCycleController.quoteLinedata[index].itemDescription.toString();
                            saleCycleController.qtyUpdateLineController.value.text=  saleCycleController.quoteLinedata[index].qty.toString();
                            saleCycleController.updateUnitPriceController.value.text=  saleCycleController.quoteLinedata[index].unitPrice.toString();
                            saleCycleController.updateManualPriceController.value.text=  saleCycleController.quoteLinedata[index].quoteLinePrice.toString();
                            saleCycleController.updateDiscountPerController.value.text=  saleCycleController.quoteLinedata[index].discountPer.toString();

                            saleCycleController.updateDiscountAmountController.value.text=  saleCycleController.quoteLinedata[index].approvedDiscountPer.toString();
                            saleCycleController.gmDiscountPerContoller.value.text=  saleCycleController.quoteLinedata[index].gmDiscountPer.toString();
                            saleCycleController.salesCreditPerContoller.value.text=  saleCycleController.quoteLinedata[index].salesCredit.toString();

                            saleCycleController.updateAmountController.value.text=  saleCycleController.quoteLinedata[index].mrpPrice.toString();
                            saleCycleController.updateTaxPerLineController.value.text=  saleCycleController.quoteLinedata[index].sgstPer.toString();
                            saleCycleController.updateTaxAmountLineController.value.text=  saleCycleController.quoteLinedata[index].sgstAmt.toString();
                            saleCycleController.updateGrossAmountLineController.value.text=  saleCycleController.quoteLinedata[index].grossAmount.toString();
                            /*saleCycleController.warrentyPeriodController.value.text= saleCycleController.quoteLinedata[index]
                                .warrantyPeriod.toString();
                            saleCycleController.deliveryWeeksController.value.text= saleCycleController.quoteLinedata[index]
                                .deliveryInWeeks.toString();*/

                            saleCycleController.index.value=index;
                            Get.toNamed(RoutesName.updatequoteLineData);

                          },
                          child: Icon(Icons.update, color: Colors.blue,size: 30),
                        ),
                        InkWell(
                          onTap: (){
                            showDialogForCreateDuplicate(context, index);
                          },
                          child:
                          Icon(Icons.add_chart, color: Colors.blue,size: 30,),
                        ),

                        InkWell(
                          onTap: (){
                            showDialogForDelete(context,index );
                          },
                          child: Icon(Icons.delete, color: Colors.red,size: 30),
                        ),

                      ]
                  ),
                );
              }
              ),
              SizedBox(height: 6,),
            ],
          ),
          leading:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${srNo}",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w800,
                ),),
              VerticalDivider(color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }


  Widget  BindSalesData(BuildContext context) {
    String? dateTimeCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteHeaderdata[0].createdOn ?? "");
    String? dateTimeApprovedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteHeaderdata[0].approvedOn ?? "");
    String? expectedclosuredate=StaticMethod.convertDateFormat1(saleCycleController.quoteHeaderdata[0].expClosureDate ?? "");
    String?quoteValidityDate=StaticMethod.convertDateFormat1(saleCycleController.quoteHeaderdata[0].quoteValidity ?? "");
    String? regretOn=StaticMethod.dateTimeToDate(saleCycleController.quoteHeaderdata[0].regretOn ?? "");
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
                  borderSide: BorderSide(
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),

              child: Column(
                children: [
                  Row(
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
                        saleCycleController
                            .quoteHeaderdata[0]
                            .salesCycleId ?? "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.sisxteen,
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
                                .quoteHeaderdata[0].accountName?? "",
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .accountName ??
                                  "" ,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
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
                          accountMaster_page_controller.view='FromquoteInformationScreen';
                          contact_vm_controller.view='FromquoteInformationScreen';
                          accountMaster_page_controller.getAccMasterBuyCodeApi(saleCycleController
                              .quoteHeaderdata[0]
                              .accountCode!);
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
                      Text(
                        saleCycleController
                            .quoteHeaderdata[0]
                            .contactName ?? "",
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
                        "Product Category",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message:  saleCycleController
                              .quoteHeaderdata[0]
                              .productCategory ?? "",
                          child: Text(
                            saleCycleController
                                .quoteHeaderdata[0]
                                .productCategory!,
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
                        "Quote Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteStatus ?? '',

                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .quoteStatus ?? "",
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
                        "Expected Closure Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
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
                    children: [
                      Text(
                        "Quote Validity",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.3,
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
                    children: [
                      Text(
                        "Quote Commit",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteCommit.toString()=='1'?'Yes':'No',

                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .quoteCommit.toString()=='1'?'Yes':'No',
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
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteTotalAmount.toString() ?? '',

                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .quoteTotalAmount.toString() ?? "",
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
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteGstAmount.toString() ?? '',

                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .quoteGstAmount.toString() ?? "",
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
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteGrossAmount.toString() ?? '',

                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .quoteGrossAmount.toString() ?? "",
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
                        width: size.width *.4,
                        child: Tooltip(
                          message: saleCycleController
                              .quoteHeaderdata[0].createdFullName ?? "",
                          child: Text(
                            saleCycleController
                                .quoteHeaderdata[0].createdFullName ?? "",
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
                    children:   [
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
                        "Reject Reason",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: saleCycleController
                              .quoteHeaderdata[0]
                              .rejectReason ?? "",
                          child: Text(
                            saleCycleController
                                .quoteHeaderdata[0]
                                .rejectReason ?? "",
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
                                  .quoteHeaderdata[0]
                                  .salesCycleId!);
                          bindListBottomSheet(context);
                        },
                        child: Text('View',
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,),
                          textAlign: TextAlign.end,

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
                        "Installation Charges",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message:saleCycleController
                                .quoteHeaderdata[0]
                                .installationCharges==null ? "":saleCycleController
                                .quoteHeaderdata[0]
                                .installationCharges.toString(),

                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0]
                                  .installationCharges==null ? "":saleCycleController
                                  .quoteHeaderdata[0]
                                  .installationCharges.toString(),
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
                        "Other Charges",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.3,
                        child: Obx(() {
                          return Text(
                            saleCycleController
                                .quoteHeaderdata[0]
                                .otherCharges==null? "": saleCycleController
                                .quoteHeaderdata[0]
                                .otherCharges.toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
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
                        "Warranty Period",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text( saleCycleController
                          .quoteHeaderdata[0]
                          .warrantyPeriod??"",
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
                        "Delivery In Weeks",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text( saleCycleController
                          .quoteHeaderdata[0]
                          .deliveryInWeeks??"",
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
                        "Advance Payment %",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text( saleCycleController
                          .quoteHeaderdata[0]
                          .advancePaymentPer==null?"":saleCycleController
                          .quoteHeaderdata[0]
                          .advancePaymentPer.toString(),
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
                        "Advance Payment Amt",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text( saleCycleController
                          .quoteHeaderdata[0]
                          .advancePaymentAmt==null?"":saleCycleController
                          .quoteHeaderdata[0]
                          .advancePaymentAmt.toString(),
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
                        "Remarks",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*0.5,
                        child: Tooltip(
                          message:saleCycleController
                              .quoteHeaderdata[0]
                              .otherRemarks??"" ,
                          child: Text( saleCycleController
                              .quoteHeaderdata[0]
                              .otherRemarks??"",
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
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
        ],
      ),
    );
  }



  Future showDialogForDelete(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: AlertDialog(
              title: Text("Delete",   style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
              ),),
              content: Container(
                /*height: size.height*.21,
                  width: size.width*4,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Do you want to delete this Quote Line?',
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
                                  saleCycleController.quoteLineDeleteApiHit(saleCycleController.quoteLinedata[index].lineNo!, "");
                                  Navigator.pop(context);
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
  }


  Future showDialogForCreateDuplicate(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: AlertDialog(
              title: Text("Create Duplicate",   style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
              ),),
              content: Container(
                /* height: size.height*.21,
                  width: size.width*4,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Do you want to Create Duplicate Line of this Quote?',
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
                                  saleCycleController.quoteLineCreateDuplicateApiHit(saleCycleController.quoteLinedata[index].lineNo!);
                                  //Get.back();
                                  Navigator.pop(context);
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
  }

  Widget bindRejectreason(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      maxLines: 2,
      maxLength: 500,
      controller: saleCycleController.rejectreasonQuoteController.value,
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
              fontWeight: FontWeight.w700,
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





  Future showDialogForHeaderUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: AlertDialog(
              title: Text("Header Quote Update",   style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w700,
              ),),
              content: Container(
                  /*height: size.height*.4,
                  width: size.width*4,*/
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5),
                        bindGeneralAddress(context),
                        SizedBox(height: 10),
                        bindShippingAddress(context),
                        SizedBox(height: 10,),
                    
                        Container(
                          width: size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              saleCycleController.quoteHeaderUpdateApiHit();
                              Get.back();
                            },
                            child: Container(
                              child: Text('Update Quote',
                                style: GoogleFonts.poppins(
                                  color: AllColors.whiteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              saleCycleController.pageNumber = 0;
                              saleCycleController.getAddressMasterList(saleCycleController.pageNumber,saleCycleController.accountCode.value);
                              saleCycleController.showConsigneeAddressList(context, saleCycleController.address_master_list);

                            },
                            child: Container(
                              child: Text('Change Address',
                                style: GoogleFonts.poppins(
                                  color: AllColors.whiteColor,
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
              ),
            ),
          );

        });
  }



  Widget updateQuoteValidity(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
          cursorColor:AllColors.primaryDark1 ,
          controller: saleCycleController.updateQuoteValidityController.value,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten
              ),
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
              )
          ),
          onTap: () async {
            DateTime? initialDate;
            if (saleCycleController.updateQuoteValidityController.value.text.isNotEmpty) {
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
                    primaryColor: AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },

            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.updateQuoteValidityController.value.text= outputFormat.format(date);
            /* else
              saleCycleController.updateQuoteValidityController.value.text = "";*/
          }



      ),
    );
  }

  Widget updateExpectedClosureDate(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
          cursorColor:AllColors.primaryDark1 ,
          controller: saleCycleController.updateExpectedClosureDateController.value,
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
            DateTime? initialDate;
            if (saleCycleController.updateExpectedClosureDateController.value.text.isNotEmpty) {
              initialDate = DateFormat('yyyy-MM-dd').parse(
                saleCycleController.updateExpectedClosureDateController.value.text,
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
              initialDate:initialDate,
              firstDate: DateTime.now(),
              lastDate: ending_date,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },

            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.updateExpectedClosureDateController.value.text= outputFormat.format(date);
            /*else
              saleCycleController.updateExpectedClosureDateController.value.text = "";*/
          }
      ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownMenu<String>(
        width: size.width-155,
        controller: saleCycleController.activeController.value,
        label: Text(
          "Active",
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
        enabled: saleCycleController.quoteHeaderdata[0].isReadySendForApproval!=1?false:true,
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.activeController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        },

        dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
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
                            *//* Get.back();
                            Get.back();*//*
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
  Widget bindGeneralAddress(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 15.0, right: 15.0),
      //color: AllColors.Card1Color,
      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        //color: AllColors.Card2Color, // Set the inside color here
        border: Border.all(
          color: AllColors.grayColor, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'General Address',
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          border: OutlineInputBorder(
            borderSide: BorderSide(

            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            updateQuoteValidity(context),
            SizedBox(height: 10),
            updateExpectedClosureDate(context),
            SizedBox(height: 10),
            /* quoteCommitDropDown(context),
                        SizedBox(height: 10),*/
            bindActive( context),



          ],
        ),
      ),
    );

  }


  Widget bindShippingAddress(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 15.0, right: 15.0),
      //color: AllColors.Card1Color,
      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        //color: AllColors.Card2Color, // Set the inside color here
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
            borderSide: BorderSide(

            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .shippingController.value,
                decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "Address",
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
                    .shippingAddress2Controller.value,
                decoration: InputDecoration(
                    hintText: "Address 2",
                    labelText: "Address 2",
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
                keyboardType: TextInputType.number,
                controller: saleCycleController
                    .Shipping_PostCode_Controller.value,
                decoration: InputDecoration(
                    hintText: "Post Code",
                    labelText: "Post Code",
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
                    .Shipping_City_Controller.value,
                decoration: InputDecoration(
                    hintText: "City",
                    labelText: "City",
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
                    .Shipping_District_Controller.value,
                decoration: InputDecoration(
                    hintText: "District",
                    labelText: "District",
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
                    .Shipping_State_Controller.value,
                decoration: InputDecoration(
                    hintText: "State",
                    labelText: "State",
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


  void openConfirmationDialog(BuildContext context, String message, String flag) {
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
            content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        message
                        ,
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
                          SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                if(flag=="Approved") {
                                  saleCycleController.quoteApprovalRejectApiHit(flag,saleCycleController.quoteHeaderdata[0].quoteId!);
                                }
                                else if(flag=="Rejected"){
                                  saleCycleController.quoteApprovalRejectApiHit(flag,saleCycleController.quoteHeaderdata[0].quoteId!);
                                }
                                else{
                                  saleCycleController.quoteSendForApprovalApiHit();
                                }

                                Get.back();
                                Get.back();
                              },
                              child: Container(
                                //width: 80,
                                //alignment: Alignment.center,
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
          );

        });

  }

  void showdialogForApproval(BuildContext context) {
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
                    'Update Quote',
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
                    Obx((){
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
                              onPressed: ()  {
                                openConfirmationDialog(context,
                                    "Do you want to Update this Sales Cycle?",
                                    "Approved");
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
                      return  Visibility(
                        visible: saleCycleController.isReject.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            bindRejectreason(context),
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
                                    openConfirmationDialog(context, "Do you want to Update this Sales Cycle?", "Rejected");
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

  showFetchSalesProductConfirmationDialog(context, String SalesId,String QuoteId) {
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
                    'Fetch!',
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
                          'Do you want to Fetch Sales Product ?',
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
                              saleCycleController.FetchSalesProductApiHit(SalesId, QuoteId);
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
  }

  Widget bindDropDownOfRejectAndApprove(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayCustomerNeedIdentityStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.statusList.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return saleCycleController.statusList.value
            .where((String option) {
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
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            saleCycleController.quoteStatusController.value.clear();
          },
          onChanged: (value){
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
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text =  saleCycleController.quoteStatusController.value.text,
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
              width: size.width*.62,
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
    showModalBottomSheet(context: context,
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
                          "Sales Cycle Products",
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
                            child: Icon(
                                Icons.filter_alt_rounded
                            ),
                          ),
                        ),

                    ],
                  ),
                ),
                Center(
                    child: Divider(height: 1, color: AllColors.primaryDark1,)),
                Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return bindSalesCycleProductData(context,);
                      }),
                    )
                ),
                Center(
                    child: Divider(height: 1, color: AllColors.primaryDark1,)),
                Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10, left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total ", style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w900,
                      ),),

                      Row(
                        children: [
                          Text("Qty: ", style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w900,
                          ),),
                          Text(saleCycleController.get_SalesCycleProductById_List.length>0?(saleCycleController.get_SalesCycleProductById_List[0].productTotalQty==null?"0":
                          saleCycleController.get_SalesCycleProductById_List[0].productTotalQty.toString()):"",
                            style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700,
                          ),),
                        ],
                      ),

                      Row(
                        children: [
                          Text("Price: ", style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w900,
                          ),),
                          Text(saleCycleController.get_SalesCycleProductById_List.length>0?(saleCycleController.get_SalesCycleProductById_List[0].productTotalAmount==null?"0"
                              :saleCycleController.get_SalesCycleProductById_List[0].productTotalAmount.toString()):"0",
                            style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700,
                          ),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
        );
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
            ),
            content: Container(
                child: Obx(() {
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
                                SizedBox(height: 5,),

                                filterItemDescription(context),
                                SizedBox(height: 5,),

                                filterWithCategoryName(context),

                                SizedBox(height: 5,),
                                EditCompetitorName(context),
                                SizedBox(height: 5,),
                                EditLossReason(context),
                                SizedBox(height: 5,),

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
                                        saleCycleController.pageNumber=0;
                                        saleCycleController.clearSaleProductListController();
                                        saleCycleController.getSaleCycleProductByIdList(saleCycleController.pageNumber,saleCycleController.quoteHeaderdata[0].salesCycleId!);
                                        Get.back();
                                      },
                                      child: Text('Reset',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.blackColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
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
                                        saleCycleController.pageNumber=0;
                                        saleCycleController.getSaleCycleProductByIdList(saleCycleController.pageNumber,saleCycleController.quoteHeaderdata[0].salesCycleId!);
                                        Get.back();
                                      },
                                      child: Text('Submit',
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
                })
            ),
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
          )
      ),
    );
  }

  Widget filterItemDescription(BuildContext context) {
    return  TextField(
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
          )
      ),
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
          )
      ),
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
          )
      ),
    );
  }

  Widget EditCompetitorName(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.updateCompetitorNameProductController
          .value,
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
          )
      ),
    );
  }

  Widget bindSalesCycleProductData(BuildContext context) {
    print("Lengh${saleCycleController.get_SalesCycleProductById_List.value
        .length}");
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
              saleCycleController.quoteHeaderdata[0].salesCycleId!,);
            saleCycleController.pageNumber += 1;
          }
        }
      });
      return Obx(() {
        return Container(
          height: size.height / 2,
          child: ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 50),
              separatorBuilder: (context, index) =>
                  Divider(height: .05, color: Colors.transparent,),
              shrinkWrap: true,
              itemCount: saleCycleController.get_SalesCycleProductById_List
                  .value.length,
              itemBuilder: (BuildContext context, int index) {
                return bindSaleCycleProductListView(context, index);
              }),
        );
      },
      );
    }
    else {
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
              "Item Code: ",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              saleCycleController
                  .get_SalesCycleProductById_List[index]
                  .itemCode ?? "",
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

                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: saleCycleController
                        .get_SalesCycleProductById_List[index]
                        .itemDescription ?? "",
                    child: Text(
                      saleCycleController
                          .get_SalesCycleProductById_List[index]
                          .itemDescription ?? "",
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
                      .get_SalesCycleProductById_List[index]
                      .categoryName.toString(),
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
                  saleCycleController
                      .get_SalesCycleProductById_List[index]
                      .qty.toString(),
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
                  "MRP Price : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .get_SalesCycleProductById_List[index]
                      .mrpPrice.toString(),
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
                      .get_SalesCycleProductById_List[index]
                      .totalPrice.toString(),
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
                      .get_SalesCycleProductById_List[index]
                      .lineStatus ?? "",
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
                      .get_SalesCycleProductById_List[index]
                      .createdBy.toString(),
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
                            .competitorName ?? "",
                        child: Text(
                          saleCycleController
                              .get_SalesCycleProductById_List[index]
                              .competitorName ?? "",
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
                          .competitorPrice == null ? "" : saleCycleController
                          .get_SalesCycleProductById_List[index]
                          .competitorPrice.toString(),
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
                            .lossReason ?? "",
                        child: Text(
                          saleCycleController
                              .get_SalesCycleProductById_List[index]
                              .lossReason ?? "",
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
                              .get_SalesCycleProductById_List[index].lossOn ??
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
                              .get_SalesCycleProductById_List[index].lossBy ??
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
    showDialog(context: context, builder: (BuildContext context, ){
      return Container(
        child: AlertDialog(
          title: Text("Quote Item Update",   style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w700,
          ),),
          content: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    bindApprovedDiscountPer(context),
                    SizedBox(height: 10),
                    Obx((){
                      return Visibility(
                          visible: saleCycleController.showGeneralManager.value,
                          child:bindGmDiscountPer(context) );
                    }),
                    SizedBox(height: 10,),
                    Obx((){
                      return  Visibility(
                        visible: saleCycleController.showBranchHead.value || saleCycleController.showGeneralManager.value,
                          child: bindSalesCreditPer(context));
                    }),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AllColors.redColor,
                            ),
                          ),
                          onPressed: ()  {
                            Get.back();
                          },
                          child: Text('Cancel',
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
                          onPressed: ()  {
                            saleCycleController.index.value=index;
                            saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[index].itemCode!, "BmGMUpdate");
                            Get.back();
                          },
                          child: Text('Update',
                            style: GoogleFonts.poppins(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10,),

                  ],
                ),
              )
          ),
        ),
      );
    });
  }

  bindApprovedDiscountPer(BuildContext context) {
    return  TextField(
      cursorColor: AllColors.primaryDark1,
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
          )
      ),
    );
  }

  bindGmDiscountPer(BuildContext context) {
     return  TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.gmDiscountPerContoller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Gm %',
          labelText: 'Gm %',
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


  bindSalesCreditPer(BuildContext context) {
    return  TextField(
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
          )
      ),
    );
  }

}





