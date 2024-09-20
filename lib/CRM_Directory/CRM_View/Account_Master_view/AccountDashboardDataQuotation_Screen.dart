import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class AccountdashboarddataquotationScreen extends StatelessWidget{
  AccountdashboarddataquotationScreen({super.key});

  final accountMaster_page_controller=Get.put(Accountmastervm());
  final saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.AccountDashboardCount_Screen);
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
                  'Quotation List',
                  overflow: TextOverflow.ellipsis,
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:accountMaster_page_controller.loading.value ,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                  child:
                  Obx(() {
                    return BindAccountDashboardListView(context);
                  }),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BindAccountDashboardListView(context) {
    if (accountMaster_page_controller
        .AccountDashboardDataQuotationList.value.isNotEmpty &&
        accountMaster_page_controller
            .AccountDashboardDataQuotationList.value.length >
            0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (accountMaster_page_controller.total_rows /
              accountMaster_page_controller.rowsPerPage)
              .toInt();
          if ((accountMaster_page_controller.total_rows %
              accountMaster_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (accountMaster_page_controller.pageNumber + 1 < total_page) {
            accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber + 1,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.AccountCode, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);
            this.accountMaster_page_controller.pageNumber += 1;
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
          itemCount: accountMaster_page_controller
              .AccountDashboardDataQuotationList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindAccountDataListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }


  Widget BindAccountDataListView(context, int position) {
    String saleCycleStatus = accountMaster_page_controller.AccountDashboardDataQuotationList[position].quoteStatus??"";
    int? IsActive = accountMaster_page_controller.AccountDashboardDataQuotationList[position].isActive;
    String isActive = "";
    if(IsActive == 1){
      isActive = "Yes";
    }else{
      isActive = "No";
    }

    Color getStatusColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.yellow[700]!;
        case 'REGRET':
          return Colors.red;
        case 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          /* TaskMaster_page_controller.getTaskMaster(TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId , 'View');
          TaskMaster_page_controller.getTaskMstDSARList(TaskMaster_page_controller.Task_Master_list[position].taskId);
        */
        },
        subtitle: Column(
          children: [
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message:  accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .quoteStatus??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .quoteStatus??"",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: getStatusColor(saleCycleStatus),
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
                  "Quote Id: ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .quoteId??"",
                      child: Text(
                        accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                            .quoteId??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  onTap: (){
                    saleCycleController.getQuoteHeaderInformation(accountMaster_page_controller.AccountDashboardDataQuotationList[position].quoteId, "QuoteDashboard");
                  },
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
                Text(
                  accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                      .quoteValidity??"",
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
                  "Product Category : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .productCategory ?? "",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .productCategory??"",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        decorationStyle: TextDecorationStyle.wavy,),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Expected Closure Date : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Text("${
                    StaticMethod.dateTimeToDate(accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .expClosureDate??"")}",
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
                  "Quote Total Amt. : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .quoteTotalAmount.toString()??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .quoteTotalAmount.toString()??"",
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .quoteGrossAmount.toString()??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .quoteGrossAmount.toString()??"",
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .quoteGstAmount.toString()??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .quoteGstAmount.toString()??"",
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                        .createdFullName??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position]
                          .createdFullName??"",
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataQuotationList[position].otherRemarks ?? "",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataQuotationList[position].otherRemarks ?? "",
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
            /* Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Method of Call : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: TaskMaster_page_controller
                        .Task_Master_list[position]
                        .methodOfCall!,
                    child: Text(
                      TaskMaster_page_controller
                          .Task_Master_list[position]
                          .methodOfCall!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),*/
          ],
        ),

        //leading: bindAvatar(accountMaster_page_controller.Account_Master_list[position].profile),
        /*trailing: taskStatus == 'PENDING FOR APPROVAL' && IsReadyForApprove == 1 ? InkWell(
            onTap: (){
              showApprovRejectDialog(context, TaskMaster_page_controller
                  .Task_Master_list[position]
                  .taskId!);
            },
            child: Icon(Icons.update,  color: Colors.blue,),
          ) : (taskStatus.toLowerCase() == 'approved'?InkWell(
            onTap: (){
              TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), TaskMaster_page_controller.Task_Master_list[position].taskId , 'View', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
              // TaskMaster_page_controller.getTaskMstDSARList(TaskMaster_page_controller.Task_Master_list[position].taskId);
              // TaskMaster_page_controller.getItemCategoryMstApi(TaskMaster_page_controller.Task_Master_list[position].taskId);
            },
            child: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
          ):SizedBox()
          )*/

      ),
    );;
  }


  void showDialogForFilter(BuildContext context) {
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
                            /*filterWithQuoteStatus( context),
                            SizedBox(height: 10),*/
                            filterWithQuoteValidity( context),
                            SizedBox(height: 10),
                            filterWithQuoteClosureDate( context),
                            SizedBox(height: 10),
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
                                    onPressed: ()  {
                                      Get.back();
                                      accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                                    },
                                    child: Container(
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.sisxteen,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  width: size.width * 0.4,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: AllColors.redColor, width: 1),
                                    )),
                                    onPressed: ()  {
                                      try{
                                        saleCycleController.filterQuoteIdController.value.clear();
                                        saleCycleController.filterExpectedClosuredateController.value.clear();
                                        saleCycleController.filterQuoteValidityController.value.clear();
                                        accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);
                                        Navigator.pop(context);
                                      }catch(e){
                                        print("Exception..${e.toString()}");
                                      }

                                    },
                                    child: Container(
                                      child: Text(
                                        'Reset',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.redColor,
                                            fontSize: AllFontSize.sisxteen,
                                            fontWeight: FontWeight.w700),
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
  }


  Widget filterWithQuoteId(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
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
          )
      ),
    );
  }

  filterWithQuoteStatus(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
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
          )
      ),
    );
  }

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.filterQuoteValidityController.value,
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
            saleCycleController.filterQuoteValidityController.value.text= outputFormat.format(date);
          else
            saleCycleController.filterQuoteValidityController.value.text = "";
        }

    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.filterExpectedClosuredateController.value,
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
            saleCycleController.filterExpectedClosuredateController.value.text= outputFormat.format(date);
          else
            saleCycleController.filterExpectedClosuredateController.value.text = "";
        }



    );
  }

}