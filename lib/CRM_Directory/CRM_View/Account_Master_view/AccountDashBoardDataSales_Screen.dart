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
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class AccountdashboarddatasalesScreen extends StatelessWidget{
  AccountdashboarddatasalesScreen({super.key});

  SalesCycleVm salesCycleController=Get.put(SalesCycleVm());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size=Get.size;

  static String _displaySaleCycleStatusForOption(String option) =>
      option;

  static String _displayApprovalStatusForOption(String option) =>
      option;


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
                  'Sales List',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  showFilterBottomSheet(context);
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
        .AccountDashboardDataSalesList.value.isNotEmpty &&
        accountMaster_page_controller
            .AccountDashboardDataSalesList.value.length >
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
            accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber + 1,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.AccountCode, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss );
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
              .AccountDashboardDataSalesList.value.length,
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
    int? IsActive = accountMaster_page_controller.AccountDashboardDataSalesList[position].isInfraLead;
    String isActive = "";
    if(IsActive == 1){
      isActive = "Yes";
    }else{
      isActive = "No";
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
                  "Sale Cycle Status : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message:  accountMaster_page_controller.AccountDashboardDataSalesList[position]
                        .salesCycleStatus??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .salesCycleStatus??"",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
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
                  "Sales Cycle Id: ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  child: Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .salesCycleId??"",
                      child: Text(
                        accountMaster_page_controller.AccountDashboardDataSalesList[position]
                            .salesCycleId??"",
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
                    salesCycleController.clearAllFieldOfFilter();
                    salesCycleController.filterQuoteAcceptedFlag.value=
                        accountMaster_page_controller.AccountDashboardDataSalesList[position]
                            .quoteAccepted??"";
                    salesCycleController.pageNumber=0;
                    salesCycleController.getsalesCycleData(salesCycleController.pageNumber,  accountMaster_page_controller.AccountDashboardDataSalesList[position]
                        .salesCycleId!, "ViewHeader", 'FromDashboard');
                    salesCycleController.pageNumber=0;
                    salesCycleController.getSaleCycleProductByIdList(salesCycleController.pageNumber,accountMaster_page_controller.AccountDashboardDataSalesList[position].salesCycleId!);
                  },
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
                Text(
                  accountMaster_page_controller.AccountDashboardDataSalesList[position]
                      .salesCycleApprovalStatus!,
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
                      message: accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .accountName ?? "",
                      child: Text(
                        accountMaster_page_controller.AccountDashboardDataSalesList[position]
                            .accountName??
                            "" + " | ${accountMaster_page_controller.AccountDashboardDataSalesList[position]
                                .accountName ?? ""}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                         // decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.wavy,),
                      ),
                    ),
                  ),
                  /*onTap: (){
                      account_vm_controller.view='FromTaskMainScreen';
                      contact_vm_controller.view='VIEWMainScreen';
                      account_vm_controller.getAccMasterBuyCodeApi(TaskMaster_page_controller.Task_Master_list[position].accountCode);
                    },*/
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataSalesList[position]
                        .contactName??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .contactName??"",
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
                  "Product Category: ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataSalesList[position]
                        .productCategory??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .productCategory??"",
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
                  "Is Infra Lead: ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: Text(
                    isActive,
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      //decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                  /*onTap: (){
                      salesCycleController.getsalesCycleData(0, TaskMaster_page_controller
                          .Task_Master_list[position]
                          .salesCycleId!, "ViewHeader", 'FromTaskScreen');
                    },*/
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: accountMaster_page_controller.AccountDashboardDataSalesList[position]
                        .approvedFullName??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .approvedFullName??"",
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
                    message: accountMaster_page_controller.AccountDashboardDataSalesList[position]
                        .createdFullName??"",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataSalesList[position]
                          .createdFullName??"" + "| ${StaticMethod.dateTimeToDate(accountMaster_page_controller.AccountDashboardDataList[position]
                          .createdOn??"")}",
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
                    message: accountMaster_page_controller.AccountDashboardDataSalesList[position].salesCycleRemarks ?? "",
                    child: Text(
                      accountMaster_page_controller.AccountDashboardDataSalesList[position].salesCycleRemarks ?? "",
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


  void showFilterBottomSheet(BuildContext context) {
    /*salesCycleController.accountNameController.value.clear();
    salesCycleController.contactNameController.value.clear();
    salesCycleController.SaleCycleStatusController.value.clear();
    salesCycleController.ApprovalStatusController.value.clear();*/
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
                        /*SizedBox(
                          height: 5,
                        ),
                        bindSaleCycleStatusDropDown(context),
*/
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

                       /* TextField(
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
                        ),*/

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
                                  accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss );

                                  //salesCycleController.getsalesCycleData(salesCycleController.pageNumber, '', '', '');
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
                                  accountMaster_page_controller.ClearSalesFilter();
                                  accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss );

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
  }

  Widget bindSaleCycleStatusDropDown(BuildContext context){
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
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
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
    return Autocomplete<String>(
      displayStringForOption: _displayApprovalStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return salesCycleController.ApprovalStatusList;
          // return const Iterable<VehicleTypeResponse>.empty();
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
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
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
    );
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

}