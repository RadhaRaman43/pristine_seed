import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';

class CreateForeCastIyemScreen extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:  () async {
      sales_force_cast_vm.clearSelectQuoteItemList();
      sales_force_cast_vm.selectAllQuoteList.value = false;
      sales_force_cast_vm.selectedForeCastQuote_list.value=[];
      Get.toNamed(RoutesName.createSalesForeCastScreen);
      return false;
    },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: AllColors.primaryDark1,
              iconTheme: IconThemeData(
                color: AllColors.whiteColor,
              ),
              title:Row(
                children: [
                  Text(
                    'Forcast Item List',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {
                    if(sales_force_cast_vm.selectedForeCastQuote_list.value.isEmpty){
                      Utils.sanckBarError("Condition False!", "please select at least one Item");
                    }
                    else{
                      sales_force_cast_vm.SalesForecastHeaderCreate();
                    }
                  }, icon: Icon(Icons.add)),

                ],
              )
          ),
          drawer: CustomDrawer(),
          body:  Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:sales_force_cast_vm.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Obx((){
                  return Visibility(
                    visible: sales_force_cast_vm.showForeCstList.value,
                      child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx((){
                            return Checkbox(
                              value: sales_force_cast_vm.selectAllForeCastList.value?true:false,
                              onChanged: (bool? value) {
                                sales_force_cast_vm.selectAllForeCastCheckbox();
                              },
                            );
                          }),
                          Text(sales_force_cast_vm.selectAllForeCastList.value?"Unselect All":"Select All",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AllColors.bluegrayColor,
                    ),
                  ],));
                }),
                Obx((){
                  return Visibility(
                    visible: sales_force_cast_vm.showForeCstList.value,
                      child: BindForeCastItemListView(context,));
                })

              ],
            ),
          ),
        ));
  }

  Widget BindForeCastItemListView(context) {
    if (sales_force_cast_vm.ForeCastQuote_list.value.isNotEmpty && sales_force_cast_vm.ForeCastQuote_list.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (sales_force_cast_vm.total_Quote_List_rows /
              sales_force_cast_vm.rowsPerPage)
              .toInt();
          if ((sales_force_cast_vm.total_Quote_List_rows %
              sales_force_cast_vm.rowsPerPage) >
              0) total_page += 1;
          // print("last index ${sales_force_cast_vm.pageNumberForQuote} ${sales_force_cast_vm.total_rows} ${sales_force_cast_vm.rowsPerPage} ${total_page}");
          if (sales_force_cast_vm.pageNumberForQuote + 1 < total_page) {
            sales_force_cast_vm.getQuoteList(sales_force_cast_vm.pageNumberForQuote+1,);
            sales_force_cast_vm.pageNumberForQuote += 1;
          }
        }
      });

      return
        Expanded(
          child: ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 10),
              separatorBuilder: (context, index) => Divider(
                height: .05,
                color: Colors.transparent,
              ),
              shrinkWrap: true,
              itemCount: sales_force_cast_vm.ForeCastQuote_list.value.length,
              itemBuilder: (BuildContext context, int index) {
                return BindForeCastItemDataListView(context, index);
              }),
        );
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'rejected':
        return Colors.red[600]!;
      case 'approved':
        return Colors.green[700]!;
      case 'draft':
        return Colors.red[900]!;
      case 'pending for approval || Open':
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }

  Widget BindForeCastItemDataListView(context, int position) {

    String saleCycleStatus = sales_force_cast_vm.ForeCastQuote_list[position].quoteStatus?.toLowerCase()??"";
    return Card(
      child: ListTile(
        onTap: () {
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Quote Id : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  sales_force_cast_vm.ForeCastQuote_list[position].quoteId?? "",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color:Colors.blue,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Obx((){
              return Checkbox(
                value: sales_force_cast_vm.ForeCastQuote_list[position].isSelected==1?true:false,
                onChanged: (bool? value) {
                  sales_force_cast_vm.toggleForeCastListCheckbox(position,context);
                },
              );
            }),
          ],
        ),
        subtitle: Column(
          children: [
            _buildLabelWithValue(label: "Item Code: ", value:  sales_force_cast_vm.ForeCastQuote_list[position].itemCode??""),
            _buildLabelWithValue(label: "Item Name: ", value:  sales_force_cast_vm.ForeCastQuote_list[position].itemName??""),
            _buildLabelWithValue(label: "Sales Cycle Id: ", value:  sales_force_cast_vm.ForeCastQuote_list[position].salesCycleId??""),
            _buildLabelWithValue(label: "Product Category: ", value:  sales_force_cast_vm.ForeCastQuote_list[position].productCategory??""),

            _buildLabelWithValue(label: "Item Qty: ", value:  sales_force_cast_vm.ForeCastQuote_list[position].qty.toString()??""),
            _buildLabelWithValue(label: "Approve Price P/U: ", value:  "₹${sales_force_cast_vm.ForeCastQuote_list[position].approvedAmountPerUnit??"0.0"}"),
            _buildLabelWithValue(label: "Approve Price: ", value:  "₹${sales_force_cast_vm.ForeCastQuote_list[position].approvedAmount??"0.0"}"),
            _buildLabelWithValue(label: "LSP: ", value:  "₹${sales_force_cast_vm.ForeCastQuote_list[position].listSellingPrice??"0.0"}"),


          ],
        ),
      ),
    );
  }


  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    Color color= AllColors.textColor,

  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Tooltip(
            message: value??"",
            child: Text(
              value ?? "",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: color,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

}