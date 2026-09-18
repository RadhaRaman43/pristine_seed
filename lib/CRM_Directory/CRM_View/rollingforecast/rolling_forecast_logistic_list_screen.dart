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
import '../../CRM_VIewModels/rollingforecastVM/rolling_forecast_logistic_vm.dart';


class RollingForeCastLogisticListScreen extends StatelessWidget{
  final sale_fore_cast_vm = Get.put(RollingForeCastLogisticVM());
  ScrollController scrollController = ScrollController();
  static String _displayStringTypeDropDownForOption(String option) =>
      option;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:  () async {
      Get.toNamed(RoutesName.homeScreen);
      return false;
    }, child: Scaffold(
      appBar: AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            children: [
              Flexible(
                child: Tooltip(
                  message: 'Rolling Forecast Logistic List',
                  child: Text(
                    'Rolling Forecast Logistic List',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              //Spacer(),
              IconButton(onPressed: () {
                sale_fore_cast_vm.downloadForeCastLineDetaisForUploadWithProgress(context,'Rolling Forecast RH Data','Rolling Forecast RH Data');
              }, icon: Icon(Icons.download)),
              IconButton(onPressed: () {
                showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))
            ],
          )
      ),
      drawer: CustomDrawer(),
      body:  RefreshIndicator(
        onRefresh:sale_fore_cast_vm.refreshList,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:sale_fore_cast_vm.loading.value ,
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
                    return BindRHdetailsListView(context);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
  Widget BindRHdetailsListView(context) {
    if (sale_fore_cast_vm.rolling_fore_cast_list.value.isNotEmpty && sale_fore_cast_vm.rolling_fore_cast_list.value.length > 0) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          int total_page = (sale_fore_cast_vm.total_rows /
              sale_fore_cast_vm.rowsPerPage)
              .toInt();
          if ((sale_fore_cast_vm.total_rows % sale_fore_cast_vm.rowsPerPage) > 0) total_page += 1;

          print("last index ${sale_fore_cast_vm.pageNumber} ${sale_fore_cast_vm.total_rows} ${sale_fore_cast_vm.rowsPerPage} ${total_page}");

          if (sale_fore_cast_vm.pageNumber + 1 < total_page) {
            sale_fore_cast_vm.SalesForecastLinesGetNew(sale_fore_cast_vm.pageNumber +1,);
            sale_fore_cast_vm.pageNumber += 1;
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
          itemCount: sale_fore_cast_vm.rolling_fore_cast_list.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'PENDING' || 'pending':
        return Colors.red[900]!;
      case 'Rejected' || 'rejected':
        return AllColors.redColor;
      case 'APPROVED' || 'approved':
        return Colors.green;
      case 'PENDING FOR APPROVAL' || 'pending for approval':
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }
  Widget BindCustomerRequestListView(context, int position) {
    var createdOn=StaticMethod.onlyDate(sale_fore_cast_vm.rolling_fore_cast_list[position].createdOn??"");
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {

        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Rolling Forecast Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: sale_fore_cast_vm.rolling_fore_cast_list[position].salesForecastId??"",
                      child: Text(sale_fore_cast_vm.rolling_fore_cast_list[position].salesForecastId??"",
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
            //Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),


          ],
        ),

        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(label: "Quote Id : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].quoteId??"",),
            _buildLabelWithValue(label: "Sale Cycle Id : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].salesCycleId??"",),
            //_buildLabelWithValue(label: "Customer Name : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].accountName??"",),
            _buildLabelWithValue(label: "Cluster Name : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].clusterName??"",),
            _buildLabelWithValue(label: "Region Name : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].regionName??"",),
            _buildLabelWithValue(label: "Created By : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].createdFullName??"",),
            _buildLabelWithValue(label: "Item Code : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].itemCode??"",),
            _buildLabelWithValue(label: "Item Name : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].itemName??"",),
            _buildLabelWithValue(label: "Item Specification : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].itemSpecification??"",),
            _buildLabelWithValue(label: "Qty : ", value: (sale_fore_cast_vm.rolling_fore_cast_list[position].qty.toInt().toString())??"",),
            _buildLabelWithValue(label: "Item Variant : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].itemVarient??"",),
            _buildLabelWithValue(label: "Parent Category Code : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].itemParentCategoryCode??"",),
            _buildLabelWithValue(label: "Item Category Code : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].itemCategoryCode??"",),
            _buildLabelWithValue(label: "Closer Month : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].closureMonth??"",),
            _buildLabelWithValue(label: "Closer Year : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].closureYear??"",),
            _buildLabelWithValue(label: "Created On : ", value: createdOn,),
            _buildLabelWithValue(label: "Required Region Name : ", value: sale_fore_cast_vm.rolling_fore_cast_list[position].requiredRegionName??"",),

          ],
        ),

        // trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
      ),
    );
  }

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    Color color = AllColors.textColor,
    //VoidCallback onTap = null,
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
                              bindFilterData(sale_fore_cast_vm.rollingForceCastId.value, 'Rolling Forecast ID'),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.quoteIdController.value, 'Quote Id'),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.saleCycleController.value, 'Sale Cycle Id'),
                              /*const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.customerNameController.value, 'Customer Name'),*/
                              const SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              const SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              const SizedBox(height: 10,),
                              bindCreatedBYFilter(context),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.itemCodeController.value, 'Item Code'),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.itemNameController.value, 'Item Name'),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.itemSpecificationController.value, 'Item Specification'),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.qtyController.value, 'Qty'),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.itemVarient_Ctrl.value, 'Item Variant'),
                              const SizedBox(height: 10,),
                              bindItemProductCategoryFilter(context),
                              const SizedBox(height: 10,),
                              bindDropDownType(context,sale_fore_cast_vm.item_category_type_controller.value,
                                  'Product Category Type',sale_fore_cast_vm.productCategoryTypeList),
                              const SizedBox(height: 10,),
                              bindParentProductCategoryFilter(context),
                              const SizedBox(height: 10,),
                              bindDropDownType(context,sale_fore_cast_vm.closerMonth_Ctrl.value, 'Closure Month',sale_fore_cast_vm.months),
                              const SizedBox(height: 10,),
                              bindDropDownType(context,sale_fore_cast_vm.closerYear_Ctrl.value, 'Closure Year',sale_fore_cast_vm.years),
                              const SizedBox(height: 10,),
                              filterWithQuoteCreatedOn(context),
                              const SizedBox(height: 10,),
                              bindFilterData(sale_fore_cast_vm.requiredRegionNameController.value, 'Required Region Name'),

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
                            Get.back();
                            sale_fore_cast_vm.filterDataChecker.value='';
                            sale_fore_cast_vm.clearFilterData();
                            sale_fore_cast_vm.clearFilterSessionData();
                            sale_fore_cast_vm.pageNumber = 0;
                            sale_fore_cast_vm.SalesForecastLinesGetNew(sale_fore_cast_vm.pageNumber,);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            sale_fore_cast_vm.pageNumber = 0;
                            sale_fore_cast_vm.SalesForecastLinesGetNew(sale_fore_cast_vm.pageNumber,);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Saved Filter',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            sale_fore_cast_vm.filterDataChecker.value='';
                            sale_fore_cast_vm.SaveFilterData();
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

  bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: sale_fore_cast_vm.createdOnController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Created On',
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
                  primaryColor: AllColors.primaryDark1,
                  colorScheme: ColorScheme.light(
                      primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            sale_fore_cast_vm.createdOnController.value.text = outputFormat.format(date);
          else
            sale_fore_cast_vm.createdOnController.value.text = "";
        }

    );
  }
  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: sale_fore_cast_vm.createdOnController.value,
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
          sale_fore_cast_vm.createdOnStartToEnd.value = "$startDate@$endDate";
          sale_fore_cast_vm.createdOnController.value.text = '$startDate - $endDate';
        } else {
          sale_fore_cast_vm.createdOnController.value.text = '';
          sale_fore_cast_vm.createdOnStartToEnd.value = "";
        }
      },
    );
  }

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = sale_fore_cast_vm.clusterGetByEmailList;
      if (sale_fore_cast_vm.clusterName_controller.value.text.isNotEmpty && sale_fore_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sale_fore_cast_vm.clusterName_controller.value.text.split('|');
        sale_fore_cast_vm.SelectedCluster_list.value =[];
        sale_fore_cast_vm.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && sale_fore_cast_vm.SelectedCluster_list.isEmpty) {
          sale_fore_cast_vm.SelectedCluster_list.assignAll(availableItems);
          sale_fore_cast_vm.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          sale_fore_cast_vm.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = sale_fore_cast_vm.SelectedCluster_list;
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
              tempSelected.addAll(sale_fore_cast_vm.SelectedCluster_list);
              List<ClusterModal> allItems = sale_fore_cast_vm.clusterGetByEmailList;

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
                                    sale_fore_cast_vm.filterDataChecker.value='';
                                    sale_fore_cast_vm.SelectedCluster_list.assignAll(tempSelected);
                                    sale_fore_cast_vm.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    sale_fore_cast_vm.getRegionsWithClusterFilterGetByEmail();
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
            labelText: "Cluster Name",
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
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
      final availableItems = sale_fore_cast_vm.regionwithclusterGetByEmailList;
      if (sale_fore_cast_vm.RegionName_controller.value.text.isNotEmpty && sale_fore_cast_vm.filterDataChecker.value=='1') {
        sale_fore_cast_vm.SelectedRegion_list.value=[];
        List<String> nameList = sale_fore_cast_vm.RegionName_controller.value.text.split('|');
        sale_fore_cast_vm.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && sale_fore_cast_vm.SelectedRegion_list.isEmpty) {
          sale_fore_cast_vm.SelectedRegion_list.assignAll(availableItems);
          sale_fore_cast_vm.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${sale_fore_cast_vm.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = sale_fore_cast_vm.SelectedRegion_list;
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
              tempSelected.addAll(sale_fore_cast_vm.SelectedRegion_list);

              final allItems = sale_fore_cast_vm.regionwithclusterGetByEmailList;

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
                                    sale_fore_cast_vm.filterDataChecker.value='';
                                    sale_fore_cast_vm.SelectedRegion_list.assignAll(tempSelected);
                                    sale_fore_cast_vm.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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
            labelText: "Region Name",
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
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

  bindParentProductCategoryFilter(BuildContext context) {
    return Obx((){
      if (sale_fore_cast_vm.parentCategoryCodeController.value.text.isNotEmpty && sale_fore_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sale_fore_cast_vm.parentCategoryCodeController.value.text.split(',');

        sale_fore_cast_vm.parentItemCategorySelectedList.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                parentCategoryCode: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: sale_fore_cast_vm.parentProductCategoryList,
        itemAsString: (ItemCategoryMstModel u) => u.parentCategoryCode??"",
        selectedItems: sale_fore_cast_vm.parentItemCategorySelectedList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: sale_fore_cast_vm.parentItemCategorySelectedList.isNotEmpty?"Parent Category Code":null,
            hintText: "Parent Category Code",
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
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Parent Category Code",
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
              selectedItems.map((e) => e.parentCategoryCode).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<ItemCategoryMstModel> selectedList) {
          sale_fore_cast_vm.parentItemCategorySelectedList.value = selectedList;
          sale_fore_cast_vm.parentCategoryCodeController.value.text =
              selectedList.map((e) => e.parentCategoryCode).join(', ');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          itemBuilder: (context, item, isSelected) =>
              ListTile(
                title: Text(item.parentCategoryCode??""),
              ),
        ),
      );
    });

  }

  bindItemProductCategoryFilter(BuildContext context) {
    return Obx((){
      if (sale_fore_cast_vm.itemCategoryCodeController.value.text.isNotEmpty && sale_fore_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sale_fore_cast_vm.itemCategoryCodeController.value.text.split(',');

        sale_fore_cast_vm.Selected_item_product_cat_list.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: sale_fore_cast_vm.item_product_cat_list,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName??"",
        selectedItems: sale_fore_cast_vm.Selected_item_product_cat_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: sale_fore_cast_vm.Selected_item_product_cat_list.isNotEmpty?"Product Category":null,
            hintText: "Product Category",
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
          // Custom builder to just show comma-separated names
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
          sale_fore_cast_vm.Selected_item_product_cat_list.value = selectedList;
          sale_fore_cast_vm.itemCategoryCodeController.value.text =
              selectedList.map((e) => e.categoryName).join(', ');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          itemBuilder: (context, item, isSelected) =>
              ListTile(
                title: Text(item.categoryName??""),
              ),
        ),
      );
    });

  }


  Widget bindDropDownType(context, TextEditingController ctrl, String hintData, List<String> list) {
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
          String monthName = _displayStringTypeDropDownForOption(selection!).toString();
          sale_fore_cast_vm.monthNameForApi = sale_fore_cast_vm.setMonthNameInShort(monthName);;
          sale_fore_cast_vm.closerMonth_Ctrl.value.text = _displayStringTypeDropDownForOption(selection!).toString();
        }
        else if(hintData =='Closure Year'){
          sale_fore_cast_vm.closerYear_Ctrl.value.text = _displayStringTypeDropDownForOption(selection!).toString();
        }
        else{
          sale_fore_cast_vm.item_category_type_controller.value.text =
              _displayStringTypeDropDownForOption(selection!).toString();
        }
      },
      dropdownMenuEntries: list
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );
  }

  Widget bindCreatedBYFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Obx(() {
      if (sale_fore_cast_vm.AccountOwner_controller.value.text.isNotEmpty && sale_fore_cast_vm.filterDataChecker.value=='1') {
        //List<String> nameList = sale_fore_cast_vm.AccountOwner_controller.value.text.split(',');
        List<String> nameList = sale_fore_cast_vm.accountNameCode.split(',');
        sale_fore_cast_vm.SelectedEmployee_Member_list.value = List.generate(nameList.length, (index) {
          debugPrint("empid.... ${nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')'))}");
          return EmployeeMemberModel(
            userFullName: sale_fore_cast_vm.isAdminWritePermission=="1" ?
            nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')):"",
            fullName: sale_fore_cast_vm.isAdminWritePermission!="1"?
            nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')):"",
            salesPersonEmpCode:nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')')),
          );
        });
      }
      final selected = sale_fore_cast_vm.SelectedEmployee_Member_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) =>
      "${sale_fore_cast_vm.isAdminWritePermission=="1"?e.userFullName ?? "":e.fullName ?? ""}(${e.salesPersonEmpCode ?? ""})").join(', ');
      return GestureDetector(
        onTap: ()  {
          openBottomSheet(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: selectedText != null ?  "Created By": "",
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
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
          sale_fore_cast_vm.tempSelected.value = [];
          sale_fore_cast_vm.tempSelected.addAll(sale_fore_cast_vm.SelectedEmployee_Member_list);
          sale_fore_cast_vm.filtered.value = sale_fore_cast_vm.employee_Member_list;
          return Obx((){
            sale_fore_cast_vm.allSelected.value = sale_fore_cast_vm.filtered.isNotEmpty
                && sale_fore_cast_vm.tempSelected.length == sale_fore_cast_vm.filtered.length;
            return Visibility(
                visible: sale_fore_cast_vm.selectOwner.value,
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
                            controller: sale_fore_cast_vm.searchController.value,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: sale_fore_cast_vm.searchController.value.text.isNotEmpty ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  sale_fore_cast_vm.searchController.value.clear();
                                  if(sale_fore_cast_vm.isAdminWritePermission=="1") {
                                    sale_fore_cast_vm.EmployeeMasterGet(sale_fore_cast_vm.searchController.value.text);
                                  }
                                  else{
                                    sale_fore_cast_vm.filtered.value =sale_fore_cast_vm.searchController.value.text.isEmpty ?
                                    sale_fore_cast_vm.employee_Member_list:sale_fore_cast_vm.employee_Member_list.where((c) =>
                                        (c.fullName ?? "").toLowerCase().contains(sale_fore_cast_vm.searchController.value.text)).toList();
                                  }


                                },
                              ) : null,
                            ),
                            onChanged: (v)
                            {
                              if(sale_fore_cast_vm.isAdminWritePermission=="1") {
                                sale_fore_cast_vm.EmployeeMasterGet(sale_fore_cast_vm.searchController.value.text);
                              }
                              else{
                                sale_fore_cast_vm.filtered.value =sale_fore_cast_vm.searchController.value.text.isEmpty ?
                                sale_fore_cast_vm.employee_Member_list:sale_fore_cast_vm.employee_Member_list.where((c) =>
                                    ("${c.fullName ?? ""} ${c.salesPersonEmpCode ?? ""}").toLowerCase().contains(sale_fore_cast_vm.searchController.value.text)).toList();
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
                            title:sale_fore_cast_vm.allSelected.value?const Text('UnSelect All'): const Text('Select All'),
                            value: sale_fore_cast_vm.allSelected.value,
                            onChanged: (val) {
                              if (val == true) {
                                sale_fore_cast_vm.tempSelected.clear();
                                sale_fore_cast_vm.allSelected.value=true;
                                sale_fore_cast_vm.tempSelected.addAll(sale_fore_cast_vm.filtered);
                              } else {
                                sale_fore_cast_vm.allSelected.value=false;
                                sale_fore_cast_vm.tempSelected.clear();
                              }
                              sale_fore_cast_vm.selectOwner.value=false;
                              sale_fore_cast_vm.selectOwner.value=true;
                            },
                          ),
                        ),*/

                        const Divider(height: 1),
                        Obx((){
                          return Visibility(visible:sale_fore_cast_vm.loading.value,
                            child:LinearProgressIndicator(
                              backgroundColor: AllColors.primaryDark1,
                              color: AllColors.textColor,
                            ), );
                        }),

                        // List
                        Expanded(
                          child: sale_fore_cast_vm.filtered.isEmpty ? const Center(child: Text('No Record Found!')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: sale_fore_cast_vm.filtered.length,
                            itemBuilder: (context, idx) {
                              final item = sale_fore_cast_vm.filtered[idx];
                              sale_fore_cast_vm.isSel.value = sale_fore_cast_vm.tempSelected.any((s) =>
                              (sale_fore_cast_vm.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                  (sale_fore_cast_vm.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                              return CheckboxListTile(
                                title: Text("${sale_fore_cast_vm.isAdminWritePermission=="1"?
                                item.userFullName ?? "":item.fullName ?? ""}(${item.salesPersonEmpCode ?? ""})"),
                                value: sale_fore_cast_vm.isSel.value,
                                onChanged: (v) {
                                  if (v == true) {
                                    sale_fore_cast_vm.isSel.value=true;
                                    sale_fore_cast_vm.tempSelected.add(item);
                                  } else {
                                    sale_fore_cast_vm.isSel.value=false;
                                    sale_fore_cast_vm.tempSelected.removeWhere((s) =>
                                    (sale_fore_cast_vm.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                        (sale_fore_cast_vm.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                                    //(s.userFullName ?? "") == (item.userFullName ?? ""));
                                  }
                                  sale_fore_cast_vm.selectOwner.value=false;
                                  sale_fore_cast_vm.selectOwner.value=true;
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
                                    sale_fore_cast_vm.SelectedEmployee_Member_list.assignAll(sale_fore_cast_vm.tempSelected);
                                    sale_fore_cast_vm.accountNameCode= sale_fore_cast_vm.tempSelected.map((nameCode)
                                    =>"${sale_fore_cast_vm.isAdminWritePermission=="1"?nameCode.userFullName??"":nameCode.fullName??""}(${nameCode.salesPersonEmpCode})" ).join(', ') ;
                                    sale_fore_cast_vm.AccountOwner_controller.value.text = sale_fore_cast_vm.tempSelected.map((e) => e.empId).join(', ');

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


}