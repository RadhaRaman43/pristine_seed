import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../constants/static_methods.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/pending_Draft_Quote_vm.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';



class AllSprMappingScreen extends StatelessWidget{
  AllSprMappingScreen({super.key});

  PendingDraftQuoteVm pendingDraftQuoteController=Get.put(PendingDraftQuoteVm());
  SalesCycleVm saleCycleController=Get.put(SalesCycleVm());
  Size size=Get.size;
  final account_vm_controller = Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());

  static String _displayQuoteStatusForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
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
                  "All SPR Mapping Item List",
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  showDialogForFilter(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh:pendingDraftQuoteController.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:pendingDraftQuoteController.loading.value ,
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
                      return BindPendingListView(context);
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),);
  }

  Widget BindPendingListView(context) {
    if (pendingDraftQuoteController.PendingDraftQuoteList.value.isNotEmpty && pendingDraftQuoteController.PendingDraftQuoteList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (pendingDraftQuoteController.total_rows /
              pendingDraftQuoteController.rowsPerPage)
              .toInt();
          if ((pendingDraftQuoteController.total_rows %
              pendingDraftQuoteController.rowsPerPage) >
              0) total_page += 1;

          // print("last index ${pendingDraftQuoteController.pageNumberForQuote} ${pendingDraftQuoteController.total_rows} ${pendingDraftQuoteController.rowsPerPage} ${total_page}");
          if (pendingDraftQuoteController.pageNumberForQuote + 1 < total_page) {
            pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote+1, "ALLSPRMAPPING");
            pendingDraftQuoteController.pageNumberForQuote += 1;
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
          itemCount: pendingDraftQuoteController.PendingDraftQuoteList.value.length,
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
    String? quoteValidityDate=StaticMethod.convertDateFormat1(pendingDraftQuoteController.PendingDraftQuoteList[position].quoteValidity ?? "");
    String? expectedClosuredateDate=StaticMethod.convertDateFormat1(pendingDraftQuoteController.PendingDraftQuoteList[position].expClosureDate ?? "");
    String? createdOn=StaticMethod.dateTimeToDate(pendingDraftQuoteController.PendingDraftQuoteList[position].createdOn ?? "");
    String saleCycleStatus = pendingDraftQuoteController.PendingDraftQuoteList[position].quoteStatus?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'rejected':
          return Colors.red[600]!;
        case 'approved':
          return Colors.green[700]!;
        case 'draft':
          return Colors.red[900]!;
        case 'pending for approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        width: size.width,
        child: ListTile(
          onTap: () {
            saleCycleController.quoteId.value =
            pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId!;
            saleCycleController.getApprovalPersonList(pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId??"");
            // saleCycleController.quoteApprovalPage.value="quoteApprovalScreen";
            saleCycleController.getQuoteHeaderInformation(pendingDraftQuoteController.PendingDraftQuoteList[position].quoteId, "FromAllSPRMapping");
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
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:  pendingDraftQuoteController.PendingDraftQuoteList[position]
                          .quoteId ?? "",
                      child: Text(
                        pendingDraftQuoteController.PendingDraftQuoteList[position]
                            .quoteId ?? "",
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
              Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(
                label: "Quote Version: ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteVersion.toString(),
                //width: size.width * 0.33,

              ),

              _buildLabelWithValue(
                label: "Quote Status: ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteStatus,
                //width: size.width * 0.33,
                color:getStatusColor(saleCycleStatus)

              ),
              _buildLabelWithValue(
                label: "Sale Cycle Id : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].salesCycleId,
                //width: size.width * 0.33,
              ),
              _buildClickableLabel(
                label: "Customer Code : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].accountCode,
                onTap: () {
                  account_vm_controller.view = 'FromAllSPRMapping';
                  contact_vm_controller.view = 'FromAllSPRMapping';
                  account_vm_controller.getAccMasterBuyCodeApi(
                    pendingDraftQuoteController
                        .PendingDraftQuoteList[position].accountCode!,
                  );
                },
              ),

              _buildLabelWithValue(
                label: "Customer Name : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].accountName,
                //width: size.width * 0.33,

              ),
              _buildLabelWithValue(
                label: "Contact Name : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].contactName,
                //width: size.width * 0.33,

              ),
              _buildLabelWithValue(
                label: "Quote Validity : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteValidity,
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Expected Closure Date : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].expClosureDate,
                //width: size.width * 0.33,

              ),
              _buildLabelWithValue(
                label: "Quote Total Amt : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteTotalAmount.toString(),
                //width: size.width * 0.33,

              ),
              _buildLabelWithValue(
                label: "Quote Gst Amt. : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteGstAmount.toString(),
                //width: size.width * 0.33,

              ),
              _buildLabelWithValue(
                label: "Quote Gross Amt. : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].quoteGrossAmount.toString(),
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Region Name : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position]
                    .branchHeadValue,
              ),
              _buildLabelWithValue(
                label: "Cluster Name : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position]
                    .clustureHeadValue,
              ),
              _buildLabelWithValue(
                label: "Item Code :  ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].itemCode,
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Item Name :  ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].itemName,
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "LSP :  ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].listSellingPrice.toString(),
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Sales Credit :  ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].salesCredit.toString(),
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Spr No. : ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].sprNo,
                //width: size.width * 0.33,
              ),

              _buildLabelWithValue(
                label: "Created By :  ",
                value: pendingDraftQuoteController.PendingDraftQuoteList[position].createdBy,
                //width: size.width * 0.33,
              ),
              _buildLabelWithValue(
                label: "Created On :  ",
                value: createdOn,
                //width: size.width * 0.33,
              ),
            ],
          ),
         // trailing: Icon(Icons.remove_red_eye_outlined,  color: Colors.blue,),
        ),
      ),
    );
  }

  void showDialogForFilter(BuildContext context) {
    // accountMaster_page_controller.IsActive_controller.clear();
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
                              SizedBox(
                                height: 5,
                              ),
                              filterWithQuoteId(context),
                              SizedBox(height: 10),
                              TextField(
                                controller: pendingDraftQuoteController.filterQuoteVersionController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Quote Version',
                                    hintText: 'Quote Version',
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
                              SizedBox(height: 10),
                              filterWithSaleCycle(context),
                              SizedBox(height: 10),
                              TextField(
                                controller: pendingDraftQuoteController.accountCodeController.value,
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
                              SizedBox(height: 10),
                              TextField(
                                controller: pendingDraftQuoteController.accountNameController.value,
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
                              SizedBox(height: 10,),
                              filterWithQuoteProductCategory(),
                              SizedBox(height: 10,),
                              filterWithQuoteStatus(context),
                              SizedBox(height: 10),
                              filterWithQuoteValidity(context),
                              SizedBox(height: 10),
                              filterWithQuoteClosureDate(context),
                              SizedBox(height: 10),
                              filterWithQuoteRhApproval(),
                              SizedBox(height: 10,),
                              filterWithQuotecnhApproval(),
                              SizedBox(height: 10,),
                              filterWithQuoteCategoryApproval(),
                              SizedBox(height: 10,),
                              filterWithQuoteGmApproval(),
                              SizedBox(height: 10,),
                              filterWithQuoteBranchHead(),
                              SizedBox(height: 10,),
                              filterWithQuoteClusterHead(),
                              SizedBox(height: 10,),
                              TextField(
                                controller: pendingDraftQuoteController.createdByCnontroller.value,
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
                              ),
                              SizedBox(height: 10,),
                              filterWithQuoteCreatedOn(context),
                              SizedBox(height: 10,),

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

                              pendingDraftQuoteController.pageNumberForQuote = 0;
                              pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLSPRMAPPING");
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
                                foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AllColors.redColor, width: 1),
                            )),
                            onPressed: () {

                              pendingDraftQuoteController.clearAllFieldOfQuoteFilter();
                              pendingDraftQuoteController.pageNumberForQuote = 0;
                              pendingDraftQuoteController.getPendingDraftQuoteList(pendingDraftQuoteController.pageNumberForQuote, "ALLSPRMAPPING");
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
                  ),
                ],
              ),
            );
          },

        );
      },
    );
  }

  Widget filterWithQuoteId(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: pendingDraftQuoteController.filterQuoteIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Id',
          labelText: 'Quote Id',
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

  filterWithSaleCycle(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: pendingDraftQuoteController.filterQuoteSaleCycleController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Sale Cycle Id',
          labelText: 'Sale Cycle Id',
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

  filterWithQuoteProductCategory() {
    return TextField(
      controller: pendingDraftQuoteController.productCategoryController.value,
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

  Widget filterWithQuoteStatus(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(  right: 15),
      child: DropdownMenu<String>(
        width: MediaQuery
            .of(context)
            .size
            .width-15,
        controller: pendingDraftQuoteController.quoteStatusController.value,
        label: Text(
          "Quote Status",
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
          pendingDraftQuoteController.quoteStatusController.value.text =
              _displayQuoteStatusForOption(selection!)
                  .toString();

        },
        dropdownMenuEntries:
        pendingDraftQuoteController.AllQuoteStatusList.map<
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
      controller: pendingDraftQuoteController.filterQuoteValidityController.value,
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
          pendingDraftQuoteController.quoteValidityStartToEnd.value = "$startDate@$endDate";
          pendingDraftQuoteController.filterQuoteValidityController.value.text =
          '$startDate - $endDate';
        } else {
          pendingDraftQuoteController.filterQuoteValidityController.value.text = '';
          pendingDraftQuoteController.quoteValidityStartToEnd.value = "";
        }
      },
    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: pendingDraftQuoteController.filterExpectedClosuredateController.value,
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
          pendingDraftQuoteController.extClosureStartToEnd.value = "$startDate@$endDate";
          pendingDraftQuoteController.filterExpectedClosuredateController.value.text =
          '$startDate - $endDate';
        } else {
          pendingDraftQuoteController.filterExpectedClosuredateController.value.text = '';
          pendingDraftQuoteController.extClosureStartToEnd.value = "";
        }
      },
    );
  }

  filterWithQuoteRhApproval() {
    return TextField(
      controller: pendingDraftQuoteController.rh_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Rh Approval',
          hintText: 'Rh Approval',
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

  filterWithQuotecnhApproval() {
    return TextField(
      controller: pendingDraftQuoteController.cbh_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'CBH Approval',
          hintText: 'CbH Approval',
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

  filterWithQuoteCategoryApproval() {
    return  TextField(
      controller: pendingDraftQuoteController.category_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Category Approval',
          hintText: 'Category Approval',
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

  filterWithQuoteGmApproval() {
    return TextField(
      controller: pendingDraftQuoteController.gm_Approval_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Gm Approval',
          hintText: 'Gm Approval',
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

  filterWithQuoteBranchHead() {
    return TextField(
      controller: pendingDraftQuoteController.region_name_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Region Name',
          hintText: 'Region Name ',
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

  filterWithQuoteClusterHead() {
    return TextField(
      controller: pendingDraftQuoteController.cluster_head_value_controller.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Cluster Name ',
          hintText: 'Cluster Name ',
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

  filterWithQuoteCreatedOn(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: pendingDraftQuoteController.createdOnCnontroller.value,
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
          pendingDraftQuoteController.createdOnStartToEnd.value = "$startDate@$endDate";
          pendingDraftQuoteController.createdOnCnontroller.value.text =
          '$startDate - $endDate';
        } else {
          pendingDraftQuoteController.createdOnCnontroller.value.text = '';
          pendingDraftQuoteController.createdOnStartToEnd.value = "";
        }
      },
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
        /* width != null
            ? Container(
          width: width,
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
        )
            :*/ Flexible(
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
}