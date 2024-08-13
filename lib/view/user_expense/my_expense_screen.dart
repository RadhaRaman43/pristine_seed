import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/user_expense_vm/user_expense_vm.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../custom_drawer.dart';

class MyExpenseScreen extends StatelessWidget{
  MyExpenseScreen({super.key});
  final myexpense_page_controller=Get.put(UserExpenseViewModel());

  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
      return  WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(RoutesName.homeScreen);
          return false;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AllColors.primaryDark1,
            child: Icon(Icons.add,color: AllColors.whiteColor,),
            onPressed: () {
              Get.toNamed(RoutesName.createExpenseScreen);
              myexpense_page_controller.getExpenseCatagory('');
              myexpense_page_controller.resetAllFields();
            },
          ),
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  'MyExpense',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: AllFontSize.twentee,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              /*  Spacer(),
                IconButton(onPressed: () {
                  Get.toNamed(RoutesName.createExpenseScreen);
                  myexpense_page_controller.getExpenseCatagory('');
                  myexpense_page_controller.resetAllFields();

                }, icon: Icon(Icons.add,color: AllColors.whiteColor,size: 30,))*/
              ],
            ),
            iconTheme: IconThemeData(
              color: AllColors.whiteColor, // Change this to the desired color
            ),
            backgroundColor: AllColors.primaryDark1,
          ),
          drawer: CustomDrawer(),
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: size.height,
            child: Obx(() {
              if (myexpense_page_controller.loading.value) {
                // Show a progress indicator while loading
                return Center(
                  child: CircularProgressIndicator(
                    color: AllColors.primaryDark1,
                    backgroundColor: AllColors.primaryliteColor,
                    strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                  ), /// You can use any progress indicator here
                );
              } else {
                // Show the UI when not loading
                return Column(
                  children: [
                    Container(
                      width: size.width,
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      decoration: BoxDecoration(
                        color: AllColors.lightgreyColor,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text('RS ${myexpense_page_controller.pending_header_amt}',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
                                    Text('Pending',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios,color: AllColors.primaryDark1,),
                              ],
                            ),
                            onTap: (){
                              myexpense_page_controller.getExpenseHeader('pending');
                            },
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            child: Row(children: [
                              Column(children: [
                                Text('RS: ${myexpense_page_controller.under_approval_header_amt}',
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine),
                                ),
                                Text('Under Approval',
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine),
                                ),
                              ],),
                              Icon(Icons.arrow_forward_ios,color: AllColors.primaryDark1,),
                            ],),
                            onTap: (){
                              myexpense_page_controller.getExpenseHeader('Under_Approve');
                            },
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Column(children: [
                                    Text('RS ${myexpense_page_controller.unpaid_header_amt}',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
                                    Text('Unpaid',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
                                  ],),

                                ),
                                Icon(Icons.arrow_forward_ios,color: AllColors.primaryDark1,),
                              ],
                            ),
                            onTap: (){
                              myexpense_page_controller.getExpenseHeader('Unpaid');
                              myexpense_page_controller.isCompleteBtn.value=false;
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*.00001,),
                    Obx((){
                      final headerList = myexpense_page_controller.header_response_list;
                      return  Visibility(
                        visible: myexpense_page_controller.isShowMyExpensesLines.value,
                        child: headerList.isNotEmpty && headerList.length>0 &&headerList[0].condition=='True' ?Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.only(bottom: 60),
                              separatorBuilder: (context, index) => Divider(
                                height: .05,
                                color: AllColors.primaryDark1,
                              ),
                              shrinkWrap: true,
                              itemCount: myexpense_page_controller.header_response_list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BindPendingListView(context, index);
                              }
                          ),
                        ):
                        Center(
                          child: Text('No Record Found',style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twentee,
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                      );
                    }),

                  ],
                );
              }
            }),
          ),
        ),
      );
  }
  //todo listview bind
  Widget BindPendingListView(context, int position) {
    return InkWell(
      child: ListTile(
        onTap: () {
          print('cliked$position');
          myexpense_page_controller.getExpensesHeaderLinesApi(myexpense_page_controller.header_response_list[position].documentNo!);
          myexpense_page_controller.getExpenseCatagory('add_new');
        },
        title: Text('Document No. : ${myexpense_page_controller.header_response_list[position].documentNo!}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(myexpense_page_controller.header_response_list[position].remarks!,
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),
            Text('Date: ${myexpense_page_controller.header_response_list[position].expenseDate}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),
          ],
        ),
        // leading: Text('Rs. 12000.00'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('RS. ${myexpense_page_controller.header_response_list[position].lineAmount.toString()}',
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.fourtine,
              ),),
            Container(
              width:size.width*0.2,
              child: Tooltip(
                message:myexpense_page_controller.header_response_list[position].status.toString() ,
                child: Text(myexpense_page_controller.header_response_list[position].status.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.redColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.fourtine,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,),
              ),
            ),
          ],
        ),
      ),
    );
  }

}