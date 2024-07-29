import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/reasonModel/reason_master_response.dart';
import '../../reources/routes/routes_name.dart';
import '../../viewModel/customer_complain_vm/customer_complain_vm.dart';
import '../custom_drawer.dart';

class CustomerComplainScreen extends StatelessWidget{

  final customer_complain_vm = Get.put(CustomerComplainVm());
  Size size = Get.size;

  static String _displayReasonCodeForOption(ReasonModel option) =>
      option.reasonCode!;
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
                'Customer Complaint List',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.eighteen,
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
    if (customer_complain_vm.customer_complain_details_list.value.isNotEmpty &&
        customer_complain_vm.customer_complain_details_list.value.length > 0){
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
            customer_complain_vm.getCustomerComplainList();
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
            itemCount: customer_complain_vm.customer_complain_details_list.value.length,
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
    var service_tat_date=StaticMethod.convertDateFormat1(customer_complain_vm.customer_complain_details_list[index].completedon??"");
    return ListTile(
      contentPadding: EdgeInsets.only(left: 5, right: 10),
      onTap: (){
        customer_complain_vm.getAllComplain(customer_complain_vm.customer_complain_details_list[index].id!);
        raiseAndShowComplainBottomSheet(context,customer_complain_vm.customer_complain_details_list[index].id!);
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
                    .customer_complain_details_list[index].serviceno!,
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
                  message:"${customer_complain_vm.customer_complain_details_list[index].customername!} (${customer_complain_vm.customer_complain_details_list[index].customerno!})",
                  child: Text("${customer_complain_vm.customer_complain_details_list[index].customername!} (${customer_complain_vm.customer_complain_details_list[index].customerno!})",
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
                  message: customer_complain_vm.customer_complain_details_list[index].invoiceno ??"",
                  child: Text(
                    customer_complain_vm.customer_complain_details_list[index].invoiceno ??"",
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
                  message: customer_complain_vm.customer_complain_details_list[index].serialno ??"",
                  child: Text(
                    customer_complain_vm.customer_complain_details_list[index].serialno ??"",
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
                  return Text(customer_complain_vm.customer_complain_details_list[index].servicestatus??"",
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
                    height: size.height*.5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: customer_complain_vm.service_no_search_controller,
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
                          controller: customer_complain_vm.serial_no_search_controller,
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
                          controller: customer_complain_vm.customer_name_search_controller,
                          decoration: InputDecoration(
                            labelText: 'Customer Name',
                            hintText: 'Customer Name',
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
                          controller: customer_complain_vm.item_no_search_controller,
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

                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: customer_complain_vm.item_name_search_controller,
                          decoration: InputDecoration(
                            labelText: 'Item Name',
                            hintText: 'Item Name',
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

                                  customer_complain_vm.getCustomerComplainList();
                                  customer_complain_vm.service_no_search_controller.clear();
                                  customer_complain_vm.serial_no_search_controller.clear();
                                  customer_complain_vm.customer_name_search_controller.clear();
                                  customer_complain_vm.item_no_search_controller.clear();
                                  customer_complain_vm.item_name_search_controller.clear();


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
                                  customer_complain_vm.service_no_search_controller.clear();
                                  customer_complain_vm.serial_no_search_controller.clear();
                                  customer_complain_vm.item_name_search_controller.clear();
                                  customer_complain_vm.item_no_search_controller.clear();
                                  customer_complain_vm.customer_name_search_controller.clear();
                                  customer_complain_vm.getCustomerComplainList();

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


  void showComplainDetailBottomSheet(BuildContext context) {
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
                  child: Container(
                    height: size.height*.5,
                    child: Obx(() {
                      return BindComlainListView(context);
                    }),
                    
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget BindComlainListView(context) {
    if (customer_complain_vm.all_complain_list.value.isNotEmpty &&
        customer_complain_vm.all_complain_list.value.length > 0){
      return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),
            shrinkWrap: true,
            itemCount: customer_complain_vm.all_complain_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindComplainListViewTile(context, index);
            }),
      );
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
                            "Select Complain",
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
                  message:customer_complain_vm.all_complain_list[index].itemname??"" ,
                  child: Text(customer_complain_vm.all_complain_list[index].itemname?? "",
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
                "Complain Remark :   ",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500),
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
                  return Text(customer_complain_vm.all_complain_list[index].servicestatus??"",
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
              Text(
                'Raise Complaint',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                height: .01,
                color: AllColors.lightgreyColor,
              ),
            ],
          ),

          content: Container(
            height: size.height * .24,
            child: Column(
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
          ),
        );
      },
    );
  }
  Widget bindReasonDropDown(context) {
    return Autocomplete<ReasonModel>(
      displayStringForOption: _displayReasonCodeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return customer_complain_vm.reason_master_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return customer_complain_vm.reason_master_list.value
            .where((ReasonModel option) {
          return option.reasonCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
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

