import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/show_route_vm/show_route_vm.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/font_weight.dart';
import '../../models/checkInModel/employee_master_model.dart';
import '../custom_drawer.dart';

class ShowRoutesScreen extends StatelessWidget{
  ShowRoutesScreen({super.key});
  final show_route_page_controller=Get.put(ShowRouteViewModel());
  Size size= Get.size;
  static String _displayemployeeForOption(EmpMasterResponse option) => option.loginEmailId!;
  static String _displayIntervalForOption(String option) => option!;
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Location Routes',
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
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Obx(() {
            if (show_route_page_controller.loading.value) {
              // Show a progress indicator while loading
              return Center(
                child:
                CircularProgressIndicator(), // You can use any progress indicator here
              );
            } else {
              // Show the UI when not loading
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: false,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                        width: (size.width - 20) * 0.40,
                                        child: bindDatePicker(context)),
                                    Container(
                                      width: (size.width - 20) * 0.60,
                                      padding: EdgeInsets.only(left: 10),
                                      //child: bindEmployeeDropDown(context),
                                      child:bindIntervalDropDown(context),
                                    )
                                  ],
                                ),
                              ),
                              bindemployeeDropDown(context),
                              SizedBox(height: size.height*0.01,),
                              //todo like dislike button section
                              Obx(() {
                                return Visibility(
                                  visible: show_route_page_controller.isVisible.value,
                                  child: Container(
                                    width: double.infinity,
                                    height: size.height*.8,
                                    child: showGoogleMap(context),
                                  ),
                                );
                              })
                              // bindListLayout(),
                            ],
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
  //todo date picker
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: show_route_page_controller.filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
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
            });
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          show_route_page_controller.filter_date_controller.text =
              outputFormat.format(date);
        else
          show_route_page_controller.filter_date_controller.text = "";

      },
    );
  }

  //todo show map..............
  Widget showGoogleMap(context){
    return GoogleMap(
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      mapToolbarEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,
      gestureRecognizers: Set()
        ..add(Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer()))
        ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
        ..add(
            Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),

      markers: show_route_page_controller.marker,
      onMapCreated: (GoogleMapController controller){
        show_route_page_controller.completer.complete(controller);
      },
      polylines: show_route_page_controller.polyline,
      myLocationEnabled: true,
      initialCameraPosition: show_route_page_controller.kGooglePlex,
      mapType: MapType.normal,
    );
  }
  Widget bindIntervalDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIntervalForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return show_route_page_controller.interval_list;
        }
        return show_route_page_controller.interval_list;
      },
      onSelected: (String selection) {
        print(selection);
        show_route_page_controller.typeAheadControllerInterval.text = _displayIntervalForOption(selection).toString();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = show_route_page_controller.typeAheadControllerInterval.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Interval',
            labelText: 'Interval',
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
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
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
                  final String option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen // Change the text color here
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
  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return show_route_page_controller.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return show_route_page_controller.employess_List
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
        show_route_page_controller.typeAheadControllerEmployee.text =
            _displayemployeeForOption(selection).toString();
        show_route_page_controller.getCoordinatesList(context);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller..text=show_route_page_controller.typeAheadControllerEmployee.text,
          focusNode: focusNode,
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
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
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
}