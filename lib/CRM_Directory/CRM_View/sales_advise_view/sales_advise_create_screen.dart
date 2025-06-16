
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_quote_information_modal.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class SalesAdviseCreateScreen extends StatelessWidget {
  final saleCycleController = Get.put(SalesCycleVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    print("List...${saleCycleController.quoteLinedata.length}");
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.quoteInformationScreen);
        return false;
      }, child: Scaffold(
        appBar:  AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sales Advise Create',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
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
              Obx(() {
                return BindSalesData(context);
              }),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 GestureDetector(
                   onTap: () {
                     saleCycleController.bindAddress();
                     showDialogForAddressUpdate(context);
                   },
                   child: Container(
                     child: Padding(
                       padding: const EdgeInsets.only(left: 10.0, right: 10, top: 7, bottom: 7),
                       child: Text("Change Address",
                         style: GoogleFonts.poppins(
                           color: AllColors.whiteColor,
                           fontWeight: FontWeight.w500,
                         ),)
                       /*Icon(
                         Icons.update,
                         color: AllColors.primaryDark1,
                       ),*/
                     ),
                     decoration: BoxDecoration(
                       color: AllColors.primaryDark1,
                         borderRadius: BorderRadius.circular(30),
                         border: Border.all(
                             color: AllColors.primaryDark1)),
                   ),
                 ),
                 SizedBox(width: 10,),
                 Obx((){
                   bool allSelected = saleCycleController.salesAdviseCheckedList
                       .every((element) => element == true);
                   return Padding(
                     padding: const EdgeInsets.only(right: 10.0),
                     child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           ActionChip(
                             label: Text(
                               allSelected ? "Unselect All" : "Select All",
                               style: GoogleFonts.poppins(
                                 color: AllColors.whiteColor,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                             onPressed: () {
                               saleCycleController.selectAllSalesAdvise(!allSelected);
                             },
                             backgroundColor: AllColors.primaryDark1,
                             shape: StadiumBorder(
                               side: BorderSide.none,
                             ),
                           ),

                         ]),
                   );
                 }),
               ],
             ),

              Divider(
                height: 1,
                color: AllColors.grayColor,
                thickness: 2,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                  child: Obx(() {
                    return bindQuoteItemList(context);
                  }),
                ),
              ),
              Wrap(
                children: [
                 Container(
                      margin:
                      EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: DefaultButton(
                        press: () {
                          List<QuoteItems> selectedJsonList = saleCycleController.getSelectedQuoteItemsAsJson();
                          if(selectedJsonList.length>0){
                            saleCycleController.getSalesAdviceCreate(selectedJsonList,saleCycleController.quoteHeaderdata[0].quoteId??"");
                          }else{
                            Utils.showErrorToastification("Error", "Please select at least one quote item.");
                          }
                         /* saleCycleController.getSalesAdviceCreate(
                          );*/
                        },
                        text: "Create",
                      ),
                    ),
                ],
              ),

            ],),
        )
    ),
    );
  }

  Widget BindSalesData(BuildContext context) {
    String? quoteValidityDate = StaticMethod.convertDateFormat1(
        saleCycleController.quoteHeaderdata[0].quoteValidity ?? "");
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColors.grayColor, // Set the border color here
                width: 1.0, // Adjust the border width if necessary
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Quote Header Info',
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
                        "Sales Cycle Id",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.quoteHeaderdata[0].salesCycleId ??
                            "",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quote Id",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteId ??
                                '',
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0].quoteId ??
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
                        "Quote Status",
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
                                .quoteHeaderdata[0].quoteStatus ??
                                '',
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0].quoteStatus ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color:Colors.green,
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
                        "Quote Validity",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * .3,
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
                        width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .quoteHeaderdata[0].quoteCommit
                                .toString() ==
                                '1'
                                ? 'Yes'
                                : 'No',
                            child: Text(
                              saleCycleController.quoteHeaderdata[0].quoteCommit
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
                                .quoteHeaderdata[0].quoteTotalAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0].quoteTotalAmount
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
                                .quoteHeaderdata[0].quoteGstAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0].quoteGstAmount
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
                                .quoteHeaderdata[0].quoteGrossAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .quoteHeaderdata[0].quoteGrossAmount
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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget bindQuoteItemList(BuildContext context) {
    if (saleCycleController.quoteLinedata.value.isNotEmpty &&
        saleCycleController.quoteLinedata.value.length > 0) {
      return ListView.separated(
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
                    width: size.width * .5,
                    child: Tooltip(
                      message:
                      "${saleCycleController.quoteLinedata[index].itemName ?? ""}(${saleCycleController.quoteLinedata[index].itemCode})",
                      child: Text(
                        "${saleCycleController.quoteLinedata[index].itemName ?? ""}(${saleCycleController.quoteLinedata[index].itemCode})",
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
              Spacer(),
              Obx((){
                return Checkbox(
                  value: saleCycleController.salesAdviseCheckedList[index],
                  onChanged: (bool? value)  {
                    saleCycleController.toggleSalesAdviseCheckbox(index);
                  },
                );
              }),

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
                            Obx((){
                              bool isSelected = saleCycleController.salesAdviseCheckedList[index];
                              return GestureDetector(
                                onTap: (){
                                  if(isSelected){
                                    updateQtySalesCycleProduct(context, index);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Qty : ",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                        decoration: isSelected?TextDecoration.underline:TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      saleCycleController.quoteLinedata[index].qty
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.twelve,
                                        fontWeight: FontWeight.w500,
                                        decoration: isSelected?TextDecoration.underline:TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

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
                                      .quoteLinedata[index].quoteLinePrice
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
                                        .quoteLinedata[index].totalPrice
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .quoteLinedata[index].totalPrice
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

        ),
      ),
    );
  }


  void updateQtySalesCycleProduct(BuildContext context,  int position) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Qty (${saleCycleController.quoteLinedata[position].itemCode})',
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

  Future showDialogForAddressUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Address Update",
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
                        bindShippingAddress(context),
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
                              saleCycleController.quoteHeaderUpdateApiHit();
                              Get.back();
                            },
                            child: Container(
                              child: Text(
                                'Update Address',
                                style: GoogleFonts.poppins(
                                  color: AllColors.whiteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
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
                              saleCycleController.pageNumber = 0;
                              saleCycleController.getAddressMasterList(
                                  saleCycleController.pageNumber,
                                  saleCycleController.quoteHeaderdata[0].accountCode!);
                              saleCycleController.showConsigneeAddressList(
                                  context, saleCycleController.address_master_list);
                            },
                            child: Container(
                              child: Text(
                                'Change Address',
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