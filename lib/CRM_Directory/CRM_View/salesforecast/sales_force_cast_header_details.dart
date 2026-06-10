import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';

class SalesForceHeaderDetails extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.SalesForeCastScreen);
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
                      'View Forcast',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '(${sales_force_cast_vm.salesForceCastHeader_list[0].salesForecastId})',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              BindSalesData(context),
              const SizedBox(height: 10,),
              Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Forcast Lines",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.eighteen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    /*Row(
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
                    )*/
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Divider(height: 1, color: AllColors.bluegrayColor,),
              const SizedBox(height: 10,),
              bindForeCastLinesData(context),

            ],
          )),
    );
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'DRAFT' || "Draft" ||'REGRET' || 'Regret' ||'PENDING'
      || 'pending' ||'Rejected' || 'rejected':
        return Colors.red[900]!;
      case 'Approved'|| 'APPROVED'|| 'approved' || 'WON':
        return Colors.green;
      case 'PENDING FOR APPROVAL' || 'pending for approval':
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }
  Widget BindSalesData(BuildContext context) {
    var createdOn=StaticMethod.dateTimeToDate(sales_force_cast_vm.salesForceCastHeader_list[0].createdOn??"");
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
      //margin: EdgeInsets.all(5),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5 , right: 10),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildLabelWithValue(label: "Sales Cycle ID : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].salesCycleId ?? "",),
            _buildLabelWithValue(label: "Quote  ID : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteId ?? "",),
            _buildLabelWithValue(label: "Item Code : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemCode ?? "",),
            _buildLabelWithValue(label: "Item Name : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemName ?? "",),
            _buildLabelWithValue(label: "Item Category : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemCategoryCode ?? "",),
            _buildLabelWithValue(label: "Quote Qty : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteQty.toString() ?? "",),
            _buildLabelWithValue(label: "Approved Price : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].quoteApprovedAmountPerUnit.toString() ?? "",),
            _buildLabelWithValue(label: "Item Variant : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].itemVarient ?? "",),
            _buildLabelWithValue(label: "Region Name : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].requiredRegionName ?? "",),
            _buildLabelWithValue(label: "Cluster  Name : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].requiredClusterName ?? "",),
            _buildLabelWithValue(label: "Cluster  Name : ", value: sales_force_cast_vm.salesForceCastHeader_list[0].lines?[index].requiredClusterName ?? "",),

          ],
        ),

      ),
    );
  }
  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    Color color = AllColors.textColor,
    BuildContext? context,
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



}