import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/item_master_vm/item_mater_vm.dart';

class UpdateNonStandardItemScreen extends StatelessWidget{
  UpdateNonStandardItemScreen({super.key});

  final item_master_controller=Get.put(ItemMasterVm());
  Size size=Get.size;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) => option.categoryName!;
  static String _displayProductTyperOption(String option) => option;
  static String _displayIsActiveForOption(String option) => option;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.nonStandardItemList);
        return false;
      }, child: Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),

          title:Row(
            children: [
              Flexible(
                child: Tooltip(
                  message: 'Update Non Standard Item (TEMP1967615)',
                  child: Text(
                    'Update Non Standard Item (TEMP1967615)',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

            ],
          )

      ),
        floatingActionButton:  Container(
          margin: EdgeInsets.only(left: 30),
          child: DefaultButton(
            press: (){
              item_master_controller.updateItemMasterCreateFromCRM(item_master_controller.item);
            },
            text: "Update",
          ),
        ),
      drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Obx((){
              return  Column(
                children: [
                  const SizedBox(height: 15,),
                  bindInputData("Name",item_master_controller.update_name_Controller.value,false,context),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: bindItemCategoryDropDown(context),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: bindProductTypeDropDown(context),
                  ),
                  const SizedBox(height: 15,),
                  bindInputData("Customer Code",item_master_controller.update_customer_code_Controller.value,true,context),
                  const SizedBox(height: 15,),
                  bindInputData("Sales Cycle ID",item_master_controller.update_sale_cycle_id_Controller.value,true,context),
                  const SizedBox(height: 15,),
                  bindInputData("Component Type",item_master_controller.component_type_Controller.value,true,context),
                  const SizedBox(height: 15,),
                  bindInputData("Specification",item_master_controller.update_specification_Controller.value,false,context),
                  const SizedBox(height: 15,),
                  bindInputData("LSP",item_master_controller.LSP_Controller.value,false,context),
                  const SizedBox(height: 15,),
                  bindInputData("BTP",item_master_controller.Btp_Controller.value,false,context),
                  const SizedBox(height: 15,),
                  bindInputData("MAP",item_master_controller.Map_Controller.value,false,context),
                  const SizedBox(height: 15,),
                  bindInputData("Standard Cost",item_master_controller.standard_cost_Controller.value,false,context),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: bindIsActiveDropDown(context),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: bindRateContractDate(context),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child:  bindExpiryDate(context),
                  ),
                  const SizedBox(height: 65,),


                ],
              );
            }),

          ),
        )

    ),
    );
  }

  Widget bindItemCategoryDropDown(context) {
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemCatMasterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return item_master_controller.productCategoryList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return item_master_controller.productCategoryList
            .where((ItemCategoryMstModel option) {
          return option.categoryName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstModel selection) {
        // Update the TextField with the selected
        item_master_controller.category_code_Controller.value.text =
            _displayItemCatMasterForOption(selection).toString();

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextField(
            onTap: () {
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = item_master_controller.category_code_Controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Category Code',
              labelText: 'Category Code',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
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
              //width: size.width * .7,
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
    );
  }

  Widget bindProductTypeDropDown(context) {
    return Container(
      // margin: const EdgeInsets.only(left: 15.0),
      width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width,
        controller:  item_master_controller.product_type_Controller.value,
        label: Text(
          "Product Type",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w300),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (String? selection) {
          print(selection);
          item_master_controller.product_type_Controller.value.text = _displayProductTyperOption(selection!).toString();

        },

        dropdownMenuEntries: item_master_controller.productTypeList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  Widget bindIsActiveDropDown(context) {
    return Container(
      width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width,
        controller:  item_master_controller.is_active_Controller.value,
        label: Text(
          "Is Active",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w300),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (String? selection) {
          print(selection);
          item_master_controller.is_active_Controller.value.text = _displayIsActiveForOption(selection!).toString();
        },
        dropdownMenuEntries: item_master_controller.IsActiveTypeList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindRateContractDate(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: item_master_controller.rate_contract_validity_date_Controller.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Rate Contract Valid Date',
            labelText: 'Rate Contract Valid Date',
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
                  // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(
                      primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            item_master_controller.rate_contract_validity_date_Controller.value.text = outputFormat.format(date);
          else
            item_master_controller.rate_contract_validity_date_Controller.value.text = "";
        }

    );
  }
  bindExpiryDate(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: item_master_controller.expiry_date_Controller.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Expiry Date',
            labelText: 'Expiry Date',
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
                  // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(
                      primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            item_master_controller.expiry_date_Controller.value.text = outputFormat.format(date);
          else
            item_master_controller.expiry_date_Controller.value.text = "";
        }

    );
  }


  Widget bindInputData(String hintData, TextEditingController controller,bool readOnly, BuildContext context,){
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType:hintData == "Phone No.*" || hintData == "Alternate Phone No."?TextInputType.phone: TextInputType.text,
        decoration: InputDecoration(
            hintText: hintData,
            labelText: hintData,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten,
                horizontal: AllFontSize.ten),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
      ),
    ) ;
  }

}