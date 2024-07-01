import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/viewModel/order_vm/order_vm.dart';

import '../../component/default_button.dart';
import '../../component/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../custom_drawer.dart';

class ViewCartScreen extends StatelessWidget{
  ViewCartScreen({super.key});

  final view_cart_page_controller=Get.put(OrderViewModel());
  
  Size size= Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'View Cart Screen',
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
                visible: view_cart_page_controller.loading.value?true:false,
                child: Container(
                  margin: EdgeInsets.only(top: 1),
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.ripple_green,
                    minHeight: 5,
                    value: 0,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('View Cart',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                  /*Text('\u{20B9} ${ view_cart_page_controller.order_details_list[0].totalPrice.toString()}',
                    style: GoogleFonts.poppins(
                      color: AllColors.redColor,
                      fontSize: AllFontSize.twentee,
                      fontWeight: FontWeight.w700,)
                ),*/
                  Text(view_cart_page_controller.order_details_list[0].orderStatus=='Pending'?'\u{20B9} ${ view_cart_page_controller.order_details_list[0].totalPrice.toString()}':
                  '\u{20B9}${view_cart_page_controller.order_details_list[0].totalApprovePrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                ],
              ),
              SizedBox(height: size.height*.005),
              Obx((){
                return Visibility(
                  visible: view_cart_page_controller.order_details_list[0].orderStatus=='Pending'?true:false,
                  child: Container(
                    width: size.width*.4,
                    child: DefaultButton(
                      text: "Create Order",
                      press: () {
                       // view_cart_page_controller.orderHeaderComplete(view_cart_page_controller.order_details_list[0].orderNo!);
                      },
                      // loading: view_cart_page_controller.loading.value,
                    ),
                  ),
                );
              }),
          /*    Obx((){
                return  Visibility(
                  visible: view_cart_page_controller.order_details_list[0].consigneeId.toString().isNotEmpty?true:false,
                  child: InkWell(
                    onTap: (){
                      showBottomSheetOpenForConsignee(context);
                    },
                    child:  Text("Consignee Name :" +
                        *//*view_cart_page_controller.order_details_list[0].consigneeId
                            ==null ?Utils.sanckBarError('Message : ',
                            "Consignee Id is null. So you can't see Consignee Details. "):
                        'Consignee Name : ' +*//*
                        (*//*view_cart_page_controller.order_details_list[0]
                                .consigneeName == null ?*//* view_cart_page_controller
                            .order_details_list[0].consigneeName.toString() ) ,

                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w800


                        )),

                  ),
                );
              }),*/

              SizedBox(height: size.height*.005),
              Row(
                children: [
                  Text('Total Qty: ${view_cart_page_controller.order_details_list[0].totalQty.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w600,)
                  ),
                  Obx((){
                    return  Visibility(
                      visible: view_cart_page_controller.order_details_list[0].orderStatus!='Pending'?true:false,
                      child: Text('/ Appr.Qty: ${view_cart_page_controller.order_details_list[0].totalApproveQty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,)
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: size.height*.005),
             /* Row(
                children: [
                  Text('In Kg: ${view_cart_page_controller.order_details_list[0].totalOrderInKg.toString()+' Kg'}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w600,)
                  ),
                  Obx((){
                    return  Visibility(
                      visible: view_cart_page_controller.order_details_list[0].orderStatus!='Pending'?true:false,
                      child: Text('/ Appr.In Kg: ${view_cart_page_controller.order_details_list[0].totalApprovePrice.toString()} ',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,)
                      ),
                    );
                  }),

                ],
              ),*/
              SizedBox(height: size.height*.005),
              /*Text('Current O/S: \u{20B9} ${view_cart_page_controller.order_details_list[0].currentOutstanding.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/
              SizedBox(height: size.height*.005),
              Text(view_cart_page_controller.order_details_list[0].orderStatus=='Approved'?'Total Appr. Disc. Amount: \u{20B9} ${view_cart_page_controller.order_details_list[0].totalApproveDiscountAmt.toString()}'
                  :'Total Disc. Amount: \u{20B9} ${view_cart_page_controller.order_details_list[0].totalDiscountAmt.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),
              SizedBox(height: size.height*.005),
              /*Text('Credit Limit: \u{20B9} ${view_cart_page_controller.order_details_list[0].cre.toString()}',
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
    if (view_cart_page_controller.order_details_list[0].lines == null ||
        view_cart_page_controller.order_details_list[0].lines!.isEmpty ) {
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
            itemCount: view_cart_page_controller.order_details_list[0].lines!.length,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(view_cart_page_controller.order_details_list[0].lines![position].itemNo ?? ''
                      ,style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700
                      ),),
                    /*Text('Sec.Pack: ${view_cart_page_controller.order_details_list[0].lines![position].secondaryPacking.toString() +' '+
                        view_cart_page_controller.order_details_list[0].lines![position].baseUnitOfMeasure.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),*/

                    Text(view_cart_page_controller.order_details_list[0].orderStatus=="Approved"?'Appr.Discount Amt. : ${view_cart_page_controller.order_details_list[0].lines![position].approveDiscountAmt.toString()}'
                        :'Discount Amt. : ${view_cart_page_controller.order_details_list[0].lines![position].discountAmt.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),
                    Text('Discount % : ${view_cart_page_controller.order_details_list[0].lines![position].discountPer.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),


                    Text('Price/ ${view_cart_page_controller.order_details_list[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                        view_cart_page_controller.order_details_list[0].lines![position].unitPrice.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),
                    Obx((){
                      return  Visibility(
                        visible: view_cart_page_controller.order_details_list[0].orderStatus!='Pending'?true:false,
                        child: Text('Appr.Price: Rs. '+
                            view_cart_page_controller.order_details_list[0].lines![position].approvePrice.toString() ?? '',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w500,
                              fontSize: AllFontSize.fourtine,
                            )
                        ),
                      );
                    }),

                    Text('Order Qty: ${view_cart_page_controller.order_details_list[0].lines![position].qty.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),
                    Text('Total Price : ${view_cart_page_controller.order_details_list[0].lines![position].totalPrice.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),

                    Obx((){
                      return  Visibility(
                        visible: view_cart_page_controller.order_details_list[0].orderStatus!='Pending'?true:false,
                        child: Text('Appr.Qty: ${view_cart_page_controller.order_details_list[0].lines![position].approveQty.toString()}',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w500,
                              fontSize: AllFontSize.fourtine,
                            )
                        ),
                      );
                    }),

                  ],
                ),
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
                                color: view_cart_page_controller.order_details_list[0].orderStatus=='Pending'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {


                            if(view_cart_page_controller.order_details_list[0].orderStatus=='Pending'){
/*
                              view_cart_page_controller.orderItemLineInsert(view_cart_page_controller.order_details_list[0].lines![position].orderNo!,
                                  view_cart_page_controller.order_details_list[0].lines![position].itemNo!,
                                  view_cart_page_controller.order_details_list[0].lines![position].qty!,'REMOVE','CART');*/

                            }
                          },
                        ),
                        Obx((){
                          return InkWell(
                            child: Text(view_cart_page_controller.order_details_list[0].lines![position].approveQty==0?
                            view_cart_page_controller.order_details_list[0].lines![position].qty.toString():
                            view_cart_page_controller.order_details_list[0].lines![position].approveQty.toString(),
                              style: TextStyle(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee,
                              ),
                            ),
                            onTap: (){
                              if(view_cart_page_controller.order_details_list[0].orderStatus=='Pending') {
                                //showRemarkDialog(context, position);
                              }
                            },
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: view_cart_page_controller.order_details_list[0].orderStatus=='Pending'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                          /*  if(view_cart_page_controller.order_details_list[0].orderStatus=='Pending') {
                              view_cart_page_controller.orderItemLineInsert(
                                  view_cart_page_controller.order_details_list[0]
                                      .lines![position].orderNo!,
                                  view_cart_page_controller.order_details_list[0]
                                      .lines![position].itemNo!,
                                  view_cart_page_controller.order_details_list[0]
                                      .lines![position].qty!, 'ADD', 'CART');
                            }*/
                          },
                        ),
                      ],
                    ),
                /*    Obx(() {
                      return  Text('In ${view_cart_page_controller.order_details_list[0].lines![position].baseUnitOfMeasure.toString()}: ${view_cart_page_controller.order_details_list[0].lines![position].orderInKg.toString()+' '+
                          view_cart_page_controller.order_details_list[0].lines![position].baseUnitOfMeasure.toString()?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          ));
                    }),*/
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Obx((){
                    return Visibility(
                      visible: view_cart_page_controller.order_details_list[0].orderStatus=='Pending'?true:false,
                      child: DefaultButtonRed(
                        text: "Delete",
                        press: () {
                          /*view_cart_page_controller.orderItemLineInsert(view_cart_page_controller.order_details_list[0].lines![position].orderNo!,
                              view_cart_page_controller.order_details_list[0].lines![position].itemNo!,
                              0,'DELETE','CART');*/
                        },
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bindImage(int position) {
    if(view_cart_page_controller.order_details_list[0].lines![position].imageUrl != null &&
        view_cart_page_controller.order_details_list[0].lines![position].imageUrl != "")
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
            view_cart_page_controller.order_details_list[0].lines![position].imageUrl!,
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
          child: Image.asset("assets/images/no_file.png",
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );

  }

  

}