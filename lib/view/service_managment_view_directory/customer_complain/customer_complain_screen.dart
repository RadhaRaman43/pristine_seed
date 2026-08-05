import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_address_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_item_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_serial_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/select_customer_complain_modal.dart';
import '../../../models/service_managment_model_directory/reasonModel/reason_master_response.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/service_managment_vm_directory/customer_complain_vm/customer_complain_vm.dart';
import '../../custom_drawer.dart';

class CustomerComplainScreen extends StatelessWidget{

  final customer_complain_vm = Get.put(CustomerComplainVm());
  Size size = Get.size;

  static String _displayReasonCodeForOption(ReasonModel option) =>
      option.reasonCode!;

  static String _displaySelectCustomerForOption(SelectCustomerComplainModal option) =>
      option.customerno!;
  static String _displaySelectAddressForOption(ComplainAddressModal option) =>
      option.customeraddress!;

  static String _displaySelectItemNameForOption(ComplainItemModal option) =>
      option.itemno!;

  static String _displaySelectSerialNoForOption(ComplainSerialModal option) =>
      option.serialno!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.complain_customer_page);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Customer Complaint List',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.eighteen,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Obx((){
                return  IconButton(onPressed: () {
                  //customer_complain_vm.getSelectCustomerFilter("");
                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp,color: customer_complain_vm.filter_color.value? AllColors.redColor:AllColors.whiteColor,));

              })
            ],
          ),

          iconTheme: IconThemeData(
            color: AllColors.whiteColor, // Change this to the desired color
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body:  Container(
          child: Column(
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(top: 0.3),
                  child: Visibility(
                    visible: customer_complain_vm.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  ),
                );
              },),

              SizedBox(height: 3,),
              Obx(() {
                return BindCustomerListView(context);
              }),
            ],
          ),
        ),

      ),
    );
  }

  Widget BindCustomerListView(context) {
    ScrollController scrollController = ScrollController();
    if (customer_complain_vm.filter_list.value.isNotEmpty &&
        customer_complain_vm.filter_list.value.length > 0){
      scrollController.addListener(() {
        print("rmgfrnrnknkvb");

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (customer_complain_vm.total_rows /
              customer_complain_vm.rowsPerPage)
              .toInt();
          if ((customer_complain_vm.total_rows %
              customer_complain_vm.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${customer_complain_vm.pageNumber} ${customer_complain_vm.total_rows} ${customer_complain_vm.rowsPerPage} ${total_page}");

          if (customer_complain_vm.pageNumber + 1 != total_page) {
            customer_complain_vm.getCompListFilter();
            this.customer_complain_vm.pageNumber += 1;
          }
        }
      });
      return Expanded(
        child: ListView.separated(
            controller:scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),
            shrinkWrap: true,
            itemCount: customer_complain_vm.filter_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindCustomerRequestListView(context, index);
            }),
      );
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset(
          "assests/images/no_data_remove.png",
          width: 300,
          height: 180,
        ),
      );

    }
  }
  Widget

  BindCustomerRequestListView(BuildContext context, int index) {
    var service_tat_date=StaticMethod.convertDateFormat1(customer_complain_vm.filter_list[index].completedon??"");
    return ListTile(
      contentPadding: EdgeInsets.only(left: 5, right: 10),
      onTap: (){
        customer_complain_vm.getAllComplain(customer_complain_vm.filter_list[index].id!);
        raiseAndShowComplainBottomSheet(context,customer_complain_vm.filter_list[index].id!);
      },
      subtitle: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Service No. :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Text(
                customer_complain_vm
                    .filter_list[index].serviceno!,
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.end,
              ),
              Spacer(),
              Text(service_tat_date?? "",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.end,),
            ],
          ),
          SizedBox(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Customer Name :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message:"${customer_complain_vm.filter_list[index].customername!} (${customer_complain_vm.filter_list[index].customerno!})",
                  child: Text("${customer_complain_vm.filter_list[index].customername!} (${customer_complain_vm.filter_list[index].customerno!})",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    // textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Invoice No. :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message: customer_complain_vm.filter_list[index].invoiceno ??"",
                  child: Text(
                    customer_complain_vm.filter_list[index].invoiceno ??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Serial No. :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message: customer_complain_vm.filter_list[index].serialno ??"",
                  child: Text(
                    customer_complain_vm.filter_list[index].serialno ??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Status : ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: size.width * .04,
              ),
              Spacer(),
              Obx(
                    () {
                  return Text(customer_complain_vm.filter_list[index].servicestatus??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),);

                },
                // child:
              ),
            ],
          ),
        ],
      ),


    );
  }


  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height/2+60,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          customer_complain_vm.clearFilterOptions();
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Icon(
                            Icons.cancel,
                            color: AllColors.primaryDark1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: AllColors.primaryDark1,
                ),
                Obx(() {
                  return Container(
                    margin: EdgeInsets.only(top: 0.3),
                    child: Visibility(
                      visible: customer_complain_vm.loading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.textColor,
                      ),
                    ),
                  );
                },
                ),
                SizedBox(height: 10,),
                Obx((){
                  return Visibility(
                      visible: customer_complain_vm.isShowDocDropDown.value,
                      child: bindSelectCustomerDropDown(context));
                }),
                SizedBox(height: 15,),
                Obx((){
                  return Visibility(
                      visible: customer_complain_vm.isShowDocDropDown.value,
                      child: bindSelectAddressDropDown(context));
                }),
                SizedBox(height: 15,),

                Obx((){
                  return Visibility(
                      visible: customer_complain_vm.isShowDocDropDown.value,
                      child: bindSelectItemDropDown(context));
                }),
                SizedBox(height: 15,),
                Obx((){
                  return Visibility(
                      visible: customer_complain_vm.isShowDocDropDown.value,
                      child: bindSelectSerialDropDown(context));
                }),
                SizedBox(height: 15,),
                bindDate(context),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: AllColors.primaryDark,
                              width: 1),
                        )),
                        onPressed: () {
                          Get.back();
                          customer_complain_vm.pageNumber=0;
                          customer_complain_vm.filter_color.value=true;
                          customer_complain_vm.getCompListFilter();
                          //customer_complain_vm.clearFilterOptions();
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: AllColors.redColor, width: 1),
                        )),
                        onPressed: () {
                          Get.back();
                          customer_complain_vm.clearFilterOptions();
                          customer_complain_vm.pageNumber=0;
                          customer_complain_vm.filter_color.value=false;
                          customer_complain_vm.getCompListFilter();

                        },
                        child: Text(
                          'Reset',
                          style: GoogleFonts.poppins(
                              color: AllColors.redColor,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        );
      },
    );
  }

  Widget bindSelectCustomerDropDown(context) {
    return Autocomplete<SelectCustomerComplainModal>(
      displayStringForOption: _displaySelectCustomerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          customer_complain_vm.addresse_search_controller.clear();
          customer_complain_vm.select_item_controller.clear();
          customer_complain_vm.select_serial_no_controller.clear();
          customer_complain_vm.address_list.value=[];
          customer_complain_vm.item_list.value=[];
          customer_complain_vm.serial_no_list.value=[];

          return customer_complain_vm.select_customer_list.value;

        }
        return await customer_complain_vm.getSelectCustomerFilter(textEditingValue.text,"Customer");
      },
      onSelected: (SelectCustomerComplainModal selection) {
        print(selection.customername);
        customer_complain_vm.customer_name_search_controller.text = _displaySelectCustomerForOption(selection).toString();
        customer_complain_vm.addresse_search_controller.clear();
        customer_complain_vm.select_item_controller.clear();
        customer_complain_vm.select_serial_no_controller.clear();
        customer_complain_vm.address_list.value=[];
        customer_complain_vm.item_list.value=[];
        customer_complain_vm.serial_no_list.value=[];
        customer_complain_vm.getSelectAddressFilter("");

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            customer_complain_vm.getSelectCustomerFilter('',"Customer");
          },

          onChanged: (value) {
            customer_complain_vm.customer_name_search_controller.text =
                value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text =
                customer_complain_vm.customer_name_search_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(

            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            labelText: 'Select Customer',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              // fontWeight: FontWeight.w300,
              //  fontSize: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<SelectCustomerComplainModal> onSelected,
          Iterable<SelectCustomerComplainModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              //width: size.width * .6,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final SelectCustomerComplainModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.customername.toString(),
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
  Widget bindSelectAddressDropDown(context) {
    return Autocomplete<ComplainAddressModal>(
      displayStringForOption: _displaySelectAddressForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          customer_complain_vm.select_item_controller.clear();
          customer_complain_vm.select_serial_no_controller.clear();
          customer_complain_vm.item_list.value=[];
          customer_complain_vm.serial_no_list.value=[];
          return customer_complain_vm.address_list.value;
        }
        return await customer_complain_vm.getSelectAddressFilter(textEditingValue.text);
      },
      onSelected: (ComplainAddressModal selection) {
        print(selection.customeraddress);
        customer_complain_vm.addresse_search_controller.text =
            _displaySelectAddressForOption(selection).toString();
        customer_complain_vm.select_item_controller.clear();
        customer_complain_vm.select_serial_no_controller.clear();
        customer_complain_vm.item_list.value=[];
        customer_complain_vm.serial_no_list.value=[];
        customer_complain_vm.getSelectItemFilter("");


        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            customer_complain_vm.getSelectAddressFilter("");
          },
          onChanged: (value) {
            customer_complain_vm.addresse_search_controller.text = value;

          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = customer_complain_vm.addresse_search_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(

            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            labelText: 'Select Address',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              // fontWeight: FontWeight.w300,
              //  fontSize: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ComplainAddressModal> onSelected,
          Iterable<ComplainAddressModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              //width: size.width * .6,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ComplainAddressModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.customeraddress.toString(),
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

  Widget bindSelectItemDropDown(context) {
    return Autocomplete<ComplainItemModal>(
      displayStringForOption: _displaySelectItemNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async{
        if (textEditingValue.text.isEmpty) {
          customer_complain_vm.select_serial_no_controller.clear();
          customer_complain_vm.serial_no_list.value=[];
          return customer_complain_vm.item_list.value;
        }
        return await customer_complain_vm.getSelectItemFilter(textEditingValue.text);
        /*return customer_complain_vm.item_list.value
            .where((ComplainItemModal option) {
          return option.itemname
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (ComplainItemModal selection) {
        print(selection.itemname);
        customer_complain_vm.select_item_controller.text = _displaySelectItemNameForOption(selection).toString();
        FocusScope.of(context).unfocus();
        customer_complain_vm.select_serial_no_controller.clear();
        customer_complain_vm.serial_no_list.value=[];
        customer_complain_vm.getSelectSerialNoFilter("");
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            customer_complain_vm.getSelectItemFilter("");
          },
          onChanged: (value) {
            customer_complain_vm.select_item_controller.text = value;

          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = customer_complain_vm.select_item_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            labelText: 'Select Item',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              // fontWeight: FontWeight.w300,
              //  fontSize: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ComplainItemModal> onSelected,
          Iterable<ComplainItemModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              //width: size.width * .6,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ComplainItemModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.itemname.toString(),
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

  Widget bindSelectSerialDropDown(context) {
    return Autocomplete<ComplainSerialModal>(
      displayStringForOption: _displaySelectSerialNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return customer_complain_vm.serial_no_list.value;
        }
        return await customer_complain_vm.getSelectSerialNoFilter(textEditingValue.text);
        /*return customer_complain_vm.serial_no_list.value
            .where((ComplainSerialModal option) {
          return option.serialno
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (ComplainSerialModal selection) {
        print(selection.serialno);
        customer_complain_vm.select_serial_no_controller.text = _displaySelectSerialNoForOption(selection).toString();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            customer_complain_vm.getSelectSerialNoFilter("");
          },
          onChanged: (value) {
            customer_complain_vm.select_serial_no_controller.text = value;

          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = customer_complain_vm.select_serial_no_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            labelText: 'Serial No',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              // fontWeight: FontWeight.w300,
              //  fontSize: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ComplainSerialModal> onSelected,
          Iterable<ComplainSerialModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              //width: size.width * .6,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ComplainSerialModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.serialno.toString(),
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

  Widget bindDate(context) {
    return TextFormField(
      controller: customer_complain_vm.select_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
        hintText: "Installation Date",
        labelText: 'Installation Date',
        hintStyle: GoogleFonts.poppins(
          color: AllColors.lightblackColor,
          //fontWeight: FontWeight.w300,
          //fontSize: AllFontSize.ten
        ),
        suffixIcon: Icon(Icons.calendar_month_outlined),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          //fontWeight: FontWeight.w300,
          //fontSize: AllFontSize.ten
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
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
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          customer_complain_vm.select_date_controller.text =
              outputFormat.format(date);
        else
          customer_complain_vm.select_date_controller.text = "";
      },
    );
  }


  void showComplainDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure minimal height
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "All Complaints",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Icon(
                          Icons.cancel,
                          color: AllColors.primaryDark1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                  child: Divider(
                    height: 1,
                    color: AllColors.primaryDark1,
                  )),
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: size.height/2,
                  child: Obx(() {
                    return BindComlainListView(context);
                  }
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget BindComlainListView(context) {
    if (customer_complain_vm.all_complain_list.value.isNotEmpty &&
        customer_complain_vm.all_complain_list.value.length > 0){
      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(
            height: .05,
            color: AllColors.primaryDark1,
          ),
          shrinkWrap: true,
           itemCount: customer_complain_vm.all_complain_list.value.length,

          itemBuilder: (BuildContext context, int index) {
             return BindComplainListViewTile(context, index);
          });
    } else {
      return Center(
        child: Image.asset(
          "assests/images/no_data_remove.png",
          width: 300,
          height: 180,
        ),
      );
    }
  }


  void raiseAndShowComplainBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Container(
                      color: Colors.grey,
                      margin:EdgeInsets.only(left: 0,right: 0,top: 5,bottom: 0),
                      height: 5,
                      width:50,

                    )
                ),
                SizedBox(height: 18,),
                Container(
                  height: size.height*.18,
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Option",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 18,),
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  showComplainDetailBottomSheet(context);
                                },
                                child: Row(
                                    children: [
                                      Icon(Icons.remove_red_eye, color: Colors.blueAccent,),
                                      SizedBox(width: 18,),
                                      Text("View All Complains", style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w500,
                                      ),)
                                    ])),
                            SizedBox(height: 18,),
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  customer_complain_vm.reason_code_controller.clear();
                                  customer_complain_vm.user_remark_controller.clear();
                                  remarkDialog(context, id);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add_chart ,color: Colors.blueAccent,),
                                    SizedBox(width: 18,),
                                    Text("Raise Complains", style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w500,
                                    ),)
                                  ],
                                )),

                          ],
                        ),
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget BindComplainListViewTile(BuildContext context, int index) {
    //var service_tat_date=StaticMethod.convertDateFormat1(customer_complain_vm.all_complain_list[index].completedon??"");
    return ListTile(
      contentPadding: EdgeInsets.only(left: 5, right: 10),
      subtitle: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Service No. :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Text(
                customer_complain_vm
                    .all_complain_list[index].serviceno!,
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.end,
              ),
              Spacer(),
              /*Text(service_tat_date?? "",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.end,),*/
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Serial No. :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message: customer_complain_vm.all_complain_list[index].serialno ??"",
                  child: Text(
                    customer_complain_vm.all_complain_list[index].serialno ??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Item Name :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message:"${customer_complain_vm.all_complain_list[index].itemname??""}(${customer_complain_vm.all_complain_list[index].itemno??""})" ,
                  child: Text("${customer_complain_vm.all_complain_list[index].itemname??""}(${customer_complain_vm.all_complain_list[index].itemno??""})",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    // textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Complain Reason :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message: customer_complain_vm.all_complain_list[index].complainreasoncode ??"",
                  child: Text(
                    customer_complain_vm.all_complain_list[index].complainreasoncode ??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Complain Remark :  ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500
                ),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Tooltip(
                  message: customer_complain_vm.all_complain_list[index].complainremark ??"",
                  child: Text(
                    customer_complain_vm.all_complain_list[index].complainremark ??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status : ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
              ),

              Spacer(),
              Obx(
                    () {
                  return Text(customer_complain_vm.all_complain_list[index].servicestatus??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  );
                },
                // child:
              ),
            ],
          ),
        ],
      ),

    );
  }


  void remarkDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Raise Complaint',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      customer_complain_vm.reason_master_list.value = [];
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),
                      child: Icon(
                        Icons.cancel,
                        color: AllColors.primaryDark1,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                height: .01,
                color: AllColors.lightgreyColor,
              ),
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(top: 0.3),
                  child: Visibility(
                    visible: customer_complain_vm.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  ),
                );
              },),
            ],
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              bindReasonDropDown(context),
              SizedBox(
                height: 13,
              ),
              TextFormField(
                controller: customer_complain_vm
                    .user_remark_controller,
                decoration: InputDecoration(
                  labelText: "User Remark ",
                  labelStyle: TextStyle(color: AllColors.primaryDark1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
                    borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
                    borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                  ),
                ),
              ),

              SizedBox(
                height: 13,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AllColors.primaryDark1,
                  ),
                ),
                onPressed: () {
                  customer_complain_vm.raiseComplainApi(id);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Text(
                    'Save',
                    style: GoogleFonts.poppins(
                      color: AllColors.customDarkerWhite,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  Widget bindReasonDropDown(context) {
    return Autocomplete<ReasonModel> (
      displayStringForOption: _displayReasonCodeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async{
        if (textEditingValue.text.isEmpty) {
          return customer_complain_vm.reason_master_list.value=[];
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return await customer_complain_vm.getReasonMaster(textEditingValue.text);
        /*return customer_complain_vm.reason_master_list.value
            .where((ReasonModel option) {
          return option.reasonCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (ReasonModel selection) {
        print(selection.reasonCode);
        customer_complain_vm.reason_code_controller.text =
            _displayReasonCodeForOption(selection).toString();
        //customer_complain_vm.reason_code = selection.reasonCode!;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(

          onChanged: (value) {
            customer_complain_vm.reason_code_controller.text =
                value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text =
                customer_complain_vm.reason_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(

            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
            labelText: 'Reason Code',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Border color when focused
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Default border color
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ReasonModel> onSelected,
          Iterable<ReasonModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              width: size.width * .6,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ReasonModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.reasonCode.toString(),
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

