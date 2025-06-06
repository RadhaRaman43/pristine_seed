import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class UpdateQuoteLineDataScreen extends StatelessWidget{
  final saleCycleController=Get.put(SalesCycleVm());

  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    int indexForHeader=saleCycleController.index.value;
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.quoteInformationScreen);
        return false;
      },
      child: Scaffold(
        appBar:  AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title:Row(
              children: [
                Text(
                  'Update Quote Sr. No. ${indexForHeader+1}',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                /*Spacer(),

                ActionChip(
                  elevation: 2,
                  padding: EdgeInsets.all(1),
                  backgroundColor: AllColors.primaryDark1,
                  shadowColor: Colors.black,
                  shape: StadiumBorder(
                      side: BorderSide(color: AllColors.grayColor)),
                  //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                  //CircleAvatar
                  label: Tooltip(
                    message: "Update Quote",
                    child: Text('Update',
                        style: GoogleFonts.poppins(
                          color: AllColors.whiteColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  onPressed: () {
                    saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[saleCycleController.index.value].itemCode!, "Update" );


                  }, //Text
                ),*/
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [

              updateItemDescriptionLine(context),
              SizedBox(height: 10,),
              updateItemDescription2Line(context),
              SizedBox(height: 10,),
              updateqtyLine(context),
              SizedBox(height: 10,),
           //   updateUnitPrice(context),
              updateManualPriceLine(context),
              SizedBox(height: 10,),
              updateDiscountPerLine(context),
              SizedBox(height: 10,),
              updateDiscountAmount(context),
              SizedBox(height: 10,),
              GmDiscountAmount(context),
              SizedBox(height: 10,),
              SalesCreditAmount(context),
              SizedBox(height: 10,),
             /* updateTaxAmountLine(context),
              SizedBox(height: 10,),
              updateGrossAmountLine(context),*/
              /*SizedBox(height: 10,),
              bindWarrentyPeriod(context),
              SizedBox(height: 10,),
              bindDeliveryWeeksPeriod(context),*/
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: DefaultButton(
                  press: (){
                    saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[saleCycleController.index.value].itemCode!, "Update" );

                  },
                  text: "Update",
                ),
              ),
              //bindContactPersonName(context),


            ],
          ),
        ),
      ),
    );
  }



  Widget updateItemDescriptionLine(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15,),
      child: TextField(
        readOnly: true,
          /*onSubmitted: (value) {
            saleCycleController.quoteLineCreateFunction(
                saleCycleController.quoteLinedata[saleCycleController.index
                    .value].itemCode!, "Update");
          },*/
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.updateItemDescriptionController.value,
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
        )
    );
  }
  Widget updateManualPriceLine(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        onSubmitted: (value){
          saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[saleCycleController.index.value].itemCode!, "Update");
        },
        onChanged: (value) {
          final parts = value.split('.');
          if (parts.length == 2 && parts[1].length > 2) {
            String trimmed = '${parts[0]}.${parts[1].substring(0, 2)}';
            saleCycleController.updateManualPriceController.value.text = trimmed;
            saleCycleController.updateManualPriceController.value.selection =
                TextSelection.fromPosition(TextPosition(offset: trimmed.length));
          }
        },
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateManualPriceController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Manual Price',
            labelText: 'Manual Price',
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
      ),
    );
  }

  Widget updateDiscountPerLine(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, ),
      child: TextField(
        onSubmitted: (value){
          saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[saleCycleController.index.value].itemCode!, "Update");
        },
        onChanged: (value) {
          final parts = value.split('.');
          if (parts.length == 2 && parts[1].length > 4) {
            // Auto-trim to 4 digits after decimal
            String trimmed = '${parts[0]}.${parts[1].substring(0, 4)}';
            saleCycleController.updateDiscountPerController.value.text = trimmed;
            saleCycleController.updateDiscountPerController.value.selection =
                TextSelection.fromPosition(TextPosition(offset: trimmed.length));
          }
        },
        /*inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d{0,4}$'),
          ),
        ],*/
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateDiscountPerController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Seeking %',
            labelText: 'Seeking %',
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
      ),
    );
  }

  Widget updateqtyLine(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15,),
      child: TextField(
        onSubmitted: (value){
          saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[saleCycleController.index.value].itemCode!, "Update");
        },
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.qtyUpdateLineController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Qty',
            labelText: 'Qty',
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
      ),
    );
  }

  Widget updateUnitPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child:
          TextField(
            readOnly: true,
            cursorColor: AllColors.primaryDark1,
            controller: saleCycleController.updateUnitPriceController.value,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.two, horizontal: AllFontSize.ten),
                hintText: 'Unit Price',
                labelText: 'Unit Price',
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
          )
    );
  }

  Widget updateDiscountAmount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly:  true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateDiscountAmountController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Approved Discount %',
            labelText: 'Approved Discount %',
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
      ),
    );
  }





  Widget updateAmount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly: true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateAmountController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Amount',
            labelText: 'Amount',
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
      ),
    );
  }

  Widget GmDiscountAmount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly: true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.gmDiscountPerContoller.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Gm Discount %',
            labelText: 'Gm Discount %',
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
      ),
    );
  }

  Widget SalesCreditAmount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly: true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.salesCreditPerContoller.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Sales Credit %',
            labelText: 'Sales Credit %',
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
      ),
    );
  }

  updateTaxPerLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly: true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateTaxPerLineController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Tax %',
            labelText: 'Tax %',
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
      ),
    );
  }

  updateTaxAmountLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly: true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateTaxAmountLineController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Tax Amount',
            labelText: 'Tax Amount',
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
      ),
    );
  }

  updateGrossAmountLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly: true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateGrossAmountLineController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Gross Amount',
            labelText: 'Gross Amount',
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
      ),
    );
  }

 Widget bindWarrentyPeriod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.warrentyPeriodController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: Container(
              padding: EdgeInsets.only(right: 15, top: 10),
              child: Text('Months',
                style: GoogleFonts.poppins(
                  color: AllColors.blackColor,
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w500,
                ),),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Warranty Period',
            labelText: 'Warranty Period',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.fourtine),
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
      ),
    );
  }

  Widget bindDeliveryWeeksPeriod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.deliveryWeeksController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: Container(
              padding: EdgeInsets.only(right: 15, top: 10),
              child: Text('Weeks',
                style: GoogleFonts.poppins(
                  color: AllColors.blackColor,
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w500,
                ),),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Delivery In Weeks',
            labelText: 'Delivery In Weeks',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.fourtine),
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
      ),
    );
  }

  updateItemDescription2Line(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        onSubmitted: (value){
          saleCycleController.quoteLineCreateFunction(saleCycleController.quoteLinedata[saleCycleController.index.value].itemCode!, "Update");
        },
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.updateItemDescription2Controller.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Item Description',
            labelText: 'Item Description',
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
      ),
    );
  }



}