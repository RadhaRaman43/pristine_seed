import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class UpdateBussinessTermPage extends StatelessWidget{
  UpdateBussinessTermPage({super.key});
  final saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
   /* print('term${saleCycleController.BusinessTerm.value}');
    if(saleCycleController.BusinessTerm.value == true){
      saleCycleController.installationChargesController.value.text = saleCycleController.quoteHeaderdata[0].installationCharges.toString();
      saleCycleController.otherChargesController.value.text = saleCycleController.quoteHeaderdata[0].otherCharges.toString();
      //saleCycleController.warrentyPeriodController.value.text = saleCycleController.quoteHeaderdata[0].warrantyPeriod.toString();
      //saleCycleController.deliveryWeeksController.value.text = saleCycleController.quoteHeaderdata[0].deliveryInWeeks.toString();
      saleCycleController.advncPaymentPerController.value.text = saleCycleController.quoteHeaderdata[0].advancePaymentPer.toString();
      saleCycleController.advncPaymentAmountController.value.text = saleCycleController.quoteHeaderdata[0].advancePaymentAmt.toString();
      saleCycleController.quoteRemarkController.value.text = saleCycleController.quoteHeaderdata[0].otherRemarks.toString();

    }else{
      saleCycleController.installationChargesController.value.clear();
      saleCycleController.otherChargesController.value.clear();
      //saleCycleController.warrentyPeriodController.value.clear();
      //saleCycleController.deliveryWeeksController.value.clear();
      saleCycleController.advncPaymentPerController.value.clear();
      saleCycleController.advncPaymentAmountController.value.clear();
      saleCycleController.quoteRemarkController.value.clear();
      saleCycleController.finalAmountController.value.clear();
    }*/
    return WillPopScope(onWillPop: () async {
      Get.toNamed(RoutesName.quoteInformationScreen);
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
                  'Business Term(${saleCycleController.quoteHeaderdata[0].quoteId.toString()})',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),

              ],
            )
        ),
        drawer: CustomDrawer(),
        body: Container(
          padding: EdgeInsets.only(bottom: 15),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5,),
                bindInstalationChagers(context),
                bindOthersChagers(context),
                bindWarrentyPeriod(context),
                bindDeliveryWeeksPeriod(context),
                bindAdvancPaymentPer(context),
                bindTotalPayment(context),
                bindAdvancPaymentAmt(context),
                bindFinalAmt(context),
                bindPendingAmt(context),
                bindTermCondition(context),
                bindRemarks(context),

            SizedBox(height: 10,),
            Visibility(
              visible: saleCycleController.BusinessTerm.value == true ? false : true,
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: DefaultButton(
                  press: (){
                    openConfirmationDialog(context,   'Do you want to send this Quote for Approval?', "");
                  },
                  text: "Submit",
                ),
              ),
            )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget bindInstalationChagers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: TextField(
        readOnly:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.installationChargesController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.currency_rupee),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Installation Charges',
            labelText: 'Installation Charges',
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
        onChanged: (text) {
          saleCycleController.calculateFinalAmt();
        },
      ),
    );
  }

  Widget bindOthersChagers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: TextField(
        readOnly:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.otherChargesController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.currency_rupee),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Other Charges',
            labelText: 'Other Charges',
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
        onChanged: (Text){
          saleCycleController.calculateFinalAmt();
        },
      ),
    );
  }

  Widget bindWarrentyPeriod(BuildContext context) {
    saleCycleController.warrentyPeriodController.value.text="12";
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
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
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
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

  Widget bindAdvancPaymentPer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: TextField(
        readOnly:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.advncPaymentPerController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.percent),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Advc. Payment Percentage',
            labelText: 'Advc. Payment Percentage',
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
        onChanged: (text) {
          checkPertageValue(context);
        },
      ),
    );
  }

  Widget bindTotalPayment(BuildContext context) {
    double totAmount = saleCycleController.quoteHeaderdata[0].quoteTotalAmount!;
    saleCycleController.quoteTotAmountController.value.text = totAmount.toString();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: TextField(
        readOnly:  true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.quoteTotAmountController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.currency_rupee),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Quote Amount',
            labelText: 'Quote Amount',
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
        onChanged: (text) {
          checkPertageValue(context);
        },
      ),
    );
  }

  Widget bindAdvancPaymentAmt(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Obx(() {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.advncPaymentAmountController.value,
          keyboardType: TextInputType.number,
          onChanged: (value){
            calculatePer();
          },

          decoration: InputDecoration(
              suffixIcon: Icon(Icons.currency_rupee),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Advc. Payment Amount',
              labelText: 'Advc. Payment Amount',
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
        );

      }),
    );
  }

  Widget bindFinalAmt(BuildContext context) {
   // double totAmount = saleCycleController.quoteHeaderdata[0].quoteTotalAmount!;
   // saleCycleController.finalAmountController.value.text = totAmount.toString();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Obx(() {
        return TextField(
          readOnly: true,
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.finalAmountController.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.currency_rupee),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Final Quote Amount',
              labelText: 'Final Quote Amount',
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
        );

      }),
    );
  }

  Widget bindPendingAmt(BuildContext context) {
    //double totAmount = saleCycleController.quoteHeaderdata[0].quoteTotalAmount!;
    //saleCycleController.pendingAmountController.value.text = totAmount.toString();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Obx(() {
        return TextField(
          readOnly: true,
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.pendingAmountController.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.currency_rupee),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Pending Quote Amount',
              labelText: 'Pending Quote Amount',
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
        );

      }),
    );
  }


  Widget bindRemarks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Obx(() {
        return TextField(
          maxLines: 2,
          maxLength: 500,
          readOnly:  saleCycleController.BusinessTerm.value,
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.quoteRemarkController.value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Remarks',
              labelText: 'Remarks',
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
        );

      }),
    );
  }

  checkPertageValue(BuildContext context) {
    final text = saleCycleController.advncPaymentPerController.value.text;
    final percentageValue = int.tryParse(text);
    if (percentageValue == null) {
      saleCycleController.advncPaymentAmountController.value.clear();
    } else if (percentageValue > 100) {
      Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
    } else if(percentageValue <= 100){
         final advanceAmt = (saleCycleController.quoteHeaderdata[0].quoteTotalAmount! * percentageValue) / 100;
         saleCycleController.advncPaymentAmountController.value.text = advanceAmt.toString();
         final parts=saleCycleController.advncPaymentAmountController.value.text.split('.');
         if(parts.length==2 && parts[1].length>4){
           String trimmed = '${parts[0]}.${parts[1].substring(0, 4)}';
           saleCycleController.advncPaymentAmountController.value.text=trimmed;
           saleCycleController.advncPaymentAmountController.value.selection =
               TextSelection.fromPosition(TextPosition(offset: trimmed.length));
         }
    }

    double? advcAmount = double.tryParse(saleCycleController.advncPaymentAmountController.value.text);
    double? finalAmount = double.tryParse(saleCycleController.finalAmountController.value.text);
    if (advcAmount == null) {
      advcAmount = 0.0;
    }
    double totAmount = finalAmount! - advcAmount;
    saleCycleController.pendingAmountController.value.text = totAmount.toString();
  }


  void openConfirmationDialog(BuildContext context, String message, String flag) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
              children: [
                Column(
                children: [
                  Text(
                      message
                      ,
                      style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1,
                      )),

                  SizedBox(height: 10),
                  Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();
                            },
                            child: Container(
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
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
                              saleCycleController.quoteBussinessTermlApiHit();
                              Get.back();
                            },
                            child: Container(
                              //width: 80,
                              //alignment: Alignment.center,
                              child: Text('Confirm',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          );

        });

  }

  Widget bindTermCondition(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Obx(() {
        return TextField(
          readOnly:  saleCycleController.BusinessTerm.value,
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.termConditionController.value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Term & Condition *',
              labelText: 'Term & Condition *',
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
        );

      }),
    );
  }

  void calculatePer() {
    if(saleCycleController.advncPaymentAmountController.value.text.isEmpty){
      saleCycleController.advncPaymentPerController.value.clear();
    }else{
      final text = double.parse(saleCycleController.advncPaymentAmountController.value.text);
      double percantage=0.0;
      if(saleCycleController.quoteTotAmountController.value.text.isNotEmpty){
        percantage=(text/double.parse(saleCycleController.quoteTotAmountController.value.text))*100;
        print("Percentage.${percantage}");
      }
      if(percantage<=100){
        saleCycleController.advncPaymentPerController.value.text = percantage.toStringAsFixed(2);

      }else{
        Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
      }

    }
  }
}