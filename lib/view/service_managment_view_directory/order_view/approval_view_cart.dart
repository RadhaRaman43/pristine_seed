import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/viewModel/order_approval_vm/order_approval_vm.dart';

import '../../component/default_button.dart';
import '../../component/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../utils/app_utils.dart';
import '../custom_drawer.dart';

class ApprovalViewCart extends StatelessWidget{
  ApprovalViewCart({super.key});

  final approval_view_page_controller=Get.put(OrderApprovalViewModel());

  Size size= Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Order Approval View',
          style: GoogleFonts.poppins(
            color: AllColors.whiteColor,
            fontSize: AllFontSize.twentee,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: AllColors.whiteColor, // Change this to the desired color
        ),
        backgroundColor: AllColors.primaryDark1,
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: Column(
          children: [
            Obx((){
              return Visibility(
                visible: approval_view_page_controller.loading.value?true:false,
                child: Container(
                  margin: EdgeInsets.only(top: 0.5),
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.textColor,
                    color: AllColors.primaryDark1,
                  ),
                ),
              );
            }),
            SizedBox(height: size.height * .01),
            Obx((){
              return  Container(
                padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                child: bindHeaderDetails(context),
              );
            }),
            Divider(
              height: 2,
              color: AllColors.primaryDark1,
            ),
            Obx((){
              return Expanded(
                child: Container(
                  child: bindListLayout(),
                ),
              );
            }),

          ],
        ),
      ),
    );
  }

  //todo bind header details........
  Widget bindHeaderDetails(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Customer Name:",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700,
                      )
                  ),
                  SizedBox(width: size.width*.02, ),
                  InkWell(
                    onTap:() {
                      showCustomerDetailsBottomSheet(context);
                    },
                    child: Container(
                      width:size.width*.55 ,
                      child: Tooltip(
                        message:"${approval_view_page_controller
                            .order_detail_list[0].customerName!= null ?
                        approval_view_page_controller
                            .order_detail_list[0]
                            .customerName!+"( ${ approval_view_page_controller
                            .order_detail_list[0]
                            .customerNo!} )":""}",
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          "${approval_view_page_controller
                              .order_detail_list[0].customerName!= null ?
                          approval_view_page_controller
                              .order_detail_list[0]
                              .customerName!+"( ${ approval_view_page_controller
                              .order_detail_list[0]
                              .customerNo!} )": ''}",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Consignee Name:",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700,
                      )
                  ),
                  SizedBox(width: size.width*.02, ),
                  Visibility(
                    visible: approval_view_page_controller
                        .order_detail_list[0].consigneeId.toString().isNotEmpty?true:false,
                    child: InkWell(
                      onTap:() {
                        showConsigneeDetailsBottomSheet(context);
                      },
                      child: Container(
                        width:size.width*.55 ,
                        child: Tooltip(
                          message:"${approval_view_page_controller
                              .order_detail_list[0].consigneeName!= null ?
                          approval_view_page_controller
                              .order_detail_list[0]
                              .consigneeName!+"( ${ approval_view_page_controller
                              .order_detail_list[0]
                              .consigneeId!} )":""}",
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            "${approval_view_page_controller
                                .order_detail_list[0].consigneeName!= null ?
                            approval_view_page_controller
                                .order_detail_list[0]
                                .consigneeName!+"( ${ approval_view_page_controller
                                .order_detail_list[0]
                                .consigneeId!} )":""}",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('View Order Details',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                  /*  Text('\u{20B9} ${ approval_view_page_controller.order_detail_list[0].totalPrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),*/
                  /*Text('\u{20B9} ${ approval_view_page_controller.order_detail_list[0].totalApprovePrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),*/
                  Text(approval_view_page_controller.order_detail_list[0].orderStatus=='Pending'?'\u{20B9} ${ approval_view_page_controller.order_detail_list[0].totalPrice.toString()}':
                  '\u{20B9}${approval_view_page_controller.order_detail_list[0].totalApprovePrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                ],
              ),
              SizedBox(height: size.height*.01),
              Obx((){
                return Visibility(
                  visible: approval_view_page_controller.order_detail_list[0].orderStatus=='Completed'?true:false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child:  DefaultButton(
                          text: "Approve",
                          press: () {
                            showApproveDialog(context,approval_view_page_controller.order_detail_list[0].orderNo!);
                            //approval_view_page_controller.orderHeaderComplete(approval_view_page_controller.order_detail_list[0].orderNo!);
                          },
                          //  loading: approval_view_page_controller.loading.value,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: DefaultButtonRed(
                          text: "Reject",
                          press: () {
                            showRemarkDialog(context,approval_view_page_controller.order_detail_list[0].orderNo!);

                            //approval_view_page_controller.orderHeaderComplete(approval_view_page_controller.order_detail_list[0].orderNo!);
                          },
                          //loading: approval_view_page_controller.loading.value,
                        ),
                      )

                    ],
                  ),
                );
              }),
              SizedBox(height: size.height*.01),
            /*  Obx((){
                return  Visibility(
                  visible: approval_view_page_controller.order_detail_list[0].consigneeId.toString().isNotEmpty?true:false,
                  child: InkWell(
                    onTap: (){
                    //  showBottomSheetOpenForConsignee(context);
                    },
                    child:  Text("Consignee Name :" +
                        *//*approval_view_page_controller.order_detail_list[0].consigneeId
                            ==null ?Utils.sanckBarError('Message : ',
                            "Consignee Id is null. So you can't see Consignee Details. "):
                        'Consignee Name : ' +*//*
                        (*//*approval_view_page_controller.order_detail_list[0]
                                .consigneeName == null ?*//* approval_view_page_controller
                            .order_detail_list[0].consigneeName.toString() ) ,

                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w800


                        )),

                  ),
                );
              }),*/

              SizedBox(height: size.height*.01),
              Text('Total Qty ${approval_view_page_controller.order_detail_list[0].totalQty} / ' +
                  (approval_view_page_controller.order_detail_list[0].orderStatus == 'Rejected'
                      ?'Rej. Qty'+ approval_view_page_controller.order_detail_list[0].totalApproveQty.toString()
                      :'Appr.Qty:'+ approval_view_page_controller.order_detail_list[0].totalApproveQty.toString()),
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w600


                  )),

              //todo ritik comment flag according check......
              /*Text('Total Qty: ${approval_view_page_controller.order_detail_list[0].totalQty.toString()} / Appr.Qty: ${approval_view_page_controller.order_detail_list[0].totalApproveQty.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/
              SizedBox(height: size.height*.01),
              //todo ritik comment flag according check......

              /* Text('In Kg: ${approval_view_page_controller.order_detail_list[0].totalOrderInKg.toString()+' Kg'} / Appr.In Kg: ${approval_view_page_controller.order_detail_list[0].totalApproveOrderInKg.toString()} ',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/

              /*Text('In Kg: ${approval_view_page_controller.order_detail_list[0].totalOrderInKg.toString()+' Kg'} / '+
                  (approval_view_page_controller.order_detail_list[0].orderStatus == 'Rejected'
                      ?'Rej.In Kg:'+ approval_view_page_controller.order_detail_list[0].totalApproveOrderInKg.toString()
                      :'Appr.In Kg:'+ approval_view_page_controller.order_detail_list[0].totalApproveOrderInKg.toString()),
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)

              ),*/


             /* SizedBox(height: size.height*.01),
              Text('Current O/S: \u{20B9} ${approval_view_page_controller.order_detail_list[0].currentOutstanding.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/
              SizedBox(height: size.height*.01),
              Text(approval_view_page_controller.order_detail_list[0].orderStatus=='Approved'?'Total Appr. Disc. Amount: \u{20B9} ${approval_view_page_controller.order_detail_list[0].totalApproveDiscountAmt.toString()}'
                  :'Total Disc. Amount: \u{20B9} ${approval_view_page_controller.order_detail_list[0].totalApproveDiscountAmt.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),
              SizedBox(height: size.height*.01),
             /* Text('Credit Limit: \u{20B9} ${approval_view_page_controller.order_detail_list[0].creditLimit.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/
            ],
          ),
        )
    );
  }



  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (approval_view_page_controller.order_detail_list[0].lines == null ||
        approval_view_page_controller.order_detail_list[0].lines!.isEmpty ) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text('No Records Found.', style: TextStyle(
              fontSize: 20,
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700
          ),),
        ),
      );
    } else {
      Size size = Get.size;
      return Container(
        height: size.height - 170,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) =>
                Divider(
                  height: 5,
                  color: AllColors.primaryDark1,
                ),
            itemCount: approval_view_page_controller.order_detail_list[0].lines!.length,
            itemBuilder: (context, index) {
              //var item = orderItemGroupPageController.searchResult[index];
              return BindListView(context,index);
            }),
      );
    }
  }
  //todo listview bind
  Widget BindListView(context,int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
        },
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bindImage(position),
                SizedBox(width: size.width*.001),
                Obx((){
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(approval_view_page_controller.order_detail_list[0].lines![position].itemNo ?? ''
                        ,style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700
                        ),),
                      /*Text('Sec.Pack: ${approval_view_page_controller.order_detail_list[0].lines![position].secondaryPacking.toString() +' '+
                          approval_view_page_controller.order_detail_list[0].lines![position].baseUnitOfMeasure.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),*/
                      Text('Price/ ${approval_view_page_controller.order_detail_list[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                          approval_view_page_controller.order_detail_list[0].lines![position].unitPrice.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),


                      //todo ritik comment according to flag.....
                      /*Text('Appr.Price/ ${approval_view_page_controller.order_detail_list[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                          approval_view_page_controller.order_detail_list[0].lines![position].approvePrice.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),*/

                      Text(
                        '${approval_view_page_controller.order_detail_list[0].orderStatus == 'Rejected'
                            ? 'Rej. Price / ${approval_view_page_controller.order_detail_list[0].lines![position].baseUnitOfMeasure.toString()}'
                            : 'Appr. Total Price'}: Rs. ${approval_view_page_controller.order_detail_list[0].lines![position].approvePrice.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),

                      Text(approval_view_page_controller.order_detail_list[0].orderStatus=="Approved"?'Appr.Discount Amt. : ${approval_view_page_controller.order_detail_list[0].lines![position].approveDiscountAmt.toString()}'
                          :'Discount Amt. : ${approval_view_page_controller.order_detail_list[0].lines![position].approveDiscountAmt.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),
                      Text('Discount % : ${approval_view_page_controller.order_detail_list[0].lines![position].discountPer.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),
                      Text('Order Qty: ${approval_view_page_controller.order_detail_list[0].lines![position].qty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),

                      Text(
                          '${approval_view_page_controller.order_detail_list[0].orderStatus == 'Rejected' ? ' Rej. Qty:${approval_view_page_controller.order_detail_list[0].lines![position].approveQty.toString()}' : 'Appr.Qty: ${approval_view_page_controller.order_detail_list[0].lines![position].approveQty.toString()}'}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )


                      ),

                      //todo ritik comment according to flag.....

                      /* Text('Appr.Qty: ${approval_view_page_controller.order_detail_list[0].lines![position].approveQty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),*/
                    ],
                  );
                }),

              ],
            ),
            SizedBox(height: size.height*.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: approval_view_page_controller.order_detail_list[0].orderStatus=='Completed'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {

                            if(approval_view_page_controller.order_detail_list[0].orderStatus=='Completed'){
                              approval_view_page_controller.orderApproverItemLineInsert(approval_view_page_controller.order_detail_list[0].lines![position].orderNo!,
                                  approval_view_page_controller.order_detail_list[0].lines![position].itemNo!,
                                  approval_view_page_controller.order_detail_list[0]
                                      .lines![position].approveQty==0?
                                  approval_view_page_controller.order_detail_list[0]
                                      .lines![position].qty!:approval_view_page_controller.order_detail_list[0]
                                      .lines![position].approveQty!,'REMOVE');
                            }


                          },
                        ),
                        Obx((){
                          return InkWell(
                            child: Text(approval_view_page_controller.order_detail_list[0].lines![position].approveQty==0?
                            approval_view_page_controller.order_detail_list[0].lines![position].qty.toString():
                            approval_view_page_controller.order_detail_list[0].lines![position].approveQty.toString(),
                              style: TextStyle(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee,
                              ),
                            ),
                            onTap: (){
                              if(approval_view_page_controller.order_detail_list[0].orderStatus=='Completed'){
                                showApproveConfirmQtyDialog(context,position);
                              }

                              //  showApproveConfirmQtyDialog(context,position);
                            },
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: approval_view_page_controller.order_detail_list[0].orderStatus=='Completed'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            if(approval_view_page_controller.order_detail_list[0].orderStatus=='Completed') {
                              approval_view_page_controller.orderApproverItemLineInsert(
                                  approval_view_page_controller.order_detail_list[0]
                                      .lines![position].orderNo!,
                                  approval_view_page_controller.order_detail_list[0]
                                      .lines![position].itemNo!,
                                  approval_view_page_controller.order_detail_list[0]
                                      .lines![position].approveQty==0?
                                  approval_view_page_controller.order_detail_list[0]
                                      .lines![position].qty!:approval_view_page_controller.order_detail_list[0]
                                      .lines![position].approveQty!, 'ADD');
                            }
                          },
                        ),
                      ],
                    ),
                   /* Obx(() {
                      return  Text('In ${approval_view_page_controller.order_detail_list[0].lines![position].baseUnitOfMeasure}: '
                          '${approval_view_page_controller.order_detail_list[0].lines![position].approveOrderInKg==0? approval_view_page_controller.order_detail_list[0].lines![position].orderInKg.toString()+' '+
                          approval_view_page_controller.order_detail_list[0].lines![position].baseUnitOfMeasure.toString():approval_view_page_controller.order_detail_list[0].lines![position].approveOrderInKg}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          ));
                    }),*/
                  ],
                ),
                Spacer(),
                /*  Expanded(
                  child: Obx((){
                    return Visibility(
                      visible: approval_view_page_controller.order_detail_list[0].orderStatus=='Pending'?true:false,
                      child: DefaultButtonRed(
                        text: "Delete",
                        press: () {
                          approval_view_page_controller.orderItemLineInsert(approval_view_page_controller.order_detail_list[0].lines![position].orderNo!,
                              approval_view_page_controller.order_detail_list[0].lines![position].itemNo!,
                              0,'DELETE','CART');
                        },
                      ),
                    );
                  }),
                ),*/
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget bindImage(int position) {
    if(approval_view_page_controller.order_detail_list[0].lines![position].imageUrl != null &&
        approval_view_page_controller.order_detail_list[0].lines![position].imageUrl != "")
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            approval_view_page_controller.order_detail_list[0].lines![position].imageUrl!,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If there's an error loading the image, display a default image
              return Image.asset(
                "assests/images/no_file.png",
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      );
    else
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            "assests/images/no_file.png",
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );

  }

  showApproveConfirmQtyDialog(BuildContext context, int position) {
    approval_view_page_controller.qty_controller.text=approval_view_page_controller.order_detail_list[0].lines![position].approveQty==0?
    approval_view_page_controller.order_detail_list[0].lines![position].qty!.toString():
    approval_view_page_controller.order_detail_list[0].lines![position].approveQty.toString();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            keyboardType: TextInputType.number,
            controller: approval_view_page_controller.qty_controller,
            decoration: InputDecoration( labelText: "Enter Qty",labelStyle: TextStyle(color: AllColors.primaryDark1,),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AllColors.primaryDark1),
                // Change underline color
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AllColors.primaryDark1), // Change focused underline color
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                if(approval_view_page_controller.qty_controller.text.isNotEmpty){
                  approval_view_page_controller.orderApproverItemLineInsert(approval_view_page_controller.order_detail_list[0].lines![position].orderNo!,
                      approval_view_page_controller.order_detail_list[0].lines![position].itemNo!,
                      int.parse(approval_view_page_controller.qty_controller.text) ,'');
                  Navigator.of(context).pop();
                }
                else
                  Utils.showErrorToastification('Order!', 'Please Enter Order Qty');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }


  void showApproveDialog(BuildContext context, String documentNo) {
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Approve...",style: TextStyle(color: AllColors.primaryDark1,)),
          content:Text('Do you want to Continue?',style: TextStyle(color: AllColors.primaryDark1),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                approval_view_page_controller.markApproveReject(documentNo, '','Approved');
                Navigator.of(context).pop();
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }

  void showRemarkDialog(BuildContext context, String documentNo) {
    approval_view_page_controller.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject...",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller: approval_view_page_controller.remarks_controller,
            decoration: InputDecoration(labelText: "Enter Remarks",labelStyle: TextStyle(color: AllColors.primaryDark1,),
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
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                if(approval_view_page_controller.remarks_controller.text.isNotEmpty){
                  approval_view_page_controller.markApproveReject(documentNo, approval_view_page_controller.remarks_controller.text,'Rejected');
                  Navigator.of(context).pop();
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }


  void showCustomerDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Show Details",
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
                    padding: EdgeInsets.all(8.0),
                    // height: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text("Customer Name:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),
                            Spacer(),

                            Container(
                              width: size.width*.5,
                              child: Tooltip(
                                message: approval_view_page_controller
                                    .order_detail_list[0].customerName??"",
                                child: Text(approval_view_page_controller
                                    .order_detail_list[0].customerName??"",style: GoogleFonts.poppins(
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
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Customer No.:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].customerNo??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),


                        Row(
                          children: [
                            Text("Customer Phone No.:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].customerPhoneNo??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Customer Address:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Container(
                              width: size.width*.5,
                              child: Tooltip(
                                message: approval_view_page_controller
                                    .order_detail_list[0].customerAddress??"",
                                child: Text(approval_view_page_controller
                                    .order_detail_list[0].customerAddress??"",style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Country Name:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].customerCountryName??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Country State:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].customerStateName??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Customer Postal Code:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].customerPostalCode??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showConsigneeDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Show Consignee Details",
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
                    padding: EdgeInsets.all(8.0),
                    // height: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text("Consignee Name:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),
                            Spacer(),

                            Container(
                              width: size.width*.5,
                              child: Tooltip(
                                message: approval_view_page_controller
                                    .order_detail_list[0].consigneeName??"",
                                child: Text(approval_view_page_controller
                                    .order_detail_list[0].consigneeName??"",style: GoogleFonts.poppins(
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
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Id:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].consigneeId??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),


                        Row(
                          children: [
                            Text("Phone No.:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].consigneePhoneNo??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Address:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Container(
                              width: size.width*.5,
                              child: Tooltip(
                                message: approval_view_page_controller
                                    .order_detail_list[0].consigneeAddress??"",
                                child: Text(approval_view_page_controller
                                    .order_detail_list[0].consigneeAddress??"",style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Country Name:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].consigneeCountryName??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("State:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].consigneeStateName??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height:  3,),
                        Row(
                          children: [
                            Text("Postal Code:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(approval_view_page_controller
                                .order_detail_list[0].consigneePostalCode??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}