
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

import '../../../../component/circular_loading.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../utils/app_utils.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class SalesCycleScreen extends StatelessWidget{
  SalesCycleScreen({super.key});
  ScrollController scrollController = ScrollController();
  SalesCycleVm salesCycleController=Get.put(SalesCycleVm());

  static String _displaySaleCycleStatusForOption(String option) =>
      option;

  static String _displayApprovalStatusForOption(String option) =>
      option;

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

 /* static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;*/

  static String _displaySaleCycleActiveForOption(String option) =>
      option;

  Size size=Get.size;

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
                  'Sales Cycle',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
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
        body:  RefreshIndicator(
        onRefresh:salesCycleController.refreshList,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:salesCycleController.loading.value ,
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
                            salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Open"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Open',
                              style: TextStyle(
                                color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Open"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              )
                            /*  style: GoogleFonts.poppins(
                                color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Open"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),*/
                            ),
                            onPressed: () {
                              salesCycleController.filterQuoteAcceptedFlag.value = 'Open';
                              salesCycleController.quoteAcceptedForFilterOnSaleCycle.value="Open";
                              salesCycleController.pageNumber=0;
                              salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "salesPage",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8),
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                            backgroundColor:salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Won"

                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Won',
                            style: TextStyle(
                              color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Won"
                                  ? AllColors.whiteColor
                                  : AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            /*  style: GoogleFonts.poppins(
                                color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Won"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),*/
                            ),
                            onPressed: () {
                              salesCycleController.filterQuoteAcceptedFlag.value = 'Won';
                              salesCycleController.quoteAcceptedForFilterOnSaleCycle.value = "Won";
                              salesCycleController.pageNumber=0;
                              salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "salesPage",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8), // optional spacing between chips
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                            backgroundColor:salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Loss"
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'Loss',
                              style: TextStyle(
                                color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Loss"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            /*  style: GoogleFonts.poppins(
                                color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value=="Loss"
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),*/
                            ),
                            onPressed: () {
                              salesCycleController.filterQuoteAcceptedFlag.value = 'Loss';
                              salesCycleController.quoteAcceptedForFilterOnSaleCycle.value="Loss";
                              salesCycleController.pageNumber=0;
                              salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "salesPage",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8),
                        Obx(() {
                          return ActionChip(
                            elevation: 2,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                            backgroundColor:salesCycleController.quoteAcceptedForFilterOnSaleCycle.value==""
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.grayColor),
                            ),
                            label: Text(
                              'All',
                             style: TextStyle(
                               color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value==""
                                   ? AllColors.whiteColor
                                   : AllColors.primaryDark1,
                               fontSize: AllFontSize.fourtine,
                               fontWeight: FontWeight.w500,
                             ),
                             /* style: GoogleFonts.poppins(
                                color: salesCycleController.quoteAcceptedForFilterOnSaleCycle.value==""
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),*/
                            ),
                            onPressed: () {
                              salesCycleController.quoteAcceptedForFilterOnSaleCycle.value="";
                              salesCycleController.filterQuoteAcceptedFlag.value = '';
                              salesCycleController.pageNumber=0;
                              salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "salesPage",'',);
                            },
                          );
                        }),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
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
      )


      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (salesCycleController.saleCycleList.value.isNotEmpty && salesCycleController.saleCycleList.value.length > 0) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          int total_page = (salesCycleController.total_rows_sales /
              salesCycleController.rowsPerPage)
              .toInt();
          if ((salesCycleController.total_rows_sales % salesCycleController.rowsPerPage) > 0) total_page += 1;

          print("last index ${salesCycleController.pageNumber} ${salesCycleController.total_rows_sales} ${salesCycleController.rowsPerPage} ${total_page}");

          if (salesCycleController.pageNumber + 1 < total_page) {
            salesCycleController.getsalesCycleData(salesCycleController.pageNumber +1, "", "salesPage", "Sales");
            salesCycleController.pageNumber += 1;
          }

          /*if (salesCycleController.pageNumber + 1 != total_page) {
            salesCycleController.getsalesCycleData(salesCycleController.pageNumber + 1, "", "", "Sales");
            salesCycleController.pageNumber += 1;
          }*/
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
          itemCount: salesCycleController.saleCycleList.value.length,
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
    var createdOn=StaticMethod.dateTimeToDate(salesCycleController.saleCycleList[position].createdOn??"");
    var approvedOn=StaticMethod.dateTimeToDate(salesCycleController.saleCycleList[position].approvedOn??"");
    String saleCycleStatus = salesCycleController.saleCycleList[position].salesCycleApprovalStatus?.toLowerCase()??"";
    String saleQuoteAccepted= salesCycleController.saleCycleList[position].quoteAccepted?.toLowerCase()??"";
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
            salesCycleController.extClosureStartToEnd.value="";
            salesCycleController.filter.value = "Customer Need Identity";
            salesCycleController.clearSaleProductListController();
          salesCycleController.salesCycleId.value=salesCycleController.saleCycleList[position].salesCycleId!;
          salesCycleController.pageNumber=0;
          salesCycleController.getsalesCycleData(salesCycleController.pageNumber, salesCycleController.saleCycleList[position].salesCycleId!, "ViewHeader", 'Sales');
          salesCycleController.itemCategorySelectedlist.value = [];
          salesCycleController.getPurchaseProcessApi();
          salesCycleController.getPurchaseTimeFrameApi();
          salesCycleController.getItemCategoryMstApi(salesCycleController.saleCycleList[position].salesCycleId! ,salesCycleController.saleCycleList[position].taskId??"","" );
          salesCycleController.ProductCategoryWiseAmtGet(0, salesCycleController.saleCycleList[position].salesCycleId!);
          salesCycleController.pageNumber=0;
          salesCycleController.getSaleCycleProductByIdList(salesCycleController.pageNumber,salesCycleController.saleCycleList[position].salesCycleId??"");
          //salesCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(salesCycleController.pageNumber,salesCycleController.saleCycleList[position].salesCycleId!);
          salesCycleController.clearAllFieldOfQuoteFilter();

          },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Sales Cycle Id: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: salesCycleController.saleCycleList[position].salesCycleId??"",
                      child: Text(salesCycleController.saleCycleList[position].salesCycleId??"",
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
                visible: salesCycleController.isAdminWritePermission.value == "1" &&
                    salesCycleController.isHeadofficePermission.value == "0",
                child:  GestureDetector(
                    onTap: (){
                      print("position sale cycle.....${position}");
                      showConfirmCompleteDialog(context,position!);
                    },
                    child: Icon(Icons.delete, color: Colors.red)),
              );
            }),

          ],
        ),
          
        subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelWithValue(label: "Approval Status : ", value: salesCycleController.saleCycleList[position].salesCycleApprovalStatus, color: getStatusColor(saleCycleStatus),),
              _buildClickableLabel(
                label: "Customer Name : ",
                value: salesCycleController.saleCycleList[position].accountName,
                width: size.width * 0.4,
                onTap: () {
                  final account_vm_controller = Get.put(Accountmastervm());
                  final contact_vm_controller = Get.put(ContactMasterVM());
                  account_vm_controller.view = 'FromSaleCycleMainScreen';
                  contact_vm_controller.view = 'FromSaleCycleMainScreen';
                  account_vm_controller.getAccMasterBuyCodeApi(
                    salesCycleController.saleCycleList[position].accountCode??"",
                  );
                },
              ),
              _buildLabelWithValue(label: "Customer Code : ", value: salesCycleController.saleCycleList[position].accountCode,),
              _buildLabelWithValue(label: "Sales Cycle Owner : ", value: salesCycleController.saleCycleList[position].salesCycleOwnerName,),
              _buildLabelWithValue(label: "Exp. Closure Date : ", value: salesCycleController.saleCycleList[position].estClosureDate,),
              //_buildLabelWithValue(label: "Expected Amount: ", value: '₹ ${salesCycleController.saleCycleList[position].estBudgetAmount}',),
              _buildLabelWithValue(label: "Expected Amount: ", value: "₹ ${
                  salesCycleController
                      .numberFormatWithComma(salesCycleController.saleCycleList[position].estBudgetAmount)
                      .toString()
              }",color:AllColors.textColor),
              _buildLabelWithValue(label: "Is Commit : ", value: salesCycleController.saleCycleList[position].commit==1?"Yes":"No",),
              _buildLabelWithValue(label: "Sales Cycle Status: ", value: salesCycleController.saleCycleList[position].salesCycleStatus,),
              _buildLabelWithValue(label: "Quote Accepted: ", value: salesCycleController.saleCycleList[position].quoteAccepted, color: getQouteAcceptedColor(saleQuoteAccepted),),
              _buildLabelWithValue(label: "Product Category : ", value: salesCycleController.saleCycleList[position].productCategory,),
              _buildLabelWithValue(label: "Budget Amount: ", value: "₹ ${
                  salesCycleController
                      .numberFormatWithComma(salesCycleController.saleCycleList[position].budgetAmount)
                      .toString()
              }",color:AllColors.textColor),
             // _buildLabelWithValue(label: "Budget Amount : ", value: "₹ ${salesCycleController.saleCycleList[position].budgetAmount.toString()}",),
              _buildLabelWithValue(label: "Contact Name : ", value: salesCycleController.saleCycleList[position].contactName,),
              _buildLabelWithValue(label: "Purchase Process : ", value: salesCycleController.saleCycleList[position].purchaseProcess,),
              _buildLabelWithValue(label: "Company Pro. Type : ", value: salesCycleController.saleCycleList[position].companyProfileType,),
              _buildLabelWithValue(label: "Is Solution Accepted : ", value: salesCycleController.saleCycleList[position].isSolutionAccepted.toString()=="1"?"Yes":"No",),
              _buildLabelWithValue(label: "Task Id : ", value: salesCycleController.saleCycleList[position].taskId,),
              _buildLabelWithValue(label: "Pin Code : ", value: salesCycleController.saleCycleList[position].postCode,),
              _buildLabelWithValue(label: "District : ", value: salesCycleController.saleCycleList[position].district,),
              _buildLabelWithValue(label: "Cluster Name : ", value: salesCycleController.saleCycleList[position].clustureHeadValue,),
              _buildLabelWithValue(label: "Region Name : ", value: salesCycleController.saleCycleList[position].branchHeadValue,),
              _buildLabelWithValue(label: "Created By : ", value: salesCycleController.saleCycleList[position].createdFullName,),
              _buildLabelWithValue(label: "Created On: ", value: createdOn,),
              _buildLabelWithValue(label: "Reporting Manager : ", value: salesCycleController.saleCycleList[position].approvedFullName,),
              _buildLabelWithValue(label: "Approved On: ", value: approvedOn,),
              _buildLabelWithValue(label: "Reject Reason : ", value: salesCycleController.saleCycleList[position].rejectReason,),
            ],
          ),

         // trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
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


  showConfirmCompleteDialog(BuildContext context, int index){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade100, // light red background
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 28,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delete",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700),
                    ),
                    Text("Do You Want to Delete This Account?",
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
                Navigator.pop(context);
                salesCycleController.SalesCycleMstDelete(index);
              },
              child: Text("Delete",style: TextStyle(color: AllColors.greenblue),),
            ),
          ],
        );
      },
    );
  }

  Widget _buildClickableLabel({
    required String label,
    required String? value,
    required VoidCallback onTap,
    double? width,
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
          child: InkWell(
            onTap: onTap,
            child: Tooltip(
              message: value ?? "",
              child: Text(
                value ?? "",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
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


  void showFilterBottomSheet(BuildContext context) {
   // salesCycleController.IsActive_controller.clear();
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
                              SizedBox(height: 10,),
                              bindSaleCycleStagesDropDown(context),
                              SizedBox(height: 5,),
                              bindFilterData(salesCycleController.saleCycleController.value, 'Sale Cycle Id'),
                              SizedBox(height: 5,),
                              Obx((){
                                return Visibility(
                                  visible: salesCycleController.filterQuoteAcceptedFlag.value=='',
                                    child:Column(
                                  children: [
                                    bindQuoteAccepted(context),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ) );
                              }),
                              bindFilterData(salesCycleController.filterTask_Id_controller.value, 'Task Id'),
                              SizedBox(height: 10,),
                              bindApprovalStatusDropDown(context),
                              SizedBox(height: 10,),
                              bindFilterData(salesCycleController.accountNameController.value, 'Customer Name'),
                              SizedBox(height: 10,),
                              bindFilterData(salesCycleController.accountCodeController.value, 'Customer Code'),
                              SizedBox(height: 10,),
                              bindProductCategoryDropDown(context),
                              SizedBox(height: 10,),
                              bindProductCategoryTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindFilterData(salesCycleController.purchaseProcessController.value, 'Purchase Process'),
                              SizedBox(height: 10,),
                              bindCompProfileTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindIsCommintdrpdown(context),
                              SizedBox(height: 10,),
                              bindSolutionAccepted(context),
                              SizedBox(height: 10,),
                              bindFilterData(salesCycleController.postalCodeController.value, 'Pin Code'),
                              SizedBox(height: 10,),
                              bindFilterData(salesCycleController.district_controller.value, 'District'),
                              SizedBox(height: 10,),
                              bindExpectedClosureDate(context),
                              SizedBox(height: 10,),
                              bindFilterData(salesCycleController.createdByController.value, 'Created By'),
                              SizedBox(height: 10,),
                              bindCreatedOn(context),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindSaleCycleOwnerFilter(context),
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
                            Get.back();
                            salesCycleController.filterDataChecker.value='';
                            salesCycleController.clearAllFieldOfFilter();
                            salesCycleController.clearFilterData();
                            salesCycleController.pageNumber = 0;
                            salesCycleController.getsalesCycleData(
                                salesCycleController.pageNumber, "", "", "");
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            salesCycleController.pageNumber = 0;
                            salesCycleController.getsalesCycleData(salesCycleController.pageNumber, "", "", "");
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Saved Filter',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            salesCycleController.filterDataChecker.value='';
                            salesCycleController.SaveFilterData();
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


  Widget bindSaleCycleStagesDropDown(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: salesCycleController.SaleCycleStatusController.value,
        label: Text("Sales Cycle Stage",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
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
          salesCycleController.SaleCycleStatusController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
          /*print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');*/

        },
        dropdownMenuEntries:
        salesCycleController.SaleCycleStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  Widget bindApprovalStatusDropDown(BuildContext context){
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: salesCycleController.ApprovalStatusController.value,
        label: Text(
          "Approval Status",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),
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
          salesCycleController.ApprovalStatusController.value.text =
              _displayApprovalStatusForOption(selection!)
                  .toString();
          /*print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');*/

        },
        dropdownMenuEntries:
        salesCycleController.ApprovalStatusList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
    //todo commented by nirupma because dropdown is not working properly
   /* return Autocomplete<String>(
      displayStringForOption: _displayApprovalStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return salesCycleController.ApprovalStatusList;
        }
        return salesCycleController.ApprovalStatusList
            .where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        // Update the TextField with the selected
        salesCycleController.ApprovalStatusController.value.text =
            _displayApprovalStatusForOption(selection).toString();
        //print('IsActive.....${salesCycleController.Task_status_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = salesCycleController.ApprovalStatusController.value
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Approval Status',
              labelText: 'Approval Status',
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
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width*.9,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
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
    );*/
  }

  bindSaleCycleOwnerFilter(BuildContext context) {
    return Obx((){
      if (salesCycleController.AccountOwner_controller.value.text.isNotEmpty && salesCycleController.filterDataChecker.value=='1') {
        List<String> nameList = salesCycleController.AccountOwner_controller.value.text.split(',');
        salesCycleController.SelectedEmployee_Member_list.value =
            List.generate(nameList.length, (index) {
              return EmployeeMemberModel(
                fullName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: salesCycleController.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: salesCycleController.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesCycleController.SelectedEmployee_Member_list.isNotEmpty?"Account Owner":null,
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
          salesCycleController.SelectedEmployee_Member_list.value =
              selectedList;
          salesCycleController.AccountOwner_controller.value.text =
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

  bindProductCategoryDropDown(BuildContext context) {
    return Obx(() {
      if (salesCycleController.productCategoryController.value.text.isNotEmpty && salesCycleController.filterDataChecker.value=='1') {
        List<String> nameList = salesCycleController.productCategoryController.value.text.split(',');

        salesCycleController.Selected_Item_Category_master_list_without_task.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: salesCycleController.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: salesCycleController.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesCycleController.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
            hintText:  "Product Category" ,
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
          salesCycleController.Selected_Item_Category_master_list_without_task.value = selectedList;
          salesCycleController.productCategoryController.value.text =
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
      controller: salesCycleController.product_category_type_Controller.value,
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
        salesCycleController.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: salesCycleController.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
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


  Widget bindSolutionAccepted(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: salesCycleController.solutionAcceptedController.value,
        label: Text(
          "Solution Accepted",
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
          salesCycleController.solutionAcceptedController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!)
                  .toString();
          print('IsActive.....${salesCycleController.solutionAcceptedController
              .value.text}');

        },
        dropdownMenuEntries:
        salesCycleController.customerNeedIdentityList.map<
            DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e, label: e!, style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindCompProfileTypeDropDown(BuildContext context) {
    return Obx(() {
      if (salesCycleController.companyProfileTypeController.value.text.isNotEmpty && salesCycleController.filterDataChecker.value=='1') {
        List<String> nameList = salesCycleController.companyProfileTypeController.value.text.split('|');

        salesCycleController.selected_company_type_list.value =
            List.generate(nameList.length, (index) {
              return CompanyTypeModal(
                description: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CompanyTypeModal>.multiSelection(
        items: salesCycleController.company_profile_type_list,
        itemAsString: (CompanyTypeModal u) => u.description ?? "",
        selectedItems: salesCycleController.selected_company_type_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: salesCycleController.selected_company_type_list.isNotEmpty ? "Company Profile Type" : null,
            hintText: "Company Profile Type",
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
          salesCycleController.selected_company_type_list.value = selectedList;
          salesCycleController.companyProfileTypeController.value.text =
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
  bindIsCommintdrpdown(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery
          .of(context)
          .size.width-15,
      controller: salesCycleController.isCommitController.value,
      label: Text(
        "Is Commit",
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
        salesCycleController.isCommitController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!)
                .toString();
      },
      dropdownMenuEntries:
      salesCycleController.customerNeedIdentityList.map<
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
      controller:salesCycleController.filterExpectedClosuredateController.value,
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
          salesCycleController.extClosureStartToEnd.value="$startDate@$endDate";
          salesCycleController.filterExpectedClosuredateController.value.text = '$startDate - $endDate';
        } else {
          salesCycleController.filterExpectedClosuredateController.value.text = '';
          salesCycleController.extClosureStartToEnd.value="";
        }
      },
    );
  }

  bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: salesCycleController.createdOnCnontroller.value,
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
            salesCycleController.createdOnCnontroller.value.text = outputFormat.format(date);
          else
            salesCycleController.createdOnCnontroller.value.text = "";
        }

    );
  }

  bindQuoteAccepted(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width-15,
        controller: salesCycleController.filterQuoteAcceptedController.value,
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
          if(selection=="Open"){
            salesCycleController.filterQuoteAcceptedFlag.value = 'Open';
          }
          else if(selection=="Won"){
            salesCycleController.filterQuoteAcceptedFlag.value = 'Won';
          }
          else if(selection=="Loss"){
            salesCycleController.filterQuoteAcceptedFlag.value = 'Loss';
          }else{
            salesCycleController.filterQuoteAcceptedFlag.value = '';
          }
          salesCycleController.filterQuoteAcceptedController.value.text =
              _displaySaleCycleStatusForOption(selection!)
                  .toString();
        },
        dropdownMenuEntries:
        salesCycleController.qouteAcceptedList.map<
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
      final availableItems = salesCycleController.clusterGetByEmailList;
      if (salesCycleController.clusterName_controller.value.text.isNotEmpty && salesCycleController.filterDataChecker.value=='1') {
        List<String> nameList = salesCycleController.clusterName_controller.value.text.split('|');
        salesCycleController.SelectedCluster_list.value =[];
        salesCycleController.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && salesCycleController.SelectedCluster_list.isEmpty) {
          salesCycleController.SelectedCluster_list.assignAll(availableItems);
          salesCycleController.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          salesCycleController.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = salesCycleController.SelectedCluster_list;
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
              tempSelected.addAll(salesCycleController.SelectedCluster_list);

              List<ClusterModal> allItems =
                  salesCycleController.clusterGetByEmailList;

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

                                    salesCycleController.filterDataChecker.value='';
                                    salesCycleController.SelectedCluster_list.assignAll(tempSelected);
                                    salesCycleController.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    salesCycleController.getRegionsWithClusterFilterGetByEmail();

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
      final availableItems = salesCycleController.regionwithclusterGetByEmailList;
      if (salesCycleController.RegionName_controller.value.text.isNotEmpty && salesCycleController.filterDataChecker.value=='1') {
        salesCycleController.SelectedRegion_list.value=[];
        List<String> nameList = salesCycleController.RegionName_controller.value.text.split('|');
        salesCycleController.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && salesCycleController.SelectedRegion_list.isEmpty) {
          salesCycleController.SelectedRegion_list.assignAll(availableItems);
          salesCycleController.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${salesCycleController.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = salesCycleController.SelectedRegion_list;
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
              tempSelected.addAll(salesCycleController.SelectedRegion_list);

              final allItems = salesCycleController.regionwithclusterGetByEmailList;

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
                                    salesCycleController.filterDataChecker.value='';
                                    salesCycleController.SelectedRegion_list.assignAll(tempSelected);
                                    salesCycleController.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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


}