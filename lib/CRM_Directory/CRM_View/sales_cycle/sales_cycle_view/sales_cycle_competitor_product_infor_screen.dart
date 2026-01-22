import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_competitor_product_infor_vm.dart';


class SalesCycleCompetitorProductInforScreen extends StatelessWidget{
  static String _displaySaleCycleStatusForOption(String option) =>
      option;

  static String _displayApprovalStatusForOption(String option) =>
      option;
  static String _displaySaleCycleActiveForOption(String option) =>
      option;

  SalesCycleCompetitorProductInforScreen({super.key});
  final saleCycleCompetitorController=Get.put(SalesCycleCompetitorProductInforVm());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.homeScreen);
        return false;
      }, child: Scaffold(
        appBar:  AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sales Cycle Competitor List',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(Icons.filter_alt_sharp, color: AllColors.whiteColor,),
                    ),
                  ),
                  onTap: (){
                    showDialogForFilter(context);
                  },
                ),
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx((){
                return Visibility(
                  visible:saleCycleCompetitorController.loading.value ,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                  child: Obx(() {
                    return bindQuoteItemList(context);
                  }),
                ),
              )

            ],),
        )
    ),
    );
  }

  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                //mainAxisSize: MainAxisSize.min, // Ensure minimal height
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shield_moon_rounded,
                          color: AllColors.primaryDark1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Filter ",
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 5,),
                              bindFilterData('Quote Id',saleCycleCompetitorController.filterQuoteIdController.value ),
                              SizedBox(height: 10),
                              bindFilterData('Customer Name',saleCycleCompetitorController.accountNameController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Customer Code',saleCycleCompetitorController.accountCodeController.value ),
                              SizedBox(
                                height: 10,
                              ),
                              bindFilterData('Sale Cycle Id',saleCycleCompetitorController.filterSalesCycleIdController.value ),
                              SizedBox(height: 10,),
                              filterWithSalesCycleStatus(context),
                              SizedBox(height: 10),
                              filterWithSalesCycleApprovalStatus(context),
                              SizedBox(height: 10),
                              filterWithQuoteAccepted(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10),
                              bindFilterData('Category Approval',saleCycleCompetitorController.category_Approval_controller.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Item Code',saleCycleCompetitorController.filterItemCodeController.value ),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              filterWithQuoteCreatedOn(context),
                              SizedBox(height: 10,),
                              bindProductCategory(context),
                              SizedBox(height: 10,),
                              bindProductCategoryTypeDropDown(context),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: _buildButton(
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            saleCycleCompetitorController.filterDataChecker.value='';
                            saleCycleCompetitorController.clearAllField();
                            saleCycleCompetitorController.clearFilterData();
                            saleCycleCompetitorController.pageNumber=0;
                            saleCycleCompetitorController.getGalesCycleCompetitorProductInformationGet( saleCycleCompetitorController.pageNumber);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            saleCycleCompetitorController.pageNumber=0;
                            saleCycleCompetitorController.getGalesCycleCompetitorProductInformationGet( saleCycleCompetitorController.pageNumber);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            saleCycleCompetitorController.filterDataChecker.value='';
                            saleCycleCompetitorController.SaveFilterData();
                          },
                        )),
                      ],
                    ),
                  ),
                  
                  /*Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark, width: 1),
                                )),
                            onPressed: () {
                              saleCycleCompetitorController.pageNumber=0;
                              saleCycleCompetitorController.getGalesCycleCompetitorProductInformationGet( saleCycleCompetitorController.pageNumber);
                              Get.back();
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
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                )),
                            onPressed: () {
                              saleCycleCompetitorController.clearAllField();
                              saleCycleCompetitorController.pageNumber=0;
                              saleCycleCompetitorController.getGalesCycleCompetitorProductInformationGet( saleCycleCompetitorController.pageNumber);
                              Get.back();
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
                  ),*/
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildButton({required String text, required Color borderColor, required Color textColor, required VoidCallback onTap,}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AllColors.whiteColor,
        foregroundColor: AllColors.lightgreyColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      onPressed: onTap,
      child: Center(
        child: FittedBox( // 🔥 PREVENTS OVERFLOW
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget bindFilterData(String hintdata, TextEditingController value,){
    return  TextField(
      controller: value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: hintdata,
          hintText: hintdata,
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
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  Widget bindQuoteItemList(BuildContext context) {
    if (saleCycleCompetitorController.salesCycleCompetitorProductInformationList.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (saleCycleCompetitorController.total_rows /
              saleCycleCompetitorController.rowsPerPage)
              .toInt();
          if ((saleCycleCompetitorController.total_rows %
              saleCycleCompetitorController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${saleCycleCompetitorController.pageNumber} ${saleCycleCompetitorController.total_rows} ${saleCycleCompetitorController.rowsPerPage} ${total_page}");

          if (saleCycleCompetitorController.pageNumber + 1 < total_page) {
            saleCycleCompetitorController.getGalesCycleCompetitorProductInformationGet(
                saleCycleCompetitorController.pageNumber+1
            );
            saleCycleCompetitorController.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
        padding: EdgeInsets.only(bottom: 10),
        separatorBuilder: (context, index) => Divider(
          height: .05,
          color: Colors.transparent,
        ),
        shrinkWrap: true,
        itemCount: saleCycleCompetitorController.salesCycleCompetitorProductInformationList.value.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return bindPendingListView(context, index);
        },
      );
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }



  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
    Color color = AllColors.textColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Tooltip(
            message: value??"",
            child: Text(
              value ?? "",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: color,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildClickableLabel({required String label, required String? value, required VoidCallback onTap,}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: onTap,
            child: Tooltip(
              message: value ?? "",
              child: Text(
                value ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bindPendingListView(BuildContext context, int position) {
    var createdOn=StaticMethod.formatDateWithTime(saleCycleCompetitorController
        .salesCycleCompetitorProductInformationList[position]
        .createdOn??"");
    String saleCycleStatus = saleCycleCompetitorController
        .salesCycleCompetitorProductInformationList[position].salesCycleStatus?.toLowerCase()??"";
    String saleQuoteAccepted= saleCycleCompetitorController
        .salesCycleCompetitorProductInformationList[position].quoteAccepted?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'suspect' :
          return Colors.yellow[700]!;
        case 'prospect' :
          return AllColors.redColor;
        case 'propose':
          return Colors.green;
        default:
          return Colors.black;
      }
    }

    Color getQouteAcceptedColor(String status) {
      switch (status) {
        case 'open'||'won' :
          return Colors.blueAccent;
        case 'loss' :
          return AllColors.redColor;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          contentPadding: EdgeInsets.only(left: 5, right: 3),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Item Code : ",
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    saleCycleCompetitorController
                        .salesCycleCompetitorProductInformationList[position]
                        .itemCode??"",
                    style: GoogleFonts.poppins(
                      color: AllColors.textColor,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        subtitle: Column(
          children: [

            _buildLabelWithValue(
              label: "Sales Cycle Id: ",
              value:saleCycleCompetitorController
                  .salesCycleCompetitorProductInformationList[position].salesCycleId,
            ),

            _buildLabelWithValue(
              label: "Sales Cycle Status: ",
              value:saleCycleCompetitorController
                  .salesCycleCompetitorProductInformationList[position].salesCycleStatus,
              color: getStatusColor(saleCycleStatus),
            ),
            
            _buildLabelWithValue(
              label: "Quote Accepted: ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].quoteAccepted,
              color: getQouteAcceptedColor(saleQuoteAccepted),
            ),
            
            _buildLabelWithValue(
              label: "Line Status : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].lineStatus,
              color: Colors.blue,
            ),
            _buildClickableLabel(
              label: "Customer Name : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].accountName,
              
              onTap: () {
                /*account_vm_controller.view = 'FromSaleCycleMainScreen';
                contact_vm_controller.view = 'FromSaleCycleMainScreen';
                account_vm_controller.getAccMasterBuyCodeApi(
                  saleCycleCompetitorController.saleCycleList[position].accountCode!,
                );*/
              },
            ),
            _buildLabelWithValue(
              label: "Customer Code : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].accountCode,),

            _buildLabelWithValue(
              label: "Product Category : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].productCategory,),

            _buildLabelWithValue(
              label: "Qty : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].qty.toString(),),
            _buildLabelWithValue(
              label: "Item Code : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].itemCode,),
            _buildLabelWithValue(
              label: "Item Description : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].itemDescription,),
            _buildLabelWithValue(
              label: "Unit Price : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].unitPrice.toString(),
            ),

            _buildLabelWithValue(label: "Mrp Price : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].mrpPrice.toString(),),

            _buildLabelWithValue(label: "Methodex Price : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].methodexPrice.toString(),
            ),
            _buildLabelWithValue(label: "Competitor Name : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].competitorName,

            ),
            _buildLabelWithValue(label: "Competitor Price : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].competitorPrice.toString(),

            ),
            _buildLabelWithValue(label: "Created By : ",
              value: saleCycleCompetitorController.salesCycleCompetitorProductInformationList[position].createdFullName,

            ),
            _buildLabelWithValue(label: "Created On : ", value: createdOn,),
          ],
        ),
      ),
    );
  }

  Widget filterWithQuoteValidity(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleCompetitorController.filterQuoteValidityController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Quote Validity Start Date -End Date',
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
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
          /* initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),*/
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1,
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final startDate = DateFormat('yyyy-MM-dd').format(picked.start);
          final endDate = DateFormat('yyyy-MM-dd').format(picked.end);
          saleCycleCompetitorController.quoteValidityStartToEnd.value =
          "$startDate@$endDate";
          saleCycleCompetitorController.filterQuoteValidityController.value.text =
          '$startDate - $endDate';
        } else {
          saleCycleCompetitorController.filterQuoteValidityController.value.text = '';
          saleCycleCompetitorController.quoteValidityStartToEnd.value = "";
        }
      },
    );

  }

  Widget filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleCompetitorController.filterExpectedClosuredateController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Expected Closure Start Date -End Date',
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
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
          /* initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),*/
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1,
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final startDate = DateFormat('yyyy-MM-dd').format(picked.start);
          final endDate = DateFormat('yyyy-MM-dd').format(picked.end);
          saleCycleCompetitorController.extClosureStartToEnd.value = "$startDate@$endDate";
          saleCycleCompetitorController.filterExpectedClosuredateController.value.text =
          '$startDate - $endDate';
        } else {
          saleCycleCompetitorController.filterExpectedClosuredateController.value.text =
          '';
          saleCycleCompetitorController.extClosureStartToEnd.value = "";
        }
      },
    );

  }


  Widget filterWithQuoteId(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleCompetitorController.filterQuoteIdController.value,
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
          )),
    );
  }

  bindProductCategory(BuildContext context) {
    return Obx(() {
      if (saleCycleCompetitorController.productCategoryController.value.text.isNotEmpty && saleCycleCompetitorController.filterDataChecker.value=='1') {
        List<String> nameList = saleCycleCompetitorController.productCategoryController.value.text.split(',');

        saleCycleCompetitorController.Selected_Item_Category_master_list_without_task.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: saleCycleCompetitorController.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: saleCycleCompetitorController.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: saleCycleCompetitorController.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
            hintText:  "Product Category" ,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty) {
            return Text(
              "Product Category",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1, // Match your hint color
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              selectedItems.map((e) => e.categoryName).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<ItemCategoryMstModel> selectedList) {
          saleCycleCompetitorController.Selected_Item_Category_master_list_without_task.value = selectedList;
          saleCycleCompetitorController.productCategoryController.value.text =
              selectedList.map((e) => e.categoryName).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.categoryName ?? ""),
          ),
        ),
      );
    });
  }
  Widget bindProductCategoryTypeDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: saleCycleCompetitorController.product_category_type_Controller.value,
      label: Text(
        "Product Category Type",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.sisxteen,
            fontWeight: FontWeight.w500),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AllColors.primaryDark1,),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
        filled: false,
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
      ),
      onSelected: (String? selection) {
        print(selection);
        saleCycleCompetitorController.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: saleCycleCompetitorController.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = saleCycleCompetitorController.clusterGetByEmailList;
      if (saleCycleCompetitorController.clusterName_controller.value.text.isNotEmpty && saleCycleCompetitorController.filterDataChecker.value=='1') {
        List<String> nameList = saleCycleCompetitorController.clusterName_controller.value.text.split('|');
        saleCycleCompetitorController.SelectedCluster_list.value =[];
        saleCycleCompetitorController.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && saleCycleCompetitorController.SelectedCluster_list.isEmpty) {
          saleCycleCompetitorController.SelectedCluster_list.assignAll(availableItems);
          saleCycleCompetitorController.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          saleCycleCompetitorController.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = saleCycleCompetitorController.SelectedCluster_list;
      final selectedText = selected.isEmpty
          ? null
          : selected.map((e) => e.geoValue).join(', ');

      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              final searchController = TextEditingController();
              final tempSelected = <ClusterModal>[];
              tempSelected.addAll(saleCycleCompetitorController.SelectedCluster_list);

              List<ClusterModal> allItems =
                  saleCycleCompetitorController.clusterGetByEmailList;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty ? allItems : allItems.where((c) => (c.geoValue ?? "").toLowerCase().contains(query)).toList();

                final allSelected = allItems.isNotEmpty && tempSelected.length == allItems.length;

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Select Clusters',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: AllColors.primaryDark1),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))
                            ],
                          ),
                        ),

                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                            ),
                            onChanged: (v) => setState(() {}),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title: const Text('Select All'),
                            value: allSelected,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  tempSelected
                                      .clear();
                                  tempSelected.addAll(allItems);
                                } else {
                                  tempSelected.clear();
                                }
                              });
                            },
                          ),
                        ),

                        const Divider(height: 1),

                        // List
                        Expanded(
                          child: filtered.isEmpty
                              ? const Center(child: Text('No clusters found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.geoValue ?? "") ==
                                  (item.geoValue ?? ""));
                              return CheckboxListTile(
                                title: Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) =>
                                      (s.geoValue ?? "") ==
                                          (item.geoValue ?? ""));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        // Done button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.green,
                                    shadowColor: AllColors.green,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {

                                    saleCycleCompetitorController.filterDataChecker.value='';
                                    saleCycleCompetitorController.SelectedCluster_list.assignAll(tempSelected);
                                    saleCycleCompetitorController.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    saleCycleCompetitorController.getRegionsWithClusterFilterGetByEmail();

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Done',style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: "Cluster Name", // 👈 Label restored here
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Row(
            children: [
              Expanded(
                child: selectedText == null
                    ? Text(
                  "Select Cluster",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: AllFontSize.sisxteen,
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    });
  }
  Widget bindRegionNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = saleCycleCompetitorController.regionwithclusterGetByEmailList;
      if (saleCycleCompetitorController.RegionName_controller.value.text.isNotEmpty && saleCycleCompetitorController.filterDataChecker.value=='1') {
        saleCycleCompetitorController.SelectedRegion_list.value=[];
        List<String> nameList = saleCycleCompetitorController.RegionName_controller.value.text.split('|');
        saleCycleCompetitorController.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && saleCycleCompetitorController.SelectedRegion_list.isEmpty) {
          saleCycleCompetitorController.SelectedRegion_list.assignAll(availableItems);
          saleCycleCompetitorController.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${saleCycleCompetitorController.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = saleCycleCompetitorController.SelectedRegion_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) => e.geoValue).join(', ');

      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              final searchController = TextEditingController();
              final tempSelected = <RegionWithClusterFilterModal>[];
              tempSelected.addAll(saleCycleCompetitorController.SelectedRegion_list);

              final allItems = saleCycleCompetitorController.regionwithclusterGetByEmailList;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty ? allItems : allItems.where((c) => (c.geoValue ?? "").toLowerCase().contains(query)).toList();

                final allSelected = allItems.isNotEmpty && tempSelected.length == allItems.length;

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Select Regions',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: AllColors.primaryDark1),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))
                            ],
                          ),
                        ),

                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                            ),
                            onChanged: (v) => setState(() {}),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title: const Text('Select All'),
                            value: allSelected,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  tempSelected.clear();
                                  tempSelected.addAll(allItems);
                                } else {
                                  tempSelected.clear();
                                }
                              });
                            },
                          ),
                        ),

                        const Divider(height: 1),

                        // List
                        Expanded(
                          child: filtered.isEmpty
                              ? const Center(child: Text('No regions found'))
                              : ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) =>
                              (s.geoValue ?? "") ==
                                  (item.geoValue ?? ""));
                              return CheckboxListTile(
                                title: Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) =>
                                      (s.geoValue ?? "") ==
                                          (item.geoValue ?? ""));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        // Done button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.green,
                                    shadowColor: AllColors.green,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    saleCycleCompetitorController.filterDataChecker.value='';
                                    saleCycleCompetitorController.SelectedRegion_list.assignAll(tempSelected);
                                    saleCycleCompetitorController.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Done',style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: "Region Name", // 👈 Label like before
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Row(
            children: [
              Expanded(
                child: selectedText == null
                    ? Text(
                  "Select Region",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: AllFontSize.sisxteen,
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    });
  }

  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleCompetitorController.createdOnCnontroller.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Created On',
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
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
          /* initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),*/
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1,
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final startDate = DateFormat('yyyy-MM-dd').format(picked.start);
          final endDate = DateFormat('yyyy-MM-dd').format(picked.end);
          saleCycleCompetitorController.createdOnStartToEnd.value = "$startDate@$endDate";
          saleCycleCompetitorController.createdOnCnontroller.value.text =
          '$startDate - $endDate';
        } else {
          saleCycleCompetitorController.createdOnCnontroller.value.text = '';
          saleCycleCompetitorController.createdOnStartToEnd.value = "";
        }
      },
    );
  }

  filterWithQuoteAccepted(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: saleCycleCompetitorController.filterQuoteAcceptedController.value,
        label: Text(
          "Select Quote Accepted",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),


        onSelected: (String? selection) {
          print(selection);

          saleCycleCompetitorController.filterQuoteAcceptedController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        saleCycleCompetitorController.qouteAcceptedList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  Widget filterWithSalesCycleApprovalStatus(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: saleCycleCompetitorController.filterSalesCycleApprovalStatusController.value,
        label: Text(
          "Approval Status",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),


        onSelected: (String? selection) {
          print(selection);
          saleCycleCompetitorController.filterSalesCycleApprovalStatusController.value.text =
              _displayApprovalStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        saleCycleCompetitorController.ApprovalStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  Widget filterWithSalesCycleStatus(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: saleCycleCompetitorController.filterSalesCycleStatusController.value,
        label: Text(
          "Sales Cycle Status",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),


        onSelected: (String? selection) {
          print(selection);
          saleCycleCompetitorController.filterSalesCycleStatusController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
          /*print('IsActive.....${saleCycleCompetitorController.solutionAcceptedController
              .value.text}');*/

        },
        dropdownMenuEntries:
        saleCycleCompetitorController.SaleCycleStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );


  }

  filterWithItemCode() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: saleCycleCompetitorController.filterItemCodeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Item Code',
          labelText: 'Item Code',
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
          )),
    );
  }

}



