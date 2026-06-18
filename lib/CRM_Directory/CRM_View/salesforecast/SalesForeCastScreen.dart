import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';

class SalesForceCastScreen extends StatelessWidget{

  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:  () async {
      Get.toNamed(RoutesName.homeScreen);
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
                Text(
                  'Sales ForceCast List',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                      sales_force_cast_vm.getCurrentDate();
                      sales_force_cast_vm.showList.value = false;
                      sales_force_cast_vm.fromPage = "ForeCastListScreen";
                      sales_force_cast_vm.clearSalesForceCastQuoteData();
                      sales_force_cast_vm.clearAllFieldOfQuoteFilter("SalesForeCastScreen");

                      Get.toNamed(RoutesName.createSalesForeCastScreen);
                    }, icon: Icon(Icons.add)),

                IconButton(onPressed: () {
                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body:  RefreshIndicator(
          onRefresh:sales_force_cast_vm.refreshList,
          child: Container(
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8), // optional spacing
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                              backgroundColor:
                              sales_force_cast_vm.foreCastStatus.value=="Pending"
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                  'Pending',
                                  style: TextStyle(
                                    color: sales_force_cast_vm.foreCastStatus.value=="Pending"
                                        ? AllColors.whiteColor
                                        : AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                              onPressed: () {
                                sales_force_cast_vm.foreCastStatus.value ="Pending";
                                sales_force_cast_vm.pageNumber=0;
                                sales_force_cast_vm.getSalesForecastListGet(sales_force_cast_vm.pageNumber, );
                              },
                            );
                          }),
                          const SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:sales_force_cast_vm.foreCastStatus.value=="Completed"
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Completed',
                                style: TextStyle(
                                  color: sales_force_cast_vm.foreCastStatus.value=="Completed"
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                sales_force_cast_vm.foreCastStatus.value ="Completed";
                                sales_force_cast_vm.pageNumber=0;
                                sales_force_cast_vm.getSalesForecastListGet(sales_force_cast_vm.pageNumber, );
                              },
                            );
                          }),
                          const SizedBox(width: 8), // optional spacing between chips

                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Obx(() {
                      return BindSaleForceCastListView(context);
                    }),
                  ),
                )
              ],
            ),
          ),
      ),
      ));
  }
  Widget BindSaleForceCastListView(context) {
    if (sales_force_cast_vm.sales_force_cast_list.value.isNotEmpty && sales_force_cast_vm.sales_force_cast_list.value.length > 0) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          int total_page = (sales_force_cast_vm.total_rows_sales_force /
              sales_force_cast_vm.rowsPerPage)
              .toInt();
          if ((sales_force_cast_vm.total_rows_sales_force % sales_force_cast_vm.rowsPerPage) > 0) total_page += 1;

          print("last index ${sales_force_cast_vm.pageNumber} ${sales_force_cast_vm.total_rows_sales_force} ${sales_force_cast_vm.rowsPerPage} ${total_page}");

          if (sales_force_cast_vm.pageNumber + 1 < total_page) {
            sales_force_cast_vm.getSalesForecastListGet(sales_force_cast_vm.pageNumber +1,);
            sales_force_cast_vm.pageNumber += 1;
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
          itemCount: sales_force_cast_vm.sales_force_cast_list.value.length,
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
    var createdOn=StaticMethod.onlyDate(sales_force_cast_vm.sales_force_cast_list[position].createdOn??"");
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          sales_force_cast_vm.getSalesForecastHeaderGetBySalesForecastId(sales_force_cast_vm.sales_force_cast_list[position].salesForecastId??"");

        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Sales Force Cast Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: sales_force_cast_vm.sales_force_cast_list[position].salesForecastId??"",
                      child: Text(sales_force_cast_vm.sales_force_cast_list[position].salesForecastId??"",
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
            Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
           /* Obx(() {
              return Visibility(
                visible: sales_force_cast_vm.isAdminWritePermission.value == "1" &&
                    sales_force_cast_vm.isHeadofficePermission.value == "0",
                child:  GestureDetector(
                    onTap: (){
                      print("position sale cycle.....${position}");
                      //showConfirmCompleteDialog(context,position!);
                    },
                    child: Icon(Icons.delete, color: Colors.red)),
              );
            }),*/

          ],
        ),

        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(label: "Sales Forecast Status : ", value: sales_force_cast_vm.sales_force_cast_list[position].salesForecastStatus??"", ),
           _buildLabelWithValue(label: "Created On : ", value: createdOn,),
           _buildLabelWithValue(label: "Month Year : ", value: sales_force_cast_vm.sales_force_cast_list[position].monthYear??"",),
           _buildLabelWithValue(label: "Created By : ", value: sales_force_cast_vm.sales_force_cast_list[position].createdFullName??"",),
           _buildLabelWithValue(label: "Region Name : ", value: sales_force_cast_vm.sales_force_cast_list[position].regionName??"",),
           _buildLabelWithValue(label: "Cluster Name : ", value: sales_force_cast_vm.sales_force_cast_list[position].clusterName??"",),
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
    // sales_force_cast_vm.IsActive_controller.clear();
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
                              bindFilterData(sales_force_cast_vm.salesForceCastId.value, 'Rolling Forecast ID'),
                              const SizedBox(height: 5,),
                              bindFilterData(sales_force_cast_vm.month_year_controller.value, 'Month Year'),
                              const SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              const SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              const SizedBox(height: 10),
                              bindCreatedBYFilter(context),
                              const SizedBox(height: 10,),
                              bindCreatedOn(context),
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
                            Get.back();
                            sales_force_cast_vm.filterDataChecker.value='';
                            sales_force_cast_vm.clearSaleFrrceCastListFilters('ClearSalesForeCast');
                            sales_force_cast_vm.clearFilterData();
                            sales_force_cast_vm.pageNumber = 0;
                            sales_force_cast_vm.getSalesForecastListGet(sales_force_cast_vm.pageNumber,);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            sales_force_cast_vm.pageNumber = 0;
                            sales_force_cast_vm.getSalesForecastListGet(sales_force_cast_vm.pageNumber,);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Saved Filter',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            sales_force_cast_vm.filterDataChecker.value='';
                            sales_force_cast_vm.SaveFilterData();
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
      controller:sales_force_cast_vm.createdOn_from_to_date_Controller.value,
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
          sales_force_cast_vm.createdOnCnontroller.value.text="$startDate@$endDate";
          sales_force_cast_vm.createdOn_from_to_date_Controller.value.text = '$startDate - $endDate';
        } else {
          sales_force_cast_vm.createdOnCnontroller.value.text = '';
          sales_force_cast_vm.createdOn_from_to_date_Controller.value.text="";
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
          sales_force_cast_vm.getRegionsWithClusterFilterGetByEmail("");
        }
      }

    });

    return Obx(() {
      final selected = sales_force_cast_vm.SelectedCluster_list;
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
                                    sales_force_cast_vm.getRegionsWithClusterFilterGetByEmail("");
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
  
  Widget bindCreatedBYFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Obx(() {
      if (sales_force_cast_vm.AccountOwner_controller.value.text.isNotEmpty && sales_force_cast_vm.filterDataChecker.value=='1') {
        List<String> nameList = sales_force_cast_vm.AccountOwner_controller.value.text.split(',');
        //List<String> nameList = sales_force_cast_vm.accountNameCode.split(',');
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
                                    sales_force_cast_vm.SelectedEmployee_Member_list.assignAll(sales_force_cast_vm.tempSelected);
                                    sales_force_cast_vm.accountNameCode= sales_force_cast_vm.tempSelected.map((nameCode)
                                    =>"${sales_force_cast_vm.isAdminWritePermission=="1"?nameCode.userFullName??"":nameCode.fullName??""}(${nameCode.empId})" ).join(', ') ;
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

}