
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class QuoteApprovalListScreen extends StatelessWidget{
  QuoteApprovalListScreen({super.key});
  QuoteApprovalListVm quoteApprovalController=Get.put(QuoteApprovalListVm());
  SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
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
                  'Quote Approval List',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
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
          onRefresh:quoteApprovalController.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:quoteApprovalController.loading.value ,
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
    if (quoteApprovalController.quoteApprovalList.value.isNotEmpty && quoteApprovalController.quoteApprovalList.value.length > 0) {
      print("ghd");
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (quoteApprovalController.total_rows /
              quoteApprovalController.rowsPerPage)
              .toInt();
          if ((quoteApprovalController.total_rows %
              quoteApprovalController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${quoteApprovalController.pageNumberForQuote} ${quoteApprovalController.total_rows} ${quoteApprovalController.rowsPerPage} ${total_page}");
          if (quoteApprovalController.pageNumberForQuote + 1 < total_page) {
            quoteApprovalController.getQuoteHeaderData(quoteApprovalController.pageNumberForQuote+1);
            quoteApprovalController.pageNumberForQuote += 1;
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
          itemCount: quoteApprovalController.quoteApprovalList.value.length,
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
    String? quoteValidityDate=StaticMethod.convertDateFormat1(quoteApprovalController.quoteApprovalList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(quoteApprovalController.quoteApprovalList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(quoteApprovalController.quoteApprovalList[position].createdOn ?? "");
    String saleCycleStatus = quoteApprovalController.quoteApprovalList[position].quoteStatus??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'PENDING':
          return Colors.brown[900]!;
        case 'Rejected':
          return Colors.red;
        case 'rejected':
          return Colors.red;
        case 'APPROVED':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
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
            saleCycleController.getQuoteHeaderInformation(quoteApprovalController.quoteApprovalList[position].quoteId, "quoteApprovalScreen");
          },
          subtitle: Column(
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
                      message: quoteApprovalController.quoteApprovalList[position].quoteId?? "",
                      child: Text(
                        quoteApprovalController.quoteApprovalList[position].quoteId?? "",
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
                    "Quote Version: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    quoteApprovalController.quoteApprovalList[position].quoteVersion.toString(),
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
                    "Quote Status : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .36,
                    child: Tooltip(
                      message: quoteApprovalController.quoteApprovalList[position]
                          .quoteStatus ?? "",
                      child: Text(quoteApprovalController.quoteApprovalList[position]
                          .quoteStatus ?? "",
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
                    "Sale Cycle Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: (){
                      saleCycleController.pageNumber = 0;
                      saleCycleController.getsalesCycleData(saleCycleController.pageNumber, quoteApprovalController.quoteApprovalList[position]
                          .salesCycleId!, "ViewHeader", "QuoteApprovalPage");
                    },
                    child: Container(
                      width: size.width * .36,
                      child: Tooltip(
                        message: quoteApprovalController.quoteApprovalList[position]
                            .salesCycleId ?? "",
                        child: Text(quoteApprovalController.quoteApprovalList[position]
                            .salesCycleId ?? "",
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
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
                      width: size.width*0.4,
                      child: Tooltip(
                        message: quoteApprovalController.quoteApprovalList[position]
                            .accountName  ?? "",
                        child: Text(
                          quoteApprovalController.quoteApprovalList[position]
                              .accountName ??
                              "",
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.end,
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
                      account_vm_controller.view='FromQuoteApproval';
                      contact_vm_controller.view='FromQuoteVIEW';
                      account_vm_controller.getAccMasterBuyCodeApi(quoteApprovalController.quoteApprovalList[position]
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
                      message: quoteApprovalController.quoteApprovalList[position]
                          .contactName ?? "",
                      child: Text(
                        quoteApprovalController.quoteApprovalList[position]
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
                    "Quote Validity : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
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
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Quote Total Amt : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .37,
                    child: Tooltip(
                      message: quoteApprovalController.quoteApprovalList[position]
                          .quoteTotalAmount.toString(),
                      child: Text(quoteApprovalController.quoteApprovalList[position]
                          .quoteTotalAmount.toString(),
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
                    "Quote Gst Amt. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: quoteApprovalController.quoteApprovalList[position]
                          .quoteGstAmount.toString(),
                      child: Text(quoteApprovalController.quoteApprovalList[position]
                          .quoteGstAmount.toString(),
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
                    "Quote Gross Amt. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message: quoteApprovalController.quoteApprovalList[position]
                          .quoteGrossAmount.toString(),
                      child: Text(quoteApprovalController.quoteApprovalList[position]
                          .quoteGrossAmount.toString(),
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
                    "Spr No. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: quoteApprovalController.quoteApprovalList[position].sprNo ?? "",
                      child: Text(quoteApprovalController.quoteApprovalList[position].sprNo ?? "",
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
                    "Created By : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: quoteApprovalController.quoteApprovalList[position]
                          .createdBy?? "",
                      child: Text(
                        quoteApprovalController.quoteApprovalList[position]
                            .createdBy ?? "",
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
                    "Created On : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: createdOn.toString(),
                      child: Text(
                       createdOn.toString(),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Is Spr : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.blackColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(quoteApprovalController.quoteApprovalList[position]
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
          trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
        ),
      ),
    );
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
                              SizedBox(
                                height: 5,
                              ),
                              filterWithQuoteId(context),
                              SizedBox(height: 10),
                              filterWithQuoteStatus(context),
                              SizedBox(height: 10),
                              filterWithSaleCycle(context),
                              SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10),
                              TextField(
                                controller: quoteApprovalController.accountNameController.value,
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
                                controller: quoteApprovalController.accountCodeController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
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

                              filterWithQuoteFrontLinerValue(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteBranchHead(),
                              SizedBox(
                                height: 10,
                              ),
                              filterWithQuoteZoneHead(),
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.primaryDark,
                                  width: 1),
                            )),
                            onPressed: () {

                              quoteApprovalController.pageNumberForQuote = 0;
                              quoteApprovalController.getQuoteHeaderData(quoteApprovalController.pageNumberForQuote,
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.redColor, width: 1),
                            )),
                            onPressed: () {

                              quoteApprovalController.clearAllFieldOfQuoteFilter();
                              quoteApprovalController.pageNumberForQuote = 0;
                              //saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,"","");
                              quoteApprovalController.getQuoteHeaderData(quoteApprovalController.pageNumberForQuote,);
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
  filterWithQuoteRhApproval() {
    return TextField(
      controller: quoteApprovalController.rh_Approval_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuotecnhApproval() {
    return TextField(
      controller: quoteApprovalController.cbh_Approval_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuoteCategoryApproval() {
    return  TextField(
      controller: quoteApprovalController.category_Approval_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuoteGmApproval() {
    return TextField(
      controller: quoteApprovalController.gm_Approval_controller.value,
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
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  filterWithQuoteStatus(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: quoteApprovalController.filterQuoteStatusController.value,
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
          )
      ),
    );
  }

  filterWithQuoteProductCategory() {
    return TextField(
      controller: quoteApprovalController.productCategoryController.value,
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

  filterWithQuoteFrontLinerValue() {
    return TextField(
      controller: quoteApprovalController.frontliner_controller.value,
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
  }

  filterWithQuoteClusterHead() {
    return TextField(
      controller: quoteApprovalController.cluster_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Cluster Head Value',
          hintText: 'Cluster Head Value',
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

  filterWithQuoteZoneHead() {
    return TextField(
      controller: quoteApprovalController.zone_head_value_controller.value,
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
  }

  filterWithQuoteBranchHead() {
    return TextField(
      controller: quoteApprovalController.branch_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Branch Head Value',
          hintText: 'Branch Head Value',
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
        controller: quoteApprovalController.createdOnCnontroller.value,
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
            quoteApprovalController.createdOnCnontroller.value.text =
                outputFormat.format(date);
          else
            quoteApprovalController.createdOnCnontroller.value.text =
            "";
        }


    );
  }
/*  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_moon_rounded, color: AllColors.lightredColor,),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel, color: AllColors.lightredColor,)
                      ),
                    ],
                  ),
                ),
                Divider(height: 1,color: Colors.grey,),
                SingleChildScrollView(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            filterWithQuoteId( context),
                            SizedBox(height: 10),
                            filterWithSaleCycle(context),
                            SizedBox(height: 10),
                            filterWithAccountName( context),
                            SizedBox(height: 10),
                            filterWithContactName( context),
                            SizedBox(height: 10),
                            filterWithQuoteValidity( context),
                            SizedBox(height: 10),
                            filterWithQuoteClosureDate( context),
                            SizedBox(height: 10),
                           *//* filterWithQuotetotalAmount( context),
                            SizedBox(height: 10),
                            filterWithQuoteGstAmt( context),
                            SizedBox(height: 10),
                            filterWithQuoteCrossAmt( context),
                            SizedBox(height: 10),*//*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        AllColors.greenblue,
                                      ),
                                    ),
                                    onPressed: ()  {
                                      try{
                                        quoteApprovalController.filterQuoteIdController.value.clear();
                                        quoteApprovalController.filterExpectedClosuredateController.value.clear();
                                        quoteApprovalController.filterQuoteValidityController.value.clear();
                                        quoteApprovalController.filterQuoteContactNameController.value.clear();
                                        quoteApprovalController.filterQuoteAccountNameController.value.clear();
                                        quoteApprovalController.getQuoteHeaderData(quoteApprovalController.pageNumberForQuote);
                                        Navigator.pop(context);
                                      }catch(e){
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
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        AllColors.redColor,
                                      ),
                                    ),
                                    onPressed: ()  {
                                      quoteApprovalController.getQuoteHeaderData(quoteApprovalController.pageNumberForQuote);
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

  Widget filterWithQuoteId(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteApprovalController.filterQuoteIdController.value,
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
          )
      ),
    );
  }

  filterWithAccountName(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteApprovalController.filterQuoteAccountNameController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Account Name',
          labelText: 'Account Name',
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
  filterWithContactName(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteApprovalController.filterQuoteContactNameController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Contact Name',
          labelText: 'Contact Name',
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

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: quoteApprovalController.filterQuoteValidityController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
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
            )
        ),
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
            quoteApprovalController.filterQuoteValidityController.value.text= outputFormat.format(date);
          else
            quoteApprovalController.filterQuoteValidityController.value.text = "";
        }

    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: quoteApprovalController.filterExpectedClosuredateController.value,
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
            quoteApprovalController.filterExpectedClosuredateController.value.text= outputFormat.format(date);
          else
            quoteApprovalController.filterExpectedClosuredateController.value.text = "";
        }



    );
  }


  /*filterWithQuotetotalAmount(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteApprovalController.filterQouteTatolAmtController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Total Amount',
          labelText: 'Quote Total Amount',
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

  filterWithQuoteGstAmt(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteApprovalController.filterQuoteGstAmtController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Gst Amt.',
          labelText: 'Quote Gst Amt.',
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

  filterWithSaleCycle(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteApprovalController.filterQuoteSaleCycleController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Sale Cycle Id',
          labelText: 'Sale Cycle Id',
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