import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class QuoteItemList extends StatelessWidget{
  QuoteItemList({super.key});
  final saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        saleCycleController.itemCodeController.value.clear();
        saleCycleController.nameController.value.clear();
        saleCycleController.categoryCodeController.value.clear();
        saleCycleController.gstGrpCodeController.value.clear();
        saleCycleController.hsnCodeController.value.clear();
        saleCycleController.categoryNameController.value.clear();
        Get.toNamed(RoutesName.quoteInformationScreen);
        return false;
      }, child: Scaffold(
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
                    /*decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AllColors.whiteColor)
                    ),*/
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
                    return bindQuoteItemList(context);
                  }),
                ),
              )

            ],),
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
                                      String ProductCategory = saleCycleController.quoteHeaderdata[0].productCategoryCode??"";
                                      String PipeProdCate = ProductCategory.replaceAll(', ', '|');
                                      try{
                                        saleCycleController.itemCodeController.value.clear();
                                        saleCycleController.nameController.value.clear();
                                        saleCycleController.categoryCodeController.value.clear();
                                        saleCycleController.gstGrpCodeController.value.clear();
                                        saleCycleController.hsnCodeController.value.clear();
                                        saleCycleController.categoryNameController.value.clear();
                                        saleCycleController.pageNumber=0;
                                        saleCycleController.itemMstGetByQuoteIdApiHit(saleCycleController.pageNumber,saleCycleController.quoteHeaderdata[0].quoteId, "", PipeProdCate);
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
                                      String ProductCategory = saleCycleController.quoteHeaderdata[0].productCategoryCode??"";
                                      String PipeProdCate = ProductCategory.replaceAll(', ', '|');
                                      saleCycleController.pageNumber=0;
                                      saleCycleController.itemMstGetByQuoteIdApiHit(saleCycleController.pageNumber,saleCycleController.quoteHeaderdata[0].quoteId, "", PipeProdCate);
                                      Navigator.pop(context);
                                      // saleCycleController.itemCodeController.value.clear();
                                      // saleCycleController.nameController.value.clear();
                                      // saleCycleController.categoryNameController.value.clear();
                                      // saleCycleController.categoryCodeController.value.clear();
                                      // saleCycleController.gstGrpCodeController.value.clear();
                                      // saleCycleController.hsnCodeController.value.clear();

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
      controller: saleCycleController.itemCodeController.value,
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
      controller: saleCycleController.nameController.value,
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

  Widget filterWithCategoryCode(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.categoryCodeController.value,
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
      controller: saleCycleController.gstGrpCodeController.value,
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
      controller: saleCycleController.hsnCodeController.value,
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

  Widget bindQuoteItemList(BuildContext context) {
    String productCategory = saleCycleController.quoteHeaderdata[0].productCategoryCode ?? "";
    String pipeProdCate = productCategory.replaceAll(', ', '|');

    if (saleCycleController.itemMstGetByQuoteIdList.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();

      /*scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int totalPage = (saleCycleController.total_rows / saleCycleController.rowsPerPage).ceil();

          print("last index ${saleCycleController.pageNumber} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${totalPage}");

          if (saleCycleController.pageNumber + 1 < totalPage) {
            saleCycleController.pageNumber += 1;
            saleCycleController.itemMstGetByQuoteIdApiHit(
                saleCycleController.pageNumber + 1,
                saleCycleController.quoteHeaderdata[0].quoteId,
                "",
                pipeProdCate
            );
          }
        }*/

        scrollController.addListener(() {
          print("ghdjhgf");
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {

            int total_page = (saleCycleController.total_rows /
                saleCycleController.rowsPerPage)
                .toInt();
            if ((saleCycleController.total_rows %
                saleCycleController.rowsPerPage) >
                0) total_page += 1;

            print(
                "last index ${saleCycleController.pageNumber} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");

            /*if (salesCycleController.pageNumber + 1 != total_page) {
            salesCycleController.getsalesCycleData(salesCycleController.pageNumber +1, "", "", "Sales");
            this.salesCycleController.pageNumber += 1;
          }*/

            if (saleCycleController.pageNumber + 1 < total_page) {
              saleCycleController.itemMstGetByQuoteIdApiHit(
                  saleCycleController.pageNumber + 1,
                  saleCycleController.quoteHeaderdata[0].quoteId,
                  "",
                  pipeProdCate
              );
              saleCycleController.pageNumber += 1;
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
        itemCount: saleCycleController.itemMstGetByQuoteIdList.value.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return bindPendingListView(context, index);
        },
      );
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );/*Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'No Record Found.',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
      );*/
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
                      .itemMstGetByQuoteIdList[index]
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
                value: saleCycleController.itemMstGetByQuoteIdList[index].isSelected==1?true:false,
                onChanged: (bool? value)  {
                   saleCycleController.toggleCheckbox(index);
                },
              );
            }),
          ],
        ),
        subtitle:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                                .itemMstGetByQuoteIdList[index]
                                .name?? "",
                            child: Text(
                              (saleCycleController
                                  .itemMstGetByQuoteIdList[index]
                                  .name?? "") ,
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
                                .itemMstGetByQuoteIdList[index]
                                .categoryName??"",
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Text(
                          saleCycleController
                              .itemMstGetByQuoteIdList[index]
                              .brandCode??"",
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
                          "BUOM: ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          saleCycleController
                              .itemMstGetByQuoteIdList[index]
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
                              .itemMstGetByQuoteIdList[index]
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
                              .itemMstGetByQuoteIdList[index]
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
                          //width: size.width*.12,
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .componentType??"",
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Flexible(
                          //width: size.width*.17,
                          child: Tooltip(
                            message:  saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .costPerUnit==0?"0":saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .costPerUnit.toString(),
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
                                  .costPerUnit==0?"0":saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Flexible(

                          child: Tooltip(
                            message:  saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .mrp.toString(),
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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
                   /* Row(
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
                          width: size.width*.2,
                          child: Tooltip(
                            message:  saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .standardCost.toString(),
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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
                          "Branch Transfer Price:",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: size.width*.05,
                          child: Tooltip(
                            message:  saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .branchTransferPrice.toString(),
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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
                        Text(
                          "Min. Acceptable price:",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: size.width*.05,
                          child: Tooltip(
                            message:saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .minimalAcceptablePrice.toString(),
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Flexible(

                          child: Tooltip(
                            message:saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .standardCost.toString(),
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Flexible(
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .active.toString() == '1'?'Yes':'No',
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Flexible(
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .isBulky.toString() == "1"?'Yes':'No',
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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

                        Flexible(
                          child: Tooltip(
                            message: saleCycleController
                                .itemMstGetByQuoteIdList[index]
                                .isExpiryMandatory.toString()=='1'?"Yes":'No',
                            child: Text(
                              saleCycleController
                                  .itemMstGetByQuoteIdList[index]
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
       /* Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  Text(
                    "Name : ",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.twelve,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    (saleCycleController
                        .itemMstGetByQuoteIdList[index]
                        .name?? "") ,
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.twelve,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Category Name : ",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.twelve,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    saleCycleController
                        .itemMstGetByQuoteIdList[index]
                        .categoryCode??"",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.twelve,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Brand Code : ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .brandCode??"",
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
                      "BUOM: ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .baseUnitOfMeasure??"",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                          .itemMstGetByQuoteIdList[index]
                          .gstGroupCode??"",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(

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
                          .itemMstGetByQuoteIdList[index]
                          .hsnCode??"",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Component Type: ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .componentType??"",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(

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
                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .costPerUnit==0?"0":saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .costPerUnit.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .mrp.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(

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
                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .active.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
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
                        Text(
                          saleCycleController
                              .itemMstGetByQuoteIdList[index]
                              .isBulky.toString(),
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
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
                    Text(
                      saleCycleController
                          .itemMstGetByQuoteIdList[index]
                          .isExpiryMandatory.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),




          ],
        ),*/
       /*trailing: Obx((){
          return Checkbox(
            value: saleCycleController.itemMstGetByQuoteIdList[index].isSelected==1?true:false,
            onChanged: (bool? value) {
             saleCycleController.toggleCheckbox(index);
            },
          );
        }),*/
      ),
    );
  }

  filterWithCategoryName(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.categoryNameController.value,
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






}



