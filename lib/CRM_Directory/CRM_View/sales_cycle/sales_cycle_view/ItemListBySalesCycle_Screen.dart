import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';



class Itemlist_by_sales_cycle_Screen extends StatelessWidget{
  Itemlist_by_sales_cycle_Screen({super.key});
  final saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
        child: Scaffold(
            appBar:  AppBar(
                backgroundColor: AllColors.primaryDark1,
                iconTheme: IconThemeData(
                  color: AllColors.whiteColor,
                ),
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Item List',
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(Icons.filter_alt_sharp, color: AllColors.whiteColor,),
                        ),
                      ),
                      onTap: (){
                        showDialogForFilter(context);
                      },
                    ),
                  ],
                )
            ),
            drawer: CustomDrawer(),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx((){
                    return Visibility(
                      visible:saleCycleController.loading.value ,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.textColor,
                      ),
                    );
                  }),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                      child: Obx(() {
                        return bindSalesItemList(context);
                      }),
                    ),
                  )

                ],),
            )
        ),
    );
  }

  Widget bindSalesItemList(BuildContext context) {
    String productCategory = saleCycleController.saleCycleList[0].productCategoryCode ?? "";
    String pipeProdCate = productCategory.replaceAll(', ', '|');

    if (saleCycleController.itemMstGetBySalesIdList.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (saleCycleController.total_rows_items /
              saleCycleController.rowsPerPage)
              .toInt();
          if ((saleCycleController.total_rows_items %
              saleCycleController.rowsPerPage) >
              0) total_page += 1;

          if (saleCycleController.pageNumberForItem + 1 < total_page) {
            saleCycleController.itemMstGetBySalesIdApiHit(
                saleCycleController.pageNumberForItem + 1,
                saleCycleController.saleCycleList[0].salesCycleId,
                pipeProdCate
            );
            saleCycleController.pageNumberForItem += 1;
          }
        }
      });

      return ListView.separated(
        padding: EdgeInsets.only(bottom: 10),
        separatorBuilder: (context, index) => Divider(
          height: .05,
          color: Colors.transparent,
        ),
        shrinkWrap: true,
        itemCount: saleCycleController.itemMstGetBySalesIdList.value.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return bindPendingListView(context, index);
        },
      );
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget bindPendingListView(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 3),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Item Code : ",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    saleCycleController
                        .itemMstGetBySalesIdList[index]
                        .itemCode??"",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Obx((){
                return Checkbox(
                  value: saleCycleController.itemMstGetBySalesIdList[index].isSelected==1?true:false,
                  onChanged: (bool? value) {
                    saleCycleController.toggleSalesCheckbox(index);
                  },
                );
              }),
            ],
          ),
          subtitle:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Name : ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Flexible(
                          //width: size.width*.2,
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetBySalesIdList[index]
                                .name?? "",
                            child: Text(
                              (saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .name?? "") ,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Category  : ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Flexible(
                          //width: size.width*.15,
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetBySalesIdList[index]
                                .categoryName??"",
                            child: Text(
                              saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .categoryName??"",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Brand Code : ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Flexible(
                          child: Tooltip(
                            message:  saleCycleController
                                .itemMstGetBySalesIdList[index]
                                .brandCode??"",
                            child: Text(
                              saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .brandCode??"",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "BUOM: ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          saleCycleController
                              .itemMstGetBySalesIdList[index]
                              .baseUnitOfMeasure??"",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "GST Group Code : ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          saleCycleController
                              .itemMstGetBySalesIdList[index]
                              .gstGroupCode??"",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hsn Code :",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          saleCycleController
                              .itemMstGetBySalesIdList[index]
                              .hsnCode??"",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Component Type: ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Flexible(
                         // width: size.width*.12,
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetBySalesIdList[index]
                                .componentType??"",
                            child: Text(
                              saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .componentType??"",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),








                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //width: size.width/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Cost Per Unit : ",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            //width: size.width*.17,
                            child: Tooltip(
                              message:  saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .costPerUnit==0?"0":saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .costPerUnit.toString(),
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .costPerUnit==0?"0":saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .costPerUnit.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            "MRP: ",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: size.width*.2,
                            child: Tooltip(
                              message:  saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .mrp.toString(),
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .mrp.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    /*  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Standard Cost:",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: size.width*.08,
                            child: Tooltip(
                              message:  saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .standardCost.toString(),
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .standardCost.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                            width:size.width*0.3,
                            child: Tooltip(
                              message:    "Branch Transfer Price:",
                              child: Text(
                                "Branch Transfer Price:",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: size.width*.08,
                            child: Tooltip(
                              message:  saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .branchTransferPrice.toString(),
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .branchTransferPrice.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                            width:size.width*0.3,
                            child: Tooltip(
                              message: "Min. Acceptable price:",
                              child: Text(
                                "Min. Acceptable price:",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: size.width*.08,
                            child: Tooltip(
                              message:saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .minimalAcceptablePrice.toString(),
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .minimalAcceptablePrice.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            "LSP:",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Flexible(
                            //width: size.width*.1,
                            child: Tooltip(
                              message:saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .standardCost.toString(),
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .standardCost.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Is Active : ",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: size.width*.2,
                            child: Tooltip(
                              message: saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .active.toString() == '1'?'Yes':'No',
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .active.toString() == '1'?'Yes':'No',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Is Bulky : ",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: size.width*.2,
                            child: Tooltip(
                              message: saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .isBulky.toString() == "1"?'Yes':'No',
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .isBulky.toString() == "1"?'Yes':'No',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Is Expiry Mandatory : ",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: size.width*.06,
                            child: Tooltip(
                              message: saleCycleController
                                  .itemMstGetBySalesIdList[index]
                                  .isExpiryMandatory.toString()=='1'?"Yes":'No',
                              child: Text(
                                saleCycleController
                                    .itemMstGetBySalesIdList[index]
                                    .isExpiryMandatory.toString()=='1'?"Yes":'No',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
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
          )
      ),
    );
  }


  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_moon_rounded, color: AllColors.lightredColor,),
                      SizedBox(width: 5,),
                      Text(
                          'Filter',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.twenteetwo,
                            fontWeight: FontWeight.w700,
                            color: AllColors.primaryDark1,
                          )),
                      Spacer(),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel, color: AllColors.lightredColor,)
                      ),
                    ],
                  ),
                ),
                Divider(height: 1,color: Colors.grey,),
                SingleChildScrollView(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            filterWithItemCode( context),
                            SizedBox(height: 10),
                            filterWithName( context),
                            SizedBox(height: 10),
                            filterWithCategoryName( context),
                            SizedBox(height: 10),
                            filterWithCategoryCode( context),
                            SizedBox(height: 10),
                            filterWithGSTGrpCode( context),
                            SizedBox(height: 10),
                            filterWithHsnCode( context),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        AllColors.redColor,
                                      ),
                                    ),
                                    onPressed: ()  {
                                      String ProductCategory = saleCycleController.saleCycleList[0].productCategoryCode??"";
                                      String PipeProdCate = ProductCategory.replaceAll(', ', '|');
                                      try{
                                        saleCycleController.itemSalesCodeController.value.clear();
                                        saleCycleController.nameSalesController.value.clear();
                                        saleCycleController.categoryNameSalesController.value.clear();
                                        saleCycleController.categoryCodeSalesController.value.clear();
                                        saleCycleController.gstGrpCodeSalesController.value.clear();
                                        saleCycleController.hsnCodeSalesController.value.clear();
                                        saleCycleController.itemMstGetBySalesIdApiHit(0,saleCycleController.saleCycleList[0].salesCycleId, PipeProdCate);
                                        Navigator.pop(context);
                                      }catch(e){
                                        print("Exception..${e.toString()}");
                                      }

                                    },
                                    child: Container(
                                      child: Text('Clear',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.blackColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        AllColors.greenblue,
                                      ),
                                    ),
                                    onPressed: ()  {
                                      String ProductCategory = saleCycleController.saleCycleList[0].productCategoryCode??"";
                                      String PipeProdCate = ProductCategory.replaceAll(', ', '|');
                                      saleCycleController.itemMstGetBySalesIdApiHit(0,saleCycleController.saleCycleList[0].salesCycleId, PipeProdCate);
                                      Navigator.pop(context);
                                      saleCycleController.itemSalesCodeController.value.clear();
                                      saleCycleController.nameSalesController.value.clear();
                                      saleCycleController.categoryNameSalesController.value.clear();
                                      saleCycleController.categoryCodeSalesController.value.clear();
                                      saleCycleController.gstGrpCodeSalesController.value.clear();
                                      saleCycleController.hsnCodeSalesController.value.clear();

                                    },
                                    child: Container(
                                      child: Text('Submit',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.blackColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )




                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget filterWithItemCode(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.itemSalesCodeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Item Code',
          labelText: 'Item Code',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget filterWithName(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.nameSalesController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Item Name',
          labelText: 'Item Name',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  filterWithCategoryName(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.categoryNameSalesController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Category Name',
          labelText: 'Category Name',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget filterWithCategoryCode(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.categoryCodeSalesController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Category Code',
          labelText: 'Category Code',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget filterWithGSTGrpCode(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.gstGrpCodeSalesController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Gst Group Code',
          labelText: 'Gst Group Code',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget filterWithHsnCode(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.hsnCodeSalesController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'HSN Code',
          labelText: 'HSN Code',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

}