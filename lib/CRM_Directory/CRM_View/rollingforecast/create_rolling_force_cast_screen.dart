import 'package:dropdown_search/dropdown_search.dart';
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
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/rollingforecastVM/SalesForeCastVM.dart';

class CreateSalesForceCastScreen extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();
  Size size=Get.size;
  static String _displayQuoteStatusForOption(String option) =>
      option;
  static String _displaySaleCycleActiveForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:  () async {
      sales_force_cast_vm.clearSelectQuoteItemList();
      if(sales_force_cast_vm.fromPage == "ForeCastHeaderDetails"){
        Get.toNamed(RoutesName.SalesForeCastHeaderDetailsScreen);
      }
      else{
        Get.offAllNamed(RoutesName.SalesForeCastScreen);
      }

      return false;
    }, child: Scaffold(
          appBar: AppBar(
              backgroundColor: AllColors.primaryDark1,
              iconTheme: IconThemeData(
                color: AllColors.whiteColor,
              ),
              title:Row(
                children: [
                  Text(
                    'Create ForceCast List',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              )
          ),
          drawer: CustomDrawer(),
          body:  Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:sales_force_cast_vm.loading.value ,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Visibility(
                  visible:  sales_force_cast_vm.fromPage == "ForeCastListScreen",
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                      child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20), // optional spacing
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                                backgroundColor: AllColors.primaryDark1,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor),
                                ),
                                label: Text(sales_force_cast_vm.month_controller.value.text,
                                    style: TextStyle(
                                      color:  AllColors.whiteColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                                onPressed: () {
                                },
                              );
                            }),
                            const SizedBox(width: 8),
                            Obx(() {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                                backgroundColor: AllColors.primaryDark1,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor),
                                ),
                                label: Text(sales_force_cast_vm.year_controller.value.text,
                                  style: TextStyle(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {

                                },
                              );
                            }),
                            const SizedBox(width: 8),
                            ActionChip(
                                  elevation: 2,
                                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                                  backgroundColor: AllColors.primaryDark1,
                                  shadowColor: Colors.black,
                                  shape: StadiumBorder(
                                    side: BorderSide(color: AllColors.grayColor),
                                  ),
                                  label: Text("Get Quote",
                                    style: TextStyle(
                                      color: AllColors.whiteColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onPressed: () {
                                    sales_force_cast_vm.showList.value=true;
                                  },
                                ),
                            const SizedBox(width: 8),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: sales_force_cast_vm.fromPage == "ForeCastHeaderDetails",
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                      const SizedBox(width: 8),
                      Obx(() {
                        return ActionChip(
                          elevation: 2,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                          backgroundColor: AllColors.primaryDark1,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(
                            side: BorderSide(color: AllColors.grayColor),
                          ),
                          label: Text(sales_force_cast_vm.month_controller.value.text,
                              style: TextStyle(
                                color:  AllColors.whiteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              )
                          ),
                          onPressed: () {
                          },
                        );
                      }),
                      const SizedBox(width: 8),
                      Obx(() {
                        return ActionChip(
                          elevation: 2,
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                          backgroundColor: AllColors.primaryDark1,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(
                            side: BorderSide(color: AllColors.grayColor),
                          ),
                          label: Text(sales_force_cast_vm.year_controller.value.text,
                            style: TextStyle(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {

                          },
                        );
                      }),
                      const SizedBox(width: 8),
                    ],)),
                Obx((){
                  return Visibility(
                      visible: sales_force_cast_vm.showList.value,
                      child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quote List",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.eighteen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Visibility(
                              visible: sales_force_cast_vm.SelectedQuoteList.length>0,
                              child: ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                                backgroundColor: AllColors.primaryDark1,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor),
                                ),
                                label: Text("Get Quote Item",
                                  style: TextStyle(
                                    color: AllColors.whiteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  sales_force_cast_vm.clearForeCastItemData();
                                  sales_force_cast_vm.clearAllFieldForecastItemFilter("ForeCastItemScreen");
                                 /* sales_force_cast_vm.filterQuoteIdController.value.text = sales_force_cast_vm.SelectedQuoteList.map((e) => e.quoteId).join(' | ');
                                  sales_force_cast_vm.quoteIds = sales_force_cast_vm.filterQuoteIdController.value.text;
                                  sales_force_cast_vm.getForeCastQuoteList(0,"ALLQuoteLineItemsForSalesForecast");*/

                                },
                              ),
                            ),


                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialogForFilter(context);
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Icon(
                                        Icons.filter_alt_rounded,
                                        color: AllColors.primaryDark1,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        border: Border.all(
                                            color:
                                            AllColors.primaryDark1)),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Divider(
                        height: 1,
                        color: AllColors.bluegrayColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx((){
                              return Checkbox(
                                value: sales_force_cast_vm.selectAllQuoteList.value?true:false,
                                onChanged: (bool? value) {
                                  sales_force_cast_vm.selectAllQuoteCheckbox();
                                },
                              );
                            }),
                            Text(sales_force_cast_vm.selectAllQuoteList.value?"Unselect All":"Select All",
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AllColors.bluegrayColor,
                      ),
                    ],
                  ));
                }),
                Obx((){
                  return Visibility(
                    visible: sales_force_cast_vm.showList.value,
                    child: BindQuoteListView(context,),
                  );
                })

              ],
            ),
          ),
        ));
  }

  Widget BindQuoteListView(context) {
    if (sales_force_cast_vm.QuoteList.value.isNotEmpty && sales_force_cast_vm.QuoteList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (sales_force_cast_vm.total_rows /
              sales_force_cast_vm.rowsPerPage)
              .toInt();
          if ((sales_force_cast_vm.total_rows %
              sales_force_cast_vm.rowsPerPage) >
              0) total_page += 1;
          // print("last index ${sales_force_cast_vm.pageNumberForQuote} ${sales_force_cast_vm.total_rows} ${sales_force_cast_vm.rowsPerPage} ${total_page}");
          if (sales_force_cast_vm.pageNumberForQuote + 1 < total_page) {
            sales_force_cast_vm.getQuoteList(sales_force_cast_vm.pageNumberForQuote+1,);
            sales_force_cast_vm.pageNumberForQuote += 1;
          }
        }
      });

      return
        Expanded(
        child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.only(bottom: 10),
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: Colors.transparent,
            ),
            shrinkWrap: true,
            itemCount: sales_force_cast_vm.QuoteList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindQuoteDataListView(context, index);
            }),
      );
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'rejected':
        return Colors.red[600]!;
      case 'approved':
        return Colors.green[700]!;
      case 'draft':
        return Colors.red[900]!;
      case 'pending for approval || Open':
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }

  Widget BindQuoteDataListView(context, int position) {
    String? quoteValidityDate=StaticMethod.convertDateFormat1(sales_force_cast_vm.QuoteList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(sales_force_cast_vm.QuoteList[position].expClosureDate ?? "");
    return Card(
      //margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Quote Id : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  sales_force_cast_vm.QuoteList[position].quoteId?? "",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color:Colors.blue,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
             Obx((){
              return Checkbox(
                value: sales_force_cast_vm.QuoteList[position].isSelected==1?true:false,
                onChanged: (bool? value) {
                  sales_force_cast_vm.toggleSalesCheckbox(position,context);
                },
              );
            }),
          ],
        ),
        subtitle: Column(
          children: [
            _buildLabelWithValue(label: "Sales Cycle Id: ", value:  sales_force_cast_vm.QuoteList[position].salesCycleId ?? "",),
            _buildLabelWithValue(label: "Customer Name: ", value:  sales_force_cast_vm.QuoteList[position].accountName ?? "",),
            _buildLabelWithValue(label: "Created By: ", value:  sales_force_cast_vm.QuoteList[position].createdFullName ?? "",),
            _buildLabelWithValue(label: "Cluster Name: ", value:  sales_force_cast_vm.QuoteList[position].clustureHeadValue ?? "",),
            _buildLabelWithValue(label: "Region Name: ", value:  sales_force_cast_vm.QuoteList[position].zoneHeadValue ?? "",),
            _buildLabelWithValue(label: "Quote Validity: ", value:  quoteValidityDate.toString(),color:AllColors.textColor),
            _buildLabelWithValue(label: "Product Category: ", value:  sales_force_cast_vm.QuoteList[position].productCategory ?? "",),
            //_buildLabelWithValue(label: "Parent Product Category: ", value:  sales_force_cast_vm.QuoteList[position].parentProductCategory ?? "",),
            _buildLabelWithValue(label: "Quote Accepted: ", value:  sales_force_cast_vm.QuoteList[position].quoteAccepted ?? "",),
            _buildLabelWithValue(label: "Quote Total Amt: ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].quoteTotalAmount).toString() ?? ""}"  ,),
            _buildLabelWithValue(label: "Quote Gst Amt: ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].quoteGstAmount).toString() ?? ""}"  ,),
            _buildLabelWithValue(label: "Quote Gross Amt: ", value:"₹ ${sales_force_cast_vm.numberFormatWithComma(sales_force_cast_vm.QuoteList[position].quoteGrossAmount).toString() ?? ""}"  ,),
            _buildLabelWithValue(label: "Created on: ", value: StaticMethod.onlyDate(sales_force_cast_vm.QuoteList[position].createdOn ?? "") ),
            _buildLabelWithValue(label: "Customer Code: ", value:  sales_force_cast_vm.QuoteList[position].accountCode ?? "",),
            _buildLabelWithValue(label: "Contact Name: ", value:  sales_force_cast_vm.QuoteList[position].contactName ?? "",),
            _buildLabelWithValue(label: "Sales Cycle Id: ", value:  sales_force_cast_vm.QuoteList[position].salesCycleId.toString(),),
            _buildLabelWithValue(label: "Quote Version: ", value:  sales_force_cast_vm.QuoteList[position].quoteVersion.toString(),),
            _buildLabelWithValue(label: "Expected Closure Date: ", value: expectedClosuredateDate.toString(),color:AllColors.textColor),

          ],
        ),
      ),
    );
  }


  Widget _buildLabelWithValue({
    required String label,
    required String? value,
   Color color= AllColors.textColor,

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
                        Icon(Icons.shield_moon_rounded, color: AllColors.primaryDark1,),
                        const SizedBox(width: 5,),
                        Text(
                          "Quote Filter ",
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
                              const SizedBox(height: 5,),
                              bindData(context,'Quote Id',sales_force_cast_vm.filterQuoteIdController.value),
                              const SizedBox(height: 10),
                              bindData(context,'Sale Cycle Id',sales_force_cast_vm.filterQuoteSaleCycleController.value),
                              const SizedBox(height: 10),
                              bindData(context,'Customer Name',sales_force_cast_vm.accountNameController.value),
                              const SizedBox(height: 10),
                              bindCreatedBYFilter(context),
                              const SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              const SizedBox(height: 10),
                              filterWithQuoteCreatedOn(context),
                              const SizedBox(height: 10,),
                              bindData(context,'Customer Code',sales_force_cast_vm.accountCodeController.value),
                              const SizedBox(height: 10,),
                              bindData(context,'Quote Version',sales_force_cast_vm.filterQuoteVersionController.value),
                              const SizedBox(height: 10,),
                              filterWithQuoteClosureDate(context),
                              const SizedBox(height: 10),
                              bindClusterNameFilter(context),
                              const SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              const SizedBox(height: 10,),

                              filterWithQuoteProductCategory(context),
                              const SizedBox(height: 10,),
                              bindProductCategoryTypeDropDown(context),
                              const SizedBox(height: 10,),
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
                            //sales_force_cast_vm.SelectedQuoteList.value = [];
                            sales_force_cast_vm.clearSalesForceCastQuoteData();
                            sales_force_cast_vm.clearAllFieldOfQuoteFilter("CreateSalesForeCastScreen");
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            sales_force_cast_vm.pageNumberForQuote = 0;
                            sales_force_cast_vm.getQuoteList(sales_force_cast_vm.pageNumberForQuote,);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Saved Filter',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            sales_force_cast_vm.saveSalesForceCastQuoteData();
                            Get.back();
                          },
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },

        );
      },
    );
  }

  Widget _buildButton({
    required String text,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
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
  bindData(BuildContext context, String labelText, TextEditingController controller,) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: labelText,
          hintText: labelText,
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

  Widget bindCreatedBYFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Obx(() {
      if (sales_force_cast_vm.AccountOwner_controller.value.text.isNotEmpty && sales_force_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sales_force_cast_vm.AccountOwner_controller.value.text.split(',');
        sales_force_cast_vm.SelectedEmployee_Member_list.value = List.generate(nameList.length, (index) {
          return EmployeeMemberModel(
            userFullName: nameList[index].trim(),
          );
        });
      }
      print("list length ${sales_force_cast_vm.employee_Member_list.length}");
      final selected = sales_force_cast_vm.SelectedEmployee_Member_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) =>
      "${sales_force_cast_vm.isAdminWritePermission=="1"?e.userFullName ?? "":e.fullName ?? ""}(${e.salesPersonEmpCode ?? ""})").join(', ');
      return GestureDetector(
        onTap: ()  {
          openBottomSheet(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: selectedText != null ?  "Created By": "", // 👈 Label restored here
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
                  "Created By",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.sisxteen
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
  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16)),),
        builder: (context){
          sales_force_cast_vm.tempSelected.value = [];
          sales_force_cast_vm.tempSelected.addAll(sales_force_cast_vm.SelectedEmployee_Member_list);
          sales_force_cast_vm.filtered.value = sales_force_cast_vm.employee_Member_list;
          return Obx((){
            sales_force_cast_vm.allSelected.value = sales_force_cast_vm.filtered.isNotEmpty
                && sales_force_cast_vm.tempSelected.length == sales_force_cast_vm.filtered.length;
            return Visibility(
                visible: sales_force_cast_vm.selectOwner.value,
                child: Padding(
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
                                  'Select Created By',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.black),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: const Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))

                            ],
                          ),
                        ),
                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: sales_force_cast_vm.searchController.value,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: sales_force_cast_vm.searchController.value.text.isNotEmpty ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  sales_force_cast_vm.searchController.value.clear();
                                  if(sales_force_cast_vm.isAdminWritePermission=="1") {
                                    sales_force_cast_vm.EmployeeMasterGet(sales_force_cast_vm.searchController.value.text);
                                  }
                                  else{
                                    sales_force_cast_vm.filtered.value =sales_force_cast_vm.searchController.value.text.isEmpty ?
                                    sales_force_cast_vm.employee_Member_list:sales_force_cast_vm.employee_Member_list.where((c) =>
                                        (c.fullName ?? "").toLowerCase().contains(sales_force_cast_vm.searchController.value.text)).toList();
                                  }


                                },
                              ) : null,
                            ),
                            onChanged: (v)
                            {
                              if(sales_force_cast_vm.isAdminWritePermission=="1") {
                                sales_force_cast_vm.EmployeeMasterGet(sales_force_cast_vm.searchController.value.text);
                              }
                              else{
                                sales_force_cast_vm.filtered.value =sales_force_cast_vm.searchController.value.text.isEmpty ?
                                sales_force_cast_vm.employee_Member_list:sales_force_cast_vm.employee_Member_list.where((c) =>
                                    ("${c.fullName ?? ""} ${c.salesPersonEmpCode ?? ""}").toLowerCase().contains(sales_force_cast_vm.searchController.value.text)).toList();
                              }

                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        /* Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title:sales_force_cast_vm.allSelected.value?const Text('UnSelect All'): const Text('Select All'),
                            value: sales_force_cast_vm.allSelected.value,
                            onChanged: (val) {
                              if (val == true) {
                                sales_force_cast_vm.tempSelected.clear();
                                sales_force_cast_vm.allSelected.value=true;
                                sales_force_cast_vm.tempSelected.addAll(sales_force_cast_vm.filtered);
                              } else {
                                sales_force_cast_vm.allSelected.value=false;
                                sales_force_cast_vm.tempSelected.clear();
                              }
                              sales_force_cast_vm.selectOwner.value=false;
                              sales_force_cast_vm.selectOwner.value=true;
                            },
                          ),
                        ),*/

                        const Divider(height: 1),
                        Obx((){
                          return Visibility(visible:sales_force_cast_vm.loading.value,
                            child:LinearProgressIndicator(
                              backgroundColor: AllColors.primaryDark1,
                              color: AllColors.textColor,
                            ), );
                        }),

                        // List
                        Expanded(
                          child: sales_force_cast_vm.filtered.isEmpty ? const Center(child: Text('No Record Found!')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: sales_force_cast_vm.filtered.length,
                            itemBuilder: (context, idx) {
                              final item = sales_force_cast_vm.filtered[idx];
                              sales_force_cast_vm.isSel.value = sales_force_cast_vm.tempSelected.any((s) =>
                              (sales_force_cast_vm.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                  (sales_force_cast_vm.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                              return CheckboxListTile(
                                title: Text("${sales_force_cast_vm.isAdminWritePermission=="1"?
                                item.userFullName ?? "":item.fullName ?? ""}(${item.salesPersonEmpCode ?? ""})"),
                                value: sales_force_cast_vm.isSel.value,
                                onChanged: (v) {
                                  if (v == true) {
                                    sales_force_cast_vm.isSel.value=true;
                                    sales_force_cast_vm.tempSelected.add(item);
                                  } else {
                                    sales_force_cast_vm.isSel.value=false;
                                    sales_force_cast_vm.tempSelected.removeWhere((s) =>
                                    (sales_force_cast_vm.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                        (sales_force_cast_vm.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                                    //(s.userFullName ?? "") == (item.userFullName ?? ""));
                                  }
                                  sales_force_cast_vm.selectOwner.value=false;
                                  sales_force_cast_vm.selectOwner.value=true;
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
                                  onPressed: () {
                                    sales_force_cast_vm.SelectedEmployee_Member_list
                                        .assignAll(sales_force_cast_vm.tempSelected);
                                    sales_force_cast_vm.AccountOwner_controller.value.text =
                                        sales_force_cast_vm.tempSelected.map((e) => e.empId).join(', ');

                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('Done',style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
        }
    );
  }

  filterWithQuoteProductCategory(BuildContext context) {
    return Obx(() {
      if (sales_force_cast_vm.productCategoryController.value.text.isNotEmpty && sales_force_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sales_force_cast_vm.productCategoryController.value.text.split('|');
        sales_force_cast_vm.Selected_item_product_cat_list.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: sales_force_cast_vm.item_product_cat_list,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: sales_force_cast_vm.Selected_item_product_cat_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: sales_force_cast_vm.Selected_item_product_cat_list.isNotEmpty ? "Product Category" : null,
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
          sales_force_cast_vm.Selected_item_product_cat_list.value = selectedList;
          sales_force_cast_vm.productCategoryController.value.text =
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
      controller: sales_force_cast_vm.product_category_type_Controller.value,
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
        sales_force_cast_vm.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: sales_force_cast_vm.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }
  Widget filterWithQuoteStatus(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: sales_force_cast_vm.quoteStatusController.value,
        label: Text(
          "Quote Status",
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
          sales_force_cast_vm.quoteStatusController.value.text =
              _displayQuoteStatusForOption(selection!)
                  .toString();

        },
        dropdownMenuEntries:
        sales_force_cast_vm.QuoteStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: sales_force_cast_vm.filterQuoteValidityController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
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
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
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
          sales_force_cast_vm.quoteValidityStartToEnd.value = "$startDate@$endDate";
          sales_force_cast_vm.filterQuoteValidityController.value.text =
          '$startDate - $endDate';
        } else {
          sales_force_cast_vm.filterQuoteValidityController.value.text = '';
          sales_force_cast_vm.quoteValidityStartToEnd.value = "";
        }
      },
    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: sales_force_cast_vm.filterExpectedClosuredateController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date -End Date',
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
          sales_force_cast_vm.extClosureStartToEnd.value = "$startDate@$endDate";
          sales_force_cast_vm.filterExpectedClosuredateController.value.text =
          '$startDate - $endDate';
        } else {
          sales_force_cast_vm.filterExpectedClosuredateController.value.text = '';
          sales_force_cast_vm.extClosureStartToEnd.value = "";
        }
      },
    );
  }
  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = sales_force_cast_vm.clusterGetByEmailList;
      if (sales_force_cast_vm.clusterName_controller.value.text.isNotEmpty && sales_force_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sales_force_cast_vm.clusterName_controller.value.text.split('|');
        sales_force_cast_vm.SelectedCluster_list.value =[];
        sales_force_cast_vm.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && sales_force_cast_vm.SelectedCluster_list.isEmpty) {
          sales_force_cast_vm.SelectedCluster_list.assignAll(availableItems);
          sales_force_cast_vm.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          sales_force_cast_vm.getRegionsWithClusterFilterGetByEmail("CreateSalesForeCastScreen");
        }
      }

    });

    return Obx(() {
      final selected = sales_force_cast_vm.SelectedCluster_list;
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
              final tempSelected = <ClusterModal>[];
              tempSelected.addAll(sales_force_cast_vm.SelectedCluster_list);

              List<ClusterModal> allItems =
                  sales_force_cast_vm.clusterGetByEmailList;

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

                                    sales_force_cast_vm.filterDataChecker.value='';
                                    sales_force_cast_vm.SelectedCluster_list.assignAll(tempSelected);
                                    sales_force_cast_vm.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    sales_force_cast_vm.getRegionsWithClusterFilterGetByEmail("CreateSalesForeCastScreen");

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
      final availableItems = sales_force_cast_vm.regionwithclusterGetByEmailList;
      if (sales_force_cast_vm.RegionName_controller.value.text.isNotEmpty && sales_force_cast_vm.filterDataChecker.value=='1') {
        sales_force_cast_vm.SelectedRegion_list.value=[];
        List<String> nameList = sales_force_cast_vm.RegionName_controller.value.text.split('|');
        sales_force_cast_vm.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && sales_force_cast_vm.SelectedRegion_list.isEmpty) {
          sales_force_cast_vm.SelectedRegion_list.assignAll(availableItems);
          sales_force_cast_vm.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${sales_force_cast_vm.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = sales_force_cast_vm.SelectedRegion_list;
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
              tempSelected.addAll(sales_force_cast_vm.SelectedRegion_list);

              final allItems = sales_force_cast_vm.regionwithclusterGetByEmailList;

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
                                    sales_force_cast_vm.filterDataChecker.value='';
                                    sales_force_cast_vm.SelectedRegion_list.assignAll(tempSelected);
                                    sales_force_cast_vm.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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
      controller: sales_force_cast_vm.createdOnCnontroller.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Select Start Date - End Date',
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
          sales_force_cast_vm.createdOnStartToEnd.value = "$startDate@$endDate";
          sales_force_cast_vm.createdOnCnontroller.value.text =
          '$startDate - $endDate';
        } else {
          sales_force_cast_vm.createdOnCnontroller.value.text = '';
          sales_force_cast_vm.createdOnStartToEnd.value = "";
        }
      },
    );
  }

  //todo there is no use
  bindQuoteAccepted(BuildContext context) {
    return Container(

      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: sales_force_cast_vm.filterQuoteAcceptedController.value,
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
          if(selection=="Open"){
            sales_force_cast_vm.filterQuoteAcceptedController.value.text = '';
          }
          else{

            sales_force_cast_vm.filterQuoteAcceptedController.value.text =selection.toString();

            debugPrint("Quote accepted.... ${sales_force_cast_vm.filterQuoteAcceptedController.value.text}");
          }


        },
        dropdownMenuEntries:
        sales_force_cast_vm.qouteAcceptedList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

}