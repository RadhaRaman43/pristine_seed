import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/item_master_vm/item_mater_vm.dart';

class NonStandardItemsScreen extends StatelessWidget{
  NonStandardItemsScreen({super.key});

  final item_master_controller=Get.put(ItemMasterVm());
  ScrollController scrollController = ScrollController();
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
          actions: [
            PopupMenuButton(itemBuilder: (BuildContext context){
              List<PopupMenuEntry> items = [];
              items.add(PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.download, color: Colors.black),
                      Text('Download Non Standard Items Data'),
                    ],
                  ),
                  onTap: () {

                  },
                ),);
              items.add(PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.download, color: Colors.black),
                    Text('Download Sample'),
                  ],
                ),
                onTap: () {

                },
              ),);
              items.add(PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.upload, color: Colors.black),
                      Text('Upload'),
                    ],
                  ),
                  onTap: () {

                  },
                ),);

              return items;
            }),
          ],
          title:Row(
            children: [
              Text(
                'Non Standard Items',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(onPressed: () {
                showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Obx((){
              return Visibility(
                visible:item_master_controller.loading.value ,
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
                child:
                Obx(() {
                  return BindCustomerListView(context);
                }),

              ),
            ),
          ],
        ),
      ),

    ),
    );
  }
  Widget BindCustomerListView(context) {
    if (item_master_controller.nonStandardList.value.isNotEmpty && item_master_controller.nonStandardList.value.length > 0) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          int total_page = (item_master_controller.total_rows_items /
              item_master_controller.rowsPerPage).toInt();
          if ((item_master_controller.total_rows_items % item_master_controller.rowsPerPage) > 0) total_page += 1;

          print("last index ${item_master_controller.pageNumber} ${item_master_controller.total_rows_items} "
              "${item_master_controller.rowsPerPage} ${total_page}");

          if (item_master_controller.pageNumber + 1 < total_page) {
            item_master_controller.itemMstSalesCycleGet(item_master_controller.pageNumber +1,);
            item_master_controller.pageNumber += 1;
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
          itemCount: item_master_controller.nonStandardList.value.length,
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
        onTap: () {

        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Item Code: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: item_master_controller.nonStandardList[position].itemCode??"",
                      child: Text(item_master_controller.nonStandardList[position].itemCode??"",
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
            Obx(() {
              return Visibility(
                visible: item_master_controller.isAdminWritePermission.value == "1" &&
                    item_master_controller.isHeadofficePermission.value == "0",
                child:  GestureDetector(
                    onTap: (){
                      print("position sale cycle.....${position}");
                      //showConfirmCompleteDialog(context,position!);
                    },
                    child: Icon(Icons.delete, color: Colors.red)),
              );
            }),

          ],
        ),

        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(label: "Customer Code : ", value: item_master_controller.nonStandardList[position].accountCode ??"",),
            _buildLabelWithValue(label: "Sales Cycle ID : ", value: item_master_controller.nonStandardList[position].salesCycleId??"",),
            _buildLabelWithValue(label: "Name : ", value: item_master_controller.nonStandardList[position].name??"",),
            _buildLabelWithValue(label: "Category : ", value: item_master_controller.nonStandardList[position].categoryName??"",),
            _buildLabelWithValue(label: "Product Type : ", value: item_master_controller.nonStandardList[position].productType??"",),
            _buildLabelWithValue(label: "Component Type : ", value: item_master_controller.nonStandardList[position].componentType??"",),
            _buildLabelWithValue(label: "HSN Code : ", value: item_master_controller.nonStandardList[position].hsnCode??"",),
            _buildLabelWithValue(label: "GST Group Code : ", value: item_master_controller.nonStandardList[position].gstGroupCode??"",),
            _buildLabelWithValue(label: "Specification : ", value: item_master_controller.nonStandardList[position].specification??"",),
            _buildLabelWithValue(label: "Standard Cost : ", value: " ₹ ${item_master_controller.numberFormatWithComma(item_master_controller.nonStandardList[position].standardCost).toString()}",),
            _buildLabelWithValue(label: "LSP : ", value: " ₹ ${item_master_controller.numberFormatWithComma(item_master_controller.nonStandardList[position].listSellingPrice).toString()}",),
            _buildLabelWithValue(label: "MAP : ", value: " ₹ ${item_master_controller.numberFormatWithComma(item_master_controller.nonStandardList[position].minimalAcceptablePrice).toString()}",),
            _buildLabelWithValue(label: "BTP : ", value: " ₹ ${item_master_controller.numberFormatWithComma(item_master_controller.nonStandardList[position].branchTransferPrice).toString()}",),
            _buildLabelWithValue(label: "Is Active : ", value: item_master_controller.nonStandardList[position].active==1?"YES":"NO",),
            _buildLabelWithValue(label: "Expired On : ", value: item_master_controller.nonStandardList[position].expiredOn??"",),
            _buildLabelWithValue(label: "Rate Contract Valid Date : ", value: item_master_controller.nonStandardList[position].rateContractValidDate??"",),
            _buildLabelWithValue(label: "Created/Updated On : ", value: item_master_controller.nonStandardList[position].updatedOn??"",),
          ],
        ),

      ),
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
                mainAxisSize: MainAxisSize.max, // Ensure minimal height
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
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: 5,),
                              bindFilterData('Item Code',item_master_controller.item_code_Controller.value),
                              bindFilterData('Customer Code',item_master_controller.customer_code_Controller.value),
                              bindFilterData('Sale cycle Id',item_master_controller.sale_cycle_id_Controller.value),
                              bindFilterData('Name',item_master_controller.name_Controller.value),
                              bindFilterData('Category',item_master_controller.category_Controller.value),
                              bindFilterData('HSN Code',item_master_controller.HSN_code_Controller.value),
                              bindFilterData('GST Group Code',item_master_controller.GST_group_code_Controller.value),
                              bindFilterData('Specification',item_master_controller.specification_Controller.value),
                              bindFilterDate(context,'Expired On',item_master_controller.expired_on_Controller.value),
                              bindFilterDate(context,'Created/Updated On',item_master_controller.created_on_Controller.value),
                              const SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildButton(
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            item_master_controller.filterDataChecker.value='';
                            item_master_controller.clearFilterData();
                            item_master_controller.clearSaveFilterData();
                            item_master_controller.pageNumber = 0;
                            item_master_controller.itemMstSalesCycleGet(item_master_controller.pageNumber);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 3,),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            item_master_controller.pageNumber = 0;
                            item_master_controller.itemMstSalesCycleGet(item_master_controller.pageNumber);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 3,),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            item_master_controller.filterDataChecker.value='';
                            item_master_controller.SaveFilterData();
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


  Widget bindFilterData(String hintdata,TextEditingController value,){
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

  bindFilterDate(BuildContext context, String hintData, TextEditingController controller) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: hintData,
            labelText: hintData,
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
            item_master_controller.expired_on_Controller.value.text = outputFormat.format(date);
          else
            item_master_controller.expired_on_Controller.value.text = "";
        }
    );
  }

}