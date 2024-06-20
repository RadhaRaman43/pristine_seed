import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/app_colors.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';

import '../../constants/app_font_size.dart';
import '../../viewModel/preventive_vm/preventive_vm.dart';

class PreventiveScreen extends StatelessWidget{
  PreventiveScreen({super.key});
  final preventive_page_controller=Get.put(PreventiveViewModel());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
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
                'Preventive List',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {
                showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))
            ],
          )

        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: preventive_page_controller.refreshPreventiveListData,
          child: Container(
            width: double.infinity,
           height: size.height,
            child: Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible:preventive_page_controller.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                },
                ),
                Container(
                   padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: preventive_page_controller.globle_search_controller,
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
                                  preventive_page_controller.getServicePreventiveList(preventive_page_controller.is_done.value,preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value,globle_search_value:preventive_page_controller.globle_search_controller.text);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  preventive_page_controller.globle_search_controller.text="";
                                  preventive_page_controller.getServicePreventiveList(preventive_page_controller.is_done.value,preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);

                                  // Add clear functionality here
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                                () {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.all(2),
                                backgroundColor: preventive_page_controller.is_done.value == 0 ? AllColors.primaryDark1
                                    : AllColors.grayColor,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                    side: BorderSide(color: AllColors.grayColor)),
                                //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                //CircleAvatar
                                label: Text('Pending',
                                    style: GoogleFonts.poppins(
                                      color:preventive_page_controller.is_done.value == 0 ? AllColors.whiteColor
                                          : AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )),
                                onPressed: () {
                                  preventive_page_controller.is_done.value = 0;
                                  preventive_page_controller
                                      .getServicePreventiveList(
                                      preventive_page_controller.is_done.value,
                                      preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);
                                }, //Text
                              );
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Obx(
                                () {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.all(2),
                                backgroundColor:
                                preventive_page_controller.is_done.value == 1
                                    ? AllColors.primaryDark1
                                    : AllColors.grayColor,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                    side: BorderSide(color: AllColors.grayColor)),
                                //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                //CircleAvatar
                                label: Text('Complete',
                                    style: GoogleFonts.poppins(
                                      color: preventive_page_controller
                                          .is_done.value ==
                                          1
                                          ? AllColors.whiteColor
                                          : AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )),
                                onPressed: () {
                                  preventive_page_controller.is_done.value = 0;
                                  preventive_page_controller.is_done.value = 1;
                                  preventive_page_controller
                                      .date_filter.value = "";
                                  preventive_page_controller
                                      .getServicePreventiveList(
                                      preventive_page_controller.is_done.value,
                                      preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);
                                }, //Text
                              );
                            },
                          ),

                          Spacer(),
                          //Obx(() {
                          //   return
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.all(5),
                              backgroundColor: AllColors.primaryDark1,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Tooltip(
                                message: "Create Preventive Call ",
                                child: Text('Add',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.whiteColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              onPressed: () {
                                preventive_page_controller.createPreventiveCalenderCallApi();

                              }, //Text
                            ),
                          ),
                          //  },),
                        ],
                      ),

                      Obx((){
                        return  Visibility(
                          visible:preventive_page_controller.is_done.value==1?false:true ,
                          child: Container(
                          //  padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return ActionChip(
                                    elevation: 2,
                                    padding: EdgeInsets.all(2),
                                    backgroundColor: preventive_page_controller.date_filter.value == "" ? AllColors.primaryDark1
                                        : AllColors.grayColor,
                                    shadowColor: Colors.black,
                                    shape: StadiumBorder(
                                        side: BorderSide(color: AllColors.grayColor)),
                                    //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                    //CircleAvatar
                                    label: Text('All',
                                        style: GoogleFonts.poppins(
                                          color:preventive_page_controller.date_filter.value == "" ? AllColors.whiteColor
                                              : AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onPressed: () {
                                      preventive_page_controller.is_done.value = 0;
                                      preventive_page_controller.date_filter.value = "";

                                      preventive_page_controller
                                          .getServicePreventiveList(
                                          preventive_page_controller.is_done.value,
                                          preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);

                                    }, //Text
                                  );
                                },
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Obx(
                                      () {
                                    return ActionChip(
                                      elevation: 2,
                                      padding: EdgeInsets.all(2),
                                      backgroundColor:
                                      preventive_page_controller.date_filter.value == "TODAY" ? AllColors.primaryDark1
                                          : AllColors.grayColor,
                                      shadowColor: Colors.black,
                                      shape: StadiumBorder(
                                          side: BorderSide(color: AllColors.grayColor)),
                                      //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                      //CircleAvatar
                                      label: Text('Today',
                                          style: GoogleFonts.poppins(
                                            color: preventive_page_controller.date_filter.value == "TODAY"? AllColors.whiteColor
                                                : AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      onPressed: () {
                                        preventive_page_controller.is_done.value = 0;
                                        preventive_page_controller.date_filter.value = "TODAY";
                                        preventive_page_controller
                                            .getServicePreventiveList(
                                            preventive_page_controller.is_done.value,
                                            preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);
                                      }, //Text
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Obx(
                                      () {
                                    return ActionChip(
                                      elevation: 2,
                                      padding: EdgeInsets.all(2),
                                      backgroundColor:
                                      preventive_page_controller.date_filter.value == "OverDue"
                                          ? AllColors.primaryDark1
                                          : AllColors.grayColor,
                                      shadowColor: Colors.black,
                                      shape: StadiumBorder(
                                          side: BorderSide(color: AllColors.grayColor)),
                                      //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                      //CircleAvatar
                                      label: Text('Breached',
                                          style: GoogleFonts.poppins(
                                            color: preventive_page_controller.date_filter.value == "OverDue" ? AllColors.whiteColor
                                                : AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      onPressed: () {
                                        preventive_page_controller.is_done.value = 0;
                                        preventive_page_controller.date_filter.value = "OverDue";
                                        preventive_page_controller
                                            .getServicePreventiveList(
                                            preventive_page_controller.is_done.value,
                                            preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);
                                      }, //Text
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Obx(
                                      () {
                                    return ActionChip(
                                      elevation: 2,
                                      padding: EdgeInsets.all(2),
                                      backgroundColor:
                                      preventive_page_controller.date_filter.value == "Future"
                                          ? AllColors.primaryDark1
                                          : AllColors.grayColor,
                                      shadowColor: Colors.black,
                                      shape: StadiumBorder(
                                          side: BorderSide(color: AllColors.grayColor)),
                                      //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                      //CircleAvatar
                                      label: Text('Future',
                                          style: GoogleFonts.poppins(
                                            color: preventive_page_controller.date_filter.value == "Future" ? AllColors.whiteColor
                                                : AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      onPressed: () {
                                        preventive_page_controller.is_done.value = 0;
                                        preventive_page_controller.date_filter.value = "Future";
                                        preventive_page_controller
                                            .getServicePreventiveList(
                                            preventive_page_controller.is_done.value,
                                            preventive_page_controller.pageNumber,preventive_page_controller.date_filter.value);
                                      }, //Text
                                    );
                                  },
                                )

                              ],
                            ),
                          ),
                        );
                      },),
                    ],
                  ),
                ),
               Obx(() {
                 return  BindCustomerListView(context);
               }),
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (preventive_page_controller
        .service_preventive_list.isNotEmpty &&
        preventive_page_controller
            .service_preventive_list.length >
            0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (preventive_page_controller.total_rows /
              preventive_page_controller.rowsPerPage)
              .toInt();
          if ((preventive_page_controller.total_rows %
              preventive_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${preventive_page_controller.pageNumber} ${preventive_page_controller.total_rows} ${preventive_page_controller.rowsPerPage} ${total_page}");

          if (preventive_page_controller.pageNumber + 1 != total_page) {
            preventive_page_controller.getServicePreventiveList(
                preventive_page_controller.is_done.value,
                preventive_page_controller.pageNumber+1,preventive_page_controller.date_filter.value);
            this.preventive_page_controller.pageNumber += 1;
          }
        }
      });

      return Expanded(
        child: ListView.separated(
          controller:scrollController ,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),
            shrinkWrap: true,
            itemCount: preventive_page_controller
                .service_preventive_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindCustomerRequestListView(context, index);
            }),
      );
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }


  Widget BindCustomerRequestListView(context, int position) {
    var service_tat_date=StaticMethod.convertDateFormat1(preventive_page_controller
        .service_preventive_list[position].serviceTatDatetime?? "");
    return InkWell(
      child: ListTile(
          onTap: () {


            preventive_page_controller.id = preventive_page_controller
                .service_preventive_list[position].id!;
            preventive_page_controller.getServicePreventiveDetails(
                preventive_page_controller
                    .service_preventive_list[position].id!,"");
          },
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Service No.:",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: size.width * .1,
                  ),
                  Text(
                    preventive_page_controller
                        .service_preventive_list[position].serviceNo!,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                  Text(service_tat_date??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.end,
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
                    "Customer :",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: size.width * .065,
                  ),
                  Container(
                    width: size.width * .61,
                    child: Tooltip(
                      message: preventive_page_controller
                          .service_preventive_list[position]
                          .customerName??"",
                      child: Text(
                        preventive_page_controller
                            .service_preventive_list[position]
                            .customerName??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),

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
                    "Address :",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),

                  ),
                  SizedBox(
                    width: size.width * .1,
                  ),
                  Container(
                    width: size.width * .61,
                    child: Tooltip(
                      message:preventive_page_controller
                          .service_preventive_list[position]
                          .customerAddress??"" ,
                      child: Text(
                        preventive_page_controller
                            .service_preventive_list[position]
                            .customerAddress??"",
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),

                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Contact No.:",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Text(
                    preventive_page_controller
                        .service_preventive_list[position].customerPhoneNo?? "",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                    textAlign: TextAlign.end,
                  ),
                  Spacer(),
                  Text(
                    "",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
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
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: size.width * .04,
                  ),
                  Spacer(),
                  Text(
                      preventive_page_controller
                          .service_preventive_list[position]
                          .serviceStatus!,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters ",
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
                    height: 420,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: preventive_page_controller.customer_no_search_controller,
                          decoration: InputDecoration(
                            labelText: 'Customer No.',
                            hintText: 'Customer No.',
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
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: preventive_page_controller.serial_no_search_controller,
                          decoration: InputDecoration(
                            labelText: 'Serial No.',
                            hintText: 'Serial No.',
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
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: preventive_page_controller.invoice_no_search_controller,
                          decoration: InputDecoration(
                            labelText: 'Invoice No.',
                            hintText: 'Invoice No.',
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
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: preventive_page_controller.item_no_search_controller,
                          decoration: InputDecoration(
                            labelText: 'Item No.',
                            hintText: 'Item No.',
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
                                  color: AllColors.primaryDark1), // Change the color to green
                            ),
                          ),
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        bindDate(context),
                        SizedBox(
                          height: 10,
                        ),

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

                                  preventive_page_controller
                                      .getServicePreventiveList(
                                      preventive_page_controller
                                          .is_done.value,
                                      preventive_page_controller.pageNumber,
                                      preventive_page_controller
                                          .date_filter.value);
                                  preventive_page_controller.customer_no_search_controller.clear();
                                  preventive_page_controller.serial_no_search_controller.clear();
                                  preventive_page_controller.invoice_no_search_controller.clear();
                                  preventive_page_controller.item_no_search_controller.clear();
                                  preventive_page_controller.invoice_date_search_controller.clear();


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
                                  preventive_page_controller.customer_no_search_controller.clear();
                                  preventive_page_controller.serial_no_search_controller.clear();
                                  preventive_page_controller.invoice_no_search_controller.clear();
                                  preventive_page_controller.item_no_search_controller.clear();
                                  preventive_page_controller.invoice_date_search_controller.clear();

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

  Widget bindDate(context) {
    return TextFormField(
      controller: preventive_page_controller.invoice_date_search_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Invoice Date",
        labelText: 'Invoice Date',
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
          preventive_page_controller.invoice_date_search_controller.text =
              outputFormat.format(date);
        else
          preventive_page_controller.invoice_date_search_controller.text = "";
      },
    );
  }


}