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
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class AccountdashboardcountScreen extends StatelessWidget{

  AccountdashboardcountScreen({super.key});

  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  final saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Get.toNamed(RoutesName.update_AccountMaster_screen);
      return false;
    },child: Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,

          ),
          /*actions: [
            IconButton(
              onPressed: (){
               // FilterDialog(context);

              },
              icon: const Icon(Icons.filter_alt_sharp),
            )
          ],*/
          title:Row(
            children: [
              Text(
                'Customer Dashboard',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView(
                   children: [
                     Card(
                       color: AllColors.whiteColor,
                       elevation: 10,
                       margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                       child: Column(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10.0),
                               color: AllColors.textColor,
                             ),
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 10),
                                   child: Icon(Icons.border_color_outlined, color: AllColors.whiteColor,),
                                 ),
                                 Text(
                                   "Task",
                                   style: GoogleFonts.poppins(
                                     color: AllColors.whiteColor,
                                     fontSize: AllFontSize.twentee,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                                 Obx(
                                       () {
                                     return IconButton(
                                       onPressed: () {
                                         accountMaster_page_controller.toggle();
                                         if (accountMaster_page_controller
                                             .isExpandDetails.value ==
                                             true) {
                                           print(
                                               "If......${accountMaster_page_controller.isExpandDetails.value}");
                                         } else {
                                           print(
                                               "else......${accountMaster_page_controller.isExpandDetails.value}");
                                         }
                                       },
                                       icon: Icon(
                                         accountMaster_page_controller
                                             .isExpandDetails.value
                                             ? Icons.arrow_drop_down
                                             : Icons.arrow_drop_up,
                                         size: 25,
                                         color: AllColors.whiteColor,
                                       ),
                                     );
                                   },
                                 )

                               ],
                             ),
                           ),
                           // Divider(color: Colors.black,),
                           Obx(() {
                             return viewTaskCount(context);
                           }),
                         ],
                       ),
                     ),
                     SizedBox(height: 10),
                     Card(
                       color: AllColors.whiteColor,
                       elevation: 10,
                       margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                       child: Column(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                               /*border: Border.all(
                        color: AllColors.blackColor, // Set the border color here
                      ),*/
                                 borderRadius: BorderRadius.circular(10.0),
                               color: AllColors.textColor,
                             ),
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 10),
                                   child: Icon(Icons.save_as_outlined, color: AllColors.whiteColor,),
                                 ),
                                 Text(
                                   "Sales",
                                   style: GoogleFonts.poppins(
                                     color: AllColors.whiteColor,
                                     fontSize: AllFontSize.twentee,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                                 Obx(
                                       () {
                                     return IconButton(
                                       onPressed: () {
                                         accountMaster_page_controller.toggleSales();
                                         if (accountMaster_page_controller
                                             .isExpandSales.value ==
                                             true) {
                                           print(
                                               "If......${accountMaster_page_controller.isExpandSales.value}");
                                         } else {
                                           print(
                                               "else......${accountMaster_page_controller.isExpandSales.value}");
                                         }
                                       },
                                       icon: Icon(
                                         accountMaster_page_controller
                                             .isExpandSales.value
                                             ? Icons.arrow_drop_down
                                             : Icons.arrow_drop_up,
                                         size: 25,
                                         color: AllColors.whiteColor,
                                       ),
                                     );
                                   },
                                 )

                               ],
                             ),
                           ),
                           // Divider(color: Colors.black,),
                           Obx(() {
                             return viewSalesCount(context);
                           }),
                         ],
                       ),
                     ),
                     SizedBox(height: 10),
                     Card(
                       color: AllColors.whiteColor,
                       elevation: 10,
                       margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                       child: Column(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                               /*border: Border.all(
                        color: AllColors.blackColor, // Set the border color here
                      ),*/
                                 borderRadius: BorderRadius.circular(10.0),
                               color: AllColors.textColor,
                             ),
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 10),
                                   child: Icon(Icons.quickreply, color: AllColors.whiteColor,),
                                 ),
                                 Text(
                                   "Quotation",
                                   style: GoogleFonts.poppins(
                                     color: AllColors.whiteColor,
                                     fontSize: AllFontSize.twentee,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                                 Obx(
                                       () {
                                     return IconButton(
                                       onPressed: () {
                                         accountMaster_page_controller.toggleQuotation();
                                         if (accountMaster_page_controller
                                             .isExpandQuotation.value ==
                                             true) {
                                           print(
                                               "If......${accountMaster_page_controller.isExpandQuotation.value}");
                                         } else {
                                           print(
                                               "else......${accountMaster_page_controller.isExpandQuotation.value}");
                                         }
                                       },
                                       icon: Icon(
                                         accountMaster_page_controller
                                             .isExpandQuotation.value
                                             ? Icons.arrow_drop_down
                                             : Icons.arrow_drop_up,
                                         size: 25,
                                         color: AllColors.whiteColor,
                                       ),
                                     );
                                   },
                                 )

                               ],
                             ),
                           ),
                           // Divider(color: Colors.black,),
                           Obx(() {
                             return viewQuotationCount(context);
                           }),
                         ],
                       ),
                     ),
                     SizedBox(height: 10),
                     Container(
                       margin: EdgeInsets.only(left: 10.0, right: 10.0),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           color: AllColors.textColor
                       ),

                       child:
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 10),
                             child: Icon(Icons.task_alt, color: AllColors.whiteColor,),
                           ),
                           Text(
                             "DSAR History",
                             style: GoogleFonts.poppins(
                               color: AllColors.whiteColor,
                               fontSize: AllFontSize.twentee,
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                           Obx(
                                 () {
                               return IconButton(
                                 onPressed: () {
                                   accountMaster_page_controller.toggleDSARHistory();
                                   if (accountMaster_page_controller
                                       .isExpandDSARHistory.value ==
                                       true) {
                                     print(
                                         "If......${accountMaster_page_controller.isExpandDSARHistory.value}");
                                   } else {
                                     print(
                                         "else......${accountMaster_page_controller.isExpandDSARHistory.value}");
                                   }
                                 },
                                 icon: Icon(
                                   accountMaster_page_controller
                                       .isExpandDSARHistory.value
                                       ? Icons.arrow_drop_down
                                       : Icons.arrow_drop_up,
                                   size: 25,
                                   color: AllColors.whiteColor,
                                 ),
                               );
                             },
                           )

                         ],
                       ),
                     ),
                     SizedBox(height: 10),
                     Obx(() {
                       return BindTaskHistoryListView(context);
                     })
                   ],
                ),
              )
          ),

        ],
      ),
    ));
  }

  Widget BindTaskHistoryListView(context) {
    if (accountMaster_page_controller.AccountTaskHistoryList.value.isNotEmpty && accountMaster_page_controller.AccountTaskHistoryList.value.length > 0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (accountMaster_page_controller.total_rows /
              accountMaster_page_controller.rowsPerPage).toInt();
          if ((accountMaster_page_controller.total_rows % accountMaster_page_controller.rowsPerPage) > 0)
            total_page += 1;

          //print("last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (accountMaster_page_controller.pageNumber + 1 != total_page) {
            this.accountMaster_page_controller.pageNumber += 1;
            accountMaster_page_controller.getAccountTaskHistory(accountMaster_page_controller.pageNumber, accountMaster_page_controller.account_code_controller.value.text);

          }
        }
      });

      return Visibility(
        visible: accountMaster_page_controller
            .isExpandDSARHistory.value == true ? true : false,
            child: Container(
              height: size.height/2,
              child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
              shrinkWrap: true,
              itemCount: accountMaster_page_controller.AccountTaskHistoryList.value.length,
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                return BindListView(context, index);
              }),
            ),
      );
    } else {
      return Center(
        child: Text("No Task DSAR History Found...",
          style: GoogleFonts.poppins(
            color: AllColors.textColor,
            fontSize: AllFontSize.twenteetwo,
            fontWeight: FontWeight.w500,
          ),),
      );
    }
  }

  Widget BindListView(context, int position) {
    var count = position + 1;
    var timeLine_date_month =
    StaticMethod.dateTimeToDate(
        accountMaster_page_controller.AccountTaskHistoryList[position].createdOn??"");
    var timeLine_date = StaticMethod.onlyMonthName(
        accountMaster_page_controller.AccountTaskHistoryList[position].createdOn??"");
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 10,
                    //right: 10,
                    bottom: 10,
                    top: 40),
                child: Row(
                  children: [
                    SizedBox(
                      child: Tooltip(
                        message: timeLine_date_month,
                        child: Text(
                          timeLine_date??"",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      width: size.width * 0.11,
                    ),
                    SizedBox(width: size.width * 0.12),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8, right: 4),
                            width: size.width * .71,
                            decoration:
                            BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      offset: Offset(0.0, 0.55),
                                      blurRadius: 0.7,
                                      blurStyle: BlurStyle.solid,
                                      color: AllColors.textColor),
                                ],
                                color: AllColors.whiteColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  accountMaster_page_controller.AccountTaskHistoryList[position].dsarStatus??"",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  accountMaster_page_controller.AccountTaskHistoryList[position].createdBy??"",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.nine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      offset: Offset(0.0, 0.55),
                                      blurRadius: 0.5,
                                      blurStyle: BlurStyle.solid,
                                      color: Colors.black54)
                                ],
                                color: Colors.white),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 3),
                                    width: size.width * .7,
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                         /* RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Task Id:  ",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    // Change this to your desired color for "Message:"
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: accountMaster_page_controller.AccountTaskHistoryList[position].taskId??"",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    // This keeps the rest of the text color unchanged
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            softWrap: true,
                                          ),*/
                                        /*  RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Sales Id:  ",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    // Change this to your desired color for "Message:"
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: accountMaster_page_controller.AccountTaskHistoryList[position].salesCycleId??"",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    // This keeps the rest of the text color unchanged
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            softWrap: true,
                                          ),*/
                                         /* RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Contact Code:  ",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    // Change this to your desired color for "Message:"
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: accountMaster_page_controller.AccountTaskHistoryList[position].contactCode??"",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    // This keeps the rest of the text color unchanged
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            softWrap: true,
                                          ),*/
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Contact Name:  ",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    // Change this to your desired color for "Message:"
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: accountMaster_page_controller.AccountTaskHistoryList[position].contactName??"",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    // This keeps the rest of the text color unchanged
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            softWrap: true,
                                          ),
                                          Visibility(
                                            visible: accountMaster_page_controller.AccountTaskHistoryList[position].dsarStatus?.toLowerCase() == "sales cycle"?true:false,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Next Interaction Date:  ",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors.primaryDark1,
                                                      // Change this to your desired color for "Message:"
                                                      fontSize: AllFontSize.fourtine,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: accountMaster_page_controller.AccountTaskHistoryList[position].nextInteractionDate??"",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors.textColor,
                                                      // This keeps the rest of the text color unchanged
                                                      fontSize: AllFontSize.twelve,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Visibility(
                                            visible: accountMaster_page_controller.AccountTaskHistoryList[position].dsarStatus?.toLowerCase() == "sales cycle"?true:false,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Next Interaction Time:  ",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors.primaryDark1,
                                                      // Change this to your desired color for "Message:"
                                                      fontSize: AllFontSize.fourtine,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: accountMaster_page_controller.AccountTaskHistoryList[position].nextInteractionTime??"",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors.textColor,
                                                      // This keeps the rest of the text color unchanged
                                                      fontSize: AllFontSize.twelve,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "DSAR Remarks:  ",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    // Change this to your desired color for "Message:"
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: accountMaster_page_controller.AccountTaskHistoryList[position].remarks,
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    // This keeps the rest of the text color unchanged
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            softWrap: true,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Task Remarks:  ",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    // Change this to your desired color for "Message:"
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: accountMaster_page_controller.AccountTaskHistoryList[position].taskRemarks,
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    // This keeps the rest of the text color unchanged
                                                    fontSize: AllFontSize.twelve,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            softWrap: true,
                                          ),
                                        ])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(left: 70,
                // left: 10,
                child: new Container(
                  height: size.height * 0.7,
                  width: 1.0,
                  color: Colors.grey.shade400,
                ),
              ),
              Positioned(bottom: 5, left: 35,
                child: Padding(padding: const EdgeInsets.only(
                      top: 10, left: 20, bottom: 70,  right: 20),
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration:
                    new BoxDecoration(
                      color:
                      Colors.lightBlue,
                      borderRadius:
                      BorderRadius
                          .circular(20),
                    ),
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: GoogleFonts
                            .poppins(
                          color: AllColors
                              .whiteColor,
                          fontSize:
                          AllFontSize
                              .ten,
                          fontWeight:
                          FontWeight
                              .w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget viewTaskCount(BuildContext context) {
    return   Visibility(
      visible: accountMaster_page_controller.isExpandDetails.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),

                Text(
                  "  All",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'TASK';
                    accountMaster_page_controller.day_flag = 'ALL';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                    },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardTaskCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardTaskCount[0].allAccountTask.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Today",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'TASK';
                    accountMaster_page_controller.day_flag = 'Today';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardTaskCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardTaskCount[0].todayAccountTask.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decorationStyle: TextDecorationStyle.wavy,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Future",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'TASK';
                    accountMaster_page_controller.day_flag = 'Future';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardTaskCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardTaskCount[0].futureAccountTask.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Breached",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'TASK';
                    accountMaster_page_controller.day_flag = 'Breached';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardData(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardTaskCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardTaskCount[0].breachedAccountTask.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
    );
  }

  Widget viewSalesCount(BuildContext context) {
    return   Visibility(
      visible: accountMaster_page_controller.isExpandSales.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  All",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'sales_cycle';
                    accountMaster_page_controller.day_flag = '';
                    accountMaster_page_controller.WonLoss = '';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss );

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardSalesCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardSalesCount[0].allAccountSales.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Suspect",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'sales_cycle';
                    accountMaster_page_controller.day_flag = 'Suspect';
                    accountMaster_page_controller.WonLoss = "";
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss );

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardSalesCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardSalesCount[0].suspectAccountSales.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decorationStyle: TextDecorationStyle.wavy,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Prospect",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'sales_cycle';
                    accountMaster_page_controller.day_flag = 'Prospect';
                    accountMaster_page_controller.WonLoss = '';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardSalesCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardSalesCount[0].prospectAccountSales.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Propose",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'sales_cycle';
                    accountMaster_page_controller.day_flag = 'Propose';
                    accountMaster_page_controller.WonLoss = "";
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, "");

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardSalesCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardSalesCount[0].proposeAccountSales.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.green,
                ),
                Text(
                  "  Won",
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'sales_cycle';
                    accountMaster_page_controller.day_flag = 'Propose';
                    accountMaster_page_controller.WonLoss = "won";
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardSalesCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardSalesCount[0].wonAccountSales.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.red,
                ),
                Text(
                  "  Loss",
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'sales_cycle';
                    accountMaster_page_controller.day_flag = 'Propose';
                    accountMaster_page_controller.WonLoss = "loss";
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataSales(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag, accountMaster_page_controller.WonLoss);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardSalesCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardSalesCount[0].lossAccountSales.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
    );
  }

  Widget viewQuotationCount(BuildContext context) {
    return   Visibility(
      visible: accountMaster_page_controller.isExpandQuotation.value == true ? true : false,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  All",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'quatation';
                    accountMaster_page_controller.day_flag = '';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardQuotationCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardQuotationCount[0].allAccountQuotation.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.black,
                ),
                Text(
                  "  Pending For Approval",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'quatation';
                    accountMaster_page_controller.day_flag = 'Pending for approval';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardQuotationCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardQuotationCount[0].pendingForApprovalAccountQuotation.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.green,
                ),
                Text(
                  "  Approved",
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'quatation';
                    accountMaster_page_controller.day_flag = 'Approved';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardQuotationCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardQuotationCount[0].approvedAccountQuotation.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.green,
                ),
                Text(
                  "  Won",
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'quatation';
                    accountMaster_page_controller.day_flag = 'Won';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardQuotationCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardQuotationCount[0].wonAccountQuotation.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decorationStyle: TextDecorationStyle.wavy,
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
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.red,
                ),
                Text(
                  "  Rejected",
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    accountMaster_page_controller.flag = 'quatation';
                    accountMaster_page_controller.day_flag = 'Rejected';
                    accountMaster_page_controller.pageNumber = 0;
                    accountMaster_page_controller.getAccountDashboardDataQuotation(accountMaster_page_controller.pageNumber,accountMaster_page_controller.is_Active.toString(), accountMaster_page_controller.account_code_controller.value.text, accountMaster_page_controller.flag, accountMaster_page_controller.day_flag);

                  },
                  child: Text(
                    accountMaster_page_controller.accountDashBoardQuotationCount.length == 0 ? "0":
                    accountMaster_page_controller.accountDashBoardQuotationCount[0].rejectedAccountQuotation.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
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
    );
  }

}