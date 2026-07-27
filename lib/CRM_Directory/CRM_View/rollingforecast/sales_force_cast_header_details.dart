import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/rollingforecastVM/SalesForeCastVM.dart';

class SalesForceHeaderDetails extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();
  Size size = Get.size;

  static String _displaySaleCycleActiveForOption(String option) =>
      option;
  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;
  static String _displayparentCategoryCodeForOption(ItemCategoryMstModel option) =>
      option.parentCategoryCode!;

  static String _displayClusterForOption(ClusterModal option) =>
      option.geoValue!;
  static String _displayRegionForOption(RegionWithClusterFilterModal option) =>
      option.geoValue!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.SalesForeCastScreen);
        return false;

      },
      child: Scaffold(
          onDrawerChanged: (isOpen) {
            if (isOpen) {
              //FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          appBar: AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'View Forecast',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '(${sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastId ??""})',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

              ],
            ),

          ),
          drawer: CustomDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Visibility(
                  visible: sales_force_cast_vm.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastStatus!.toLowerCase()=="pending",
                          child: ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                              backgroundColor: Colors.black,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text("Get Quote",
                                  style: TextStyle(
                                    color:  AllColors.whiteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                              onPressed: () {
                                sales_force_cast_vm.showList.value = true;
                                sales_force_cast_vm.fromPage = "ForeCastHeaderDetails";
                                sales_force_cast_vm.QuoteList.value=[];
                                sales_force_cast_vm.clearAllFieldOfQuoteFilter("SalesForeCastScreen");
                                Get.toNamed(RoutesName.createSalesForeCastScreen);
                                },
                            ),
                        ),
                        const SizedBox(width: 8),
                        Visibility(
                          visible: sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastStatus!.toLowerCase()=="pending",
                          child: ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor: Colors.black,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text("Complete",
                                style: TextStyle(
                                  color: AllColors.whiteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                showConfirmCompleteDialog(context,0,"");
                              },
                            ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              BindSalesData(context),
              const SizedBox(height: 10,),
              Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  children: [
                    Text(
                      "Forecast Lines",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.eighteen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        sales_force_cast_vm.clearExcelController();
                        showFilterBottomSheet(context);
                      },
                      child: Tooltip(
                        message: "Download Data With Filter",
                        child: Icon(Icons.download, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        sales_force_cast_vm.downloadQuoteDetailsWithProgress(context,"all_line_details","All Line Details");
                      },
                      child: Tooltip(
                        message: "Download Data",
                        child: Icon(Icons.download, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        sales_force_cast_vm.uploadExcelToServer();
                      },
                      child: Tooltip(
                        message: "Upload Data",
                        child: Icon(Icons.upload, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),

              Obx((){
                final totalList = sales_force_cast_vm.salesForceCastHeader_list[0].totalMonthYearQty ?? [];
                if( totalList != null && totalList.isNotEmpty && totalList.length>0){
                  return  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Center(
                            child: Divider(
                              height: 1,
                              color: AllColors.lightgreyColor,
                            ),
                          ),
                          Text(
                            "Total",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          VerticalDivider(
                            width: 20, // total space taken
                            thickness: 1,
                            color: AllColors.lightgreyColor,
                          ),
                           Table(
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                defaultColumnWidth: const FixedColumnWidth(130),
                                border: TableBorder.symmetric(
                                  inside: BorderSide(
                                    width: 1,
                                    color: AllColors.lightgreyColor,
                                  ),
                                ),
                                children: [
                                  TableRow(
                                    children: totalList.map((item) {
                                      return tableHeaderCell(
                                        "${item.closureMonth}-${item.closureYear}",
                                      );
                                    }).toList(),
                                  ),
                                  TableRow(
                                    children: totalList.map((item) {
                                      return tableValueCell(
                                        item.totalMonthYearQty?.toString() ?? "0",
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )


                        ],
                      ),
                    ),
                  );
                }
                else{
                  return SizedBox();
                }
              }),
              const SizedBox(height: 10,),
              Divider(height: 1, color: AllColors.bluegrayColor,),
              const SizedBox(height: 10,),
              bindForeCastLinesData(context),

            ],
          )),
    );
  }

  Widget tableHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AllColors.textColor,
          fontSize: AllFontSize.sisxteen,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
  Widget tableValueCell(dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value?.toString() ?? "0",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.sisxteen,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'DRAFT' || "Draft" ||'REGRET' || 'Regret' ||'Rejected' || 'rejected':
        return Colors.red[900]!;
      case 'Approved'|| 'APPROVED'|| 'approved' || 'WON' || 'Completed' || "COMPLETED":
        return Colors.green;
      case 'PENDING FOR APPROVAL' || 'pending for approval' ||'PENDING'
      || 'pending':
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }
  Widget BindSalesData(BuildContext context) {
    var createdOn=StaticMethod.onlyDate(sales_force_cast_vm.salesForceCastHeader_list[0].createdOn??"");
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColors.grayColor, // Set the border color here
                width: 1.0, // Adjust the border width if necessary
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Sales ForeCast Details',
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                    fontSize: AllFontSize.twentee),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  bindData(fixText: "Month Year : ",data:sales_force_cast_vm.salesForceCastHeader_list[0].monthYear ?? ""),
                  const SizedBox(height: 3,),
                  bindData(fixText: "Status : ",data:sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastStatus ?? "",color:getStatusColor(sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastStatus ?? "")),
                  const SizedBox(height: 3,),
                  bindData(fixText: "Cluster Name : ",data:sales_force_cast_vm.salesForceCastHeader_list[0].clusterName ?? ""),
                  const SizedBox(height: 3,),
                  bindData(fixText: "Region Name : ",data:sales_force_cast_vm.salesForceCastHeader_list[0].regionName ?? ""),
                  const SizedBox(height: 3,),
                  bindData(fixText: "Created By : ",data:sales_force_cast_vm.salesForceCastHeader_list[0].createdFullName ?? ""),
                  const SizedBox(height: 3,),
                  bindData(fixText: "Created On : ",data:createdOn??""),
                  const SizedBox(height: 3,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget bindData({required String fixText,required String data,Color color = AllColors.textColor,
    VoidCallback? onTap, TextDecoration? decoration, TextDecorationStyle? decorationStyle,}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fixText,
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
              message: data,
              child: Text(data,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                  decoration: decoration,
                  decorationStyle: decorationStyle,
                ),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget bindForeCastLinesData(BuildContext context) {
    if (sales_force_cast_vm.salesForceCastHeader_list[0].lines!.isNotEmpty && sales_force_cast_vm.salesForceCastHeader_list[0].lines!.length > 0) {
      return Obx(
            () {
          return Expanded(
            child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.only(bottom: 10),
                separatorBuilder: (context, index) => Divider(
                  height: .05,
                  color: Colors.transparent,
                ),
                shrinkWrap: true,
                itemCount: sales_force_cast_vm.salesForceCastHeader_list[0].lines!.length,
                itemBuilder: (BuildContext context, int index) {
                  return bindPendingListView(context, index);
                }),
          );
        },
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'No Record Found.',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }

  Widget bindPendingListView(BuildContext context, int index,) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5 , right: 10),
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "Quote  ID : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Flexible(
                  child: Tooltip(
                    message: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteId ?? "",
                    child: Text(sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteId ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
           Obx(() {
              return Visibility(
                visible: /*sales_force_cast_vm.isAdminWritePermission.value == "1" &&
                    sales_force_cast_vm.isHeadofficePermission.value == "0" &&*/ sales_force_cast_vm.foreCastStatus.value =="Completed",
                child:  GestureDetector(
                    onTap: (){
                      sales_force_cast_vm.editableDataApi(sales_force_cast_vm.salesForceCastHeader_list[0].lines![index],"delete");
                      showConfirmCompleteDialog(context,index,"delete");
                    },
                    child: Icon(Icons.delete, color: Colors.red)),
              );
            }),

        ],
      ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            //_buildLabelWithValue(label: "Quote  ID : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteId ?? "",),
            _buildLabelWithValue(label: "Sales Cycle ID : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].salesCycleId ?? "",),
            _buildLabelWithValue(label: "Item Code : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemCode ?? "",),
            _buildLabelWithValue(label: "Item Name : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemName ?? "",),
            _buildLabelWithValue(label: "Item Category : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemCategoryCode ?? "",),
            _buildLabelWithValue(label: "Quote Qty : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteQty.toInt().toString() ?? "",),
            _buildLabelWithValue(label: "Approved Price : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteApprovedAmountPerUnit.toString() ?? "",index: index),
            bindEditableData(label: "Item Variant : ",
              value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemVarient ?? "",context: context,index: index
            ),
            bindEditableData(label: "Cluster  Name : ",
                value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].requiredClusterName ?? "",
                index: index,context: context),
            _buildLabelWithValue(label: "Region Name : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].requiredRegionName ?? "",),

            ...sales_force_cast_vm.salesForceCastHeader_list[0].lines![index].forecastMonths
                .map((e) => bindMonthYearData(
                label: "${e.month} ${e.year} : ",
                value: (e.value ?? 0).toString(),
              context: context,
              index: index, month: e.month,year: e.year
            ),
            ).toList(),

          ],
        ),

      ),
    );
  }


  Widget _buildLabelWithValue({
    required String label,
    required String value,
    Color color = AllColors.textColor,
    BuildContext? context,
    int index=0,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Tooltip(
              message: value ?? "",
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
        ),

      ],
    );
  }

  Widget bindMonthYearData({
    required String label, required String month, required String year,
    required String value,
    Color color = AllColors.textColor,
    required BuildContext context,
    required int index,
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
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  sales_force_cast_vm.qtyCtrl.value.text=value;
                  debugPrint("quantity ${sales_force_cast_vm.qtyCtrl.value.text} ${value}");
                  sales_force_cast_vm.editableDataApi(sales_force_cast_vm.salesForceCastHeader_list[0].lines![index],"edit");
                  showDialogForChangeVarient(context,index,"Edit Quantity",month,year);
                },
                child: Tooltip(
                  message: value ?? "",
                  child: Text(
                    value ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,

                    ),
                  ),
                ),
              ),
            ),
          ),


      ],
    );
  }

  Widget bindEditableData({
    required String label,
    required String value,
    Color color = AllColors.textColor,
    required BuildContext context,
    required int index
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
            child: Align(
              alignment: Alignment.centerRight,
              child: Tooltip(
                message: value ?? "",
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
          ),
        const SizedBox(width: 10),
        Visibility(
           visible:label=="Item Variant : " || label=="Cluster  Name : " ,
           child: GestureDetector(
              onTap: (){
                if(label=="Item Variant : "){
                  sales_force_cast_vm.itemVariantCtrl.value.text=value;
                  sales_force_cast_vm.editableDataApi(sales_force_cast_vm.salesForceCastHeader_list[0].lines![index],"edit");
                  showDialogForChangeVarient(context,index,"Edit Item Variant",'','');
                }
                else if(label=="Cluster  Name : "){
                  sales_force_cast_vm.clusterCtrl.value.text=value;
                  sales_force_cast_vm.regionCtrl.value.text=sales_force_cast_vm.salesForceCastHeader_list[0].lines![index].requiredRegionName??"";
                  sales_force_cast_vm.getClustersGetByRajeshEmail();
                  sales_force_cast_vm.editableDataApi(sales_force_cast_vm.salesForceCastHeader_list[0].lines![index],"edit");
                  showDialogForChangeVarient(context,index,"Edit Cluster/Region",'','');
                }
                else{

                }

              },
              child: Icon(Icons.edit,color: AllColors.yellowColor,size: 15,)),
         ),
        const SizedBox(width: 10),
        Visibility(
          visible: label=="Item Variant : " || label=="Cluster  Name : ",
          child: GestureDetector(
              onTap: (){
                if(label=="Item Variant : "){
                  sales_force_cast_vm.itemVariantCtrl.value.text="";
                  sales_force_cast_vm.editableDataApi(sales_force_cast_vm.salesForceCastHeader_list[0].lines![index],"add");
                  showDialogForChangeVarient(context,index,"Add Item Variant",'','');
                }
                else if(label=="Cluster  Name : "){
                  sales_force_cast_vm.clusterCtrl.value.text="";
                  sales_force_cast_vm.regionCtrl.value.text="";
                  sales_force_cast_vm.editableDataApi(sales_force_cast_vm.salesForceCastHeader_list[0].lines![index],"edit");
                  showDialogForChangeVarient(context,index,"Add Cluster/Region",'','');
                }
                else{

                }

              },
              child:
              Icon(Icons.add_circle_sharp,color: AllColors.bluegrayColor,)),
        ),

      ],
    );
  }

  showDialogForChangeVarient(BuildContext context, int index, String title,String month, String year,){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100, // light red background
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Divider(height: 1,),
              Obx(() {
                return Visibility(
                  visible: sales_force_cast_vm.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              const SizedBox(height: 20,),

              Visibility(
                visible: title=="Edit Item Variant" || title=="Add Item Variant",
                  child: bindFilterData(sales_force_cast_vm.itemVariantCtrl.value,'Item Variant')),

              Visibility(
                  visible: title=="Edit Quantity",
                  child: bindFilterData(sales_force_cast_vm.qtyCtrl.value,'Quantity')),

              Visibility(
                  visible: title=="Edit Cluster/Region" || title=="Add Cluster/Region",
                  child: bindClusterDropDown(context)),

              Visibility(visible:title=="Edit Cluster/Region" || title=="Add Cluster/Region",
                child: const SizedBox(height: 10,),),

              Visibility(
                    visible: title=="Edit Cluster/Region" || title=="Add Cluster/Region",
                    child: Obx((){
                      return Visibility(visible: sales_force_cast_vm.regionCtlShow.value,
                          child: bindRegionDropDown(context));
                    })),

            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(title=="Edit Item Variant" || title=="Add Item Variant") {
                  if (sales_force_cast_vm.itemVariantCtrl.value.text.isNotEmpty) {

                  }
                  else {
                    Utils.sanckBarSuccess("Upload!", "Please enter Item Variant");
                    return;
                  }
                }
                else if(title=="Edit Cluster/Region" || title=="Add Cluster/Region"){
                  if(sales_force_cast_vm.clusterCtrl.value.text.isEmpty){
                    Utils.sanckBarSuccess("Upload!", "Please Select Cluster Name");
                    return;
                  }
                  if(sales_force_cast_vm.regionCtrl.value.text.isEmpty){
                    Utils.sanckBarSuccess("Upload!", "Please Select Region Name");
                    return;
                  }
                }
                else if(sales_force_cast_vm.qtyCtrl.value.text.isEmpty){
                  Utils.sanckBarSuccess("Upload!", "Please Enter Quantity");
                  return;
                }
                sales_force_cast_vm.ChangeSalesForecastUploadItem(
                    sales_force_cast_vm.quoteDowExcelList, title,month,year);

               Navigator.pop(context);

              },
              child:Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade100,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ),
          ],
        );
      },
    );
  }

  showConfirmCompleteDialog(BuildContext context, int position, String flag,){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:flag=='delete'? Colors.red.shade100:Colors.green.shade100, // light red background
                  shape: BoxShape.circle,
                ),
                child:flag=='delete'? const Icon(Icons.delete, color: Colors.red, size: 28,):
                const Icon(Icons.info_outline, color: Colors.green, size: 28,),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(flag=='delete'?'Delete':"Complete",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700),
                    ),
                    Text("Do You Want to  complete Forecast ""${sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastId ??""}",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                      softWrap: true,
                    ),
                  ],
                ),
              ),

            ],
          ),

          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                if(flag=='delete'){
                  sales_force_cast_vm.SalesForecastDeleteItems(
                    sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastId ??"",
                      sales_force_cast_vm.quoteDowExcelList);

                }
                else{
                  sales_force_cast_vm.SalesForecastHeaderCompleted(sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastId ??"");
                }
                Navigator.pop(context);

              },
              child: Text(flag=='delete'?"Delete":"Complete",style: TextStyle(color:flag=='delete'?AllColors.redColor: AllColors.greenblue),),
            ),
          ],
        );
      },
    );
  }

  void showFilterBottomSheet(BuildContext context) {
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_moon_rounded, color: AllColors.primaryDark1,),
                        SizedBox(width: 5,),
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
                              const SizedBox(height: 5,),
                              bindFilterData(sales_force_cast_vm.quoteId_ex_Ctrl.value, 'Quote Id'),
                              const SizedBox(height: 10,),
                              bindFilterData(sales_force_cast_vm.saleCycleId_ex_Ctrl.value, 'Sales Cycle Id'),
                              const SizedBox(height: 10,),
                              bindDropDownType(context,sales_force_cast_vm.closerMonth_ex_Ctrl.value,
                                  'Closure Month',sales_force_cast_vm.months),
                              const SizedBox(height: 10,),
                              bindDropDownType(context,sales_force_cast_vm.closerYear_ex_Ctrl.value,
                                  'Closure Year',sales_force_cast_vm.years),
                              const SizedBox(height: 10,),
                              bindDropDownType(context,sales_force_cast_vm.item_category_type_ex_Ctrl.value,
                                  "Item Category Type",sales_force_cast_vm.productCategoryTypeList),
                              const SizedBox(height: 10,),
                              bindProductCategoryDropDown(context),
                              Obx(() {
                                return Visibility(
                                  visible:
                                  sales_force_cast_vm.Selected_item_product_cat_list.length > 0 ? true : false,
                                  child: Wrap(
                                    spacing: 8.0,
                                    children: sales_force_cast_vm.Selected_item_product_cat_list
                                        .map((category) {
                                      return Chip(
                                        label: Text(category.categoryName ?? ""),
                                        onDeleted: () {
                                          sales_force_cast_vm.Selected_item_product_cat_list.remove(category);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              }),
                              const SizedBox(height: 10,),
                              bindParentProductCategoryDropDown(context),
                              Obx(() {
                                return Visibility(
                                  visible:
                                  sales_force_cast_vm.parentItemCategorySelectedList.length > 0 ? true : false,
                                  child: Wrap(
                                    spacing: 8.0,
                                    children: sales_force_cast_vm.parentItemCategorySelectedList
                                        .map((category) {
                                      return Chip(
                                        label: Text(category.parentCategoryCode ?? ""),
                                        onDeleted: () {
                                          sales_force_cast_vm.parentItemCategorySelectedList.remove(category);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              }),
                              const SizedBox(height: 10,),
                              bindFilterData(sales_force_cast_vm.cluster_name_ex_Ctrl.value, 'Cluster Name'),
                              const SizedBox(height: 10,),
                              bindFilterData(sales_force_cast_vm.region_name_ex_Ctrl.value, 'Region Name'),
                              const SizedBox(height: 10,),
                              bindFilterData(sales_force_cast_vm.itemCode_ex_Ctrl.value, 'Item Code'),
                              const SizedBox(height: 10,),
                              bindFilterData(sales_force_cast_vm.itemName_ex_Ctrl.value, 'Item Name'),
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
                          text: 'Download Excel',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            sales_force_cast_vm.SalesForecastLinesGetForUpload(context);
                            Get.back();
                          },
                        )),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
  Widget bindFilterData(TextEditingController value,String hintdata){
    return  TextField(
      controller: value,
      keyboardType: hintdata=='Quantity'?TextInputType.number:TextInputType.text,
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

  Widget bindClusterDropDown(context) {
    return Autocomplete<ClusterModal>(
      displayStringForOption: _displayClusterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return sales_force_cast_vm.clusterGetByEmailList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return sales_force_cast_vm.clusterGetByEmailList
            .where((ClusterModal option) {
          return option.geoValue
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ClusterModal selection) {
        // Update the TextField with the selected
        sales_force_cast_vm.regionCtrl.value.text ="";
        sales_force_cast_vm.clusterCtrl.value.text =
            _displayClusterForOption(selection).toString();
        sales_force_cast_vm.getRegionsWithClusterGetByRajeshEmail();
        sales_force_cast_vm.regionCtlShow.value=false;
        sales_force_cast_vm.regionCtlShow.value=true;


      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextField(
            // onTap: () {
            //   controller.clear();
            // },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = sales_force_cast_vm.clusterCtrl.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Cluster Name',
              labelText: 'Cluster Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ClusterModal> onSelected,
          Iterable<ClusterModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width * .7,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ClusterModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.geoValue.toString(),
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

  Widget bindRegionDropDown(context) {
    return Autocomplete<RegionWithClusterFilterModal>(
      displayStringForOption: _displayRegionForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return sales_force_cast_vm.regionwithclusterGetByEmailList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return sales_force_cast_vm.regionwithclusterGetByEmailList
            .where((RegionWithClusterFilterModal option) {
          return option.geoValue
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (RegionWithClusterFilterModal selection) {
        // Update the TextField with the selected
        sales_force_cast_vm.regionCtrl.value.text =
            _displayRegionForOption(selection).toString();


      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextField(
            // onTap: () {
            //   controller.clear();
            // },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = sales_force_cast_vm.regionCtrl.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Region Name',
              labelText: 'Region Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<RegionWithClusterFilterModal> onSelected,
          Iterable<RegionWithClusterFilterModal> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width * .7,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final RegionWithClusterFilterModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.geoValue.toString(),
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
  Widget bindDropDownType(context, TextEditingController ctrl, String hintData, List<String> productCategoryTypeList) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: ctrl,
      label: Text(hintData,
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
        if(hintData=='Closure Month'){
          String monthName = _displaySaleCycleActiveForOption(selection!).toString();
          sales_force_cast_vm.closerMonth_ex_Ctrl.value.text = _displaySaleCycleActiveForOption(selection!).toString();
          sales_force_cast_vm.monthNameForApi = sales_force_cast_vm.setMonthNameInShort(monthName);;

        }
        else if(hintData =='Closure Year'){
          sales_force_cast_vm.closerYear_ex_Ctrl.value.text =
              _displaySaleCycleActiveForOption(selection!).toString();
        }
        else{
          sales_force_cast_vm.item_category_type_ex_Ctrl.value.text =
              _displaySaleCycleActiveForOption(selection!).toString();
        }
      },
      dropdownMenuEntries: productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );
  }

  Widget bindProductCategoryDropDown(context) {
    return Container(
      width: size.width,
      child: Autocomplete<ItemCategoryMstModel>(
        displayStringForOption: _displayItemCatMasterForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return sales_force_cast_vm.item_product_cat_list.value;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return sales_force_cast_vm.item_product_cat_list
              .where((ItemCategoryMstModel option) {
            return option.categoryName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (ItemCategoryMstModel selection) {
          sales_force_cast_vm.product_category_ex_Ctrl.value.text =
              _displayItemCatMasterForOption(selection).toString();
          if (!sales_force_cast_vm.Selected_item_product_cat_list.contains(selection)) {
            sales_force_cast_vm.Selected_item_product_cat_list.add(selection);
            Utils.showToastification('Success', 'Add Successfully');
          } else {
            Utils.showErrorToastification('Error', 'Already Selected');
          }
          sales_force_cast_vm.product_category_ex_Ctrl.value.clear();
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: () {
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = sales_force_cast_vm.product_category_ex_Ctrl.value.text,
            focusNode: focusNode,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: () {
                    if (focusNode.hasFocus) {
                      focusNode.unfocus();
                    } else {
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Product Category',
                labelText: 'Product Category',
                hintStyle: GoogleFonts.poppins(
                    color: AllColors.lightblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.ten),
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.fourtine),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
            Iterable<ItemCategoryMstModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final ItemCategoryMstModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.categoryName.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.sisxteen
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
      ),
    );
  }
  Widget bindParentProductCategoryDropDown(context) {
    return Container(
      width: size.width,
      child: Autocomplete<ItemCategoryMstModel>(
        displayStringForOption: _displayparentCategoryCodeForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return sales_force_cast_vm.parentProductCategoryList.value;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return sales_force_cast_vm.parentProductCategoryList
              .where((ItemCategoryMstModel option) {
            return option.parentCategoryCode
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (ItemCategoryMstModel selection) {
          sales_force_cast_vm.parent_product_category_ex_Ctrl.value.text =
              _displayparentCategoryCodeForOption(selection).toString();
          if (!sales_force_cast_vm.parentItemCategorySelectedList.contains(selection)) {
            sales_force_cast_vm.parentItemCategorySelectedList.add(selection);
            Utils.showToastification('Success', 'Add Successfully');
          } else {
            Utils.showErrorToastification('Error', 'Already Selected');
          }
          sales_force_cast_vm.parent_product_category_ex_Ctrl.value.clear();
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: () {
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = sales_force_cast_vm.product_category_ex_Ctrl.value.text,
            focusNode: focusNode,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: AllColors.primaryDark1,
                  onPressed: () {
                    if (focusNode.hasFocus) {
                      focusNode.unfocus();
                    } else {
                      focusNode.requestFocus();
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Parent Product Category',
                labelText: 'Parent Product Category',
                hintStyle: GoogleFonts.poppins(
                    color: AllColors.lightblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.ten),
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.fourtine),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
            Iterable<ItemCategoryMstModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final ItemCategoryMstModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.parentCategoryCode.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.sisxteen
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
      ),
    );
  }


}