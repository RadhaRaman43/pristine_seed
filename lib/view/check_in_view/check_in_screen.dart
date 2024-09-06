import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';
import 'package:navigation_drawer_flutter/viewModel/CheckIn_vm/check_in_vm.dart';
import 'dart:io';
import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/checkInModel/employee_master_model.dart';
import '../../models/checkInModel/vehicleType_model.dart';
import '../../models/checkInModel/vehicle_no_model.dart';

class CheckInScreen extends StatelessWidget{
  CheckInScreen({super.key});
  Size size=Get.size;
  final check_in_page_controller=Get.put(CheckInViewModel());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static String _displayStringForOption(VehicleTypeResponse option) =>
      option.vehicleType!;
  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;
  static String _displayvehiclenoForOption(VehicleNoResponse option) =>
      option.vehicleNumber!;
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async  {
          Get.offAllNamed(RoutesName.homeScreen);
          return false;
        },
        child: Scaffold(
          appBar:AppBar(
              backgroundColor: AllColors.primaryDark1,
              iconTheme: IconThemeData(
                color: AllColors.whiteColor,
              ),
              title:Text(
                'Check In',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ),
          drawer: CustomDrawer(),
          body: Container(
            width: double.infinity,
            height: size.height,
            child: Obx(() {
              if (check_in_page_controller.loading.value) {
                // Show a progress indicator while loading
                return Center(
                  child:CircularProgressIndicator(color: AllColors.primaryDark1,), // You can use any progress indicator here
                /*  BlurryModalProgressHUD(
                    inAsyncCall: check_in_page_controller.loading.value,
                    blurEffectIntensity: 4,
                    progressIndicator: SpinKitFadingCircle(color: AllColors.primaryDark1,),
                    dismissible: false,
                    opacity: 0.4,
                    color: Colors.black54,
                    child: Scaffold(),
                  ),*/

                );
              } else {
                // Show the UI when not loading
                return Column(
                  children: [
                    //todo header section

                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 12),
                        shrinkWrap: true,
                        children: [
                          Container(
                            // padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Obx((){
                                    return Visibility(visible: check_in_page_controller.isVehicle.value,
                                      child: bindVehicleTypeDropDown(context), );

                                  }),
                                  //todo Dropdown Widget


                                  SizedBox(height: size.height * 0.02),
                                  //todo place TextFormField
                                  TextFormField(
                                    controller:
                                    check_in_page_controller.place_edit_controller.value,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Place can't be blank";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      // Clear the error when the user enters a value
                                      if (value.isNotEmpty) {
                                        _formKey.currentState?.validate();
                                      }
                                    },
                                    maxLength: 100,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: AllFontSize.two,
                                          horizontal: AllFontSize.one),
                                      hintText: "Enter Place Name",
                                      labelText: 'Place',
                                      hintStyle: GoogleFonts.poppins(
                                        color: AllColors.lightblackColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: AllFontSize.ten,
                                      ),
                                      labelStyle: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: AllFontSize.sisxteen,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AllColors
                                                .primaryDark1), // Change the color to green
                                      ),
                                    ),
                                    cursorColor: AllColors.primaryDark1,
                                  ),
                                  SizedBox(height: size.height * 0.02),

                                  //todo working with Checkbox
                                  Row(
                                    children: [
                                      Obx(() {
                                        return Checkbox(
                                          value: check_in_page_controller
                                              .isCheckBoxChecked.value,
                                          activeColor: AllColors.primaryDark1,
                                          onChanged: (value) {
                                            check_in_page_controller.checkin_opening_km_controller.value.text='';
                                            check_in_page_controller.vehicle_no_controller.text='';
                                            check_in_page_controller.isCheckBoxChecked.value = value ?? false;
                                          },
                                        );
                                      }),
                                      Text(
                                        'Working With',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //todo working with employess Dropdown Widget
                                  Obx(
                                        () => Visibility(
                                      visible: check_in_page_controller.isCheckBoxChecked.value,
                                      child: bindemployeeDropDown(context),
                                    ),
                                  ),
                                  //todo vehivle number......
                                  Obx(
                                        () => Visibility(
                                      visible: (check_in_page_controller.selected_vehicle_type!.value.isMaintainKm!=null && check_in_page_controller.selected_vehicle_type!.value.isMaintainKm!>0 && check_in_page_controller.isCheckBoxChecked==false)
                                          && check_in_page_controller.isVehicleHiding.value==true,
                                      child:Column(
                                        children: [
                                          Obx(() {
                                            return Visibility(
                                                visible:check_in_page_controller.isvehicleNo.value,
                                                child: bindVehicleNoDropDown(context));
                                          },
                                          ),

                                          //child: bindVehicleNoDropDown(context)),
                                          SizedBox(height: size.height * 0.02),
                                          bindOpeningkm(context),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.04),
                                  //todo Image Uploader Pickers
                                  Obx(() {
                                    return Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Visibility(
                                          visible: true,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  check_in_page_controller.getFrontImage('CheckIn','');
                                                  print('hjgh');
                                                },
                                                child: DottedBorder(
                                                  color: Colors.grey,
                                                  strokeWidth: 2,
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(20),
                                                  dashPattern: [10, 5, 10, 5],
                                                  child: Container(
                                                    width: size.width * 0.40,
                                                    height: size.height * 0.22,
                                                    child: check_in_page_controller
                                                        .inFront_image_path
                                                        .isNotEmpty
                                                        ? ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(20.0),
                                                      child: kIsWeb
                                                          ? Image.network(
                                                        check_in_page_controller
                                                            .inFront_image_path
                                                            .toString(),
                                                        fit: BoxFit
                                                            .cover, // Use BoxFit.cover to make the image fit
                                                      )
                                                          : Image.file(
                                                        File(check_in_page_controller
                                                            .inFront_image_path
                                                            .toString()),
                                                        fit: BoxFit
                                                            .cover, // Use BoxFit.cover to make the image fit
                                                      ),
                                                    )
                                                        : Icon(
                                                      Icons.camera,
                                                      size: 60,
                                                      color: AllColors
                                                          .primaryDark1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                'Front Image',
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: AllFontSize.fourtine,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: !check_in_page_controller
                                              .isCheckBoxChecked.value && check_in_page_controller.isManiTainKm.value>0,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  check_in_page_controller
                                                      .getBackImage('CheckIn');
                                                },
                                                child: DottedBorder(
                                                  color: Colors.grey,
                                                  strokeWidth: 2,
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(20),
                                                  dashPattern: [10, 5, 10, 5],
                                                  child: Container(
                                                    width: size.width * 0.40,
                                                    height: size.height * 0.22,
                                                    child: check_in_page_controller
                                                        .inBack_image_path
                                                        .isNotEmpty
                                                        ? ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(20.0),
                                                      child: kIsWeb
                                                          ? Image.network(
                                                        check_in_page_controller
                                                            .inBack_image_path
                                                            .toString(),
                                                        fit: BoxFit
                                                            .cover, // Use BoxFit.cover to make the image fit
                                                      )
                                                          : Image.file(
                                                        File(check_in_page_controller
                                                            .inBack_image_path
                                                            .toString()),
                                                        fit: BoxFit
                                                            .cover, // Use BoxFit.cover to make the image fit
                                                      ),
                                                    )
                                                        : Icon(
                                                      Icons.camera,
                                                      size: 60,
                                                      color: AllColors
                                                          .primaryDark1,
                                                    ), // Placeholder icon
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                'Back Image',
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: AllFontSize.fourtine,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  SizedBox(height: size.height * 0.04),
                                  //todo submit button ui
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    // Space between the buttons
                                    children: [
                                      Expanded(
                                        child: DefaultButton(
                                          text: "Submit",
                                          press: () {
                                            check_in_page_controller.submitCheckInDataApi1(
                                                check_in_page_controller.place_edit_controller.value);
                                          },
                                          loading: check_in_page_controller.loading.value,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      // Adjust the spacing as needed
                                      Expanded(
                                        child: DefaultButton(
                                          text: "Reset",
                                          press: () {
                                            _formKey.currentState?.reset();
                                            check_in_page_controller.typeAheadControllerVehicle.clear();
                                            check_in_page_controller.place_edit_controller.value.clear();
                                            check_in_page_controller.typeAheadControllerEmployee.clear();
                                            check_in_page_controller.isCheckBoxChecked.value = false;
                                            check_in_page_controller.inFront_image_path.value = '';
                                            check_in_page_controller.inBack_image_path.value = '';
                                            // check_in_page_controller.resetField();
                                            check_in_page_controller.vehicleNoList.value=[] ;
                                            check_in_page_controller.vehicle_no_controller.clear();
                                            check_in_page_controller.isVehicleHiding.value=false;
                                            check_in_page_controller.isVehicle.value=true;
                                          },
                                          loading: check_in_page_controller.loading.value = false,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      );
  }

  //todo vehicles dropdown
  Widget bindVehicleTypeDropDown(context) {

    return Container(
      width: size.width*.94,
      child: DropdownMenu<VehicleTypeResponse>(
        width: size.width * .94,
        controller: check_in_page_controller.typeAheadControllerVehicle,
        label: Text(
          "Vehicle Type",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //hintStyle:TextStyle(color: ),
          //labelStyle: TextStyle(color: AllColors.primaryDark1,fontSize: AllFontSize.sisxteen,fontWeight: FontWeight.w700),
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        enabled: true,
        onSelected: (VehicleTypeResponse? selection) {
          //check_in_page_controller.isShowCheckinVehicleNo.value=true;
          check_in_page_controller.selected_vehicle_type!.value=selection!;
          if(selection!=null)
          {
            check_in_page_controller.isVehicleHiding.value=true;
          }
          check_in_page_controller.isManiTainKm.value=selection.isMaintainKm!;
          // Update the TextField with the selected
          check_in_page_controller.typeAheadControllerVehicle.text = _displayStringForOption(selection).toString();
          check_in_page_controller.getVehicleNumber(check_in_page_controller.typeAheadControllerVehicle.text,'');
          check_in_page_controller.vehicle_no_controller.clear();
          check_in_page_controller.checkin_opening_km_controller.value.clear();
          check_in_page_controller.inFront_image_path.value="";
          check_in_page_controller.inBack_image_path.value="";
          // check_in_page_controller.getVehicletype();
        },
        dropdownMenuEntries:
        check_in_page_controller.vehicleTypeList.map<DropdownMenuEntry<VehicleTypeResponse>>((VehicleTypeResponse e) {
          return DropdownMenuEntry<VehicleTypeResponse>(value: e, label: e.vehicleType!);
        }).toList(),
      ),
    );
  }




  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        /* if (textEditingValue.text.isEmpty) {
          return check_in_page_controller.employeeTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
*/
        if (textEditingValue.text.isEmpty) {
          check_in_page_controller.isShowCustomerDetails.value = false;
          return [];
        }

        return await check_in_page_controller.searchCustomer(textEditingValue.text);
        return check_in_page_controller.employeeTypeList
            .where((EmpMasterResponse option) {
          return option.loginEmailId
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (EmpMasterResponse selection) {
        print(selection.loginEmailId);
        // Update the TextField with the selected
        check_in_page_controller.typeAheadControllerEmployee.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1 ,
          controller: controller..text=check_in_page_controller.typeAheadControllerEmployee.text,
          focusNode: focusNode,
          onChanged: (value){
            check_in_page_controller.typeAheadControllerEmployee.clear();
          },
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Employee',
            labelText: 'Employee',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten
            ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<EmpMasterResponse> onSelected,
          Iterable<EmpMasterResponse> suggestions) {
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
                  final EmpMasterResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.loginEmailId.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen// Change the text color here
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

  Widget bindVehicleNoDropDown(context) {
    return Container(
      width: size.width*.94,
      child: DropdownMenu<VehicleNoResponse>(
        width: size.width * .94,
        controller: check_in_page_controller.vehicle_no_controller,

        label: Text(
          "Vehicle No. ",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //hintStyle:TextStyle(color: ),
          //labelStyle: TextStyle(color: AllColors.primaryDark1,fontSize: AllFontSize.sisxteen,fontWeight: FontWeight.w700),
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        enabled: true,
        onSelected: (VehicleNoResponse? selection) {
          check_in_page_controller.vehicle_no_controller.text = _displayvehiclenoForOption(selection!).toString();
          check_in_page_controller.checkin_opening_km_controller.value.text = selection.closingKm.toString();

          // check_in_page_controller.getVehicletype();
        },

        dropdownMenuEntries:
        check_in_page_controller.vehicleNoList.value.map<DropdownMenuEntry<VehicleNoResponse>>((VehicleNoResponse e) {
          return DropdownMenuEntry<VehicleNoResponse>(value: e, label: e.vehicleNumber!);
        }).toList(),
      ),
    );
  }

  Widget bindOpeningkm(context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: check_in_page_controller.checkin_opening_km_controller.value,
      onChanged: (value) {
        check_in_page_controller.checkin_opening_km_controller.value.text=value;

      },
      //maxLength: 100,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Opening Km",
        labelText: 'Opening Km',
        hintStyle: GoogleFonts.poppins(
          color: AllColors.lightblackColor,
          fontWeight: FontWeight.w300,
          fontSize: AllFontSize.ten,
        ),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontWeight: FontWeight.w700,
          fontSize: AllFontSize.sisxteen,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

}