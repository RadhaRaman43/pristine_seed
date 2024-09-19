import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/service_managment_vm_directory/order_vm/order_vm.dart';
import '../../custom_drawer.dart';


class OrderItemCategoryScreen extends StatelessWidget{
  OrderItemCategoryScreen({super.key});

  final order_category_page_controller=Get.put(OrderViewModel());

  Size size= Get.size;
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
          title:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Category',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                  "(${order_category_page_controller
                      .order_details_list[0].orderNo != null ?
                  order_category_page_controller.order_details_list[0]
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      refreshCatagery();

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                      child: Column(
                        children: [
                          Container(
                            child: Column(crossAxisAlignment: CrossAxisAlignment
                                .start,
                              children: [
                                Obx((){
                                  return Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 3,),
                                        Container(
                                         // padding: const EdgeInsets.only(left: 8.0),
                                          // /width: size.width*.4,
                                          child: Row(
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
                                                    message:"${order_category_page_controller
                                                        .order_details_list[0].customerName!= null ?
                                                    order_category_page_controller.order_details_list[0]
                                                        .customerName!+"( ${ order_category_page_controller.order_details_list[0]
                                                        .customerNo!} )":""}",
                                                    child: Text(
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.start,
                                                        "${order_category_page_controller
                                                            .order_details_list[0].customerName!= null ?
                                                        order_category_page_controller.order_details_list[0]
                                                            .customerName!+"( ${ order_category_page_controller.order_details_list[0]
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
                                      ],
                                    ),
                                  );
                                }),

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
            order_category_page_controller
                .search_item_variety_controller.text="";
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
                                message: order_category_page_controller.order_details_list[0].customerName??"",
                                child: Text(order_category_page_controller.order_details_list[0].customerName??"",style: GoogleFonts.poppins(
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

                            Text(order_category_page_controller.order_details_list[0].customerNo??"",style: GoogleFonts.poppins(
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

                            Text(order_category_page_controller.order_details_list[0].customerPhoneNo??"",style: GoogleFonts.poppins(
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

                            Text(order_category_page_controller.order_details_list[0].customerAddress??"",style: GoogleFonts.poppins(
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

                            Text(order_category_page_controller.order_details_list[0].customerCountryName??"",style: GoogleFonts.poppins(
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

                            Text(order_category_page_controller.order_details_list[0].customerStateName??"",style: GoogleFonts.poppins(
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

                            Text(order_category_page_controller.order_details_list[0].customerPostalCode??"",style: GoogleFonts.poppins(
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

  Future<void> refreshCatagery() async {
    order_category_page_controller.getOrderItemCategoryGet(order_category_page_controller.order_details_list[0].orderNo!);

  }


}