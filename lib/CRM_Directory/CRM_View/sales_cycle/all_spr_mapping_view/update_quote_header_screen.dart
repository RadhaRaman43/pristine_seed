import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../component/default_button.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../utils/app_utils.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class UpdateQuoteHeaderScreen extends StatelessWidget{
  final address_vm_controller = Get.put(Addressmastervm());
  final saleCycleController = Get.put(SalesCycleVm());
  Size size = Get.size;
  static String _displayCustomerNeedIdentityStatusForOption(String option) => option;

  static String _displayDecisionMakerForOption(String option) => option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                  "Update Quote Header",
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),

              ],
            )
        ),
        drawer: CustomDrawer(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      bindCharges(context),
                      SizedBox(height: 10),
                      bindShippingAddress(context),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 Fixed buttons at bottom
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        saleCycleController.quoteHeaderUpdateApiHit(saleCycleController.quoteHeaderdata[0].quoteId??"");
                        Get.back();
                      },
                      child: Container(
                        child: Text(
                          'Update Quote',
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget bindCharges(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AllColors.grayColor, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'General',
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          children: [

            updateQuoteValidity(context),
            const SizedBox(height: 10),
            updateExpectedClosureDate(context),
            const SizedBox(height: 10),

            Visibility(
              visible:
                saleCycleController.isAdminWritePermission == "1" ||
                saleCycleController.userType.toLowerCase() == "branch head" ||
                saleCycleController.userType.toLowerCase() == "cluster head" ||
                saleCycleController.userType.toLowerCase() == "general manager",
              child: Column(
                children: [
              bindInputData(context,'Installation Charges',saleCycleController.installationChargesController.value,Icon(Icons.currency_rupee)),
              const SizedBox(height: 10),
              bindInputData(context,'Other Charges',saleCycleController.otherChargesController.value,Icon(Icons.currency_rupee)),
              const SizedBox(height: 10),
              bindInputData(context,'Warranty Period',saleCycleController.warrentyPeriodController.value,Container(padding: EdgeInsets.only(right: 15, top: 10),
              child: Text('Months', style: GoogleFonts.poppins(color: AllColors.blackColor, fontSize: AllFontSize.sisxteen, fontWeight: FontWeight.w500,),),)),
             const SizedBox(height: 10),
              bindInputData(context,'Delivery In Weeks',saleCycleController.deliveryWeeksController.value,Container(padding: EdgeInsets.only(right: 15, top: 10),
              child: Text('Weeks', style: GoogleFonts.poppins(color: AllColors.blackColor, fontSize: AllFontSize.sisxteen, fontWeight: FontWeight.w500,),),)),
               const SizedBox(height: 10),
              bindInputData(context,'Advc. Payment Percentage',saleCycleController.advncPaymentPerController.value,Icon(Icons.percent)),
              const SizedBox(height: 10),
              bindInputData(context,'Advc. Payment Amount',saleCycleController.advncPaymentAmountController.value,Icon(Icons.currency_rupee)),
              const SizedBox(height: 10),
              bindInputData(context,'Quote Amount',saleCycleController.quoteTotAmountController.value,Icon(Icons.currency_rupee)),
              const SizedBox(height: 10),
              bindInputData(context,'Final Quote Amount',saleCycleController.finalAmountController.value,Icon(Icons.currency_rupee)),
              const SizedBox(height: 10),
              bindInputData(context,'Pending Quote Amount',saleCycleController.pendingAmountController.value,Icon(Icons.currency_rupee)),
              const SizedBox(height: 10),
              bindTermCondition(context),
              const SizedBox(height: 10),
                ],
              ),
            ),

            bindActive(context),
            const SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
  Widget updateQuoteValidity(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.updateQuoteValidityController.value,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Quote Validity',
              labelText: 'Quote Validity',
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          onTap: () async {
            DateTime? initialDate;
            if (saleCycleController
                .updateQuoteValidityController.value.text.isNotEmpty) {
              initialDate = DateFormat('yyyy-MM-dd').parse(
                saleCycleController.updateQuoteValidityController.value.text,
              );
              // Ensure initialDate is not before firstDate
              if (initialDate.isBefore(DateTime.now())) {
                initialDate = DateTime.now();
              }
            } else {
              initialDate = DateTime.now();
            }
            DateTime ending_date = new DateTime(2200);
            FocusScope.of(context).requestFocus(new FocusNode());
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime.now(),
              lastDate: ending_date,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor:
                    AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme:
                    ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.updateQuoteValidityController.value.text =
                  outputFormat.format(date);
            /* else
              saleCycleController.updateQuoteValidityController.value.text = "";*/
          }),
    );
  }

  Widget updateExpectedClosureDate(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
          cursorColor: AllColors.primaryDark1,
          controller:
          saleCycleController.updateExpectedClosureDateController.value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              suffixIcon: Icon(Icons.calendar_month),
              hintText: 'Expected Closure Date',
              labelText: 'Expected Closure Date',
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          onTap: () async {
            DateTime? initialDate;
            if (saleCycleController
                .updateExpectedClosureDateController.value.text.isNotEmpty) {
              initialDate = DateFormat('yyyy-MM-dd').parse(
                saleCycleController
                    .updateExpectedClosureDateController.value.text,
              );
              // Ensure initialDate is not before firstDate
              if (initialDate.isBefore(DateTime.now())) {
                initialDate = DateTime.now();
              }
            } else {
              initialDate = DateTime.now();
            }
            DateTime ending_date = new DateTime(2200);
            FocusScope.of(context).requestFocus(new FocusNode());
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime.now(),
              lastDate: ending_date,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor:
                    AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme:
                    ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.updateExpectedClosureDateController.value
                  .text = outputFormat.format(date);
            /*else
              saleCycleController.updateExpectedClosureDateController.value.text = "";*/
          }),
    );
  }

  bindInputData(BuildContext context,String levelText, TextEditingController controller, Widget suffixIcon) {
    if(levelText=="Warranty Period"){
      controller.text='12';
    }
    else if(levelText=="Quote Amount"){
      double totAmount = saleCycleController.quoteHeaderdata[0].quoteTotalAmount!;
      //saleCycleController.quoteTotAmountController.value.text = totAmount.toString();
      controller.text = totAmount.toString();
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        readOnly:levelText=="Quote Amount" || levelText=='Pending Quote Amount' ||
            levelText=='Final Quote Amount'?true:  saleCycleController.BusinessTerm.value,
        cursorColor:AllColors.primaryDark1 ,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: levelText,
            labelText: levelText,
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

          if(levelText=='Installation Charges' ||levelText=='Other Charges'){
            saleCycleController.calculateFinalAmt();
          }
          if(levelText=='Advc. Payment Amount'){
            calculatePer();
          }
          if(levelText=='Advc. Payment Percentage' || levelText=='Quote Amount'){
            checkPertageValue(context);
          }


        },
      ),
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
      }else if(text>100){
        Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
      }
      /*else{
        Utils.showErrorToastification('Error', 'Payment Percentage cannot be greater than 100');
      }*/

    }
  }
  checkPertageValue(BuildContext context) {
    final text = saleCycleController.advncPaymentPerController.value.text;
    final percentageValue = int.tryParse(text);
    if (percentageValue == null) {
      saleCycleController.advncPaymentAmountController.value.clear();
    } else if (percentageValue > 100) {
      print("hhhh${percentageValue}");
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
  Widget bindTermCondition(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),

      child: Obx(() {
        return TextField(
          readOnly:  saleCycleController.BusinessTerm.value,
          cursorColor: AllColors.primaryDark1,
          controller: saleCycleController.termConditionController.value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Term & Condition',
              labelText: 'Term & Condition',
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

  Widget bindActive(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownMenu<String>(
        width: size.width ,
        controller: saleCycleController.activeController.value,
        label: Text("Active",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        //enabled: saleCycleController.quoteHeaderdata[0].isReadySendForApproval != 1 ? false : true,
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.activeController.value.text = _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        },
        dropdownMenuEntries: saleCycleController.customerNeedIdentityList
            .map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e,
              label: e!,
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(AllColors.primaryDark1),
              ));
        }).toList(),
      ),
    );
  }

  Widget bindShippingAddress(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AllColors.grayColor, // Set the border color here
          width: 1.0, // Adjust the border width if necessary
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Shipping Address',
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child:Obx((){
         return  Column(
            children: [
              bindShippingAddressConfirmation(context),
              const  SizedBox(height: 15,),
             Visibility(
                  visible: saleCycleController.isVisibiltyShippingAddressQuote.value,
                  child: Column(
                    children: [
                      bindShippinbAddressData(context,"Address",saleCycleController.shippingController.value),
                      /*  Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  readOnly: true,
                  controller: saleCycleController.shippingController.value,
                  decoration: InputDecoration(
                      hintText: "Address",
                      labelText: "Address",
                      //suffixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                            ),*/
                      const SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller:
                          saleCycleController.shippingAddress2Controller.value,
                          decoration: InputDecoration(
                              hintText: "Address 2",
                              labelText: "Address 2",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          controller:
                          saleCycleController.Shipping_PostCode_Controller.value,
                          decoration: InputDecoration(
                              hintText: "Pin Code",
                              labelText: "Pin Code",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: saleCycleController.Shipping_City_Controller.value,
                          decoration: InputDecoration(
                              hintText: "City",
                              labelText: "City",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          readOnly: true,
                          controller:
                          saleCycleController.Shipping_District_Controller.value,
                          decoration: InputDecoration(
                              hintText: "District",
                              labelText: "District",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: saleCycleController.Shipping_State_Controller.value,
                          decoration: InputDecoration(
                              hintText: "State",
                              labelText: "State",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DefaultButton(
                              press:(){
                                address_vm_controller.FromPage.value="SalesCycleQuotation";
                                address_vm_controller.clearController();
                                address_vm_controller.account_code_controller.text=saleCycleController.quoteHeaderdata[0].accountCode??"";
                                address_vm_controller.account_name_controller.text=saleCycleController.quoteHeaderdata[0].accountName??"";
                                address_vm_controller.GstRegistration.value=false;
                                address_vm_controller.getGeoPostalCodeApi(50, '');
                                Get.toNamed(RoutesName.addNewAddress_screen);
                              },
                              text:
                              'Add New',
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: DefaultButton(
                              press: (){
                                saleCycleController.pageNumber = 0;
                                saleCycleController.getAddressMasterList(
                                    saleCycleController.pageNumber,
                                    saleCycleController.accountCode.value);
                                saleCycleController.showConsigneeAddressList(
                                    context, saleCycleController.address_master_list,saleCycleController.accountCode.value);
                              },
                              text: 'Change ',

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )



            ],
          );
        })


      ),
    );
  }
  bindShippinbAddressData(BuildContext context, String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: hintText,
            //suffixIcon: Icon(Icons.email),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  bindShippingAddressConfirmation(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width,
        controller: saleCycleController.updateQuoteShippingAddressConfirmation.value,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.updateQuoteShippingAddressConfirmation.value.text =
              _displayDecisionMakerForOption(selection!).toString();
          saleCycleController.isVisibiltyShippingAddressQuote.value =
              selection == 'Yes';
        },
        dropdownMenuEntries: saleCycleController.customerNeedIdentityList
            .map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e,
              label: e!,
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(AllColors.primaryDark1),
              ));
        }).toList(),
      ),
    );
  }

}