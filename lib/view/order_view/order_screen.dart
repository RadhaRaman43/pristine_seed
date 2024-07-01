import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Order Screen',
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
                     visible:order_header_page_controller.loading.value ,
                     child: LinearProgressIndicator(
                       color: AllColors.textColor,
                       backgroundColor: AllColors.primaryDark1,
                     ),
                   ),
                 );
               },
             ),


             Obx(() =>   bindListView(context),)


           ],
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

}