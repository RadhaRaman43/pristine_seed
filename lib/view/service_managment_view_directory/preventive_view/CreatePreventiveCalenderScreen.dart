import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/createPreventiveCalenderModel.dart';
import '../../../viewModel/service_managment_vm_directory/preventive_vm/preventive_vm.dart';
import '../../custom_drawer.dart';


class CreatePreventiveCalenderScreen extends StatelessWidget{
  CreatePreventiveCalenderScreen({super.key});
  final create_preventive_page_controller=Get.put(PreventiveViewModel());
  Size size= Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.preventive_screen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Preventive Calender',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Spacer(),
              GestureDetector(
                onTap: (){
                  create_preventive_page_controller.getAMCRequestInvoice("");
                  Get.toNamed(RoutesName.add_new_preventive_calender_screen);
                },
                child: CircleAvatar(
                  minRadius: 18,
                    child: Icon(Icons.add,color:AllColors.primaryDark1),
                ),
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                    return Container(
                      margin: EdgeInsets.only(top: 0.3),
                      child: Visibility(
                        visible: create_preventive_page_controller.loading
                            .value,
                        child: LinearProgressIndicator(
                          backgroundColor: AllColors.primaryDark1,
                          color: AllColors.textColor,
                        ),
                      ),
                    );
                  },
                ),
                Obx(() {
                  return BindCustomerListView(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget BindCustomerListView(context) {
    if (create_preventive_page_controller
        .create_preventive_calender_list.value.isNotEmpty &&
        create_preventive_page_controller
            .create_preventive_calender_list.value.length >
            0) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), // Prevents parent ListView from scrolling conflicts
          itemCount: create_preventive_page_controller
              .create_preventive_calender_list.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindPreventiveRequestListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

/*  Widget BindCustomerRequestListView(context, int position) {
    return ListTile(
        subtitle: Container(
          width: double.infinity,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 3,top: 2),
                width: 100,
                height: 50,
                color: AllColors.yellowColor,
                child: Text(create_preventive_page_controller.create_preventive_calender_list[position].warrantyDate!,
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize:AllFontSize.fourtine,
                    fontWeight: FontWeight.w700,
                  ),

                ),
              ),

              ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                  return Text("fgfgfgfgfgfgfgfgggfgfgggg",style: TextStyle(color: AllColors.primaryDark1,fontSize: 20),);

              }, separatorBuilder: (context, index) {
                return Divider();
              }, itemCount:2)
            ],
          ),
        ),
        );
  }*/


  Widget BindPreventiveRequestListView(BuildContext context, int position) {
   // var monthName=StaticMethod.onlyMonthName(create_preventive_page_controller.create_preventive_calender_list[position].warrantyDate!);
    var monthName=StaticMethod.onlyMonthNameThreeCharacter(create_preventive_page_controller.create_preventive_calender_list[position].warrantyDate!);
    var yearName=StaticMethod.onlyYearName(create_preventive_page_controller.create_preventive_calender_list[position].warrantyDate!);
    return InkWell(
      onTap: () {

      },
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10,right: 10),
        subtitle: Container(

          decoration: BoxDecoration(
            boxShadow: <BoxShadow> [
              BoxShadow(
                offset: Offset(1.0, 0.0),
                blurRadius: 5.0,
                color: Colors.black54
              )

            ],color: Colors.white
          ),
         // / width: double.infinity,

          height: 100,  // Increased height to fit horizontal ListView
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                width: size.width*.20,
                height: 95,
                child: Column(
                  children: [
                    Text(monthName!,
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Text(yearName!,
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text("(${create_preventive_page_controller.create_preventive_calender_list[position].pendingPmRequest.toString()})",
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                  ],
                )
              ),
            VerticalDivider(),
                Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = create_preventive_page_controller.create_preventive_calender_list[position].preventiveRequests![index];
                    return bindItemDetails(context,index,item);
                  },
                  separatorBuilder: (context, index) {
                    return VerticalDivider();
                  },
                  itemCount: create_preventive_page_controller.create_preventive_calender_list[position].preventiveRequests!.length,  // Adjust item count as necessary
                ),
              ),
            ],
          ),



          /*Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 3, top: 2),
                width: 100,
                height: 50,
                color: AllColors.primaryDark1,
                child: Text(
                  "nfkndfjkgn",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
             Row(children: [
               Text("jfdngjkdnjkgbndfjk"),
             ],)
             // SizedBox(height: 10),
            */

          /*  Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      child: Text(
                        "Item $index",
                        style: TextStyle(
                          color: AllColors.primaryDark1,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return VerticalDivider();
                  },
                  itemCount: 5,  // Adjust item count as necessary
                ),
              ),*/
          /*
            ],
          ),*/
        ),
      ),
    );
  }

  bindItemDetails(BuildContext context, int index, PreventiveRequests item) {
   return  InkWell(
     onTap: () {
       showPreventiveDetailsBottomSheet(context,item);
     },
     child: Container(
          width:size.width*.35 ,
          padding: EdgeInsets.symmetric(horizontal: 4),
          //alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                SizedBox(height: 8,),
                Container(
                  width: size.width*.25,
                  child: Tooltip(
                    message:item.itemName!+"(${item.itemNo!})" ,
                    child: Text(item.itemName!+"(${item.itemNo!}) ",
                      style:GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 3,),
                Text(item.serialNo!,
                    style:GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: 10,
                )
                ),
                SizedBox(height: 3,),
                Text(item.serviceNo!,
                    style:GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: 10,
                    )
                ),
              ],
            ),
          )


      ),
   );
  }

  void
  showPreventiveDetailsBottomSheet(BuildContext context, PreventiveRequests item){
    final now = DateTime.now();
    create_preventive_page_controller.warranty_visit_time_controller.text= DateFormat.Hms().format(now);
    var Date=StaticMethod.convertDateFormat1(item.warrantyDate!);
    create_preventive_page_controller.warranty_visit_date_controller.text=Date!;

    var warranty_date=StaticMethod.convertDateFormat1(item.warrantyDate??"");

    print(Date);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
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
                        "Show Preventive Details ",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Icon(Icons.cancel,color: AllColors.primaryDark1,),
                        ),
                      )
                    ],
                  ),
                ),
                Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
                SingleChildScrollView(
                  child: Container(
                    height: 420,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Warranty Id :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.warrantyId!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Service id :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.serviceId!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Item Name :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Container(
                              width: size.width*.55,
                              child: Tooltip(
                                message:item.itemName!+"(${item.itemNo})" ,
                                child: Text(item.itemName!+"(${item.itemNo})",style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                  
                          ],
                        ),
                        SizedBox(height: 3,),
                  
                        Row(
                          children: [
                            Text("Service No. :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.serviceNo!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),
                  
                          ],
                        ),
                        SizedBox(height: 3,),
                  
                        Row(
                          children: [
                            Text("Serial No. :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.serialNo!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Warranty Date  :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(warranty_date??"",style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),
                  
                          ],
                        ),
                       SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Customer No. :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.customerNo!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Customer Name :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.customerName!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Customer Address :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Container(
                              width: size.width*.55,
                              child: Tooltip(
                                message:item.customerAddress! ,
                                child: Text(item.customerAddress!,style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Customer PinCode :",style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                            ),),
                            Spacer(),
                            Text(item.customerPincode!,style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        SizedBox(height: 3,),
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          
                          child:  bindDate(context),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          child:  bindTime(context),
                        ),


                        SizedBox(height: 10,),

                        ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AllColors.textColor2,
                                side: BorderSide(
                                    color: AllColors
                                        .primaryDark1,
                                    width: 1)),
                            onPressed: () {
                            String date= create_preventive_page_controller.warranty_visit_date_controller.text;
                             String time= create_preventive_page_controller.warranty_visit_time_controller.text;
                              String? date1= StaticMethod.convertDateFormat(date);


                              String final_date_and_time=date1!+"T"+time;


                            create_preventive_page_controller.createPreventiveCallApi(item.warrantyId!,item.serviceId!,final_date_and_time);

                            print(final_date_and_time);


                            },


                            child: Tooltip(
                              message: "Create Call",
                              child: Text(
                                "Create Call",
                                style: GoogleFonts.poppins(
                                  color: AllColors
                                      .primaryDark1,
                                  fontSize:
                                  AllFontSize.sisxteen,
                                  fontWeight:
                                  FontWeight.w300,
                                ),
                              ),
                            )),
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
      controller: create_preventive_page_controller.warranty_visit_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Visit Date",
        labelText: 'Visit Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime currentDate = DateTime.now();
        DateTime ending_date = DateTime(2200);
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: currentDate, // Set the firstDate to currentDate
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                // accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null) {
          create_preventive_page_controller.warranty_visit_date_controller.text =
              outputFormat.format(date);
        }
      },
    );
  }



  /*Widget bindDate(context) {
    return TextFormField(
     controller: create_preventive_page_controller.warranty_visit_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Visit Date",
        labelText: 'Visit Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
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
          create_preventive_page_controller.warranty_visit_date_controller.text =
              outputFormat.format(date);
      //  else
         // create_preventive_page_controller.warranty_visit_date_controller.text = "";
      },
    );
  }*/

/*  Widget bindTime(BuildContext context) {
    return TextFormField(
      controller: create_preventive_page_controller.warranty_visit_time_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Visit Time",
        labelText: 'Visit Time',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1),
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        if (time != null) {
          final now = DateTime.now();
          final formattedTime = DateFormat('HH:mm:ss').format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
          create_preventive_page_controller.warranty_visit_time_controller.text = formattedTime;
        } else {
          // Set current time if no time is picked
          final now = DateTime.now();
          final formattedTime = DateFormat('HH:mm:ss').format(DateTime(now.year, now.month, now.day, now.hour, now.minute));
          create_preventive_page_controller.warranty_visit_time_controller.text = formattedTime;
        }
      },
    );
  }*/

  Widget bindTime(BuildContext context) {
    return TextFormField(
      controller: create_preventive_page_controller.warranty_visit_time_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Visit Time",
        labelText: 'Visit Time',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.fourtine),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1),
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        if (time != null) {
          print("ok");
          final now = DateTime.now();
          final formattedTime = DateFormat('HH:mm:ss').format(DateTime(now.year, now.month, now.day, time.hour, time.minute, now.second));
          print(create_preventive_page_controller.warranty_visit_time_controller.text);
          create_preventive_page_controller.warranty_visit_time_controller.text = formattedTime;
        } else {
          print("Cancel");
          // Set current time if no time is picked
          final now = DateTime.now();
          final formattedTime = DateFormat('HH:mm:ss').format(now);
          print(create_preventive_page_controller.warranty_visit_time_controller.text);
          create_preventive_page_controller.warranty_visit_time_controller.text = formattedTime;
        }
      },
    );
  }


}
