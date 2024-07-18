import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/viewModel/return_indent_vm/return_indent_vm.dart';

import '../../component/custome_loading_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/return_indent_model/location_model.dart';
import '../custom_drawer.dart';

class NewReturnIndentScreen extends StatelessWidget{
  NewReturnIndentScreen({super.key});
  final return_indent_page_controller=Get.put(ReturnIndentViewModel());
  static String _displayLocationNameForOption(LocationResponse option) =>
      option.locationName!;


  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Return Indent ',
            style: GoogleFonts.poppins(
              color: AllColors.whiteColor,
              fontSize: AllFontSize.twentee,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor, // Change this to the desired color
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
      body: Container(
        width: double.infinity,
        height:size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Container(
                      margin: EdgeInsets.only(top: 0.3),
                      child: Visibility(
                        visible: return_indent_page_controller.loading.value,
                        child: LinearProgressIndicator(
                          backgroundColor: AllColors.primaryDark1,
                          color: AllColors.textColor,
                        ),
                      ),
                    );
                  },
                  ),

                 /* Obx(() {
                    return
                  },)*/

                  bindLocationDropDown(context),

                  SizedBox(height: 5),


                  CustomLoadingButton(
                    loading:return_indent_page_controller.loading.value,
                    icon:  Icons.create,
                    text: "Create",
                    press: (){


                      return_indent_page_controller.ReturnIndentHeaderCreate("Init");
                    },
                  )

                 /* ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AllColors.textColor2,
                        side: BorderSide(
                            color: AllColors
                                .primaryDark1,
                            width: 1)),
                    onPressed: () {
                      return_indent_page_controller.ReturnIndentHeaderCreate("",return_indent_page_controller.location_code_controller.text);

                    },
                    icon: Icon(Icons.create,color: AllColors.primaryDark1,),
                    label: Container(
                      child: Tooltip(
                        message: "Create",
                        child: Text(
                          "Create",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    //  child:
                  ),*/

                ],
              ),
            )
          ],
        ),
      )
    );
  }
  Widget bindLocationDropDown(BuildContext context) {
    // Initialize a TextEditingController if not already done
    return_indent_page_controller.location_code_controller.addListener(() {
      return_indent_page_controller.update(); // Call update to refresh the state
    });

    return Autocomplete<LocationResponse>(
      displayStringForOption: _displayLocationNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return return_indent_page_controller.location_list.value;
        }
        return return_indent_page_controller.location_list.value.where((LocationResponse option) {
          return option.locationName!.toLowerCase().contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (LocationResponse selection) {
        print(selection.locationName);
        return_indent_page_controller.location_code_controller.text =
            _displayLocationNameForOption(selection).toString();
        return_indent_page_controller.location_code = selection.locationId!;
        return_indent_page_controller.is_location_dropdown.value=true;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = return_indent_page_controller.location_code_controller.text,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Location',
            labelText: 'Select Location',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
            ),
            suffixIcon: Obx(() {
              return Visibility(
                visible: return_indent_page_controller.is_location_dropdown.value?true:false,
                child: InkWell(
                  onTap: () {
                    controller.clear();
                    return_indent_page_controller.is_location_dropdown.value=false;
                    return_indent_page_controller.location_code_controller.clear();
                    return_indent_page_controller.location_code = '';
                    FocusScope.of(context).unfocus();
                  },
                  child: Icon(Icons.clear),
                ),
              );
            },
            //  child:
            ),
            labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<LocationResponse> onSelected,
          Iterable<LocationResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final LocationResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.locationName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.sisxteen,
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