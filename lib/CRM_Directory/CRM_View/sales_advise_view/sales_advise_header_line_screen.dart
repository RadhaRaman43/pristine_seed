
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sales_advise_modal/sales_advise_header_line_modal.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';

import '../../../component/back_button.dart';
import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../models/service_managment_model_directory/bulk_indent_model/bulk_item_master_model.dart';
import '../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';

class SalesAdviseHeaderLineScreen extends StatelessWidget{
  var saleCycleController=Get.put(SalesCycleVm());
  final address_vm_controller = Get.put(Addressmastervm());
  Size size=Get.size;
  static String _displayItemNoForOption(BulkItemMasterGetModel option) =>
      option.itemCode!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        saleCycleController.pageNumberSalesAdvise=0;
        saleCycleController.getSalesAdviseData(saleCycleController.pageNumberSalesAdvise,
          saleCycleController.quoteHeaderdata[0].salesCycleId??"", saleCycleController.quoteHeaderdata[0].quoteId??"","" );
        Get.toNamed(RoutesName.salesAdviseHeaderScreen);
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
                Text(
                  'Sales Advise(${saleCycleController.salesAdviseHeaderLineList[0].salesAdviceId.toString()})',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),

                Obx((){
                  return  Visibility(
                    visible: (saleCycleController.salesAdviseHeaderLineList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()
                    || saleCycleController.userType.toLowerCase()=="branch head")
                      && saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft",
                    child: GestureDetector(
                        onTap: (){
                          saleCycleController.bindSalesAdviseAddress(saleCycleController.salesAdviseHeaderLineList[0]);
                          showDialogForAddressUpdate(context, );
                        },
                        child: Tooltip(
                            message: "Update Sales Advise Header",
                            child: Icon(Icons.update_sharp))),
                  );
                })
              ],
            ),

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
                    Obx(() {
                      return BindSalesAdviseHeaderData(context);
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sales Advise Line Details",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.eighteen,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Visibility(
                            visible: (saleCycleController.salesAdviseHeaderLineList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()
                                || saleCycleController.userType.toLowerCase()=="branch head")
                                &&saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft",
                            child: ActionChip(
                                label: Text(
                                  "Complete",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  showDialogForComplete(context);
                                },
                                backgroundColor: AllColors.primaryDark1,
                                shape: StadiumBorder(
                                  side: BorderSide.none,
                                ),
                              ),
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

                    Obx(() {
                      return bindSalesAdvisItemList(context);
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


  Widget BindSalesAdviseHeaderData(BuildContext context) {
    String? dateTimeCreatedOn = StaticMethod.dateTimeToDate(
        saleCycleController.salesAdviseHeaderLineList[0].createdOn ?? "");
    String? expectedclosuredate = StaticMethod.convertDateFormat1(
        saleCycleController.salesAdviseHeaderLineList[0].expClosureDate ?? "");
    String? quoteValidityDate = StaticMethod.convertDateFormat1(
        saleCycleController.salesAdviseHeaderLineList[0].quoteValidity ?? "");
    String? completedOn=StaticMethod.dateTimeToDate(saleCycleController.salesAdviseHeaderLineList[0].completedOn ?? "");
    String saleCycleQuoteStatus =
        saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase() ?? "";
    Color getStatusColor(String status) {
      switch (status) {
        case "draft":
          return Colors.red[900]!;
        case 'completed':
          return Colors.green;
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
                labelText: 'Sales Advise Header',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sales Quote Id",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController.salesAdviseHeaderLineList[0].quoteId ??
                            "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
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
                        "Sales Cycle Id",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        saleCycleController.salesAdviseHeaderLineList[0].salesCycleId ??
                            "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
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
                        "Sales Advise Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .3,
                        child:  Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].salesAdviceStatus ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].salesAdviceStatus ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: getStatusColor(saleCycleQuoteStatus),
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
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
                          message: saleCycleController.salesAdviseHeaderLineList[0]
                              .accountCode  ?? "",
                          child: Text(
                            saleCycleController.salesAdviseHeaderLineList[0]
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
                  SizedBox(
                    height: 3,
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
                          message: saleCycleController.salesAdviseHeaderLineList[0]
                              .accountName  ?? "",
                          child: Text(
                            saleCycleController.salesAdviseHeaderLineList[0]
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
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact Name',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        saleCycleController.salesAdviseHeaderLineList[0].contactName ??
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Category",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .4,
                        child: Tooltip(
                          message: saleCycleController
                              .salesAdviseHeaderLineList[0].productCategory ??
                              "",
                          child: Text(
                            saleCycleController
                                .salesAdviseHeaderLineList[0].productCategory!,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expected Closure Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quote Validity",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .3,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quote Commit",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Flexible(
                        //width: size.width * .3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteCommit
                                .toString() ==
                                '1'
                                ? 'Yes'
                                : 'No',
                            child: Text(
                              saleCycleController.salesAdviseHeaderLineList[0].quoteCommit
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sales Advise Total Amt.",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        //width: size.width * .3,
                        child:  Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteTotalAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].quoteTotalAmount
                                  .toString() ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          )

                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sales Advise GST Amt.",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        //width: size.width * .3,
                        child:Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteGstAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].quoteGstAmount
                                  .toString() ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          )

                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sales Advise Gross Amt.",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Flexible(
                       // width: size.width * .3,
                        child:  Tooltip(
                            message: saleCycleController
                                .salesAdviseHeaderLineList[0].quoteGrossAmount
                                .toString() ??
                                '',
                            child: Text(
                              saleCycleController
                                  .salesAdviseHeaderLineList[0].quoteGrossAmount
                                  .toString() ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                      )
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
                                  .salesAdviseHeaderLineList[0].salesCycleId!);
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
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Flexible(
                       // width: size.width * .4,
                        child: Tooltip(
                          message: saleCycleController
                              .salesAdviseHeaderLineList[0].createdFullName ??
                              "",
                          child: Text(
                            saleCycleController
                                .salesAdviseHeaderLineList[0].createdFullName ??
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Created on",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

                  Obx((){
                    return Visibility(
                      visible: saleCycleController.salesAdviseHeaderLineList[0]
                          .salesAdviceStatus?.toLowerCase()=="completed",
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Completed by : ",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500),
                              ),
                              Flexible(
                                child: Tooltip(
                                  message: saleCycleController.salesAdviseHeaderLineList[0]
                                      .completedBy??"",
                                  child: Text(
                                    saleCycleController.salesAdviseHeaderLineList[0]
                                        .completedBy??"",
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
                                "Completed Full Name : ",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500),
                              ),
                              Flexible(
                                child: Tooltip(
                                  message: saleCycleController.salesAdviseHeaderLineList[0]
                                      .completedFullName??"",
                                  child: Text(
                                    saleCycleController.salesAdviseHeaderLineList[0]
                                        .completedFullName??"",
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
                                "Completed On : ",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500),
                              ),
                              Flexible(
                                child: Tooltip(
                                  message: completedOn.toString(),
                                  child: Text(
                                    completedOn.toString(),
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
                        ],
                      ),
                    );
                  }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bindSalesAdvisItemList(BuildContext context) {
    if (saleCycleController.salesAdviseLinesDataList.value.isNotEmpty &&
        saleCycleController.salesAdviseLinesDataList.value.length > 0) {
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
                itemCount: saleCycleController.salesAdviseLinesDataList.value.length,
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
    return InkWell(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Name: ",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Flexible(
               // width: size.width * .4,
                child: Tooltip(
                  message:
                  "${saleCycleController.salesAdviseLinesDataList[index].itemName ?? ""}(${saleCycleController.salesAdviseLinesDataList[index].itemCode})",
                  child: Text(
                    "${saleCycleController.salesAdviseLinesDataList[index].itemName ?? ""}(${saleCycleController.salesAdviseLinesDataList[index].itemCode})",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: (saleCycleController.salesAdviseHeaderLineList[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()
                    || saleCycleController.userType.toLowerCase()=="branch head")
                    &&
                saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft",
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      showDialogForDelete(context, index);
                    },
                        icon: Icon(Icons.delete, color: AllColors.redColor, size: 30,)),


                    IconButton(onPressed: (){
                      saleCycleController.qtyUpdateLineController.value.text=saleCycleController.salesAdviseLinesDataList[index].qty.toString();
                      updateQtySalesCycleProduct(context, saleCycleController.salesAdviseLinesDataList[index], index);
                    }, icon: Icon(Icons.update_outlined, size: 30, color: AllColors.textColor,)),
                  ],
                ),
              )
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
                                        .salesAdviseLinesDataList[index].itemDescription ??
                                        "",
                                    child: Text(
                                      (saleCycleController.salesAdviseLinesDataList[index]
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
                                  "ERP Item Code : ",
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
                                        .salesAdviseLinesDataList[index].itemCode ??
                                        "",
                                    child: Text(
                                      (saleCycleController.salesAdviseLinesDataList[index]
                                          .itemCode ??
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
                            GestureDetector(
                              onTap: (){
                                if(saleCycleController.salesAdviseLinesDataList[index].productType?.toLowerCase()!="standard"
                                    && saleCycleController.salesAdviseHeaderLineList[0].salesAdviceStatus?.toLowerCase()=="draft"){
                                  updateERPItemName(context,saleCycleController.salesAdviseLinesDataList[index], index);
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "ERP Item Name : ",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.twelve,
                                      fontWeight: FontWeight.w500,
                                        decoration: saleCycleController.salesAdviseLinesDataList[index].productType?.toLowerCase()!="standard"?TextDecoration.underline
                                            :TextDecoration.none
                                    ),
                                  ),
                                  Container(
                                    width: size.width * .2,
                                    child: Tooltip(
                                      message: saleCycleController
                                          .salesAdviseLinesDataList[index].erpItemName ??
                                          "",
                                      child: Text(
                                        (saleCycleController.salesAdviseLinesDataList[index]
                                            .erpItemName ??
                                            ""),
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.twelve,
                                          fontWeight: FontWeight.w500,
                                          decoration: saleCycleController.salesAdviseLinesDataList[index].productType?.toLowerCase()!="standard"?TextDecoration.underline
                                              :TextDecoration.none
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                        .salesAdviseLinesDataList[index].categoryName ??
                                        "",
                                    child: Text(
                                      (saleCycleController
                                          .salesAdviseLinesDataList[index].categoryName ??
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
                                  saleCycleController.salesAdviseLinesDataList[index].qty
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
                                Text(
                                  saleCycleController
                                      .salesAdviseLinesDataList[index].quoteLinePrice
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
                                  saleCycleController.salesAdviseLinesDataList[index].sgstAmt
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
                                      .salesAdviseLinesDataList[index].discountPer
                                      .toString(),
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
                  Expanded(
                      child: Container(
                        width: size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                        .salesAdviseLinesDataList[index].approvedDiscountPer
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .salesAdviseLinesDataList[index].approvedDiscountPer
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
                                        .salesAdviseLinesDataList[index]
                                        .approvedAmount ==
                                        null
                                        ? "0"
                                        : saleCycleController
                                        .salesAdviseLinesDataList[index].approvedAmount
                                        .toString(),
                                    child: Text(
                                      saleCycleController.salesAdviseLinesDataList[index]
                                          .approvedAmount ==
                                          null
                                          ? ""
                                          : saleCycleController
                                          .salesAdviseLinesDataList[index].approvedAmount
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
                                      .salesAdviseLinesDataList[index].salesCredit
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
                                        .salesAdviseLinesDataList[index].totalPrice
                                        .toString(),
                                    child: Text(
                                      saleCycleController
                                          .salesAdviseLinesDataList[index].totalPrice
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
                                  saleCycleController.salesAdviseLinesDataList[index].sgstPer
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
                                  saleCycleController.salesAdviseLinesDataList[index].gstAmount
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
                                      .salesAdviseLinesDataList[index].totalPrice
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
                                      .salesAdviseLinesDataList[index].isSprRequired
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



   updateERPItemName(BuildContext context, QuoteItems salesAdviseLinesDataList, int index ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update(${salesAdviseLinesDataList.itemCode})',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                ),

                SizedBox(
                  height: 15,
                ),
               bindERPItemName(context, index),
                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DefaultButton(
                         press: (){
                           saleCycleController.getsalesAdviceLineItemUpdate(salesAdviseLinesDataList);
                           Get.back();
                         },
                       text: "Save",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: DefaultButton(
                        press: (){
                          saleCycleController.erpItemNameController.value
                              .clear();
                          Navigator.pop(context);
                        },
                        text: "Cancel",
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void updateQtySalesCycleProduct(BuildContext context, QuoteItems salesAdviseLinesDataList, int index ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Qty (${salesAdviseLinesDataList.itemCode})',
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
                        //color: Colors.white,
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
                      Expanded(
                        child: DefaultButton(
                          press: (){
                            saleCycleController.getSalesAdviseLineUpdate(salesAdviseLinesDataList);
                            Get.back();
                          },
                          text:"Save" /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: DefaultButton(
                          text: "Cancel",
                          press: (){
                            saleCycleController.qtyUpdateLineController.value
                                .clear();
                            Navigator.pop(context); 
                          },
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
                      Text('Do you want to delete this Sales Advise Line?',
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
                                  saleCycleController.getSalesAdviseLineDelete(saleCycleController.salesAdviseLinesDataList[index]);
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

  Future showDialogForComplete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                "Complete",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Do you want to Complete this Sales Advise Line?',
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
                                  saleCycleController.getSalesAdviseHeaderComplete(saleCycleController.salesAdviseLinesDataList[0].salesAdviceId??"");
                                  Navigator.pop(context);
                                },
                                child: Container(
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

 Future showDialogForAddressUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address Update",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.close_outlined, size: 25, color: AllColors.primaryDark1,))
                ],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DefaultButton(
                                  text: 'Change',
                                  press: (){
                                    saleCycleController.pageNumber = 0;
                                    saleCycleController.getAddressMasterList(
                                        saleCycleController.pageNumber,
                                        saleCycleController.quoteHeaderdata[0].accountCode!);
                                    saleCycleController.showConsigneeAddressList(
                                        context, saleCycleController.address_master_list,saleCycleController.quoteHeaderdata[0].accountCode!);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: DefaultButton(
                                  text: 'Update',
                                  press: (){
                                    saleCycleController.getSalesAdviseHeaderUpdate(saleCycleController.salesAdviseLinesDataList[0].salesAdviceId??"");
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
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
                              address_vm_controller.FromPage.value="AddSalesAdvise";
                              address_vm_controller.clearController();
                              address_vm_controller.account_code_controller.text=saleCycleController.saleCycleList[0].accountCode??"";
                              address_vm_controller.account_name_controller.text=saleCycleController.saleCycleList[0].accountName??"";
                              address_vm_controller.gst_registration_type_controller.value.text = 'UnRegistered';
                              address_vm_controller.getGeoPostalCodeApi();
                              Get.toNamed(RoutesName.addNewAddress_screen);
                            },
                            child: Container(
                              child: Text(
                                'Add New Address',
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
            ),
          ],
        ),
      ),
    );
  }
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
                            "Qty: ",
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
                                    saleCycleController
                                        .getSaleCycleProductByIdList(
                                        saleCycleController.pageNumber,
                                        saleCycleController
                                            .quoteHeaderdata[0]
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
                                        saleCycleController
                                            .quoteHeaderdata[0]
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
            })),
          );
        });
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
              "Item Code: ",
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
                Container(
                  width: size.width * .4,
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
                  saleCycleController.get_SalesCycleProductById_List[index].qty
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
                  "MRP Price : ",
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
            /* Row(
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
            ),*/
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
            /*Column(
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
            )*/
          ],
        ),
      ),
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



  Widget bindERPItemName(context,int index) {
    return Autocomplete<BulkItemMasterGetModel>(
      displayStringForOption: _displayItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.item_no_list.value;
        }
        return await saleCycleController.getItemNo(textEditingValue.text);
      },
      onSelected: (BulkItemMasterGetModel selection) {

        saleCycleController.erpItemNameController.value.text =
            _displayItemNoForOption(selection).toString();
        //saleCycleController.item_no = selection.itemCode!;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTapOutside: (value){
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            if(value.isEmpty){
              saleCycleController.erpItemNameController.value.clear();
            }
            saleCycleController.getItemNo("");
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = saleCycleController.erpItemNameController.value.text ,
          focusNode: focusNode,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Select Erp Item Name ',
              labelText: 'Select Erp Item Name',
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
          AutocompleteOnSelected<BulkItemMasterGetModel> onSelected,
          Iterable<BulkItemMasterGetModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              width: size.width*.7,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final BulkItemMasterGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child:Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * .6,
                              child: Tooltip(
                                message: option.itemCode.toString() +
                                    " (${option.displayName ?? ""} )",
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  option.itemCode.toString() +
                                      " (${option.displayName ?? ""} )",
                                  style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }


}