
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
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class SalesAdviseHeaderScreen extends StatelessWidget{
  SalesAdviseHeaderScreen({super.key});
  SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  static String _displaySalesAdviseStatusForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        saleCycleController.clearAllFieldOfQuoteFilter();
        saleCycleController.getQuoteHeaderInformation(
            saleCycleController.quoteHeaderdata[0].quoteId, "");
        Get.toNamed(RoutesName.quoteInformationScreen);
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
                  'Sales Advise ',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Obx((){
                  return Visibility(
                    visible:  saleCycleController.quoteHeaderdata[0].createdBy?.toLowerCase()==saleCycleController.email.toLowerCase()
                        || saleCycleController.userType.toLowerCase()=="branch head",
                      child: IconButton(
                          onPressed: () {
                            saleCycleController.routingForSalesAdvise.value="SalesAdvise";
                            saleCycleController.salesAdviceItemList.value=saleCycleController.quoteLinedata;
                            saleCycleController.salesAdviseCheckedList.value =
                                List.generate(saleCycleController.quoteLinedata.length, (_) => false);
                            Get.toNamed(RoutesName.salesAdviseCreateScreen);
                          },
                          icon: Icon(Icons.add_circle, size: 30,)),
                  );
                }),

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
          onRefresh: saleCycleController.refreshListOfSalesAdvise,
          child: Container(
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
    if (saleCycleController.salesAdviseHeaderList.value.isNotEmpty && saleCycleController.salesAdviseHeaderList.value.length > 0) {
      print("ghd");
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
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
              "last index ${saleCycleController.pageNumberSalesAdvise} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
          if (saleCycleController.pageNumberSalesAdvise + 1 < total_page) {
            saleCycleController.getSalesAdviseData(saleCycleController.pageNumberSalesAdvise+1,"","","");
            saleCycleController.pageNumberSalesAdvise += 1;
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
          itemCount: saleCycleController.salesAdviseHeaderList.value.length,
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
    String? quoteValidityDate=StaticMethod.convertDateFormat1(saleCycleController.salesAdviseHeaderList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(saleCycleController.salesAdviseHeaderList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(saleCycleController.salesAdviseHeaderList[position].createdOn ?? "");
    String? completedOn=StaticMethod.dateTimeToDate(saleCycleController.salesAdviseHeaderList[position].completedOn ?? "");
    String saleAdviseStatus = saleCycleController.salesAdviseHeaderList[position].salesAdviceStatus?.toLowerCase()??"";
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
          onTap: (){
            saleCycleController.routingSalesAdvise.value="fromSalesAdviseHeader";
            saleCycleController.getSalesAdviseHeaderLine(saleCycleController.salesAdviseHeaderList[position].salesAdviceId?? "");
          },
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
                      message: saleCycleController.salesAdviseHeaderList[position].salesAdviceId?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position].salesAdviceId?? "",
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
               Icon(Icons.remove_red_eye, size: 30,color: AllColors.textColor,)
            ],
          ),
          subtitle: Column(
            children: [
              Row(
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
                      message: saleCycleController.salesAdviseHeaderList[position].salesCycleId?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position].salesCycleId?? "",
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
                      message: saleCycleController.salesAdviseHeaderList[position].salesAdviceStatus?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position].salesAdviceStatus?? "",
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
                      message: saleCycleController.salesAdviseHeaderList[position].quoteId?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position].quoteId?? "",
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
                    saleCycleController.salesAdviseHeaderList[position].quoteVersion.toString(),
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .accountCode  ?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position]
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .accountName  ?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position]
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .contactName ?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position]
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .quoteTotalAmount.toString(),
                      child: Text(saleCycleController.salesAdviseHeaderList[position]
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .quoteGstAmount.toString(),
                      child: Text(saleCycleController.salesAdviseHeaderList[position]
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .quoteGrossAmount.toString(),
                      child: Text(saleCycleController.salesAdviseHeaderList[position]
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
/*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Spr No. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    //width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.salesAdviseHeaderList[position].sprNo ?? "",
                      child: Text(saleCycleController.salesAdviseHeaderList[position].sprNo ?? "",
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
              ),*/
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
                      message: saleCycleController.salesAdviseHeaderList[position]
                          .createdBy?? "",
                      child: Text(
                        saleCycleController.salesAdviseHeaderList[position]
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
              Obx((){
                return Visibility(
                  visible: saleCycleController.salesAdviseHeaderList[position]
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
                              message: saleCycleController.salesAdviseHeaderList[position]
                                  .completedBy??"",
                              child: Text(
                                saleCycleController.salesAdviseHeaderList[position]
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
                              message: saleCycleController.salesAdviseHeaderList[position]
                                  .completedFullName??"",
                              child: Text(
                                saleCycleController.salesAdviseHeaderList[position]
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
                  Text(saleCycleController.salesAdviseHeaderList[position]
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

  filterWithSalesAdviseStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: saleCycleController.salesAdviseStatusController.value,
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
          saleCycleController.salesAdviseStatusController.value.text =
              _displaySalesAdviseStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        saleCycleController.salesAdviseStatusList.map<
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
      controller:saleCycleController.createdOnCnontroller
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
          saleCycleController.createdOnStartToEnd.value="$startDate@$endDate";
          saleCycleController.createdOnCnontroller.value.text = '$startDate - $endDate';
        } else {
          saleCycleController.createdOnCnontroller.value.text = '';
          saleCycleController.createdOnStartToEnd.value="";
        }
      },
    );
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
                                controller: saleCycleController
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
                              saleCycleController.pageNumberSalesAdvise = 0;
                              //saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,"","");
                              saleCycleController.getSalesAdviseData(
                                  saleCycleController.pageNumberSalesAdvise,
                                  saleCycleController
                                      .quoteHeaderdata[0].salesCycleId??"",
                                  saleCycleController
                                      .quoteHeaderdata[0].quoteId??"",saleCycleController.salesAdviseStatusController.value.text
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
                              saleCycleController.pageNumberSalesAdvise = 0;
                              //saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,"","");
                              saleCycleController.getSalesAdviseData(
                                saleCycleController.pageNumberSalesAdvise,
                                saleCycleController
                                    .quoteHeaderdata[0].salesCycleId??"",
                                saleCycleController
                                    .quoteHeaderdata[0].quoteId??"",""
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


  Widget filterWithSalesAdviseId(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleController.salesAdviseIdController.value,
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

}