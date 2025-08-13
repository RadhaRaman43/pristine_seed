import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_competitor_product_infor_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class SalesCycleCompetitorProductInforScreen extends StatelessWidget{
  SalesCycleCompetitorProductInforScreen({super.key});
  final saleCycleController=Get.put(SalesCycleCompetitorProductInforVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.homeScreen);
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
                      'Sales Cycle Competitor List',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                /*GestureDetector(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(Icons.filter_alt_sharp, color: AllColors.whiteColor,),
                    ),
                  ),
                  onTap: (){
                    showDialogForFilter(context);
                  },
                ),*/
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
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

 /* void showDialogForFilter(BuildContext context) {
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
  }*/

/*  Widget filterWithItemCode(BuildContext context) {
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
  }*/

  Widget bindQuoteItemList(BuildContext context) {
    if (saleCycleController.salesCycleCompetitorProductInformationList.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();
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

          if (saleCycleController.pageNumber + 1 < total_page) {
            saleCycleController.getGalesCycleCompetitorProductInformationGet(
                saleCycleController.pageNumber+1
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
        itemCount: saleCycleController.salesCycleCompetitorProductInformationList.value.length,
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



  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
    Color color = AllColors.textColor,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        /* width != null
            ? Container(
          width: width,
          child: Tooltip(
            message: value ?? "",
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
        )
            :*/ Flexible(
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



  Widget _buildClickableLabel({
    required String label,
    required String? value,
    required VoidCallback onTap,
    double? width,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            child: Tooltip(
              message: value ?? "",
              child: Text(
                value ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bindPendingListView(BuildContext context, int position) {
    var createdOn=StaticMethod.formatDateWithTime(saleCycleController
        .salesCycleCompetitorProductInformationList[position]
        .createdOn??"");
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
                        .salesCycleCompetitorProductInformationList[position]
                        .itemCode??"",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        subtitle: Column(
          children: [

            _buildLabelWithValue(
              label: "Sales Cycle Id: ",
              value:saleCycleController
                  .salesCycleCompetitorProductInformationList[position].salesCycleId,
            ),
            /*_buildLabelWithValue(
              label: "Task Id : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].taskId,
              //width: size.width * 0.36,
            ),*/
            /*_buildLabelWithValue(
              label: "Quote Accepted: ",
              value: salesCycleController.saleCycleList[position].quoteAccepted,
              color: getQouteAcceptedColor(saleQuoteAccepted),
            ),*/
            /*_buildLabelWithValue(
              label: "Approval Status : ",
              value: salesCycleController.saleCycleList[position].salesCycleApprovalStatus,
              // width: size.width * 0.36,
              color: getStatusColor(saleCycleStatus),
            ),*/
            _buildLabelWithValue(
              label: "Line Status : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].lineStatus,
              //width: size.width * 0.33,
              color: Colors.blue,
            ),
            _buildClickableLabel(
              label: "Customer Name : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].accountName,
              width: size.width * 0.4,
              onTap: () {
                /*account_vm_controller.view = 'FromSaleCycleMainScreen';
                contact_vm_controller.view = 'FromSaleCycleMainScreen';
                account_vm_controller.getAccMasterBuyCodeApi(
                  salesCycleController.saleCycleList[position].accountCode!,
                );*/
              },
            ),
            _buildLabelWithValue(
              label: "Customer Code : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].accountCode,
              //width: size.width * 0.4,
            ),

            _buildLabelWithValue(
              label: "Product Category : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].productCategory,
              //width: size.width * 0.35,
            ),

            _buildLabelWithValue(
              label: "Qty : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].qty.toString(),
              //width: size.width * 0.3,
            ),
            _buildLabelWithValue(
              label: "Item Code : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].itemCode,
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Item Description : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].itemDescription,
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Unit Price : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].unitPrice.toString(),
            ),

            _buildLabelWithValue(
              label: "Mrp Price : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].mrpPrice.toString(),
            ),

            _buildLabelWithValue(
              label: "Methodex Price : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].methodexPrice.toString(),
              //width: size.width * 0.35,
            ),
            _buildLabelWithValue(
              label: "Competitor Name : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].competitorName,
              //width: size.width * 0.35,
            ),
            _buildLabelWithValue(
              label: "Competitor Price : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].competitorPrice.toString(),
              //width: size.width * 0.35,
            ),
            _buildLabelWithValue(
              label: "Created By : ",
              value: saleCycleController
                  .salesCycleCompetitorProductInformationList[position].createdFullName,
              //width: size.width * 0.33,
            ),
            _buildLabelWithValue(
              label: "Created On : ",
              value: createdOn,
              //width: size.width * 0.4,
            ),
          ],
        ),
      ),
    );
  }

/*  filterWithCategoryName(BuildContext context) {
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
  }*/






}



