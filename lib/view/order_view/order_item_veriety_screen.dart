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
           title:Text(
             'Item View Screen',
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
                 return  Container(
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
                             Text('Ordered Qty: ${item_variety_page_controller.order_item_get_list[0].orderQty! ?? ''}',
                                 style: GoogleFonts.poppins(
                                   color: item_variety_page_controller.order_item_get_list[0].orderQty!>0?AllColors.redColor:AllColors.blackColor,
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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item_variety_page_controller.order_item_get_list[position].itemName ?? ''
                      ,style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700
                      ),),
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
    print(item_variety_page_controller.order_item_get_list[0].imageUrl.toString());
    if(item_variety_page_controller.order_item_get_list.length>0
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

}