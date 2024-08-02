import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/order_vm/order_vm.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../custom_drawer.dart';

class OrderScreen extends StatelessWidget{
  OrderScreen({super.key});

  Size size= Get.size;

  final order_header_page_controller=Get.put(OrderViewModel());
  @override
  Widget build(BuildContext context) {
    print(order_header_page_controller.pending_amt);
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title:Row(
            children: [
              Text(
                'Order',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),

              IconButton(onPressed: () {
                showFilterBottomSheet(context);


              }, icon: Icon(Icons.filter_alt_sharp)),

              Obx(() {
               return
                  Visibility(
                    visible:order_header_page_controller.status.value=="Pending"?true:false,
                    child: IconButton(onPressed: () {
                    order_header_page_controller.resetAllNewOrderFields();
                    var outputFormat = DateFormat('dd-MM-yyyy');
                    order_header_page_controller.order_date_controller.text =
                        outputFormat.format(DateTime.now());
                    Get.toNamed(RoutesName.new_order_screen);
                                    }, icon: Icon(Icons.add)),
                  );
              },)
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
                     margin: EdgeInsets.only(top: 0.5),
                     child: Visibility(
                       visible:order_header_page_controller.loading.value ,
                       child: LinearProgressIndicator(
                         color: AllColors.textColor,
                         backgroundColor: AllColors.primaryDark1,
                       ),
                     ),
                   );
                 },
               ),
               Container(
                 padding: EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     TextFormField(
                       controller: order_header_page_controller.global_search_controller,
                       decoration: InputDecoration(
                         hintText: "Enter Order No.",
                         contentPadding: EdgeInsets.all(10),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(
                               color: AllColors.primaryDark1), // Customize the border color
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(
                               color: Colors.grey), // Customize the border color
                         ),
                         suffixIcon: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             IconButton(
                               icon: Icon(Icons.search),
                               onPressed: () async {
                                 order_header_page_controller.pageNumber=0;
                                 order_header_page_controller.orderHeaderApi(order_header_page_controller.pageNumber,global_search:order_header_page_controller.global_search_controller.text);
                               },
                             ),
                             IconButton(
                               icon: Icon(Icons.clear),
                               onPressed: () {
                                 order_header_page_controller.pageNumber=0;
                                 order_header_page_controller.global_search_controller.clear();
                                 order_header_page_controller.orderHeaderApi(order_header_page_controller.pageNumber);

                                 // Add clear functionality here
                               },
                             ),
                           ],
                         ),
                       ),
                     ),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                        Obx(() {
                           return
                             ActionChip(
                               elevation: 2,
                               padding: EdgeInsets.all(2),
                               backgroundColor:order_header_page_controller.status.value=="Pending"?AllColors.primaryDark1:AllColors.grayColor,
                               shadowColor: Colors.black,
                               shape: StadiumBorder(
                                   side: BorderSide(color: AllColors.grayColor)),
                               //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                               //CircleAvatar
                               label: Text('Pending',
                                   style: GoogleFonts.poppins(
                                     color:order_header_page_controller.status.value=="Pending"?AllColors.whiteColor:AllColors.primaryDark1,
                                     fontSize: AllFontSize.fourtine,
                                     fontWeight: FontWeight.w500,
                                   )
                               ),
                               onPressed: () {
                                 order_header_page_controller.status.value="Pending";
                                 order_header_page_controller.orderHeaderApi(order_header_page_controller.pageNumber);
      ;
                               }, //Text
                             );
                           },),
                         SizedBox(width: 5,),
                         Obx(() {
                             return

                               ActionChip(
                               elevation: 2,
                               padding: EdgeInsets.all(2),
                               backgroundColor:order_header_page_controller.status.value=="Completed"?AllColors.primaryDark1:AllColors.grayColor,
                               shadowColor: Colors.black,
                               shape: StadiumBorder(
                                   side: BorderSide(color: AllColors.grayColor)),
                               //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                               //CircleAvatar
                               label: Text('Under Approval',
                                   style: GoogleFonts.poppins(
                                     color:order_header_page_controller.status.value=="Completed"?AllColors.whiteColor:AllColors.primaryDark1,
                                     fontSize: AllFontSize.fourtine,
                                     fontWeight: FontWeight.w500,
                                   )),
                               onPressed: () {
                                 order_header_page_controller.status.value="Completed";
                                 order_header_page_controller.pageNumber=0;
                                 order_header_page_controller.orderHeaderApi(order_header_page_controller.pageNumber);

                               }, //Text
                             );
                       },),
                         SizedBox(width: 5,),
                         Obx(() {
                           return ActionChip(
                             elevation: 2,
                             padding: EdgeInsets.all(2),
                             backgroundColor:order_header_page_controller.status.value=="Approved"?AllColors.primaryDark1:AllColors.grayColor,
                             shadowColor: Colors.black,
                             shape: StadiumBorder(
                                 side: BorderSide(color: AllColors.grayColor)),
                             //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                             //CircleAvatar
                             label: Text('Pending Shipped',
                               style: GoogleFonts.poppins(
                                 color:order_header_page_controller.status.value=="Approved"? AllColors.whiteColor:AllColors.primaryDark1,
                                 fontSize: AllFontSize.fourtine,
                                 fontWeight: FontWeight.w500,
                               ),
                               overflow: TextOverflow.ellipsis,
                             ),
                             onPressed: () {
                               order_header_page_controller.status.value="Approved";
                               order_header_page_controller.pageNumber=0;
                               order_header_page_controller.orderHeaderApi(order_header_page_controller.pageNumber);

                             }, //Text
                           );
                         },
                           //child:
                         ),

                       ],
                     ),
                   ],
                 ),
               ),

               SizedBox(height: size.height*0.01,),

               Obx(() =>   bindListView(context),)


             ],
           ),

         ),


      ),
    );
  }

  bindListView(BuildContext context) {
    ScrollController scrollController = ScrollController();
    if(order_header_page_controller.order_header_list!=null &&
        order_header_page_controller.order_header_list.isNotEmpty &&
        order_header_page_controller.order_header_list.length>0){

      scrollController.addListener(() {
        print("rmgfrnrnknkvb");

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (order_header_page_controller.total_rows /
              order_header_page_controller.rowsPerPage)
              .toInt();
          if ((order_header_page_controller.total_rows %
              order_header_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${order_header_page_controller.pageNumber} ${order_header_page_controller.total_rows} ${order_header_page_controller.rowsPerPage} ${total_page}");

          if (order_header_page_controller.pageNumber + 1 != total_page) {
            order_header_page_controller.orderHeaderApi(
                order_header_page_controller.pageNumber+1);
            this.order_header_page_controller.pageNumber += 1;
          }
        }
      });

      return Expanded(
        child: ListView.separated(
          shrinkWrap: true,
            itemBuilder: (context, index) {
          return bindOrderList(context,index);
        }, separatorBuilder: (context, index) {
             return Divider(color: AllColors.primaryDark1,height: 0.5,);
        }, itemCount: order_header_page_controller.order_header_list.length),
      );
    }else{
      return Container(
        child: Center(
          child:Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
        ),
      );
      
    }
    
  }

  //todo listview bind
  Widget  bindOrderList(context, int position) {
    var orderDate = StaticMethod.dateTimeToDate(order_header_page_controller.order_header_list[position].createdOn!);
    return InkWell(
      child: ListTile(
        onTap: () {
          if(order_header_page_controller.order_header_list[position].orderStatus=='Completed' ||
              order_header_page_controller.order_header_list[position].orderStatus=='Approved'){
            order_header_page_controller.orderDetailsApiHit(order_header_page_controller.order_header_list[position].orderNo!,'CART');
          }else{
            order_header_page_controller.orderDetailsApiHit(order_header_page_controller.order_header_list[position].orderNo!,'');
          }

        },
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Order:',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),

            SizedBox(width: size.width*0.03,),

            Text('${order_header_page_controller.order_header_list[position].orderNo ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
          ],
        ),



        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order_header_page_controller.order_header_list[position].customerName ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),

            Text('Date: ${orderDate ?? ''}',
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text('RS. ${order_header_page_controller.order_header_list[position].totalPrice.toString()}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),),
            ),
            Expanded(
              child: Text('${order_header_page_controller.order_header_list[position].orderStatus=='Approved'?'Appr. Price.${order_header_page_controller.order_header_list[position].totalApprovePrice.toString()}':''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),
              ),
            ),
            Expanded(
              child: Text(order_header_page_controller.order_header_list[position].orderStatus ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.redColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),),
            ),
          ],
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
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
                        "Filters",
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
                   // height: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                         controller: order_header_page_controller.order_filter_customer_no_controller,
                          decoration: InputDecoration(
                            labelText: 'Customer No.',
                            hintText: 'Customer No.',
                            hintStyle: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.ten,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w700,
                              fontSize: AllFontSize.sisxteen,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                         controller: order_header_page_controller.order_filter_customer_name_controller,
                          decoration: InputDecoration(
                            labelText: 'Customer Name',
                            hintText: 'Customer Name',
                            hintStyle: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.ten,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w700,
                              fontSize: AllFontSize.sisxteen,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        bindDate(context),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark,
                                      width: 1),
                                )),
                                onPressed: () {
                                  Get.back();
                                  order_header_page_controller.pageNumber=0;
                                  order_header_page_controller.orderHeaderApi(order_header_page_controller.pageNumber);

                                },
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                )),
                                onPressed: () {
                                  Get.back();
                                  order_header_page_controller.order_filter_customer_name_controller.clear();
                                  order_header_page_controller.order_filter_customer_no_controller.clear();
                                  order_header_page_controller.order_filter_date_controller.clear();


                                },
                                child: Text(
                                  'Reset',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.redColor,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
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


  Widget bindDate(context) {
    return TextFormField(
        controller: order_header_page_controller.order_filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Order Date",
        labelText: 'Order Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
        DateTime ending_date = new DateTime(2200);
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: stating_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                //accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          order_header_page_controller.order_filter_date_controller.text = outputFormat.format(date);
        else
          order_header_page_controller.order_filter_date_controller.text = "";
      },
    );
  }


}