import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class ApprovedQuotationList extends StatelessWidget{
  ApprovedQuotationList({super.key});

  final saleCycleController=Get.put(SalesCycleVm());


  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if(saleCycleController.quoteApprovalPage.value=="approvedQuotationScreen"){
            saleCycleController.pageNumber=0;
            saleCycleController.pageNumberForQuote=0;
            saleCycleController.getsalesCycleData(saleCycleController.pageNumber, saleCycleController.salesCycleId.value, "", saleCycleController.FromPage.value);
            saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, '');
            Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
            saleCycleController.showDialogForsalescycleUpdate(context, saleCycleController.saleCycleList[0]);
          }else {
            saleCycleController.pageNumber=0;
            saleCycleController.pageNumberForQuote=0;
            saleCycleController.getsalesCycleData(saleCycleController.pageNumber, saleCycleController.salesCycleId.value, "", saleCycleController.FromPage.value);
            saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, '');
            //Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
            Get.back();


          }



      return false;
    },
    child: Scaffold(
        appBar: AppBar(
        backgroundColor: AllColors.primaryDark1,
        iconTheme: IconThemeData(
          color: AllColors.whiteColor,
        ),
        title:Row(
          children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quotation List',
              style: GoogleFonts.poppins(
                color: AllColors.whiteColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '(${saleCycleController.saleCycleList[0].salesCycleId.toString()})',
              style: GoogleFonts.poppins(
                color: AllColors.whiteColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
            Spacer(),
            GestureDetector(
              onTap: (){
                showDialogForFilter(context);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Icon(Icons.filter_alt_rounded, color: AllColors.whiteColor,),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AllColors.whiteColor)
                ),
              ),
            ),
      ])
    ),
      drawer: CustomDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Obx((){
              return Visibility(
                visible:saleCycleController.loading.value ,
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.primaryDark1,
                  color: AllColors.textColor,
                ),
              );
            }),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                child: Obx(() {
                  return BindAprovedQuotationList(context);
                }),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget BindAprovedQuotationList(context){

    if (saleCycleController.quoteList.value.isNotEmpty && saleCycleController.quoteList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (saleCycleController.total_rows /
              saleCycleController.rowsPerPage)
              .toInt();
          if ((saleCycleController.total_rows %
              saleCycleController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${saleCycleController.pageNumberForQuote} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
          if (saleCycleController.pageNumberForQuote + 1 < total_page) {
            saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote + 1,saleCycleController.salesCycleId.value, '');
            saleCycleController.pageNumberForQuote += 1;
          }
        }
      });

      return ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          separatorBuilder: (context, index) => Divider(
            height: .05,
            color: Colors.transparent,
          ),
          shrinkWrap: true,
          itemCount: saleCycleController.quoteList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindListView(context, index);
          });
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }


  Widget BindListView(BuildContext context, int index) {
    String? expClosureDate=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].expClosureDate ?? "");
    String? quoteValidity=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].quoteValidity ?? "");
    String saleCycleStatus = saleCycleController.quoteList[index].quoteStatus??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.yellow[700]!;
        case 'REGRET':
          return Colors.red;
        case 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    String? dateCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteList[index].createdOn??"");
    return Card(
      //margin: EdgeInsets.all(5),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title:Row(
          children: [
            Text(
              "Quote Id : ",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              saleCycleController
                  .quoteList[index]
                  .quoteId??"",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Quote Version : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (saleCycleController
                      .quoteList[index]
                      .quoteVersion.toString()) ,
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Product Category : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  width: size.width*.3,
                  child: Tooltip(
                    message:  saleCycleController
                        .quoteList[index]
                        .productCategory ?? "",
                    child: Text(
                      saleCycleController
                          .quoteList[index]
                          .productCategory ??"",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            Row(

              children: [
                Text(
                  "Quote Status : ",
                  style: GoogleFonts.poppins(
                    color:AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteStatus??"",
                  style: GoogleFonts.poppins(
                    color: getStatusColor(saleCycleStatus),
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Validity : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  quoteValidity.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Expected Closure Date : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  expClosureDate.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Quote Total Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteTotalAmount.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Gross Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteGrossAmount.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Gross Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteGrossAmount.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Created By :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .createdFullName??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(

              children: [
                Text(
                  "Created On : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  dateCreatedOn.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Is Active : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  saleCycleController
                      .quoteList[index]
                      .isActive==0?"No":"Yes",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*Obx(() {
              return Checkbox(
                  value: saleCycleController.isCheck.value == index,
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      saleCycleController.selectCheckbox(index);
                    } else {
                      saleCycleController.isCheck.value = -1;
                    }
                   *//* saleCycleController.isCheck.value = value!;
                    saleCycleController.selectedQuotationIdController.value.text = saleCycleController
                        .quoteList[index].quoteId??"";*//*
                    //saleCycleController.CheckBoxApprovedQuotationList(index);
                  });
                          }),*/

            Obx((){
              return Checkbox(
                value: saleCycleController.checkBoxValues[index] ?? false,
                activeColor: AllColors.primaryDark1,
                onChanged: (bool? value) {
                  saleCycleController.toggleMultiCheckbox(index);
                },
              );
            }),

            SizedBox(width: 8,),
            InkWell(
                onTap: (){
                  saleCycleController.quoteId.value=saleCycleController.quoteList[index].quoteId!;
                  saleCycleController.getQuoteHeaderInformation(saleCycleController.quoteList[index].quoteId, "approvedQuotationScreen");
                },
                child: Icon(Icons.remove_red_eye, color: Colors.blueAccent,)),
          ],
        ),
      ),
    );
  }

  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_moon_rounded, color: AllColors.lightredColor,),
                      SizedBox(width: 5,),
                      Text(
                          'Filter',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.twenteetwo,
                            fontWeight: FontWeight.w700,
                            color: AllColors.primaryDark1,
                          )),
                      Spacer(),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel, color: AllColors.lightredColor,)
                      ),
                    ],
                  ),
                ),
                Divider(height: 1,color: Colors.grey,),
                SingleChildScrollView(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            filterWithQuoteId( context),
                            SizedBox(height: 10),
                            filterWithQuoteValidity( context),
                            SizedBox(height: 10),
                            filterWithQuoteClosureDate( context),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        AllColors.greenblue,
                                      ),
                                    ),
                                    onPressed: ()  {
                                      try{
                                        saleCycleController.filterQuoteIdController.value.clear();
                                        saleCycleController.filterExpectedClosuredateController.value.clear();
                                        saleCycleController.filterQuoteValidityController.value.clear();
                                        saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, 'Approved');
                                        Navigator.pop(context);
                                      }catch(e){
                                        print("Exception..${e.toString()}");
                                      }

                                    },
                                    child: Container(
                                      child: Text('Clear',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.blackColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        AllColors.redColor,
                                      ),
                                    ),
                                    onPressed: ()  {
                                      saleCycleController.pageNumberForQuote=0;
                                      saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, 'Approved');
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      child: Text('Submit',
                                        style: GoogleFonts.poppins(
                                          color: AllColors.blackColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )




                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget filterWithQuoteId(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.filterQuoteIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Id',
          labelText: 'Quote Id',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.filterQuoteValidityController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Quote Validity',
            labelText: 'Quote Validity',
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
          DateTime ending_date = new DateTime(2200);
          DateTime start_date = new DateTime(1900);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
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
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            saleCycleController.filterQuoteValidityController.value.text= outputFormat.format(date);
          else
            saleCycleController.filterQuoteValidityController.value.text = "";
        }

    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.filterExpectedClosuredateController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Expected Closure Date',
            labelText: 'Expected Closure Date',
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
                  primaryColor: AllColors.primaryDark1, // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            saleCycleController.filterExpectedClosuredateController.value.text= outputFormat.format(date);
          else
            saleCycleController.filterExpectedClosuredateController.value.text = "";
        }



    );
  }



}