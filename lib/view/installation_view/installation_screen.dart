import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/back_button.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../reources/routes/routes_name.dart';
import '../../viewModel/home_vm/HomeViewModel.dart';
import '../../viewModel/installation_vm/installation_vm.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class InstallationScreen extends StatelessWidget {
  InstallationScreen({super.key});

  final installation_page_controller = Get.put(InstallationViewModel());

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Installation List',
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
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor, // Change this to the desired color
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body:  Container(
          width: double.infinity,
          height: size.height,
          child:Container(
            child: Column(
              children: [
                Obx(() {
                    return Container(
                      margin: EdgeInsets.only(top: 0.3),
                      child: Visibility(
                        visible: installation_page_controller.loading.value,
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller:
                        installation_page_controller.globle_search_controller,
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
                                  installation_page_controller
                                      .getServiceInstallationList(
                                      installation_page_controller
                                          .is_done.value,
                                      installation_page_controller.pageNumber,
                                      installation_page_controller
                                          .date_filter.value,
                                      globle_search_value:
                                      installation_page_controller
                                          .globle_search_controller.text);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  installation_page_controller.pageNumber=0;
                                  installation_page_controller
                                      .globle_search_controller.text = "";
                                  installation_page_controller
                                      .getServiceInstallationList(
                                      installation_page_controller
                                          .is_done.value,
                                      installation_page_controller.pageNumber,
                                      installation_page_controller
                                          .date_filter.value);
                                  // Add clear functionality here
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                     // SizedBox(height: size.height*0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                                () {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.all(2),
                                backgroundColor:
                                installation_page_controller.is_done.value == 0
                                    ? AllColors.primaryDark1
                                    : AllColors.grayColor,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                    side: BorderSide(color: AllColors.grayColor)),
                                //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                //CircleAvatar
                                label: Text('Pending',
                                    style: GoogleFonts.poppins(
                                      color: installation_page_controller
                                          .is_done.value ==
                                          0
                                          ? AllColors.whiteColor
                                          : AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )),
                                onPressed: () {
                                  installation_page_controller.pageNumber=0;
                                  installation_page_controller
                                      .globle_search_controller.text = "";
                                  installation_page_controller.is_done.value = 0;
                                  installation_page_controller
                                      .getServiceInstallationList(
                                      installation_page_controller
                                          .is_done.value,
                                      installation_page_controller.pageNumber,
                                      installation_page_controller
                                          .date_filter.value);
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
                                backgroundColor:
                                installation_page_controller.is_done.value == 1
                                    ? AllColors.primaryDark1
                                    : AllColors.grayColor,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                    side: BorderSide(color: AllColors.grayColor)),
                                //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                //CircleAvatar
                                label: Text('Complete',
                                    style: GoogleFonts.poppins(
                                      color: installation_page_controller
                                          .is_done.value ==
                                          1
                                          ? AllColors.whiteColor
                                          : AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )),
                                onPressed: () {
                                  installation_page_controller.pageNumber=0;
                                  installation_page_controller
                                      .globle_search_controller.text = "";
                                  installation_page_controller.is_done.value = 1;
                                  installation_page_controller
                                      .date_filter.value = "";
                                  installation_page_controller
                                      .getServiceInstallationList(
                                      installation_page_controller
                                          .is_done.value,
                                      installation_page_controller.pageNumber,
                                      installation_page_controller
                                          .date_filter.value);
                                }, //Text
                              );
                            },
                          ),





                        ],
                      ),
                     // SizedBox(height: size.height*0.01,),
                      Obx(
                            () {
                          return Visibility(
                            visible: installation_page_controller.is_done.value == 1
                                ? false
                                : true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                //padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                        return ActionChip(
                                          elevation: 2,
                                          padding: EdgeInsets.all(2),
                                          backgroundColor: installation_page_controller
                                              .date_filter.value ==
                                              ""
                                              ? AllColors.primaryDark1
                                              : AllColors.grayColor,
                                          shadowColor: Colors.black,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: AllColors.grayColor)),
                                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                          //CircleAvatar
                                          label: Text('All',
                                              style: GoogleFonts.poppins(
                                                color: installation_page_controller
                                                    .date_filter.value ==
                                                    ""
                                                    ? AllColors.whiteColor
                                                    : AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          onPressed: () {
                                            installation_page_controller.pageNumber=0;
                                            installation_page_controller
                                                .globle_search_controller.text = "";
                                            installation_page_controller.is_done.value =
                                            0;
                                            installation_page_controller
                                                .date_filter.value = "";
                                            installation_page_controller
                                                .getServiceInstallationList(
                                                installation_page_controller
                                                    .is_done.value,
                                                installation_page_controller
                                                    .pageNumber,
                                                installation_page_controller
                                                    .date_filter.value);
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
                                          backgroundColor: installation_page_controller
                                              .date_filter.value ==
                                              "TODAY"
                                              ? AllColors.primaryDark1
                                              : AllColors.grayColor,
                                          shadowColor: Colors.black,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: AllColors.grayColor)),
                                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                          //CircleAvatar
                                          label: Text('Today',
                                              style: GoogleFonts.poppins(
                                                color: installation_page_controller
                                                    .date_filter.value ==
                                                    "TODAY"
                                                    ? AllColors.whiteColor
                                                    : AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          onPressed: () {
                                            installation_page_controller.pageNumber=0;
                                            installation_page_controller
                                                .globle_search_controller.text = "";
                                            installation_page_controller.is_done.value =
                                            0;
                                            installation_page_controller
                                                .date_filter.value = "TODAY";
                                            installation_page_controller
                                                .getServiceInstallationList(
                                                installation_page_controller
                                                    .is_done.value,
                                                installation_page_controller
                                                    .pageNumber,
                                                installation_page_controller
                                                    .date_filter.value);
                                          }, //Text
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Obx(() {
                                        return ActionChip(
                                          elevation: 2,
                                          padding: EdgeInsets.all(2),
                                          backgroundColor: installation_page_controller
                                              .date_filter.value ==
                                              "OverDue"
                                              ? AllColors.primaryDark1
                                              : AllColors.grayColor,
                                          shadowColor: Colors.black,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: AllColors.grayColor)),
                                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                          //CircleAvatar
                                          label: Text('Breached',
                                              style: GoogleFonts.poppins(
                                                color: installation_page_controller
                                                    .date_filter.value ==
                                                    "OverDue"
                                                    ? AllColors.whiteColor
                                                    : AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          onPressed: () {
                                            installation_page_controller.pageNumber=0;
                                            installation_page_controller
                                                .globle_search_controller.text = "";
                                            installation_page_controller.is_done.value =
                                            0;
                                            installation_page_controller
                                                .date_filter.value = "OverDue";
                                            installation_page_controller
                                                .getServiceInstallationList(
                                                installation_page_controller
                                                    .is_done.value,
                                                installation_page_controller
                                                    .pageNumber,
                                                installation_page_controller
                                                    .date_filter.value);
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
                                          backgroundColor: installation_page_controller
                                              .date_filter.value ==
                                              "Future"
                                              ? AllColors.primaryDark1
                                              : AllColors.grayColor,
                                          shadowColor: Colors.black,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: AllColors.grayColor)),
                                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                          //CircleAvatar
                                          label: Text('Future',
                                              style: GoogleFonts.poppins(
                                                color: installation_page_controller
                                                    .date_filter.value ==
                                                    "Future"
                                                    ? AllColors.whiteColor
                                                    : AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          onPressed: () {
                                            installation_page_controller.pageNumber=0;
                                            installation_page_controller
                                                .globle_search_controller.text = "";
                                            installation_page_controller.is_done.value =
                                            0;
                                            installation_page_controller
                                                .date_filter.value = "Future";
                                            installation_page_controller
                                                .getServiceInstallationList(
                                                installation_page_controller
                                                    .is_done.value,
                                                installation_page_controller
                                                    .pageNumber,
                                                installation_page_controller
                                                    .date_filter.value);
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
                                          backgroundColor: installation_page_controller
                                              .date_filter.value ==
                                              "Wait For Indent"
                                              ? AllColors.primaryDark1
                                              : AllColors.grayColor,
                                          shadowColor: Colors.black,
                                          shape: StadiumBorder(
                                              side: BorderSide(color: AllColors.grayColor)),
                                          //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                                          //CircleAvatar
                                          label: Text('Wait For Indent',
                                              style: GoogleFonts.poppins(
                                                color: installation_page_controller
                                                    .date_filter.value ==
                                                    "Wait For Indent"
                                                    ? AllColors.whiteColor
                                                    : AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          onPressed: () {
                                            installation_page_controller.pageNumber=0;
                                            installation_page_controller
                                                .globle_search_controller.text = "";
                                            installation_page_controller.is_done.value =
                                            0;
                                            installation_page_controller
                                                .date_filter.value = "Wait For Indent";
                                            installation_page_controller
                                                .getServiceInstallationList(
                                                installation_page_controller
                                                    .is_done.value,
                                                installation_page_controller
                                                    .pageNumber,
                                                installation_page_controller
                                                    .date_filter.value);
                                          }, //Text
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Obx(() {
                  return BindCustomerListView(context);
                }),
              ],
            ),
          )
        ),




        /*Container(
          child: RefreshIndicator(
            onRefresh: () async {

            },
            child:  ListView(
              children: [
                // Replace these with your list items
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
                ListTile(title: Text('Item 3')),
              ],
            ),
          ),
        )*/




      ),
    );
  }

  Widget BindCustomerListView(context) {
    ScrollController scrollController = ScrollController();
    if (installation_page_controller
            .service_intallatallation_list.value.isNotEmpty &&
        installation_page_controller
                .service_intallatallation_list.value.length > 0){
      scrollController.addListener(() {
        print("rmgfrnrnknkvb");

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (installation_page_controller.total_rows /
                  installation_page_controller.rowsPerPage)
              .toInt();
          if ((installation_page_controller.total_rows %
                  installation_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${installation_page_controller.pageNumber} ${installation_page_controller.total_rows} ${installation_page_controller.rowsPerPage} ${total_page}");

          if (installation_page_controller.pageNumber + 1 != total_page) {
            installation_page_controller.getServiceInstallationList(
                installation_page_controller.is_done.value,
                installation_page_controller.pageNumber+1,
                installation_page_controller.date_filter.value);
            this.installation_page_controller.pageNumber += 1;
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
            itemCount: installation_page_controller
                .service_intallatallation_list.value.length,
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


  Widget BindCustomerRequestListView(context, int position) {
    var service_tat_date=StaticMethod.convertDateFormat1(installation_page_controller
        .service_intallatallation_list[position].serviceTatDatetime??"");
    return InkWell(
      child: ListTile(
          onTap: () {
            installation_page_controller.id = installation_page_controller
                .service_intallatallation_list[position].id!;
            installation_page_controller.getServiceInstallationDetails(
                installation_page_controller
                    .service_intallatallation_list[position].id!,
                "");
            print(service_tat_date);
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
                  ),
                  SizedBox(
                    width: size.width * .1,
                  ),
                  Text(
                    installation_page_controller
                        .service_intallatallation_list[position].serviceNo!,
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
                        fontWeight: FontWeight.w700),
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
                    "Customer :",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width * .065,
                  ),
                  Container(
                    width: size.width * .61,
                    child: Tooltip(
                      message: installation_page_controller
                          .service_intallatallation_list[position]
                          .customerName!,
                      child: Text(
                        installation_page_controller
                            .service_intallatallation_list[position]
                            .customerName!,
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
                      message: installation_page_controller
                          .service_intallatallation_list[position]
                          .customerAddress??"",
                      child: Text(
                        installation_page_controller
                            .service_intallatallation_list[position]
                            .customerAddress??"",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Contact No.:",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Text(
                    installation_page_controller
                        .service_intallatallation_list[position].customerPhoneNo ?? "",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                  Text(
                    "",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
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
                      return Text(installation_page_controller
                          .service_intallatallation_list[position].isUnderApproval!>0 &&
                          installation_page_controller
                              .service_intallatallation_list[position].serviceStatus=="Completed"?"Under Approval":
                      installation_page_controller
                          .service_intallatallation_list[position]
                          .serviceStatus!,
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

  Future<void> _downloadExcel(BuildContext context) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    sheetObject.cell(CellIndex.indexByString("A1")).value = "Sample Data";

    // Get the directory to save the file.
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/sample.xlsx";
    final file = File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
    print(path);
    print(file);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excel file downloaded to $path')),
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
                    height: 420,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                         controller: installation_page_controller.customer_no_search_controller,
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
                          controller: installation_page_controller.serial_no_search_controller,
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
                          controller: installation_page_controller.invoice_no_search_controller,
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
                          controller: installation_page_controller.item_no_search_controller,
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

                                  installation_page_controller
                                      .getServiceInstallationList(
                                      installation_page_controller
                                          .is_done.value,
                                      installation_page_controller.pageNumber,
                                      installation_page_controller
                                          .date_filter.value);
                                   installation_page_controller.customer_no_search_controller.clear();
                                  installation_page_controller.serial_no_search_controller.clear();
                                   installation_page_controller.invoice_no_search_controller.clear();
                                   installation_page_controller.item_no_search_controller.clear();
                                  installation_page_controller.invoice_date_search_controller.clear();


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
                                  installation_page_controller.customer_no_search_controller.clear();
                                  installation_page_controller.serial_no_search_controller.clear();
                                  installation_page_controller.invoice_no_search_controller.clear();
                                  installation_page_controller.item_no_search_controller.clear();
                                  installation_page_controller.invoice_date_search_controller.clear();

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
      controller: installation_page_controller.invoice_date_search_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Invoice Date",
        labelText: 'Invoice Date',
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
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          installation_page_controller.invoice_date_search_controller.text =
              outputFormat.format(date);
        else
          installation_page_controller.invoice_date_search_controller.text = "";
      },
    );
  }

}
