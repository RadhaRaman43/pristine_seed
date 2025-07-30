

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_pending_for_approval_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';


class SaleCyclePendingForApprovalList extends StatelessWidget{
  final salesCyclePendingForApprovalController=Get.put(SalesCyclePendingForApprovalVm());
  final salesCycleController=Get.put(SalesCycleVm());

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displaySaleCycleStatusForOption(String option) =>
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
          salesCycleController.getItemCategoryMstApi(salesCycleId ,taskId );
          salesCycleController.ProductCategoryWiseAmtGet(0, salesCycleId);
          salesCycleController.pageNumber=0;
          //salesCycleController.getSaleCycleProductByIdList(salesCycleController.pageNumber,salesCycleId);
          salesCycleController.getsalesCycleCompetitorProductGetBySalesCycleId(salesCycleController.pageNumber,salesCycleId);
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

  Widget _buildClickableLabel({
    required String label,
    required String? value,
    required VoidCallback onTap,
    double? width,
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
        InkWell(
          onTap: onTap,
          child: Container(
            width: width,
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
                              SizedBox(
                                height: 10,
                              ),
                              bindSaleCycleIdDropDown(context),
                              SizedBox(
                                height: 5,
                              ),
                              bindTaskId(),
                              SizedBox(
                                height: 5,
                              ),

                              bindSaleCycleStatusDropDown(context),

                              SizedBox(
                                height: 10,
                              ),

                              TextField(
                                controller: salesCyclePendingForApprovalController.accountNameController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Customer Name',
                                    hintText: 'Customer Name',
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
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              TextField(
                                controller: salesCyclePendingForApprovalController.accountCodeController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Customer Code',
                                    hintText: 'Customer Code',
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
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              bindSaleCycleOwner(),
                              SizedBox(
                                height: 10,
                              ),

                              bindProductCategory(),
                              SizedBox(
                                height: 10,
                              ),

                              bindPurchaseProcess(),
                              SizedBox(
                                height: 10,
                              ),


                              bindCompProfileTypeDropDown(),
                              SizedBox(
                                height: 10,
                              ),

                              bindIsCommintdrpdown(context),
                              SizedBox(
                                height: 10,
                              ),

                              bindSolutionAccepted(context),
                              SizedBox(
                                height: 10,
                              ),
                              /*  bindProposedSolution(context),
                              SizedBox(
                                height: 10,
                              ),*/


                              bindPostalCode(),
                              SizedBox(
                                height: 10,
                              ),
                              bindDistrict(),
                              SizedBox(
                                height: 10,
                              ),


                              /* bindFrontLinerValue(),
                              SizedBox(
                                height: 10,
                              ),*/
                              bindBranchHead(),
                              SizedBox(
                                height: 10,
                              ),
                              /* bindZoneHead(),
                              SizedBox(
                                height: 10,
                              ),*/
                              bindClusterHead(),
                              SizedBox(
                                height: 10,
                              ),
                              bindCreatedBy(),
                              SizedBox(
                                height: 10,
                              ),

                              bindExpectedClosureDate(context),
                              SizedBox(
                                height: 10,
                              ),

                              bindCreatedOn(context),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                  ),
                ],
              ),
            );
          },

        );
      },
    );
  }
  Widget bindSaleCycleStatusDropDown(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(  right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
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

  Widget bindSaleCycleIdDropDown(BuildContext context) {
    return  TextField(
      controller: salesCyclePendingForApprovalController.saleCycleController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Sale Cycle Id',
          hintText: 'Sale Cycle Id',
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



  bindTaskId() {
    return TextField(
      controller: salesCyclePendingForApprovalController.filterTask_Id_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Task Id',
          hintText: 'Task Id',
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

  bindCompProfileTypeDropDown() {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesCyclePendingForApprovalController.companyProfileTypeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Company Profile Type',
          hintText: 'Company Profile Type',
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
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }

  bindPostalCode() {
    return TextField(
      controller: salesCyclePendingForApprovalController.postalCodeController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Pin Code',
          hintText: 'Pin Code',
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

  bindDistrict() {
    return TextField(
      controller: salesCyclePendingForApprovalController.district_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'District',
          hintText: 'District',
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

  bindCreatedBy() {
    return TextField(
      controller: salesCyclePendingForApprovalController.createdByController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Created By',
          hintText: 'Created By',
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

/*  bindFrontLinerValue() {
    return TextField(
      controller: salesCycleController.frontliner_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'FrontLiner Value',
          hintText: 'FrontLiner Value',
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
  }*/

  bindClusterHead() {
    return TextField(
      controller: salesCyclePendingForApprovalController.cluster_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Cluster Name',
          hintText: 'Cluster Name',
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

  /*bindZoneHead() {
    return TextField(
      controller: salesCycleController.zone_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Zone Head Value',
          hintText: 'Zone Head Value',
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
  }*/

  bindBranchHead() {
    return TextField(
      controller: salesCyclePendingForApprovalController.branch_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Region Name',
          hintText: 'Region Name',
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

  bindProductCategory() {
    return TextField(
      controller: salesCyclePendingForApprovalController.productCategoryController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Product Category',
          hintText: 'Product Category',
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

  bindPurchaseProcess() {
    return TextField(
      controller: salesCyclePendingForApprovalController.purchaseProcessController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Purchase Process',
          hintText: 'Purchase Process',
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
      padding: const EdgeInsets.only( right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
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

  Widget bindProposedSolution(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesCyclePendingForApprovalController.proposedSolutionController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
          hintText: 'Proposed Solution',
          labelText: 'Proposed Solution',
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

  /* bindCreatedOn(BuildContext context) {
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
            salesCycleController.createdOnCnontroller.value.text =
                outputFormat.format(date);
          else
            salesCycleController.createdOnCnontroller.value.text =
            "";
        }


    );
  }*/
  bindCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: salesCyclePendingForApprovalController.createdOnCnontroller.value,
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
          salesCyclePendingForApprovalController.createdOnStartToEnd.value="$startDate@$endDate";
          salesCyclePendingForApprovalController.createdOnCnontroller.value.text = '$startDate - $endDate';
        } else {
          salesCyclePendingForApprovalController.createdOnCnontroller.value.text = '';
          salesCyclePendingForApprovalController.createdOnStartToEnd.value="";
        }
      },
    );
  }
}