import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/user_expense_vm/expense_approver_vm.dart';

import '../../component/default_button.dart';
import '../../component/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/user_expense_model/expense_Line_Submit_model.dart';
import '../../utils/app_utils.dart';
import '../custom_drawer.dart';

class ExpenseApproverHeaderViewScreen extends StatelessWidget{
  ExpenseApproverHeaderViewScreen({super.key});
  Size size= Get.size;
  final expense_header_page_controller=Get.put(ExpensesApproverViewModel());
  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: ()  async{
         Get.toNamed(RoutesName.expenseApprovarScreen);
         return false;
       },
       child: Scaffold(
         appBar: AppBar(
           title: Row(
             children: [
               Text(
                 'Expense Details',
                 style: GoogleFonts.poppins(
                   color: AllColors.whiteColor,
                   fontSize: AllFontSize.twentee,
                   fontWeight: FontWeight.w700,
                 ),
               ),

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
           child: Column(
             children: [

               Obx(() {
                 return Visibility(
                   visible: expense_header_page_controller.loading.value,
                   child: LinearProgressIndicator(
                     backgroundColor: AllColors.primaryDark1,
                     color: AllColors.primaryliteColor,
                   ),
                 );
               }),
               Expanded(
                 child: Column(children: [
                   Padding(padding:const EdgeInsets.only(left: 9.0,right: 8.0,top: 8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text(
                           "Description ("+ expense_header_page_controller.expense_header_detail_list[0].documentNo.toString()+")",
                           style: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontSize: AllFontSize.sisxteen,
                               fontWeight: FontWeight.w700),
                         ),


                       ],
                     ),
                   ),

                   Padding(padding: EdgeInsets.only(left: 10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text(
                           expense_header_page_controller.expense_header_detail_list[0].remarks.toString(),
                           style: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontSize: AllFontSize.fourtine,
                               fontWeight: FontWeight.w300
                           ),
                         ),
                       ],),
                   ),

                   Padding(padding:const EdgeInsets.only(left: 9.0,right: 8.0,top: 5.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text(
                           "Total Expense : ",
                           style: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontSize: AllFontSize.sisxteen,
                               fontWeight: FontWeight.w700),
                         ),

                         Spacer(),
                         Text(
                           expense_header_page_controller.expense_header_detail_list[0].totalLineAmount.toString(),
                           style: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontSize: AllFontSize.fourtine,
                               fontWeight: FontWeight.w700
                           ),
                         ),

                       ],
                     ),
                   ),
                   Padding(padding: EdgeInsets.only(top: 7),
                     child: Divider(
                       height: 1,
                       color: AllColors.primaryDark1,
                     ),
                   ),
                   Padding(padding: EdgeInsets.only(left: 10,top: 3.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text(
                           "Expenses Submitted : ",
                           style: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontSize: AllFontSize.sisxteen,
                               fontWeight: FontWeight.w700),
                         ),
                       ],),
                   ),

                   Divider(
                     height: .05,
                     color: AllColors.primaryDark1,
                   ),
                   //bindListLayout(),
                   Expanded(
                       child: bindListLayout()
                   ),
                   Visibility(
                     visible: (expense_header_page_controller.selection_type=="Dislike" || expense_header_page_controller.selection_type=="Like") ?
                     false:true,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             width: size.width*.4,
                             child:  DefaultButton(
                               text: "Approve",
                               press: () {
                                 showConfirmCompleteDialog(context,"Do You Want To Approve?");
                               },
                               //  loading: viewCartController.loading.value,
                             ),
                           ),
                           Container(
                             width: size.width*.4,
                             child: DefaultButtonRed(
                               text: "Reject",
                               press: () {
                                 showRemarkDialog(context,
                                     expense_header_page_controller.expense_header_detail_list[0].documentNo.toString()
                                     ,expense_header_page_controller.approver_list_data[0].documentType,"Dislike");

                               },
                               //loading: viewCartController.loading.value,
                             ),
                           )

                         ],
                       ),
                     ),
                   ),
                 ]
                 ),
               ),
             ],
           ),
         ),
       ),
     );
  }


  void showRemarkDialog(BuildContext context, String documentNo,String documentType, String dislike) {
    //Navigator.pop(context);
    expense_header_page_controller.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Enter Remarks",style: TextStyle(color: AllColors.primaryDark1,fontSize: AllFontSize.sisxteen),),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller: expense_header_page_controller.remarks_controller,
            decoration: InputDecoration(labelText: "Remarks",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,))
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                //Navigator.of(context).pop();
                Navigator.pop(context);
                // Get.back();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor)),
            ),
            TextButton(
              onPressed: () {
                if(expense_header_page_controller.remarks_controller.text.isNotEmpty){
                  expense_header_page_controller.markApproveReject(documentNo, documentType,dislike,expense_header_page_controller.remarks_controller.text);
                  Navigator.of(context).pop();
                }
                else
                  Utils.showErrorToastification('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1)),
            ),
          ],
        );
      },
    );
  }
  Widget bindListLayout() {
    List<Lines>? line_list =expense_header_page_controller.expense_header_detail_list[0].lines!;
    if(line_list==null || line_list!.isEmpty){
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('No Records Found.',style: TextStyle(
            fontSize: 20,
            color: AllColors.primaryColor
        ),),
      );
    }else{
      Size size = Get.size;
      return Container(
        height: size.height*.7,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),

            itemCount: line_list!.length,
            itemBuilder: (context, index) {
              return BindListView(context,line_list!, index);
            }),
      );
    }

  }
  Widget BindListView(context,List<Lines> linesList, int index)
  {
    return InkWell(
      child: ListTile(
          onTap: () {
            if(linesList[index].imageCount!>0){
              expense_header_page_controller.showLineImagesPopup(context,linesList,index);
            }
            else{
              Utils.sanckBarError('Images', 'This Item Has No Image');
            }
          },
          title: Text(" Name : " +linesList[index].expenseName!,style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,fontWeight: FontWeight.w700
          ),),
          subtitle: Container(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" Expense Amount: "+linesList[index].expenseAmount.toString()!,
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    )),

                Padding(padding: EdgeInsets.only(left: 2),
                  child: Text("Remark : "+linesList[index].expenseRemark.toString()!,
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.twelve,
                      )),
                ),


                //todo ritik change...

                if (linesList[index]?.isLodging != null && linesList[index]!.isLodging! > 0)
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 2),
                        child: Text(
                          'From Date: ' + (linesList[index].lodgingFromDate?.toString() ?? ''),
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.twelve,
                          ),
                        ),
                      ),
                      SizedBox(width: 8), // Add some spacing between the Text widgets
                      Text(
                        'To Date: ' + (linesList[index].lodgingToDate?.toString() ?? ''),
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.twelve,
                        ),
                      ),


                      Padding(padding: EdgeInsets.only(left: 2),
                        child: Text("Region : "+linesList[index].regionName.toString()!,
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w500,
                              fontSize: AllFontSize.twelve,
                            )),
                      ),

                    ],

                  ),


                if(linesList[index]?.isKm != null && linesList[index]!.isKm! > 0)
                  Text(
                    ' Total Km: ' + (linesList[index].totalKmTravel?.toString() ?? ''),
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    ),
                  ),

                /* Text('Images: '+linesList[index].imageCount.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.twelve,
                  )),*/




              ],
            ),
          ),
          //leading: bindAvatar(line_list[0].lines!),
          trailing:
          Container(
              width: 50,
              height: 50,
              child:Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Tooltip(
                      message: 'Line Attachment',
                      child: Icon(Icons.attachment,color: AllColors.primaryDark1,size: 25, )),
                  Text(linesList[index].imageCount.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.twelve,
                      )),
                ],)
            /*Tooltip(
                message: 'Line Attachment',
                child: Icon(Icons.attachment,color: AllColors.primaryDark1,size: 25, )),*/
          )


      ),
    );
  }

  showConfirmCompleteDialog(BuildContext context,String message){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content:   Text(
            message,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print('dono...'+expense_header_page_controller.expense_header_detail_list[0].documentNo.toString()+'...'+expense_header_page_controller.approver_list_data[0].documentType.toString());
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                expense_header_page_controller.markApproveReject(expense_header_page_controller.expense_header_detail_list[0].documentNo.toString(),expense_header_page_controller.approver_list_data[0].documentType.toString(), "Like",'');

                // Get.toNamed(RoutesName.checkInApproverScreen);
                //  plantingLineDetailsPageController.PlantingHeaderComplete(planting_no!);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }
}