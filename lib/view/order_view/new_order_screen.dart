import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';
import 'package:navigation_drawer_flutter/viewModel/order_vm/order_vm.dart';

import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/order_model/consignee_Model.dart';
import '../../models/order_model/customer_model.dart';

class NewOrderScreen extends StatelessWidget {
  NewOrderScreen({super.key});

  final new_order_page_controller = Get.put(OrderViewModel());
  Size size = Get.size;

  static String _displaybillToCustomerForOption(CustomersModel option) =>
      option.customerName!;

  static String _displayConsigneeForOption(ConsigneeModel option) =>
      option.name!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'New Order',
              style: GoogleFonts.poppins(
                color: AllColors.whiteColor,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700,
              ),
            ),
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
            return Visibility(
              visible: new_order_page_controller.loading.value ? true : false,
              child: Container(
                margin: EdgeInsets.only(top: 0.5),
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.primaryDark1,
                  color: AllColors.textColor,
                ),
              ),
            );
          }),
          Expanded(
              child: ListView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 12),
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Visibility(
                        visible: new_order_page_controller.isShowDropDown.value,
                        child: bindBillToCustomerDropDown(context));
                  }),

                  Obx(() {
                    return Visibility(
                        visible: new_order_page_controller
                            .isShowCustomerDetails.value,
                        child: bindCustomerDetails(context));
                  }),

                  Obx(() {
                    return Visibility(
                      visible:
                          new_order_page_controller.isShowCustomerDetails.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Checkbox(
                              value: new_order_page_controller
                                  .isCheckBoxChecked.value,
                              activeColor: AllColors.primaryDark1,
                              onChanged: (value) {
                                new_order_page_controller
                                    .isCheckBoxChecked.value = value ?? false;
                                new_order_page_controller.getConsignee(
                                    new_order_page_controller
                                        .selected_customer.value.customerNo!);
                              },
                            );
                          }),
                          Text(
                            'Ship to Address is different',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w700,
                              fontSize: AllFontSize.fourtine,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

//todo ship to address Dropdown Widget
                  Obx(
                    () => Visibility(
                      visible: new_order_page_controller.isCheckBoxChecked.value,
                      child: bindConsigneeDropDown(context),
                    ),
                  ),
                  SizedBox(height: 8),
                  bindDatePicker(context),
                  SizedBox(height: 8),
                  bindDatePickerExpiry(context),
                  SizedBox(height: size.height * .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Expanded(
                          child: DefaultButton(
                            text: "Submit",
                            press: () {
                              //  new_order_page_controller.screen_change="";
                              new_order_page_controller
                                  .orderHeaderCreate('order');
                            },
                            loading: new_order_page_controller.loading.value,
                          ),
                        );
                      }),
                      SizedBox(width: size.width * .01),
                      Expanded(
                        child: DefaultButton(
                          text: "Reset",
                          press: () {
                            new_order_page_controller.resetAllNewOrderFields();
                          },
                          //loading: pageController.loading.value,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ))
        ],
      )),
    );
  }

  Widget bindBillToCustomerDropDown(context) {
    return Autocomplete<CustomersModel>(
      displayStringForOption: _displaybillToCustomerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          new_order_page_controller.isShowCustomerDetails.value = false;
          new_order_page_controller.customers_controller.clear();
          new_order_page_controller
              .isCheckBoxChecked.value=false;
         // FocusScope.of(context).unfocus();

          return [];
        }

        return await new_order_page_controller
            .searchCustomer(textEditingValue.text);
      },
      onSelected: (CustomersModel selection) {
        new_order_page_controller.isShowCustomerDetails.value = true;
        new_order_page_controller.isShowCheck.value = true;
        new_order_page_controller.selected_customer.value = selection;
        new_order_page_controller.customers_controller.text =
            _displaybillToCustomerForOption(selection).toString();
        new_order_page_controller.order_expiry_date_controller.text =
            new_order_page_controller
                .getCurrentExpryDate(selection.expiryNoOfDays!);
        FocusScope.of(context).unfocus();
        /*print(selection.name);
        print(selection.customerNo);*/
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = new_order_page_controller.customers_controller.text,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Bill-to-Customer',
            labelText: 'Bill-to-Customer',
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
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CustomersModel> onSelected,
          Iterable<CustomersModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final CustomersModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.customerName.toString(),
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
    );
  }

  Widget bindCustomerDetails(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          new_order_page_controller.selected_customer.value.customerAddress
              .toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          new_order_page_controller.selected_customer.value.customerState
                  .toString() +
              " (" +
              new_order_page_controller
                  .selected_customer.value.customerStateCode
                  .toString() +
              " )",
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        /*Text(
          new_order_page_controller.selected_customer.value.countryName.toString() +
              " (" +
              new_order_page_controller.selected_customer.value.countryCode.toString() +
              " )," +
              new_order_page_controller.selected_customer.value.postCode.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),*/
        SizedBox(height: 4.0),

        /*Text(
          'GST:${new_order_page_controller.selected_customer.value.gs
              .toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Credit Limit: Rs. ${new_order_page_controller.selected_customer.value
              .creditLimit.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Outstanding: Rs. ${new_order_page_controller.selected_customer.value
              .currentOutstanding.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.redColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),*/
      ],
    );
  }

  //todo date picker
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: new_order_page_controller.order_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Date",
        labelText: 'Date',
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
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          new_order_page_controller.order_date_controller.text =
              outputFormat.format(date);
        else
          new_order_page_controller.order_date_controller.text = "";
      },
    );
  }

  Widget bindDatePickerExpiry(context) {
    return TextFormField(
      controller: new_order_page_controller.order_expiry_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Expiry Date",
        labelText: 'Expiry Date',
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
      /* onTap: () async {
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
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          new_order_page_controller.order_expiry_date_controller.text =
              outputFormat.format(date);
        else
          new_order_page_controller.order_expiry_date_controller.text = "";
      },*/
    );
  }


  Widget bindConsigneeDropDown(context) {
    return Autocomplete<ConsigneeModel>(
      displayStringForOption: _displayConsigneeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
         // new_order_page_controller.isShowConsigneeDetails.value = false;
          return new_order_page_controller.consignee_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return new_order_page_controller.consignee_list
            .where((ConsigneeModel option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ConsigneeModel selection) {
        print(selection.name);
      //  new_order_page_controller.isShowConsigneeDetails.value = true;
       // new_order_page_controller.selected_consignee.value = selection;
        new_order_page_controller.consignee_name_drop_down_controller.text=
            _displayConsigneeForOption(selection).toString();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = new_order_page_controller.consignee_name_drop_down_controller.text,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Consignee Name',
            labelText: 'Consignee Name',
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
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ConsigneeModel> onSelected,
          Iterable<ConsigneeModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ConsigneeModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.name.toString(),
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
    );
  }
}
