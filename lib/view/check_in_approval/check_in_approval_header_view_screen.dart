import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/viewModel/checkIin_approval_vm/checkin_approval_vm.dart';

import '../../component/default_button.dart';
import '../../component/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/checkInModel/checkIn_model.dart';
import '../../utils/app_utils.dart';
import '../custom_drawer.dart';

class CheckInApprovalHeaderViewScreen extends StatelessWidget{
  CheckInApprovalHeaderViewScreen({super.key});

  final checkin_header_page_controller=Get.put(CheckInApprovalViewModel());

  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    var orderDate = StaticMethod.dateTimeToDate(checkin_header_page_controller.checkIn_list_response[0].createdOn??"");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.primaryDark1,
        iconTheme: IconThemeData(
          color: AllColors.whiteColor,
        ),
        title: Text(
          'Check In Details',
          style: GoogleFonts.poppins(
            color: AllColors.whiteColor,
            fontSize: AllFontSize.twentee,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                visible: checkin_header_page_controller.loading.value,
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.primaryDark1,
                  color: AllColors.primaryliteColor,
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Document No. :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          checkin_header_page_controller.checkIn_list_response[0].documentNo.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Vehicle Type :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          checkin_header_page_controller.checkIn_list_response[0].vehileType.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Place To Visit :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          checkin_header_page_controller.checkIn_list_response[0].placeToVisit.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Working With :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),

                      Spacer(),
                      Container(
                        width: size.width*.5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Tooltip(
                            message: checkin_header_page_controller.checkIn_list_response[0].workingWithEmail.toString()
                                .isNotEmpty
                                ? checkin_header_page_controller.checkIn_list_response[0].workingWithEmail
                                .toString()
                                : 'No',
                            child: Text(
                              overflow: TextOverflow.ellipsis, // Truncate long text with an ellipsis
                              maxLines: 1,
                              textAlign: TextAlign.end,
                              // Display text in a single line
                              checkin_header_page_controller.checkIn_list_response[0].workingWithEmail.toString()
                                  .isNotEmpty
                                  ? checkin_header_page_controller.checkIn_list_response[0].workingWithEmail
                                  .toString()
                                  : 'No',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Km :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          checkin_header_page_controller.checkIn_list_response[0].totalKm.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Traveling Amount :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          checkin_header_page_controller.checkIn_list_response[0].travellingAmount.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Remark :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          checkin_header_page_controller.checkIn_list_response[0].remarks.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Check In :",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        orderDate.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 0.5,color: AllColors.lightgreyColor,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Total Expense:",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Obx(
                            () {
                          return Text(
                            checkin_header_page_controller.checkIn_list_response[0].totalLineAmount.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300),
                          );
                        },

                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],),
                   Divider(height: 0.5,color: AllColors.lightgreyColor,),
                ],
              ),
            ),
            Divider(height: 0.5,color: AllColors.lightgreyColor,),
            Expanded(
              child:
              SingleChildScrollView(
                child: Column(children: [
                  bindListLayout(),
                ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Visibility(
                visible:  (checkin_header_page_controller.selection_type == "Dislike" || checkin_header_page_controller.selection_type == "Like") ?
                checkin_header_page_controller.isapprove_reject_button.value ==true :  checkin_header_page_controller.isapprove_reject_button.value == false,
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
                            //
                            showConfirmCompleteDialog(context,"Do You Want To Approve?");

                          },
                          //  loading: viewCartController.loading.value,
                        ),
                      ),
                      Container(
                        width:size.width*.4,
                        child: DefaultButtonRed(
                          text: "Reject",
                          press: () {
                            showRemarkDialog(context,
                                checkin_header_page_controller.checkIn_list_response[0].documentNo.toString()
                                ,checkin_header_page_controller.approver_list_data[0].documentType,"Dislike");
                          },
                          //loading: viewCartController.loading.value,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
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
                print('dono...'+checkin_header_page_controller.checkIn_list_response[0].documentNo.toString()+'...'+checkin_header_page_controller.approver_list_data[0].documentType.toString());
                // Cancel button pressed
                Navigator.pop(context);
                //Get.offAllNamed(RoutesName.checkInApproverScreen);
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                checkin_header_page_controller.markApproveReject(checkin_header_page_controller.checkIn_list_response[0].documentNo.toString(),checkin_header_page_controller.approver_list_data[0].documentType.toString(), "Like",'');

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
  Widget bindListLayout() {
    List<Lines>? line_list =checkin_header_page_controller.checkIn_list_response[0].lines!;
    if(line_list==null || line_list!.isEmpty){
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('No Records Found.',style: TextStyle(fontSize: 20, color: AllColors.primaryColor),),
      );
    }else{
      Size size = Get.size;
      return Container(
        // height: size.height*0.69,
        height: size.height*0.55,
        child: ListView.separated(
            shrinkWrap: true,
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
            checkin_header_page_controller.showLineImagesPopup(context,linesList,index);
          }
          else{
            Utils.sanckBarError('Images', 'This Item Has No Image');
          }
        },
        title: Text("Expense Name : " +linesList[index].expenseName!,style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,fontWeight: FontWeight.w500
        ),),
        subtitle: Container(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Expense Amount: "+linesList[index].expenseAmount.toString()!,
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.twelve,
                  )),
              Text('Images: '+linesList[index].imageCount.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.twelve,
                  )),
            ],
          ),
        ),
        //leading: bindAvatar(line_list[0].lines!),
        trailing: Tooltip(
            message: 'Line Attachment',
            child: Icon(Icons.attachment,color: AllColors.primaryDark1,size: 25,)),
      ),
    );
  }


  void showRemarkDialog(BuildContext context, String documentNo,String documentType, String dislike) {
    //Navigator.pop(context);
    checkin_header_page_controller.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Enter Remarks",style: TextStyle(color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen)),
          content: TextFormField(
            controller: checkin_header_page_controller.remarks_controller,
            decoration: InputDecoration(labelText: "Remark",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,))
            ),

          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                //Navigator.of(context).pop();
                if(checkin_header_page_controller.remarks_controller.text.isNotEmpty){
                  checkin_header_page_controller.markApproveReject(documentNo, documentType,dislike,checkin_header_page_controller.remarks_controller.text);
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



}