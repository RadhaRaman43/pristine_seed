import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/viewModel/order_vm/order_vm.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../custom_drawer.dart';

class OrderItemVarietyScreen extends StatelessWidget{
  OrderItemVarietyScreen({super.key});

  final item_variety_page_controller=Get.put(OrderViewModel());

  Size size= Get.size;

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop:  ()  async {

         Get.toNamed(RoutesName.order_item_category_screen);
         item_variety_page_controller.getOrderItemCategoryGet(item_variety_page_controller.order_details_list[0].orderNo!);

         return false;
       },
       child: Scaffold(
         floatingActionButton: FloatingActionButton(
           onPressed: () {
             Get.toNamed(RoutesName.order_view_cart_screen);
           },
           child: Stack(
             children: [
               Container(
                 width: 60,
                 height: 60,
                 child: Column(children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 4.0),
                     child: buildShoppingBagBadge(),
                   ),
                   Icon(Icons.shopping_cart_rounded, color: AllColors.whiteColor, size: 30), // Your shopping bag icon
                 ],),
               ),
             ],

           ), // You can change the icon as needed
           backgroundColor: AllColors
               .primaryDark1, // Customize the button's background color

         ),
         appBar: AppBar(
           title:Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 'Item View',
                 style: GoogleFonts.poppins(
                   color: AllColors.whiteColor,
                   fontSize: AllFontSize.twentee,
                   fontWeight: FontWeight.w700,
                 ),
               ),Text(
                   "(${item_variety_page_controller
                       .order_details_list[0].orderNo != null ?
                   item_variety_page_controller.order_details_list[0]
                       .orderNo! : ''}"+')',
                   style: GoogleFonts.poppins(
                     color: AllColors.whiteColor,
                     fontSize: AllFontSize.sisxteen,
                     fontWeight: FontWeight.w600,
                   )
               ),

             ],
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
                   visible: item_variety_page_controller.loading.value?true:false,
                   child: Container(
                     margin: EdgeInsets.only(top: 1),
                     child: LinearProgressIndicator(
                       backgroundColor: AllColors.primaryDark1,
                       color: AllColors.textColor,
                     ),
                   ),
                 );
               }),

               SizedBox(height: size.height * .01),
               Obx((){
                 return  Column(
                   children: [
                     Container(
                       padding: const EdgeInsets.only(left: 8.0),
                       // /width: size.width*.4,
                       child: Row(
                         children: [
                           Text("Customer Name:",
                               style: GoogleFonts.poppins(
                                 color: AllColors.primaryDark1,
                                 fontSize: AllFontSize.fourtine,
                                 fontWeight: FontWeight.w600,
                               )
                           ),
                           SizedBox(width: size.width*.02, ),
                           InkWell(
                             onTap: () {
                               showCustomerDetailsBottomSheet(context);
                             },
                             child: Container(
                               width:size.width*.55 ,
                               child: Tooltip(
                                 message:"${item_variety_page_controller
                                     .order_details_list[0].customerName!= null ?
                                 item_variety_page_controller.order_details_list[0]
                                     .customerName!:""}",
                                 child: Text(
                                   overflow: TextOverflow.ellipsis,
                                   textAlign: TextAlign.start,
                                   "${item_variety_page_controller
                                       .order_details_list[0].customerName!= null ?
                                   item_variety_page_controller.order_details_list[0]
                                       .customerName!+"(${ item_variety_page_controller.order_details_list[0]
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
                     ),
                     Container(
                       padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                       child: ListTile(
                         subtitle: Row(
                           children: [
                             bindImage(item_variety_page_controller.index),
                             SizedBox(width: size.width*.04),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(item_variety_page_controller.order_item_get_list[0].categoryCode ?? ''
                                   ,style: GoogleFonts.poppins(
                                       color: AllColors.primaryDark1,
                                       fontSize: AllFontSize.sisxteen,
                                       fontWeight: FontWeight.w700
                                   ),),
                                 Text(item_variety_page_controller.order_item_get_list[0].itemName ?? '',
                                     style: GoogleFonts.poppins(
                                       color: AllColors.primaryDark1,
                                       fontWeight: FontWeight.w500,
                                       fontSize: AllFontSize.fourtine,
                                     )),
                              /*   Text('Ordered Qty: ${item_variety_page_controller.order_item_get_list[0].orderQty! ?? ''}',
                                     style: GoogleFonts.poppins(
                                       color: item_variety_page_controller.order_item_get_list[0].orderQty!>0?AllColors.redColor:AllColors.blackColor,
                                       fontWeight: FontWeight.w500,
                                       fontSize: AllFontSize.fourtine,
                                     )),
*/

                                 Text('Ordered Qty: ${item_variety_page_controller.order_item_get_list[0].categoryWiseTotalQty.toString()}',
                                     style: GoogleFonts.poppins(
                                       color: item_variety_page_controller.order_item_get_list[0].categoryWiseTotalQty!=null ?AllColors.redColor:AllColors.blackColor,
                                       fontWeight: FontWeight.w500,
                                       fontSize: AllFontSize.fourtine,
                                     )),



                                 /*Text('In ${item_variety_page_controller.order_item_get_list[0].baseUnitOfMeasure.toString()}: ${item_variety_page_controller.order_item_get_list[0].orderInKg!.toString() ?? ''}',
                                     style: GoogleFonts.poppins(
                                       color: item_variety_page_controller.order_item_get_list[0].orderInKg!>0?AllColors.redColor:AllColors.blackColor,
                                       fontWeight: FontWeight.w500,
                                       fontSize: AllFontSize.fourtine,
                                     )),*/
                               ],
                             ),
                           ],
                         ),

                       ),
                     ),
                   ],
                 );
               }),

               Divider(
                 height: 2,
                 color: AllColors.blackColor,
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
       ),
     );
  }


  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (item_variety_page_controller.order_item_get_list == null ||
        item_variety_page_controller.order_item_get_list.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text('No Records Found.', style: TextStyle(
              fontSize: 20,
              color: AllColors.primaryColor
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
            itemCount: item_variety_page_controller.order_item_get_list.length,
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
      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:size.width*.61,
                      child: Tooltip(
                        message: item_variety_page_controller.order_item_get_list[position].itemName ?? '',
                        child: Text(item_variety_page_controller.order_item_get_list[position].itemName ?? ''
                          ,style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    /*Text('Sec.Pack: ${item_variety_page_controller.order_item_get_list[position].secondaryPacking.toString() +' '+
                        item_variety_page_controller.order_item_get_list[position].baseUnitOfMeasure.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),*/
                    Text('Price/ ${item_variety_page_controller.order_item_get_list[position].baseUnitOfMeasure.toString()+': Rs. '+
                        item_variety_page_controller.order_item_get_list[position].unitPrice.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: AllColors.primaryDark1, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            item_variety_page_controller.orderItemLineInsert(item_variety_page_controller.order_details_list[0].orderNo!,
                                item_variety_page_controller.order_item_get_list[position].itemNo!,
                                item_variety_page_controller.order_item_get_list[position].orderQty!,'REMOVE','VARIETY');
                          },
                        ),
                        Obx((){
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              child: Text(item_variety_page_controller.order_item_get_list[position].orderQty.toString(),
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AllFontSize.twentee,
                                ),
                              ),
                              onTap: (){
                               showRemarkDialog(context,position);
                              },
                            ),
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: AllColors.primaryDark1, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            print(item_variety_page_controller.order_item_get_list[position].itemNo);
                            item_variety_page_controller.orderItemLineInsert(item_variety_page_controller.order_details_list[0].orderNo!,
                                item_variety_page_controller.order_item_get_list[position].itemNo!,
                                item_variety_page_controller.order_item_get_list[position].orderQty!,'ADD','VARIETY');
                          },
                        ),
                      ],
                    ),
                   /* Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text('In ${item_variety_page_controller.order_item_get_list[position].baseUnitOfMeasure.toString()}: ${item_variety_page_controller.order_item_get_list[position].orderInKg!.toString()+' '+
                          item_variety_page_controller.order_item_get_list[position].baseUnitOfMeasure.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),
                    ),*/
                  ],
                )
              ],
            ),
          ),
          if(position==item_variety_page_controller.order_item_get_list.length-1)
            Divider(
              height: 2,
              color: AllColors.blackColor,
            )
        ],
      ),
    );
  }
  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(item_variety_page_controller.order_details_list[0].totalQty.toString(),/*item_variety_page_controller.order_item_get_list[0].orderQty!=null ?
      item_variety_page_controller.order_item_get_list[0].orderQty.toString(): '0'*/
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red, // Set your preferred text color
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
    });
  }

  Widget bindImage(int index) {
  //  print(item_variety_page_controller.order_item_get_list[0].imageUrl.toString());
    if(item_variety_page_controller.order_item_get_list.length>0 && item_variety_page_controller.order_item_get_list.isNotEmpty
        && item_variety_page_controller.order_item_get_list[0].imageUrl!= null &&
        item_variety_page_controller.order_item_get_list[0].imageUrl != "")
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
            item_variety_page_controller.order_item_get_list[0].imageUrl!,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If there's an error loading the image, display a default image
              return Image.asset(
                "assests/images/no_file.png",
                width: 100,
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
            "assets/images/no_file.png",
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );
  }

  showRemarkDialog(BuildContext context, int position) {
    item_variety_page_controller.qty_controller.text=item_variety_page_controller.order_item_get_list[position].orderQty.toString();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1,),),
          content: TextFormField(
            cursorColor:AllColors.primaryDark1,
            keyboardType: TextInputType.number,
            controller: item_variety_page_controller.qty_controller,
            decoration: InputDecoration(labelText: "Enter Qty",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color:AllColors.primaryDark1, )),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:AllColors.primaryDark1, ))

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
                if(item_variety_page_controller.qty_controller.text.isNotEmpty){
                  item_variety_page_controller.orderItemLineInsert(item_variety_page_controller.order_details_list[0].orderNo!,
                      item_variety_page_controller.order_item_get_list[position].itemNo!,
                      int.parse(item_variety_page_controller.qty_controller.text),'','Dialog');
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
                              width: size.width*.6,
                              child: Text(item_variety_page_controller.order_details_list[0].customerName??"",style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,

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

                            Text(item_variety_page_controller.order_details_list[0].customerNo??"",style: GoogleFonts.poppins(
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

                            Text(item_variety_page_controller.order_details_list[0].customerPhoneNo??"",style: GoogleFonts.poppins(
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

                            Text(item_variety_page_controller.order_details_list[0].customerAddress??"",style: GoogleFonts.poppins(
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
                            Text("Country Name:",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),),

                            Spacer(),

                            Text(item_variety_page_controller.order_details_list[0].customerCountryName??"",style: GoogleFonts.poppins(
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
                            Text(item_variety_page_controller.order_details_list[0].customerStateName??"",style: GoogleFonts.poppins(
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