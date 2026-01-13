

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../constants/static_methods.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_pending_for_approval_vm.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';



class SaleCyclePendingForApprovalList extends StatelessWidget{
  final salesCyclePendingForApprovalController=Get.put(SalesCyclePendingForApprovalVm());
  final salesCycleController=Get.put(SalesCycleVm());

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displaySaleCycleStatusForOption(String option) =>
      option;

  static String _displaySaleCycleActiveForOption(String option) =>
      option;

  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: () async{
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
                "Sales Cycle Approval List",
                 style: GoogleFonts.poppins(
                   color: AllColors.whiteColor,
                   fontSize: 16.0,
                   fontWeight: FontWeight.w700,
                 ),
               ),
               Spacer(),
               IconButton(onPressed: () {
                 showFilterBottomSheet(context);
               }, icon: Icon(Icons.filter_alt_sharp))
             ],
           )
       ),
       drawer: CustomDrawer(),
       body: RefreshIndicator(
         onRefresh:salesCyclePendingForApprovalController.refreshList,
         child: Container(
           width: double.infinity,
           height: double.infinity,
           child: Column(
             children: [
               Obx((){
                 return Visibility(
                   visible:salesCyclePendingForApprovalController.loading.value ,
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
     ),);
  }




  Widget BindCustomerListView(context) {
    if (salesCyclePendingForApprovalController.saleCyclePendingForApprovalList.value.isNotEmpty && salesCyclePendingForApprovalController.saleCyclePendingForApprovalList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (salesCyclePendingForApprovalController.total_rows /
              salesCyclePendingForApprovalController.rowsPerPage)
              .toInt();
          if ((salesCyclePendingForApprovalController.total_rows %
              salesCyclePendingForApprovalController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${salesCyclePendingForApprovalController.pageNumber} ${salesCyclePendingForApprovalController.total_rows} ${salesCyclePendingForApprovalController.rowsPerPage} ${total_page}");

          /*if (salesCycleController.pageNumber + 1 != total_page) {
            salesCycleController.getsalesCycleData(salesCycleController.pageNumber +1, "", "", "Sales");
            this.salesCycleController.pageNumber += 1;
          }*/

          if (salesCyclePendingForApprovalController.pageNumber + 1 < total_page) {
            salesCyclePendingForApprovalController.getsalesCycleData(salesCyclePendingForApprovalController.pageNumber + 1,);
            salesCyclePendingForApprovalController.pageNumber += 1;
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
          itemCount: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList.value.length,
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
    var createdOn=StaticMethod.dateTimeToDate(salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].createdOn??"");
    var approvedOn=StaticMethod.dateTimeToDate(salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].approvedOn??"");
    String saleCycleStatus = salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].salesCycleApprovalStatus??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'PENDING' || 'Pending':
          return Colors.red[900]!;
        case 'Rejected' || 'rejected':
          return AllColors.redColor;
        case 'APPROVED' || 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL' || 'Pending For Approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          //salesCycleController.FromPage.value = "FromSCPendingForApproval";
          var item = salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position];
          String salesCycleId = item.salesCycleId ?? "";
          String taskId = item.taskId ?? "";
          salesCyclePendingForApprovalController.extClosureStartToEnd.value="";
          //salesCycleController.filter.value = "Sales cycle";
          //salesCyclePendingForApprovalController.clearSaleProductListController();
          salesCycleController.filterQuoteAcceptedFlag.value="";
          salesCycleController.salesCycleId.value=salesCycleId;
          salesCycleController.pageNumber=0;
          salesCycleController.getsalesCycleData(salesCycleController.pageNumber, salesCycleId, "ViewHeader", 'FromSCPendingForApproval');
          salesCycleController.itemCategorySelectedlist.value = [];
          salesCycleController.getPurchaseProcessApi();
          salesCycleController.getPurchaseTimeFrameApi();
          salesCycleController.getItemCategoryMstApi(salesCycleId ,taskId,"" );
          salesCycleController.ProductCategoryWiseAmtGet(0, salesCycleId);
          salesCycleController.pageNumber=0;
          salesCycleController.getSaleCycleProductByIdList(salesCycleController.pageNumber,salesCycleId);
         // salesCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(salesCycleController.pageNumber,salesCycleId);
          salesCycleController.clearAllFieldOfQuoteFilter();

        },
        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(
              label: "Sales Cycle Stage : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].salesCycleStatus,
              //width: size.width * 0.33,
              color: Colors.blue,
            ),
            _buildLabelWithValue(
              label: "Sales Cycle Id: ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].salesCycleId,
            ),
            _buildLabelWithValue(
              label: "Task Id : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].taskId,
              //width: size.width * 0.36,
            ),
            _buildLabelWithValue(
              label: "Approval Status : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].salesCycleApprovalStatus,
              // width: size.width * 0.36,
              color: getStatusColor(saleCycleStatus),
            ),
            /*_buildClickableLabel(
              label: "Account Name : ",
              value: salesCycleController.saleCyclePendingForApprovalList[position].accountName,
              width: size.width * 0.4,
              onTap: () {
                account_vm_controller.view = 'FromSaleCycleMainScreen';
                contact_vm_controller.view = 'FromSaleCycleMainScreen';
                account_vm_controller.getAccMasterBuyCodeApi(
                  salesCycleController.saleCyclePendingForApprovalList[position].accountCode!,
                );
              },
            ),*/
            _buildLabelWithValue(
              label: "Customer Code : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].accountCode,
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Sales Cycle Owner : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].salesCycleOwnerName,
              //width: size.width * 0.33,
            ),
            _buildLabelWithValue(
              label: "Contact Name : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].contactName,
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Product Category : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].productCategory,
              //width: size.width * 0.35,
            ),
            _buildLabelWithValue(
              label: "Purchase Process : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].purchaseProcess,
              //width: size.width * 0.35,
            ),
            _buildLabelWithValue(
              label: "Company Pro. Type : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].companyProfileType,
              //width: size.width * 0.3,
            ),
            _buildLabelWithValue(
              label: "Is Commit : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].commit==1?"Yes":"No",
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Solution Accepted : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].isSolutionAccepted == 1 ? "Yes" : "No",
            ),

            _buildLabelWithValue(
              label: "Pin Code : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].postCode,
            ),

            _buildLabelWithValue(
              label: "District : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].district,
            ),

            _buildLabelWithValue(
              label: "Region Name : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].branchHeadValue,
            ),
            _buildLabelWithValue(
              label: "Cluster Name : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].clustureHeadValue,
            ),

            _buildLabelWithValue(
              label: "Created By : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].createdFullName,
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Approved By : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].approvedBy == ""
                  ? ""
                  : salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].approvedFullName,
              //width: size.width * 0.4,
            ),
            _buildLabelWithValue(
              label: "Exp. Closure Date : ",
              value: salesCyclePendingForApprovalController.saleCyclePendingForApprovalList[position].estClosureDate,
              //width: size.width * 0.3,
            ),
            _buildLabelWithValue(
              label: "Created On: ",
              value: createdOn,
              //: size.width * 0.33,
            ),

          ],
        ),

        trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
      ),
    );
  }

  Widget _buildLabelWithValue({
    required String label,
    required String? value,
    double? width,
    Color color = AllColors.textColor,
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
                //mainAxisSize: MainAxisSize.min, // Ensure minimal height
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
                              SizedBox(height: 10,),
                              bindSaleCycleStatusDropDown(context),
                              SizedBox(height: 5,),
                              bindData(context,'Sale Cycle Id',salesCyclePendingForApprovalController.saleCycleController.value),
                              SizedBox(height: 5,),
                              bindData(context,'Task Id',salesCyclePendingForApprovalController.filterTask_Id_controller.value),
                              SizedBox(height: 10,),
                              bindData(context,'Customer Name',salesCyclePendingForApprovalController.accountNameController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Customer Code',salesCyclePendingForApprovalController.accountCodeController.value),
                              SizedBox(height: 10,),
                              bindData(context,'Purchase Process',salesCyclePendingForApprovalController.purchaseProcessController.value),
                              SizedBox(height: 10,),
                              bindCompProfileTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindIsCommintdrpdown(context),
                              SizedBox(height: 10,),
                              bindSolutionAccepted(context),
                              SizedBox(height: 10,),
                              bindData(context,'Pin Code',salesCyclePendingForApprovalController.postalCodeController.value),
                              SizedBox(height: 10,),
                              bindData(context,'District',salesCyclePendingForApprovalController.district_controller.value),
                              SizedBox(height: 10,),
                              bindExpectedClosureDate(context),
                              SizedBox(height: 10,),
                              bindCreatedOn(context),
                             /* SizedBox(height: 10,),
                              bindData(context,'Reporting Manager',salesCyclePendingForApprovalController.reporting_manager_Controller.value),*/
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindAccountOwnerFilter(context),
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
                          text: 'Submit',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            salesCyclePendingForApprovalController.pageNumber = 0;
                            salesCyclePendingForApprovalController.getsalesCycleData(salesCyclePendingForApprovalController.pageNumber,);
                          },
                        )),

                        const SizedBox(width: 6),

                        Expanded(child: _buildButton(
                          text: 'Reset',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            Get.back();
                            salesCyclePendingForApprovalController.filterDataChecker.value='';
                            salesCyclePendingForApprovalController.clearAllFieldOfFilter();
                            salesCyclePendingForApprovalController.clearFilterData();
                            salesCyclePendingForApprovalController.pageNumber=0;
                            salesCyclePendingForApprovalController.getsalesCycleData(salesCyclePendingForApprovalController.pageNumber,);
                          },
                        )),

                        const SizedBox(width: 6),

                        Expanded(child: _buildButton(
                          text: 'Saved Filter',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            salesCyclePendingForApprovalController.filterDataChecker.value='';
                            salesCyclePendingForApprovalController.SaveFilterData();
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.primaryDark,
                                  width: 1),
                            )),
                            onPressed: () {
                              Get.back();
                              salesCyclePendingForApprovalController.pageNumber = 0;
                              salesCyclePendingForApprovalController.getsalesCycleData(salesCyclePendingForApprovalController.pageNumber,);
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.redColor, width: 1),
                            )),
                            onPressed: () {
                              Get.back();
                              salesCyclePendingForApprovalController.clearAllFieldOfFilter();
                              salesCyclePendingForApprovalController.pageNumber=0;
                              salesCyclePendingForApprovalController.getsalesCycleData(salesCyclePendingForApprovalController.pageNumber,);

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


  Widget bindSaleCycleStatusDropDown(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: salesCyclePendingForApprovalController.SaleCycleStatusController.value,
        label: Text(
          "Sales Cycle Stage",
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
          salesCyclePendingForApprovalController.SaleCycleStatusController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
          /*print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');*/

        },
        dropdownMenuEntries:
        salesCyclePendingForApprovalController.SaleCycleStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
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

  bindProductCategory(BuildContext context) {
    if (salesCyclePendingForApprovalController.productCategoryController.value.text.isNotEmpty && salesCyclePendingForApprovalController.filterDataChecker.value=='1') {
      List<String> nameList = salesCyclePendingForApprovalController.productCategoryController.value.text.split(',');

      salesCyclePendingForApprovalController.Selected_Item_Category_master_list_without_task.value =
          List.generate(nameList.length, (index) {
            return ItemCategoryMstModel(
              categoryName: nameList[index].trim(),
            );
          });
    }
    return Obx(() {
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: salesCyclePendingForApprovalController.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: salesCyclePendingForApprovalController.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesCyclePendingForApprovalController.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
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
          salesCyclePendingForApprovalController.Selected_Item_Category_master_list_without_task.value = selectedList;
          salesCyclePendingForApprovalController.productCategoryController.value.text =
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
      controller: salesCyclePendingForApprovalController.product_category_type_Controller.value,
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
        salesCyclePendingForApprovalController.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: salesCyclePendingForApprovalController.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }

  bindCompProfileTypeDropDown(BuildContext context) {
    return Obx(() {
      if (salesCyclePendingForApprovalController.companyProfileTypeController.value.text.isNotEmpty && salesCyclePendingForApprovalController.filterDataChecker.value=='1') {
        List<String> nameList = salesCyclePendingForApprovalController.companyProfileTypeController.value.text.split('|');

        salesCyclePendingForApprovalController.selected_company_type_list.value =
            List.generate(nameList.length, (index) {
              return CompanyTypeModal(
                description: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CompanyTypeModal>.multiSelection(
        items: salesCyclePendingForApprovalController.company_profile_type_list,
        itemAsString: (CompanyTypeModal u) => u.description ?? "",
        selectedItems: salesCyclePendingForApprovalController.selected_company_type_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesCyclePendingForApprovalController.selected_company_type_list.isNotEmpty ? "Company Profile Type" : null,
            hintText: "Company Profile Type",
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
              "Company Profile Type",
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
              selectedItems.map((e) => e.description).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CompanyTypeModal> selectedList) {
          salesCyclePendingForApprovalController.selected_company_type_list.value = selectedList;
          salesCyclePendingForApprovalController.companyProfileTypeController.value.text =
              selectedList.map((e) => e.description).join('|');
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
            title: Text(item.description ?? ""),
          ),
        ),
      );
    });
  }

  Widget bindRegionNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = salesCyclePendingForApprovalController.regionwithclusterGetByEmailList;
      if (availableItems.isNotEmpty &&
          salesCyclePendingForApprovalController.SelectedRegion_list.isEmpty) {
        salesCyclePendingForApprovalController.SelectedRegion_list.assignAll(availableItems);
        salesCyclePendingForApprovalController.RegionName_controller.value.text =
            availableItems.map((e) => e.geoValue).join('|');

      }
    });
    return Obx(() {
      final selected = salesCyclePendingForApprovalController.SelectedRegion_list;
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
              final tempSelected = <RegionWithClusterFilterModal>[];
              tempSelected.addAll(salesCyclePendingForApprovalController.SelectedRegion_list);

              final allItems =
                  salesCyclePendingForApprovalController.regionwithclusterGetByEmailList;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? allItems
                    : allItems
                    .where((c) =>
                    (c.geoValue ?? "").toLowerCase().contains(query))
                    .toList();

                final allSelected =
                    allItems.isNotEmpty && tempSelected.length == allItems.length;

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
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
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
                                  onPressed: () {
                                    salesCyclePendingForApprovalController.SelectedRegion_list
                                        .assignAll(tempSelected);
                                    salesCyclePendingForApprovalController.RegionName_controller
                                        .value.text =
                                        tempSelected
                                            .map((e) => e.geoValue)
                                            .join('|');
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Done'),
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
  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = salesCyclePendingForApprovalController.clusterGetByEmailList;
      if (availableItems.isNotEmpty &&
          salesCyclePendingForApprovalController.SelectedCluster_list.isEmpty) {
        salesCyclePendingForApprovalController.SelectedCluster_list.assignAll(availableItems);
        salesCyclePendingForApprovalController.clusterName_controller.value.text =
            availableItems.map((e) => e.geoValue).join('|');
        salesCyclePendingForApprovalController.getRegionsWithClusterFilterGetByEmail();
      }
    });

    return Obx(() {
      final selected = salesCyclePendingForApprovalController.SelectedCluster_list;
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
              tempSelected.addAll(salesCyclePendingForApprovalController.SelectedCluster_list);

              List<ClusterModal> allItems =
                  salesCyclePendingForApprovalController.clusterGetByEmailList;

              return StatefulBuilder(builder: (context, setState) {
                final query = searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? allItems
                    : allItems
                    .where((c) =>
                    (c.geoValue ?? "").toLowerCase().contains(query))
                    .toList();

                final allSelected =
                    allItems.isNotEmpty && tempSelected.length == allItems.length;

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
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
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
                                  onPressed: () {
                                    salesCyclePendingForApprovalController.SelectedCluster_list.assignAll(tempSelected);
                                    salesCyclePendingForApprovalController.clusterName_controller.value.text = tempSelected
                                        .map((e) => e.geoValue)
                                        .join('|');
                                    salesCyclePendingForApprovalController.getRegionsWithClusterFilterGetByEmail();

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Done'),
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

  bindAccountOwnerFilter(BuildContext context) {
    return Obx((){
      if (salesCyclePendingForApprovalController.AccountOwner_controller.value.text.isNotEmpty && salesCyclePendingForApprovalController.filterDataChecker.value=='1') {
        List<String> nameList = salesCyclePendingForApprovalController.AccountOwner_controller.value.text.split(',');
        salesCyclePendingForApprovalController.SelectedEmployee_Member_list.value =
            List.generate(nameList.length, (index) {
              return EmployeeMemberModel(
                fullName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: salesCyclePendingForApprovalController.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: salesCyclePendingForApprovalController.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesCyclePendingForApprovalController.SelectedEmployee_Member_list.isNotEmpty?"Account Owner":null,
            hintText: "Sales Cycle Owner",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              " Sales Cycle Owner",
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
              selectedItems.map((e) => e.fullName).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<EmployeeMemberModel> selectedList) {
          salesCyclePendingForApprovalController.SelectedEmployee_Member_list.value =
              selectedList;
          salesCyclePendingForApprovalController.AccountOwner_controller.value.text =
              selectedList.map((e) => e.fullName).join(', ');
        },

        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              // Top margin here
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          itemBuilder: (context, item, isSelected) =>
              ListTile(
                title: Text(item.fullName??""),
              ),
        ),
      );
    });

  }
  bindSaleCycleOwner() {
    return TextField(
      controller: salesCyclePendingForApprovalController.salesCycleOwnerController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Sales Cycle Owner',
          hintText: 'Sales Cycle Owner',
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

  Widget bindSolutionAccepted(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: salesCyclePendingForApprovalController.solutionAcceptedController.value,
        label: Text(
          "Solution Accepted",
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
          salesCyclePendingForApprovalController.solutionAcceptedController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!)
                  .toString();
          print('IsActive.....${salesCyclePendingForApprovalController.solutionAcceptedController
              .value.text}');

        },
        dropdownMenuEntries:
        salesCyclePendingForApprovalController.customerNeedIdentityList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindIsCommintdrpdown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size.width-15,
      controller: salesCyclePendingForApprovalController.isCommitController.value,
      label: Text(
        "Is Commit",
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
        salesCyclePendingForApprovalController.isCommitController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!)
                .toString();
      },
      dropdownMenuEntries:
      salesCyclePendingForApprovalController.customerNeedIdentityList.map<
          DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );
  }


  bindExpectedClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller:salesCyclePendingForApprovalController.filterExpectedClosuredateController
          .value,
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
          salesCyclePendingForApprovalController.extClosureStartToEnd.value="$startDate@$endDate";
          salesCyclePendingForApprovalController.filterExpectedClosuredateController.value.text = '$startDate - $endDate';
        } else {
          salesCyclePendingForApprovalController.filterExpectedClosuredateController.value.text = '';
          salesCyclePendingForApprovalController.extClosureStartToEnd.value="";
        }
      },
    );

  }

  bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: salesCyclePendingForApprovalController.createdOnCnontroller.value,
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
                  // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
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
            salesCyclePendingForApprovalController.createdOnCnontroller.value.text = outputFormat.format(date);
          else
            salesCyclePendingForApprovalController.createdOnCnontroller.value.text = "";
        }

    );
  }

}