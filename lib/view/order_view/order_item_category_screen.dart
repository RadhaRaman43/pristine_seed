import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/viewModel/order_vm/order_vm.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../reources/routes/routes_name.dart';
import '../custom_drawer.dart';

class OrderItemCategoryScreen extends StatelessWidget{
  OrderItemCategoryScreen({super.key});

  final order_category_page_controller=Get.put(OrderViewModel());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async  {
        Get.offAllNamed(RoutesName.order_screen);
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
            'Order Category Screen',
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
              Obx(() {
                return  Container(
                  margin: EdgeInsets.only(top: 0.2),
                  child: Visibility(
                    visible:order_category_page_controller.loading.value ,
                    child: LinearProgressIndicator(
                      color: AllColors.textColor,
                      backgroundColor: AllColors.primaryDark1,
                    ),
                  ),
                );
              },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                    child: Column(
                      children: [
                        Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    order_category_page_controller
                                        .order_details_list[0].captionForCategory!,
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: bindSearchCategoryItemCrop1(context),
                              ),
                              // bindItemCategoryCropDropDown(context),
                              Obx((){
                                return  bindListLayout();
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (order_category_page_controller.searchResult == null ||
        order_category_page_controller.searchResult.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child:  Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
        ),
      );
    } else {
      Size size = Get.size;
      return Container(
        height: size.height - 170,
        child: ListView.separated(
            padding: EdgeInsets.only(bottom: 120),
            separatorBuilder: (context, index) =>
                Divider(
                  height: 2,
                  color: AllColors.primaryDark1,
                ),
            itemCount: order_category_page_controller.searchResult.length,
            itemBuilder: (context, index) {
              //var item = order_category_page_controller.searchResult[index];
              return BindListView(context, index);
            }),
      );
    }
  }



  //todo bind for list view category items.....
  Widget BindListView(BuildContext context, int index) {
    {
      return InkWell(
        child: ListTile(
          onTap: () {
            print(order_category_page_controller.searchResult[index].categoryCode);
            order_category_page_controller.index=index;
            order_category_page_controller.getOrderItemGet(order_category_page_controller.order_details_list[0].orderNo!,order_category_page_controller.searchResult[index].categoryCode!,"VARIETY");


           // order_category_page_controller. search_item_varieties_controller.clear();
           // order_category_page_controller.SelectedVariety.value=order_category_page_controller.searchResult[index].categoryCode!;
          //  order_category_page_controller.getOrderItemGroupGet(order_category_page_controller.order_detail_list[0].orderNo!,
            //    order_category_page_controller.searchResult[index].categoryCode!,'screen');


          },
          title: Text(
            '${order_category_page_controller.searchResult[index]
                .categoryCode}${'('}${order_category_page_controller.searchResult[index]
                .categoryDescription==null?"":order_category_page_controller.searchResult[index]
                .categoryDescription}${')'}'?? '',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen, fontWeight: FontWeight.w700
            ),
          ),

          trailing: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Varieties: ${order_category_page_controller
                    .searchResult[index].itemGroupCount.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    )
                ),
                Text('Ordered Qty: ${order_category_page_controller
                    .searchResult[index].orderQty.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: order_category_page_controller
                          .searchResult[index].orderQty!>0?AllColors.redColor:AllColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    )
                ),
              ],
            ),
          ),
        ),
      );
    }
  }


  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(
        order_category_page_controller.order_details_list[0].totalQty
            .toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red, // Set your preferred text color
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
    });
  }

  Widget bindSearchCategoryItemCrop1(context) {
    return Container(
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search,color: AllColors.primaryDark1,),
            title: new TextField(
              controller: order_category_page_controller
                  .search_item_category_crop_controller,
              decoration: new InputDecoration(
                  hintText: 'Search Category', border: InputBorder.none,hintStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              )),
              onChanged: (value){
             order_category_page_controller.onSearchTextChanged(value);
              },
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel,color: AllColors.redColor,), onPressed: () {
              order_category_page_controller
                  .search_item_category_crop_controller.clear();
            order_category_page_controller.onSearchTextChanged('');
            },
            ),
          ),
        )
    );
  }
}