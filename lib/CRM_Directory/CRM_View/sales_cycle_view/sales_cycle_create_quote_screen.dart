
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class SalesCycleCreateQuoteScreen extends StatelessWidget{
  final saleCycleController=Get.put(SalesCycleVm());
  final address_vm_controller = Get.put(Addressmastervm());
  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;
  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        saleCycleController.quoteValidityController.value.clear();
        saleCycleController.expectedClosuredateController.value.clear();
        saleCycleController.productCategoryController.value.clear();
        saleCycleController.shippingController.value.clear();
        saleCycleController.shippingAddress2Controller.value.clear();
        saleCycleController.accountNameController.value.clear();
        saleCycleController.contactNameController.value.clear();
        Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
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
                 'Add Quote(${saleCycleController.saleCycleList[0].salesCycleId})',
                 style: GoogleFonts.poppins(
                   color: AllColors.whiteColor,
                   fontSize: 18.0,
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
                bindAccountName(context),
                SizedBox(height: 10,),
                bindContactName(context),
                SizedBox(height: 10,),
                bindApprovalStatus(context),
                SizedBox(height: 10,),
                bindQuotevalidity(context),
                SizedBox(height: 10,),
                bindExpectedClosureDate(context),
                SizedBox(height: 10,),
                bindKindAttention(context),
                SizedBox(height: 10,),
                bindProductCategoryDropDown(context),
                SizedBox(height: 10,),

                Obx(() {
                  return
                    Wrap(
                      spacing: 8.0,
                      children: saleCycleController.itemCategorySelectedlist
                          .map((category) {
                        return Chip(
                          label: Text(category.categoryName!),
                          onDeleted: () {
                            saleCycleController.itemCategorySelectedlist.remove(
                                category);
                          },
                        );
                      }).toList(),
                    );

                }),
                SizedBox(height: 10,),
               /* bindQuoteCommitName(context),
                SizedBox(height: 10,),*/
                bindShippingAddress(context),
                SizedBox(height: 10,),
                 Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: DefaultButton(
                    press: (){
                      saleCycleController.saleCycleQuoteCreate(saleCycleController.saleCycleList[0].salesCycleId!);
                       //saleCycleController.accountNameController.value.clear();
                      //saleCycleController.contactNameController.value.clear();

                    },
                    text: "Add Quote",
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: DefaultButton(
                    press: (){
                      address_vm_controller.FromPage.value="AddQuote";
                      address_vm_controller.clearController();
                      address_vm_controller.account_code_controller.text=saleCycleController.saleCycleList[0].accountCode??"";
                      address_vm_controller.account_name_controller.text=saleCycleController.saleCycleList[0].accountName??"";
                      address_vm_controller.gst_registration_type_controller.value.text = 'UnRegistered';
                      address_vm_controller.getGeoPostalCodeApi();
                      Get.toNamed(RoutesName.addNewAddress_screen);
                    },
                    text: "Add New Address",
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: DefaultButton(
                    press: (){
                     // address_vm_controller.clearController();
                      saleCycleController.pageNumber = 0;
                      saleCycleController.getAddressMasterList(saleCycleController.pageNumber,saleCycleController.accountCode.value);
                      saleCycleController.showConsigneeAddressList(context, saleCycleController.address_master_list,saleCycleController.accountCode.value);


                    },
                    text: "Change Address",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bindKindAttention(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15,),
      child: TextField(
        onChanged: (value){
          final words = value.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).toList();

          if (words.length > 500) {
            final limitedText = words.take(500).join(' ');
            saleCycleController.kindAttentionController.value.text = limitedText;
            saleCycleController.kindAttentionController.value.selection =
                TextSelection.fromPosition(TextPosition(offset: limitedText.length));
          }
        },
        maxLength: 500,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.kindAttentionController.value,

        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Kind Attention*',
            labelText: 'Kind Attention*',
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

  Widget bindAccountName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: TextField(
        readOnly:  true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.accountNameController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Account Name',
            labelText: 'Account Name',
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

  Widget bindContactName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly:  true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.contactNameController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Contact Name',
            labelText: 'Contact Name',
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

  Widget bindApprovalStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        readOnly:  true,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.ApprovalStatusController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Approval Status',
            labelText: 'Approval Status',
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

  Widget bindShippingAddress(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      //color: AllColors.Card1Color,
      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        //color: AllColors.Card2Color, // Set the inside color here
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
            borderSide: BorderSide(

            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .shippingController.value,
                decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "Address",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .shippingAddress2Controller.value,
                decoration: InputDecoration(
                    hintText: "Address 2 ",
                    labelText: "Address 2 ",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                controller: saleCycleController
                    .Shipping_PostCode_Controller.value,
                decoration: InputDecoration(
                    hintText: "Pin Code",
                    labelText: "Pin Code",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_City_Controller.value,
                decoration: InputDecoration(
                    hintText: "City",
                    labelText: "City",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_District_Controller.value,
                decoration: InputDecoration(
                    hintText: "District",
                    labelText: "District",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_State_Controller.value,
                decoration: InputDecoration(
                    hintText: "State",
                    labelText: "State",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            /*SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_phone_Controller.value,
                decoration: InputDecoration(
                    hintText: "Phone No.",
                    labelText: "Phone No.",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),

            SizedBox(height: 15,),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              //padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                readOnly: true,
                controller: saleCycleController
                    .Shipping_email_Controller.value,
                decoration: InputDecoration(
                    hintText: "Email Id",
                    labelText: "Email Id",
                    //suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten,
                        horizontal: AllFontSize.ten),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ),*/


          ],
        ),
      ),
    );

  }

 Widget bindQuotevalidity(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(left: 15, right: 15),
     child: TextField(
       cursorColor:AllColors.primaryDark1 ,
       controller: saleCycleController.quoteValidityController.value,
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               vertical: AllFontSize.two, horizontal: AllFontSize.ten
           ),
           suffixIcon: Icon(Icons.calendar_month),
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
           )
       ),
       onTap: () async {
         DateTime? initialDate;
         if (saleCycleController.quoteValidityController.value.text.isNotEmpty) {
           initialDate = DateFormat('yyyy-MM-dd').parse(
             saleCycleController.quoteValidityController.value.text,
           );
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
                   primaryColor: AllColors.primaryDark1, // Header background color
                   //accentColor: AllColors.primaryDark1, // Color of the buttons
                   colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                   buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                 ),
                 child: child!,
               );
             },

           );
           var outputFormat = DateFormat('yyyy-MM-dd');
           if (date != null && date != "")
             saleCycleController.quoteValidityController.value.text= outputFormat.format(date);
           else
             saleCycleController.quoteValidityController.value.text = "";
         }

     ),
   );
 }

  Widget bindExpectedClosureDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.expectedClosuredateController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
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
            )
        ),
        onTap: () async {
          DateTime? initialDate;
          if (saleCycleController.expectedClosuredateController.value.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
                saleCycleController.expectedClosuredateController.value.text,
            );
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
                    primaryColor: AllColors.primaryDark1, // Header background color
                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                    colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },

            );
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              saleCycleController.expectedClosuredateController.value.text= outputFormat.format(date);

          }



      ),
    );
  }

 /*Widget bindContactPersonName(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(left: 15.0, right: 15),
     child: TextField(
       cursorColor:AllColors.primaryDark1 ,
       controller: saleCycleController.contactQuoteCommitController.value,
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               vertical: AllFontSize.two, horizontal: AllFontSize.ten),
           hintText: 'Quote Commit',
           labelText: 'Quote Commit',
           hintStyle: GoogleFonts.poppins(
               color: AllColors.lightblackColor,
               fontWeight: FontWeight.w300,
               fontSize: AllFontSize.ten),
           labelStyle: GoogleFonts.poppins(
               color: AllColors.primaryDark1,
               fontWeight: FontWeight.w700,
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
 }*/

  Widget bindQuoteCommitName(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0),
      width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width-30,
        controller: saleCycleController.contactQuoteCommitController.value,
        label: Text(
          "Quote Commit",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
          saleCycleController.contactQuoteCommitController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();

        },
        dropdownMenuEntries:
        saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  Widget bindProductCategoryDropDown(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Autocomplete<ItemCategoryMstModel>(
        displayStringForOption: _displayItemCatMasterForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return saleCycleController.productCategoryList.value;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return saleCycleController.productCategoryList
              .where((ItemCategoryMstModel option) {
            return option.categoryName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (ItemCategoryMstModel selection) {
          saleCycleController.productCategoryController.value.text =
              _displayItemCatMasterForOption(selection).toString();
          if (!saleCycleController.itemCategorySelectedlist.contains(selection)) {
            saleCycleController.itemCategorySelectedlist.add(selection);
            //Utils.showToastification('Success', 'Add Successfully');
          }else{
            Utils.showErrorToastification('Error', 'Already Selected');
          }
          print("list${saleCycleController.itemCategorySelectedlist.length}");

        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: (){
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = saleCycleController.productCategoryController.value.text,
            focusNode: focusNode,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: (){
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Product Category',
              labelText: 'Product Category',

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
                )
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
            Iterable<ItemCategoryMstModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.7,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final ItemCategoryMstModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.categoryName.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize
                                  .sisxteen // Change the text color here
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}