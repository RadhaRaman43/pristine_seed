import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/component/default_button_red.dart';
import 'package:navigation_drawer_flutter/models/service_managment_model_directory/servicePreventiveModel/amc_request_invoice_item_get_modal.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/amc_request_invoice_modal.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/service_managment_vm_directory/preventive_vm/preventive_vm.dart';
import '../../custom_drawer.dart';

class AddNewPreventiveCalenderScreen extends StatelessWidget {
  final create_preventive_page_controller = Get.put(PreventiveViewModel());

  static String _displayAMCRequestInvoiceNoForOption(
          AMCRequestInvoiceGetModal option) =>
      option.invoiceNo ?? "";

  static String _displayAMCRequestInvoiceItemNoForOption(
          AMCRequestInvoiceItemGetModal option) =>
      option.itemNo! +"( ${option.itemName} )";

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        create_preventive_page_controller.clearAllField();
        Get.toNamed(RoutesName.create_preventive_calender_view_screen);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Preventive Calender',
              style: GoogleFonts.poppins(
                color: AllColors.whiteColor,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700,
              ),
            ),
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            backgroundColor: AllColors.primaryDark1,
          ),
          drawer: CustomDrawer(),
          body: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Visibility(
                    visible: create_preventive_page_controller.isShowInvoiceNo.value,
                    child: bindInvoiceNo(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx((){
                    return Visibility(
                      visible: create_preventive_page_controller.isShowItemNo.value,
                      child: bindInvoiceItemGet(context),
                    );
                  }),

                  const SizedBox(
                    height: 10,
                  ),
                  bindWarrantyStartDate(context),
                  const SizedBox(
                    height: 10,
                  ),
                  bindWarrantyEndDate(context),
                  const SizedBox(
                    height: 10,
                  ),
                  bindFrequency(context),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultButtonRed(
                          text: 'Clear',
                          press: () {
                            create_preventive_page_controller.clearAllField();
                          },
                          loading: create_preventive_page_controller
                              .btnloading.value,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DefaultButton(
                          text: 'Submit',
                          press: () {
                            if (create_preventive_page_controller
                                .amcRequestInvoiceNoController
                                .value
                                .text
                                .isEmpty) {
                              Utils.sanckBarError(
                                  'Invoice No. ', 'Please Select Invoice No.');
                            } else if (create_preventive_page_controller
                                .selectedItemNo
                                .value
                                .isEmpty) {
                              Utils.sanckBarError(
                                  'Item No. ', 'Please Select Item No.');
                            } else if (create_preventive_page_controller
                                .warrantyStartDateController
                                .value
                                .text
                                .isEmpty) {
                              Utils.sanckBarError('Warranty Start Date',
                                  'Please Select Warranty Start Date');
                            } else if (create_preventive_page_controller
                                .warrantyEndDateController.value.text.isEmpty) {
                              Utils.sanckBarError('Warranty End Date',
                                  'Please Select Warranty End Date');
                            } else if (create_preventive_page_controller
                                .frequencyController.value.text.isEmpty) {
                              Utils.sanckBarError(
                                  'Frequency', 'Please Enter Frequency');
                            } else {
                              create_preventive_page_controller
                                  .getAMCRequestCreation();
                            }
                          },
                          loading: create_preventive_page_controller
                              .btnloading.value,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          })),
    );
  }


  Widget bindInvoiceNo(BuildContext context) {
    final controller = create_preventive_page_controller;
    return Autocomplete<AMCRequestInvoiceGetModal>(
      key: ValueKey(controller.invoiceKey.value),
      displayStringForOption: (option) =>
      option.invoiceNo ?? "",
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return await controller
            .getAMCRequestInvoice(textEditingValue.text);
      },
      onSelected: (selection) async {
        controller.amcRequestInvoiceNoController.value.text =
            selection.invoiceNo ?? "";
        controller.serviceNo.value =
            selection.serviceNo ?? "";
        controller.amcRequestInvoiceItemNoController.clear();
        controller.selectedItemNo.value = "";
        controller.amcRequestInvoiceItemNoList.clear();
        create_preventive_page_controller.itemKey.value++;

        await controller.getAMCRequestInvoiceItemNo(
            selection.invoiceNo ?? "");
      },

      fieldViewBuilder: (context, textController, focusNode, onSubmit) {
        final c = create_preventive_page_controller;
        if (c.amcRequestInvoiceNoController.value.text.isNotEmpty &&
            textController.text !=
                c.amcRequestInvoiceNoController.value.text) {
          textController.text =
              c.amcRequestInvoiceNoController.value.text;
          textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length),
          );
        }
        return TextField(
          controller: textController,
          focusNode: focusNode,
          cursorColor: AllColors.primaryDark1,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onChanged: (value) {
            c.amcRequestInvoiceNoController.value.text = value;
            if(value.isEmpty){
              c.selectedItemNo.value="";
              create_preventive_page_controller.itemKey.value++;
            }
          },

          decoration: InputDecoration(
            hintText: 'Select Invoice No.',
            labelText: 'Select Invoice No.',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.fourtine),
            contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two,
              horizontal: AllFontSize.ten,
            ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
          ),
        );
      },

      optionsViewBuilder:
          (context, onSelected, suggestions) {
        return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              child: Container(
                color: AllColors.grayColor1,
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final option = suggestions.elementAt(index);
                    return ListTile(
                      title: Text(option.invoiceNo ?? ""),
                      onTap: () => onSelected(option),
                    );
                  },
                ),
              ),
            )
        );
      },
    );
  }
 /* Widget bindInvoiceNo(context) {
    return Autocomplete<AMCRequestInvoiceGetModal>(
      displayStringForOption: _displayAMCRequestInvoiceNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        *//*if (textEditingValue.text.isEmpty) {
          return [];
          //return create_preventive_page_controller.amcRequestInvoiceList.value;
        }*//*
        return await create_preventive_page_controller.getAMCRequestInvoice(textEditingValue.text);
      },
      onSelected: (AMCRequestInvoiceGetModal selection) {
        print(selection);
        create_preventive_page_controller.amcRequestInvoiceNoController.value
            .text = _displayAMCRequestInvoiceNoForOption(selection!).toString();
        create_preventive_page_controller.serviceNo.value =
            selection.serviceNo ?? "";
        create_preventive_page_controller.amcRequestInvoiceItemNoController.clear();
        create_preventive_page_controller.amcRequestInvoiceItemNoList.clear();
        create_preventive_page_controller.selectedItemNo.value="";
        create_preventive_page_controller.isShowItemNo.value=false;
        create_preventive_page_controller.isShowItemNo.value=true;
        create_preventive_page_controller.getAMCRequestInvoiceItemNo(selection.invoiceNo ?? "");

        //FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTapOutside: (value) {
            FocusScope.of(context).unfocus();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = create_preventive_page_controller
                .amcRequestInvoiceNoController.value.text,
          focusNode: focusNode,
          onChanged: (value){
            if(value.isEmpty || value==null){
              create_preventive_page_controller
                  .amcRequestInvoiceNoController.value.clear();
              create_preventive_page_controller.isShowInvoiceNo.value=false;
              create_preventive_page_controller.isShowInvoiceNo.value=true;
              create_preventive_page_controller
                  .amcRequestInvoiceItemNoController.clear();
              create_preventive_page_controller.isShowItemNo.value=false;
              create_preventive_page_controller.isShowItemNo.value=true;

            }
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Select Invoice No. ',
              labelText: 'Select Invoice No. ',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.fourtine),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AMCRequestInvoiceGetModal> onSelected,
          Iterable<AMCRequestInvoiceGetModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              width: size.width,
              constraints: BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final AMCRequestInvoiceGetModal option =
                      suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width*.7,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                option.invoiceNo.toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                    ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }*/

/*  bindInvoiceNo(BuildContext context){
    return Container(
      child: DropdownMenu<AMCRequestInvoiceGetModal>(
        width: MediaQuery.of(context).size.width,
        controller: create_preventive_page_controller.amcRequestInvoiceNoController.value,
        label: Text("Select Invoice No.",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
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
        menuHeight: 300,
        enableFilter: false,
        enableSearch: true,
        requestFocusOnTap: true,


        onSelected: (AMCRequestInvoiceGetModal? selection) {
          print(selection);
          create_preventive_page_controller.amcRequestInvoiceNoController.value.text =
              _displayAMCRequestInvoiceNoForOption(selection!)
                  .toString();
          create_preventive_page_controller.serviceNo.value=selection.serviceNo??"";
          create_preventive_page_controller.amcRequestInvoiceItemNoController.value.clear();
          create_preventive_page_controller.getAMCRequestInvoiceItemNo(selection.invoiceNo??"");


        },
        dropdownMenuEntries: create_preventive_page_controller.amcRequestInvoiceList.map<
            DropdownMenuEntry<AMCRequestInvoiceGetModal>>((AMCRequestInvoiceGetModal e) {
          return DropdownMenuEntry<AMCRequestInvoiceGetModal>(
              value: e, label: e.invoiceNo??"", style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }*/

  /*bindInvoiceItemGet(BuildContext context){
    return Container(
      child: DropdownMenu<AMCRequestInvoiceItemGetModal>(
        width: MediaQuery.of(context).size.width,
        controller: create_preventive_page_controller.amcRequestInvoiceItemNoController.value,
        label: Text("Select Item No.",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
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


        onSelected: (AMCRequestInvoiceItemGetModal? selection) {
          print(selection);
          create_preventive_page_controller.amcRequestInvoiceItemNoController.value.text =
              _displayAMCRequestInvoiceItemNoForOption(selection!)
                  .toString();
        },
        enableFilter: true,
        enableSearch: true,
        requestFocusOnTap: true,
        menuHeight: 300,
        dropdownMenuEntries: create_preventive_page_controller.amcRequestInvoiceItemNoList.value.map<
            DropdownMenuEntry<AMCRequestInvoiceItemGetModal>>((AMCRequestInvoiceItemGetModal e) {
          return DropdownMenuEntry<AMCRequestInvoiceItemGetModal>(
              value: e, label: e.itemNo??"", style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }*/
  Widget bindInvoiceItemGet(BuildContext context) {
    return Obx(() {
      final c = create_preventive_page_controller;
      return Autocomplete<AMCRequestInvoiceItemGetModal>(
       /* key: ValueKey(
            c.amcRequestInvoiceItemNoList.length.toString() +
                c.selectedItemNo.value),*/
        key: ValueKey(c.itemKey.value),
        displayStringForOption: (option) => option.itemNo ?? "",
       /* optionsBuilder: (TextEditingValue textEditingValue) {
          final list = c.amcRequestInvoiceItemNoList;
          if (textEditingValue.text.isEmpty) return list;
          return list.where((item) {
            return item.itemNo!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },*/

        optionsBuilder: (TextEditingValue textEditingValue) {
          final c = create_preventive_page_controller;
          if (c.amcRequestInvoiceNoController.value.text.trim().isEmpty) {
            return const Iterable<AMCRequestInvoiceItemGetModal>.empty();
          }
          final list = c.amcRequestInvoiceItemNoList;
          if (textEditingValue.text.isEmpty) {
            return list;
          }
          return list.where((item) {
            return item.itemNo!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (selection) {
          c.selectedItemNo.value = selection.itemNo ?? "";
          FocusScope.of(context).unfocus();
        },

        fieldViewBuilder:
            (context, textController, focusNode, onSubmit) {
          if (c.selectedItemNo.value.isNotEmpty &&
              textController.text != c.selectedItemNo.value) {
            textController.text = c.selectedItemNo.value;
          }
          return TextField(
            controller: textController,
            focusNode: focusNode,
            cursorColor: AllColors.primaryDark1,
            decoration: InputDecoration(
              hintText: 'Select Item No.',
              labelText: 'Select Item No.',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.fourtine),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
             /* border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),*/
            ),
          );
        },

        optionsViewBuilder:
            (context, onSelected, suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              child: Container(
                color: AllColors.grayColor1,
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  itemCount: suggestions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final option = suggestions.elementAt(index);

                    return ListTile(
                      title: Text(
                          "${option.itemNo} (${option.itemName})"),
                      onTap: () => onSelected(option),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    });
  }
/*  Widget bindInvoiceItemGet(context) {
    return Autocomplete<AMCRequestInvoiceItemGetModal>(
      displayStringForOption: _displayAMCRequestInvoiceItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          print("list...${create_preventive_page_controller.amcRequestInvoiceItemNoList.length}");
          return create_preventive_page_controller.amcRequestInvoiceItemNoList.value;
        }
        return create_preventive_page_controller.amcRequestInvoiceItemNoList
            .where((AMCRequestInvoiceItemGetModal option) {
          return option.itemNo
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },


      onSelected: (AMCRequestInvoiceItemGetModal selection) {
        print(selection);
        create_preventive_page_controller
                .amcRequestInvoiceItemNoController.text =
            _displayAMCRequestInvoiceItemNoForOption(selection!).toString();
        FocusScope.of(context).unfocus();
        create_preventive_page_controller.selectedItemNo.value=selection.itemNo??"";
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTapOutside: (value) {
            FocusScope.of(context).unfocus();
          },
          onTap: (){
            create_preventive_page_controller.isShowItemNo.value=false;
            create_preventive_page_controller.isShowItemNo.value=true;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = create_preventive_page_controller
                .amcRequestInvoiceItemNoController.text,
          focusNode: focusNode,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              hintText: 'Select Item No. ',
              labelText: 'Select Item No. ',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.fourtine),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AMCRequestInvoiceItemGetModal> onSelected,
          Iterable<AMCRequestInvoiceItemGetModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              constraints: BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final AMCRequestInvoiceItemGetModal option =
                      suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width*.7,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                  option.itemNo! +"( ${option.itemName} )",
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                    ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }*/

  bindWarrantyStartDate(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller:
            create_preventive_page_controller.warrantyStartDateController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Warranty Start Date',
            labelText: 'Warranty Start Date',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.fourtine),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
        onTap: () async {
          DateTime start_date = new DateTime(1900);
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
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
            create_preventive_page_controller.warrantyStartDateController.value
                .text = outputFormat.format(date);
          else
            create_preventive_page_controller
                .warrantyStartDateController.value.text = "";
        });
  }

  bindWarrantyEndDate(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        readOnly: true,
        controller:
            create_preventive_page_controller.warrantyEndDateController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Warranty End Date',
            labelText: 'Warranty End Date',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.fourtine),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
        onTap: () async {
          final text = create_preventive_page_controller
              .warrantyStartDateController.value.text;
          DateTime start_date = DateFormat("yyyy-MM-dd").parse(text);
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime initialDate = DateTime.now().isBefore(start_date)
              ? start_date
              : DateTime.now();
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1,
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
            create_preventive_page_controller.warrantyEndDateController.value
                .text = outputFormat.format(date);
          else
            create_preventive_page_controller
                .warrantyEndDateController.value.text = "";
        });
  }

  bindFrequency(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: create_preventive_page_controller.frequencyController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Enter Frequency',
          hintText: 'Enter Frequency',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.fourtine),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      cursorColor: AllColors.primaryDark1,
    );
  }


}
