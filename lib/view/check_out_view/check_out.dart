
 import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/viewModel/CheckIn_vm/check_in_vm.dart';
 import 'dart:io';
import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/font_weight.dart';
import '../../models/checkInModel/vehicle_no_model.dart';
import '../../reources/routes/routes_name.dart';
import '../custom_drawer.dart';

class CheckOutScreen extends StatelessWidget{
  CheckOutScreen({super.key});

  final checkOut_page_controller=Get.put(CheckInViewModel());
  Size size=Get.size;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static String _displayvehiclenoForOption(VehicleNoResponse option) =>
      option.vehicleNumber!;
  @override
  Widget build(BuildContext context) {
    // Parse the input date string to a DateTime object
    DateTime parsedDate = DateTime.parse(checkOut_page_controller.curretn_date);

    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

    List<String> dateTimeParts = checkOut_page_controller.dateTime.split("T");
    print(dateTimeParts);
    String date = dateTimeParts[0];
    String time = dateTimeParts[1];
    List<String> timeParts = time.split('.');
    String fomatedTime = timeParts[0];
    DateTime parsedDate1 = DateTime.parse(date);

    String formattedDate1 = DateFormat('dd-MM-yyyy').format(parsedDate1);
    //todo get fetch data from api and set data to textform field................
    checkOut_page_controller.getAndSetData();

    bool verify =false;
    if(checkOut_page_controller.current_checkIn_response[0].isMaintainKm! > 0){
      if(checkOut_page_controller.current_checkIn_response[0].isWorkingWith!>0){
        verify=true;
      }else{
        verify=false;
      }
    }else{
      verify=true;
    }
    checkOut_page_controller.isvisible.value = verify;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AllColors.primaryDark1,
        iconTheme: IconThemeData(
          color: AllColors.whiteColor,
        ),
        title:Text(
          'Check Out',
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
    child: Column(
      children: [
        //todo header container

        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 3),
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white70, width: .5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Vehicle Type :",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  checkOut_page_controller
                                      .current_checkIn_response[0]
                                      .vehileType
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Place To Visit :",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  checkOut_page_controller
                                      .current_checkIn_response[0]
                                      .placeToVisit
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Working With :",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Container(
                                width: size.width*.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Tooltip(
                                    message:checkOut_page_controller
                                        .current_checkIn_response[0]
                                        .workingWithEmail
                                        .toString()
                                        .isNotEmpty
                                        ? checkOut_page_controller
                                        .current_checkIn_response[0]
                                        .workingWithEmail
                                        .toString()
                                        : 'No',
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis, // Truncate long text with an ellipsis
                                      maxLines: 1, // Display text in a single line
                                      checkOut_page_controller
                                          .current_checkIn_response[0]
                                          .workingWithEmail
                                          .toString()
                                          .isNotEmpty
                                          ? checkOut_page_controller
                                          .current_checkIn_response[0]
                                          .workingWithEmail
                                          .toString()
                                          : 'No',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Check In :",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Text(
                                formattedDate1,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  fomatedTime,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Current Time: ",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Text(formattedDate,
                                style: GoogleFonts.poppins(
                                    color: AllColors.redColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Obx(() {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    checkOut_page_controller
                                        .curretn_time.value,
                                    style: GoogleFonts.poppins(
                                        color: AllColors.redColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Total Time Worked: ",
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Obx((){
                                return Text(checkOut_page_controller.total_work_time.value,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.redColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w300),
                                );
                              }),
                              SizedBox(
                                width: 3,
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.001),
                    Divider(
                      color: AllColors.primaryDark1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 0),
                      child: Align(
                        child: Text(
                          'Check Out',
                          style: TextStyle(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: AllFontWeight.bodyeight),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    //SizedBox(height: size.height * 0.001),
                    Divider(
                      color: AllColors.primaryDark1,
                    ),
                    SizedBox(height: size.height * 0.001),
                    Obx(() {
                      return Visibility(
                        visible: !checkOut_page_controller.isvisible.value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                          child: Column(
                            children: [
                              bindVehicleNoDropDown(context),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 0.36,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      readOnly: true,
                                      controller: checkOut_page_controller
                                          .opening_km_controller,
                                      onChanged: (value) {
                                        checkOut_page_controller
                                            .opening_km_controller.value;
                                      },
                                      //maxLength: 100,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
                                        hintText: "Opening Km",
                                        labelText: 'Opening Km',
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
                                      cursorColor: AllColors.primaryDark1,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Container(
                                    width: size.width * 0.36,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: checkOut_page_controller
                                          .closing_km_controller,
                                      onChanged: (value) {
                                        checkOut_page_controller
                                            .closing_km_controller.value;
                                      },
                                      //maxLength: 100,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
                                        hintText: "Closing Km",
                                        labelText: 'Closing Km',
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
                                      cursorColor: AllColors.primaryDark1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: size.height * 0.02),

                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15),
                        child: TextFormField(
                          controller: checkOut_page_controller.da_controller,
                          onChanged: (value) {
                            checkOut_page_controller.da_controller.value;
                          },
                          //maxLength: 100,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
                            hintText: "AT HQ (DA)",
                            labelText: "AT HQ (DA)",
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
                          cursorColor: AllColors.primaryDark1,
                        ),
                      ),
                    ),
                    //SizedBox(height: size.height * 0.02),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15),
                      child: TextFormField(
                        controller:
                        checkOut_page_controller.remarks_controller,
                        onChanged: (value) {
                          checkOut_page_controller.remarks_controller.value;
                        },
                        //maxLength: 100,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
                          hintText: "Remarks",
                          labelText: "Remarks",
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
                        cursorColor: AllColors.primaryDark1,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    //todo Image Uploader Pickers
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: true,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      checkOut_page_controller
                                          .getFrontImage('CheckOut','');
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
                                        child: GetImageFrontSection(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Front Image',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1, fontWeight: FontWeight.w700, fontSize: AllFontSize.fourtine,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                              !checkOut_page_controller.isvisible.value,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      checkOut_page_controller
                                          .getBackImage('CheckOut');
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
                                          child: GetImageBackSection()),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Back Image',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1, fontWeight: FontWeight.w700, fontSize: AllFontSize.fourtine,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //todo obx comment code when we loading close(Ritik)......
                          /* Obx(() {
                                  return */Expanded(
                            child: DefaultButton(
                              text: "CheckOut",
                              press: () {
                                checkOut_page_controller.loading.value =
                                true;
                                checkOut_page_controller
                                    .SubmitCheckOutDataApi(
                                    checkOut_page_controller
                                        .vehicle_no_controller.value,
                                    checkOut_page_controller
                                        .opening_km_controller.value,
                                    checkOut_page_controller
                                        .remarks_controller.value);

                              },
                              loading:checkOut_page_controller.loading.value,
                            ),
                          ),
                          //   }),

                          // SizedBox(width: 16),

                          Visibility(
                            visible: false,
                            child: Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      AllColors.primaryDark1),
                                ),
                                onPressed: () {
                                  checkOut_page_controller
                                      .vehicle_no_controller
                                      .clear();
                                  checkOut_page_controller
                                      .opening_km_controller
                                      .clear();
                                  checkOut_page_controller
                                      .closing_km_controller
                                      .clear();
                                  checkOut_page_controller.da_controller
                                      .clear();
                                  checkOut_page_controller.remarks_controller
                                      .clear();
                                  Get.toNamed(RoutesName.addExpanseScreen);
                                },
                                child: Text("Reset"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),

    );
  }



  Widget bindVehicleNoDropDown(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Autocomplete<VehicleNoResponse>(
            displayStringForOption: _displayvehiclenoForOption,
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return checkOut_page_controller.vehicleNoList;
              }
              return [];//todo for not show any option on tap textform field....
              /*return checkInpageController.vehicleNoList
                  .where((VehicleNoResponse option) {
                return option.vehicleNumber
                    .toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              }).toList();*/
            },
            onSelected: (VehicleNoResponse selection) {
              print(selection.vehicleNumber);
              checkOut_page_controller.vehicle_no_controller.text = _displayvehiclenoForOption(selection).toString();
              checkOut_page_controller.opening_km_controller.text = selection.closingKm.toString();
            },
            fieldViewBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback onFieldSubmitted) {
              return TextFormField(
                controller: controller..text = checkOut_page_controller.vehicle_no_controller.text,
                focusNode:focusNode,
                readOnly: true,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
                  hintText: 'Vehicle No.',
                  labelText: 'Vehicle No.',
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
                    borderSide: BorderSide(color: AllColors.primaryDark1),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a vehicle number';
                  }
                  return null;
                },
              );
            },
            optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<VehicleNoResponse> onSelected, Iterable<VehicleNoResponse> suggestions) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: suggestions.isEmpty
                        ? Text(
                      'No Record Found!',
                      style: GoogleFonts.poppins(
                        color: AllColors.lightblackColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final VehicleNoResponse option = suggestions.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                            if (_formKey.currentState!.validate()) {
                              print('No selection');
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              option.vehicleNumber.toString(),
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
          ),
        ],
      ),
    );
  }

  Widget GetImageFrontSection() {
    // print(checkInpageController
    //     .current_checkIn_response[0].checkOutImages!.frontImage);
    if (checkOut_page_controller
        .current_checkIn_response[0].checkOutImages!.frontImage
        .toString()
        .contains("no_image_placeholder.png") &&
        (checkOut_page_controller.outFront_image_path.isEmpty)) {
      {

        return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Icon(
              Icons.camera,
              size: 60,
              color: AllColors.primaryDark1,
            )
          /* Image.network(
          checkInpageController.current_checkIn_response[0].checkOutImages!.frontImage.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),*/
        );
      }
    }else if( !checkOut_page_controller
        .current_checkIn_response[0].checkOutImages!.frontImage
        .toString()
        .contains("no_image_placeholder.png") &&
        checkOut_page_controller.outFront_image_path.isEmpty
    ) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          checkOut_page_controller
              .current_checkIn_response[0].checkOutImages!.frontImage.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    }else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(checkOut_page_controller.outFront_image_path.toString()),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    }
  }

  Widget GetImageBackSection() {
    if (checkOut_page_controller
        .current_checkIn_response[0].checkOutImages!.backImage
        .toString()
        .contains("no_image_placeholder.png") &&
        (checkOut_page_controller.outBack_image_path.isEmpty)) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Icon(
            Icons.camera,
            size: 60,
            color: AllColors.primaryDark1,
          )
      );
    }
    if (!checkOut_page_controller
        .current_checkIn_response[0].checkOutImages!.backImage
        .toString()
        .contains("no_image_placeholder.png") &&
        (checkOut_page_controller.outBack_image_path.isEmpty)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          checkOut_page_controller
              .current_checkIn_response[0].checkOutImages!.backImage.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(checkOut_page_controller.outBack_image_path.toString()),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    }
  }



}