
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../constants/static_methods.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_advise_all_list_vm.dart';


class AllSalesAdviseLineItemsScreen extends StatelessWidget{
  AllSalesAdviseLineItemsScreen({super.key});
  SalesAdviseAllListVm salesAdviseAllVmController=Get.put(SalesAdviseAllListVm());
  //SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  static String _displaySalesAdviseStatusForOption(String option) => option;
  static String _displaySaleCycleActiveForOption(String option) => option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.homeScreen);
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
                  'All Sales Advise Items ',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      showDialogForFilter(context);
                    },
                    child: Icon(Icons.filter_alt_rounded, size: 30,)),

              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: salesAdviseAllVmController.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:salesAdviseAllVmController.loading.value ,
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
                      return BindCustomerListView(context);
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (salesAdviseAllVmController.salesAdviseList.value.isNotEmpty && salesAdviseAllVmController.salesAdviseList.value.length > 0) {
      print("ghd");
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (salesAdviseAllVmController.total_rows /
              salesAdviseAllVmController.rowsPerPage)
              .toInt();
          if ((salesAdviseAllVmController.total_rows %
              salesAdviseAllVmController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${salesAdviseAllVmController.pageNumber} ${salesAdviseAllVmController.total_rows} ${salesAdviseAllVmController.rowsPerPage} ${total_page}");
          if (salesAdviseAllVmController.pageNumber + 1 < total_page) {
            salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber+1);
            salesAdviseAllVmController.pageNumber += 1;
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
          itemCount: salesAdviseAllVmController.salesAdviseList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    String? quoteValidityDate=StaticMethod.convertDateFormat1(salesAdviseAllVmController.salesAdviseList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(salesAdviseAllVmController.salesAdviseList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(salesAdviseAllVmController.salesAdviseList[position].createdOn ?? "");
   // String? completedOn=StaticMethod.dateTimeToDate(salesAdviseAllVmController.salesAdviseList[position]. ?? "");
    String saleAdviseStatus = salesAdviseAllVmController.salesAdviseList[position].salesAdviceStatus?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'draft':
          return Colors.red[900]!;
        case 'completed':
          return Colors.green;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Sales Advise Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    child: Tooltip(
                      message: salesAdviseAllVmController.salesAdviseList[position].salesAdviceId?? "",
                      child: Text(
                        salesAdviseAllVmController.salesAdviseList[position].salesAdviceId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color:Colors.blue,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),

            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(
                label: "Sales Cycle Id : ",
                value: salesAdviseAllVmController.salesAdviseList[position].salesCycleId,
                //width: size.width * 0.33,
                color: Colors.blue,
              ),
              _buildLabelWithValue(
                label: "Sales Advise Status : ",
                value: salesAdviseAllVmController.salesAdviseList[position].salesAdviceStatus,
                //width: size.width * 0.33,
                color: getStatusColor(saleAdviseStatus),
              ),

              _buildLabelWithValue(
                label: "Quote Id : ",
                value: salesAdviseAllVmController.salesAdviseList[position].quoteId,
              ),
              _buildLabelWithValue(
                label: "Quote Version: ",
                value: salesAdviseAllVmController.salesAdviseList[position].quoteVersion.toString(),
              ),
              _buildLabelWithValue(
                label: "Quote Validity: ",
                value: salesAdviseAllVmController.salesAdviseList[position].quoteValidity.toString(),
              ),
              _buildLabelWithValue(
                label: "Customer Code : ",
                value: salesAdviseAllVmController.salesAdviseList[position].accountCode,
              ),
              _buildLabelWithValue(
                label: "Customer Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position].accountName,
              ),
              _buildLabelWithValue(
                label: "Contact Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position].contactName,
              ),
              _buildLabelWithValue(
                label: "Expected Closure Date : ",
                value:  expectedClosuredateDate,
              ),
              _buildLabelWithValue(
                label: "Quote Total Amt : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .quoteTotalAmount.toString(),
              ),
              _buildLabelWithValue(
                label: "Quote Gst Amt. : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .quoteGstAmount.toString(),
              ),
              _buildLabelWithValue(
                label: "Quote Gross Amt. : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .quoteGrossAmount.toString(),
              ),
              _buildLabelWithValue(
                label: "Created By : ",
                value:  salesAdviseAllVmController.salesAdviseList[position]
                    .createdFullName,
              ),
              _buildLabelWithValue(
                label: "Created On : ",
                value: createdOn.toString(),
              ),
              _buildLabelWithValue(
                label: "Region Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position]
                    .branchHeadValue,
              ),
              _buildLabelWithValue(
                label: "Cluster Name : ",
                value: salesAdviseAllVmController.salesAdviseList[position]
                    .clustureHeadValue,
              ),
              _buildLabelWithValue(
                  label: "Item Code : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .itemCode
              ),
              _buildLabelWithValue(
                  label: "Item Name : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .itemName
              ),
              _buildLabelWithValue(
                  label: "Qty : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .qty.toString()
              ),
              _buildLabelWithValue(
                  label: "LSP : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .listSellingPrice.toString()
              ),
              _buildLabelWithValue(
                  label: "Sales Credit : ",
                  value: salesAdviseAllVmController.salesAdviseList[position]
                      .salesCredit.toString()
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Is Spr : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.blackColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(salesAdviseAllVmController.salesAdviseList[position]
                      .isSpr==1?"Yes":"No",
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          initialChildSize: 0.75,
          //minChildSize: 0.5,
          //maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure minimal height
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
                          "Sales Advise Filter ",
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
                              filterWithSalesAdviseStatus(context),
                              SizedBox(height: 10),
                              bindFilterData('Sale Advise Id',salesAdviseAllVmController.salesAdviseIdController.value ),
                              SizedBox(height: 10),
                              bindFilterData('Quote Id',salesAdviseAllVmController.quoteIdController.value ),
                              SizedBox(height: 10),
                              bindFilterData('Quote Version',salesAdviseAllVmController.quoteVersionController.value ),
                              SizedBox(height: 10),
                              bindFilterData('Sale Cycle Id',salesAdviseAllVmController.saleCycleIdController.value ),
                              SizedBox(height: 10),
                              bindFilterData('Customer Name',salesAdviseAllVmController.accountNameController.value ),
                              SizedBox(height: 10),
                              bindFilterData('Customer Code',salesAdviseAllVmController.accountCodeController.value ),
                              SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10,),
                              bindFilterData('RH Approval',salesAdviseAllVmController.rh_Approval_controller.value ),
                              SizedBox(height: 10,),
                              bindFilterData('CBH Approval',salesAdviseAllVmController.cbh_Approval_controller.value ),
                              SizedBox(height: 10,),
                              bindFilterData('GM Approval',salesAdviseAllVmController.Gm_Approval_Controller.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Item Code',salesAdviseAllVmController.itemCodeController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Item Name',salesAdviseAllVmController.itemNameController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Qty',salesAdviseAllVmController.quantityFilterController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('LSP',salesAdviseAllVmController.LSPFilterController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('MAP',salesAdviseAllVmController.MAPFilterController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('BTP',salesAdviseAllVmController.BTPFilterController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('BM %',salesAdviseAllVmController.BM_per_ilterController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('GM %',salesAdviseAllVmController.GM_per_ilterController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Standard Cost',salesAdviseAllVmController.StandardCostController.value ),
                              SizedBox(height: 10,),
                              bindFilterData('Standard Credit',salesAdviseAllVmController.SalesCreditController.value ),
                              SizedBox(height: 10,),
                              filterWithQuoteCreatedOn(context),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
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
                            salesAdviseAllVmController.filterDataChecker.value='';
                            salesAdviseAllVmController.clearAllSaleAdviseLineFilterData();
                            salesAdviseAllVmController.clearAllField();
                            salesAdviseAllVmController.pageNumber=0;
                            salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            salesAdviseAllVmController.pageNumber=0;
                            salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber);
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
                            salesAdviseAllVmController.filterDataChecker.value='';
                            salesAdviseAllVmController.SaveAllSaleAdviseLineFilterData();
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
                              salesAdviseAllVmController.pageNumber=0;
                              salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber);
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
                              salesAdviseAllVmController.clearAllField();
                              salesAdviseAllVmController.pageNumber=0;
                              salesAdviseAllVmController.getSaleCycleProductByIdList(salesAdviseAllVmController.pageNumber);
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

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesAdviseAllVmController.filterQuoteValidityController.value,
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
           /*initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          )*/
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
          salesAdviseAllVmController.quoteValidityStartToEnd.value="$startDate@$endDate";
          salesAdviseAllVmController.filterQuoteValidityController.value.text = '$startDate - $endDate';
        } else {
          salesAdviseAllVmController.filterQuoteValidityController.value.text = '';
          salesAdviseAllVmController.quoteValidityStartToEnd.value="";
        }
      },
    );

  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesAdviseAllVmController.filterExpectedClosuredateController
          .value,
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
           /*initialDateRange: DateTimeRange(
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
          salesAdviseAllVmController.extClosureStartToEnd.value="$startDate@$endDate";
          salesAdviseAllVmController.filterExpectedClosuredateController.value.text = '$startDate - $endDate';
        } else {
          salesAdviseAllVmController.filterExpectedClosuredateController.value.text = '';
          salesAdviseAllVmController.extClosureStartToEnd.value="";
        }
      },
    );

  }

  filterWithSalesAdviseStatus(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: salesAdviseAllVmController.salesAdviseStatusController.value,
        label: Text(
          "Sales Advise Status",
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
          salesAdviseAllVmController.salesAdviseStatusController.value.text =
              _displaySalesAdviseStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        salesAdviseAllVmController.salesAdviseStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }


  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = salesAdviseAllVmController.clusterGetByEmailList;
      if (salesAdviseAllVmController.clusterName_controller.value.text.isNotEmpty && salesAdviseAllVmController.filterDataChecker.value=='1') {
        List<String> nameList = salesAdviseAllVmController.clusterName_controller.value.text.split('|');
        salesAdviseAllVmController.SelectedCluster_list.value =[];
        salesAdviseAllVmController.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && salesAdviseAllVmController.SelectedCluster_list.isEmpty) {
          salesAdviseAllVmController.SelectedCluster_list.assignAll(availableItems);
          salesAdviseAllVmController.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          salesAdviseAllVmController.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = salesAdviseAllVmController.SelectedCluster_list;
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
              tempSelected.addAll(salesAdviseAllVmController.SelectedCluster_list);

              List<ClusterModal> allItems =
                  salesAdviseAllVmController.clusterGetByEmailList;

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

                                    salesAdviseAllVmController.filterDataChecker.value='';
                                    salesAdviseAllVmController.SelectedCluster_list.assignAll(tempSelected);
                                    salesAdviseAllVmController.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    salesAdviseAllVmController.getRegionsWithClusterFilterGetByEmail();

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
      final availableItems = salesAdviseAllVmController.regionwithclusterGetByEmailList;
      if (salesAdviseAllVmController.RegionName_controller.value.text.isNotEmpty && salesAdviseAllVmController.filterDataChecker.value=='1') {
        salesAdviseAllVmController.SelectedRegion_list.value=[];
        List<String> nameList = salesAdviseAllVmController.RegionName_controller.value.text.split('|');
        salesAdviseAllVmController.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && salesAdviseAllVmController.SelectedRegion_list.isEmpty) {
          salesAdviseAllVmController.SelectedRegion_list.assignAll(availableItems);
          salesAdviseAllVmController.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${salesAdviseAllVmController.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = salesAdviseAllVmController.SelectedRegion_list;
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
              tempSelected.addAll(salesAdviseAllVmController.SelectedRegion_list);

              final allItems = salesAdviseAllVmController.regionwithclusterGetByEmailList;

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
                                    salesAdviseAllVmController.filterDataChecker.value='';
                                    salesAdviseAllVmController.SelectedRegion_list.assignAll(tempSelected);
                                    salesAdviseAllVmController.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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

  bindProductCategory(BuildContext context) {
    return Obx(() {
      if (salesAdviseAllVmController.productCategoryController.value.text.isNotEmpty && salesAdviseAllVmController.filterDataChecker.value=='1') {
        List<String> nameList = salesAdviseAllVmController.productCategoryController.value.text.split(',');

        salesAdviseAllVmController.Selected_Item_Category_master_list_without_task.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: salesAdviseAllVmController.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: salesAdviseAllVmController.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesAdviseAllVmController.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
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
          salesAdviseAllVmController.Selected_Item_Category_master_list_without_task.value = selectedList;
          salesAdviseAllVmController.productCategoryController.value.text =
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
      controller: salesAdviseAllVmController.product_category_type_Controller.value,
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
        salesAdviseAllVmController.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: salesAdviseAllVmController.productCategoryTypeList.map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }

  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesAdviseAllVmController.createdOnCnontroller
          .value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
        labelText: 'Created On Start Date -End Date',
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
          salesAdviseAllVmController.createdOnStartToEnd.value="$startDate@$endDate";
          salesAdviseAllVmController.createdOnCnontroller.value.text = '$startDate - $endDate';
        } else {
          salesAdviseAllVmController.createdOnCnontroller.value.text = '';
          salesAdviseAllVmController.createdOnStartToEnd.value="";
        }
      },
    );

  }


  Widget _buildLabelWithValue({
    required String label,
    required String? value,
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

}