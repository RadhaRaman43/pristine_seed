import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/service_managment_vm_directory/bulk_indent_Vm/bulk_indent_vm.dart';
import '../../custom_drawer.dart';


class BulkIndentListScreen extends StatelessWidget{
  BulkIndentListScreen({super.key});

  final bulkIndentController=Get.put(BulkIndentViewModel());

  static String _displayIndentStatusForOption(String option) => option!;
  static String _displayIndentTypeForOption(String option) => option!;

  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title: Row(
            children: [
              Text(
                'Bulk Indent List',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Obx(() {
                print(bulkIndentController.status);
                return  Visibility(
                  visible:bulkIndentController.status=="Completed"?false:true,
                  child: IconButton(onPressed: () {
                    bulkIndentController.is_indent_type_dropDown.value=true;
                    bulkIndentController.is_Showindent.value=false;
                    bulkIndentController.indent_type_controller.text="Bulk_Inventory";
                    bulkIndentController.BulkHeaderCreateApi("");
                    //Get.toNamed(RoutesName.create_bulk_indent_screen);
                  }, icon: Icon(Icons.add)),
                );
              },
               // child:
              ),

              IconButton(onPressed: () {
                showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))

            ],

          ),
        ),
        drawer: CustomDrawer(),
        body: Container(
          height:size.height ,
          width: double.infinity,
          child: Column(
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(top: 0.3),
                  child: Visibility(
                    visible: bulkIndentController.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  ),
                );
              },
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bulkIndentController.globle_search_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: AllColors.primaryDark1), // Customize the border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.grey), // Customize the border color
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            bulkIndentController.pageNumber=0;
                            bulkIndentController.getBulkIndentList(
                                bulkIndentController.pageNumber,bulkIndentController.status.value, global_search: bulkIndentController.globle_search_controller.text);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            bulkIndentController.pageNumber=0;
                            bulkIndentController.globle_search_controller.text = "";

                            bulkIndentController.getBulkIndentList(
                                bulkIndentController.pageNumber ,bulkIndentController.status.value,global_search: bulkIndentController.globle_search_controller.text);

                            // Add clear functionality here
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                        return ActionChip(
                          elevation: 2,
                          padding: EdgeInsets.all(2),
                          backgroundColor:
                          bulkIndentController.status.value == "Pending"
                              ? AllColors.primaryDark1
                              : AllColors.grayColor,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor)),
                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                          //CircleAvatar
                          label: Text('Pending',
                              style: GoogleFonts.poppins(
                                color: bulkIndentController
                                    .status.value ==
                                    "Pending"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              )),
                          onPressed: () {
                            bulkIndentController.pageNumber=0;
                            bulkIndentController.status.value="Pending";
                            bulkIndentController.getBulkIndentList(bulkIndentController.pageNumber, bulkIndentController.status.value);

                          }, //Text
                        );
                      },
                    ),
                    SizedBox(width: 5,),
                    Obx(
                          () {
                        return ActionChip(
                          elevation: 2,
                          padding: EdgeInsets.all(2),
                          backgroundColor: bulkIndentController.status.value == "Completed"
                              ? AllColors.primaryDark1
                              : AllColors.grayColor,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor)),
                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                          //CircleAvatar
                          label: Text('Complete',
                              style: GoogleFonts.poppins(
                                color: bulkIndentController
                                    .status.value ==
                                    "Completed"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              )),
                          onPressed: () {
                            bulkIndentController.pageNumber=0;
                            bulkIndentController.status.value = "Completed";
                            bulkIndentController.getBulkIndentList(bulkIndentController.pageNumber, bulkIndentController.status.value);

                          }, //Text
                        );
                      },
                    ),
                  ],
                ),
              ),

              Obx(() => bindList(context), ),

            ],

          ),
        ),
      ),
    );
  }

  Widget bindList(BuildContext context) {
    ScrollController scrollController = ScrollController();
    if (bulkIndentController
        .bulk_indent_list.value.isNotEmpty &&
        bulkIndentController.bulk_indent_list.value.length > 0){
      scrollController.addListener(() {
        print("rmgfrnrnknkvb");

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (bulkIndentController.total_rows /
              bulkIndentController.rowsPerPage)
              .toInt();
          if ((bulkIndentController.total_rows %
              bulkIndentController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${bulkIndentController.pageNumber} ${bulkIndentController.total_rows} ${bulkIndentController.rowsPerPage} ${total_page}");

          if (bulkIndentController.pageNumber + 1 != total_page) {
            bulkIndentController.getBulkIndentList(
              bulkIndentController.pageNumber+1,bulkIndentController.status.value,);
            this.bulkIndentController.pageNumber += 1;
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
            itemCount: bulkIndentController.bulk_indent_list.value.length,
            itemBuilder: (BuildContext context, int index) {

              return BindIndentListView(context, index);
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

  Widget BindIndentListView(context, int position) {
    print(bulkIndentController
        .bulk_indent_list[position].serviceNo);
    var update_on=StaticMethod.dateTimeToDate(bulkIndentController
        .bulk_indent_list[position].updatedOn??"");
    return InkWell(
      child: ListTile(
          onTap: () {
            bulkIndentController.BulkHeaderCreateApi(bulkIndentController.bulk_indent_list[position].indentNo!);
          },
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Indent No. :",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width * .1,
                  ),
                  Text( bulkIndentController
                      .bulk_indent_list[position]
                      .indentNo!,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.end,),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Location :",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width * .13,
                  ),
                  Text(
                    bulkIndentController
                        .bulk_indent_list[position].locationCode ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    // textAlign: TextAlign.end,
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
                    "Date :",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(update_on.toString(),
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Status ",
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
                      return Text(bulkIndentController
                          .bulk_indent_list[position].indentStatus ?? "",
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
          )),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  child: Container(
                    // height: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //SizedBox(height: 5,),
                        //bindIndentStatusDropDropDown(context),
                      //  SizedBox(height: 5,),
                      //  bindServiceTypeDropDropDown(context),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: bulkIndentController.indent_no_controller,
                          decoration: InputDecoration(
                            labelText: 'Indent No.',
                            hintText: 'Indent No.',
                            hintStyle: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.ten,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w300,
                              //fontSize: AllFontSize.sisxteen,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),

                        /*SizedBox(height: 5,),
                        TextField(
                          controller: bulkIndentController.service_controller,
                          decoration: InputDecoration(
                            labelText: 'Service No.',
                            hintText: 'Service No.',
                            hintStyle: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.ten,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w300,
                              //fontSize: AllFontSize.sisxteen,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),*/
                        SizedBox(
                          height: 10,
                        ),

                        bindDate(context),

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
                                  bulkIndentController.pageNumber=0;
                                  bulkIndentController
                                      .getBulkIndentList(
                                    bulkIndentController.pageNumber,bulkIndentController.status.value,);

                               /*     if(bulkIndentController.indent_status_controller.text=='Pending'){
                                      bulkIndentController.status.value="Pending";
                                    }if(bulkIndentController.indent_status_controller.text=="Completed"){
                                    bulkIndentController.status.value="Completed";
                                  }*/


                                 // bulkIndentController.indent_no_controller.clear();
                                 // bulkIndentController.service_controller.clear();
                                 // bulkIndentController.indent_serviceType_controller.clear();
                                 // bulkIndentController.date_controller.clear();
                                 // bulkIndentController.indent_status_controller.clear();



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
                                  bulkIndentController.indent_no_controller.clear();
                                  bulkIndentController.service_controller.clear();
                                  bulkIndentController.indent_serviceType_controller.clear();
                                  bulkIndentController.date_controller.clear();
                                  bulkIndentController.indent_status_controller.clear();
                                  bulkIndentController.getBulkIndentList(
                                  bulkIndentController.pageNumber,bulkIndentController.status.value,);
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bindIndentStatusDropDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIndentStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return bulkIndentController.indent_status_list;
        }
        return bulkIndentController.indent_status_list;
      },
      onSelected: (String selection) {
        print(selection);
        bulkIndentController.indent_status_controller.text =
            _displayIndentStatusForOption(selection).toString();

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = bulkIndentController.indent_status_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Indent Status',
            labelText: 'Indent Status',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                //fontWeight: FontWeight.w300,
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

  Widget bindServiceTypeDropDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIndentTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return bulkIndentController.service_type_list;
        }
        return bulkIndentController.service_type_list;
      },
      onSelected: (String selection) {
        print(selection);
        bulkIndentController.indent_serviceType_controller.text =
            _displayIndentTypeForOption(selection).toString();

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = bulkIndentController.indent_serviceType_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Indent Type',
            labelText: 'Indent Type',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                //fontWeight: FontWeight.w300,
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
      controller: bulkIndentController.date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Indent Date",
        labelText: 'Indent Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontWeight: FontWeight.w300,
          // fontSize: AllFontSize.sisxteen
        ),
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
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          bulkIndentController.date_controller.text =
              outputFormat.format(date);
        else
          bulkIndentController.date_controller.text = "";
      },
    );
  }
}