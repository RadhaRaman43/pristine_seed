import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sale_cycle_modal/approval_person_model.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class ApprovalPersonList extends StatelessWidget{
  ApprovalPersonList({super.key});
  final saleCycleController=Get.put(SalesCycleVm());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()  async {
        Get.toNamed(RoutesName.quoteInformationScreen);

        return false;

      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title: Text(
            'Approval Person List',
            style: GoogleFonts.poppins(
              color: AllColors.whiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        drawer: CustomDrawer(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:saleCycleController.loading.value ,
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
                  child: Obx(() {
                    return BindCustomerListView(context);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (saleCycleController.approvalPersonList.isNotEmpty &&
        saleCycleController.approvalPersonList!=null &&
        saleCycleController.approvalPersonList.length > 0   ) {
      ScrollController scrollController = ScrollController();
      /*scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (contact_vm_controller.total_rows /
              contact_vm_controller.rowsPerPage).toInt();
          if ((contact_vm_controller.total_rows % contact_vm_controller.rowsPerPage) > 0)
            total_page += 1;

          print("last index ${contact_vm_controller.pageNumber} ${contact_vm_controller.total_rows} ${contact_vm_controller.rowsPerPage} ${total_page}");

          if (contact_vm_controller.pageNumber + 1 < total_page) {
            this.contact_vm_controller.pageNumber += 1;
            contact_vm_controller.getContactMasterList(contact_vm_controller.pageNumber+1, '', '', '');

          }
        }
      });*/

      final nonAdminList = saleCycleController.approvalPersonList
          .where((item) => item.isAdmin == 0) // or item.isAdmin != 1 depending on your model
          .toList();

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: nonAdminList.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index, nonAdminList);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position, List<getApprovalPersonMadol> nonAdminList){
    String? dateApprovedOn=StaticMethod.dateTimeToDate(nonAdminList[position].approvedOn??"");
    final item = nonAdminList[position];
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
        onTap: () {
      //accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
          },

          /*leading: Text(
              saleCycleController.approvalPersonList[position]
                  .approverOrder.toString(),
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  color: AllColors.textColor,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500),
          ),*/

          subtitle:
          Column(
            children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Approver Order : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .approverOrder.toString(),
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .approverOrder.toString(),
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
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Is SPR : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .isSpr.toString()=='1'?"Yes":"No",
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .isSpr.toString()=='1'?"Yes":"No",
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
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "SPR No: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .sprNo?? "",
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .sprNo?? "",
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
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "SPR Category Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .sprCategoryName.toString(),
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .sprCategoryName.toString(),
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
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Quote Status : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .quoteStatus?? "",
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .quoteStatus?? "",
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
              SizedBox(height: 3),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Approved By : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .approvedFullName?? "",
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .approvedFullName?? "",
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

              SizedBox(height: 3),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Approved On : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: dateApprovedOn?? "",
                      child: Text(
                        dateApprovedOn?? "",
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

              SizedBox(height: 3),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Reject Reason : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: saleCycleController.approvalPersonList[position]
                          .rejectReason?? "",
                      child: Text(
                        saleCycleController.approvalPersonList[position]
                            .rejectReason?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                ],
              ),*/

              detailRow("Approver Order", item.approverOrder.toString(), ),
              /*detailRow("Is SPR", item.isSpr.toString() == '1' ? "Yes" : "No", ),
              detailRow("SPR No", item.sprNo ?? "",),
              detailRow("SPR Category", item.sprCategoryName ?? "", ),
              detailRow("User Type", item.userType ?? "", ),*/
             /* detailRow("Approver Geo Name", item.approverGeoName ?? "", ),
              detailRow("Approver Geo Value", item.approverGeoValue ?? "", ),*/
              detailRow("Quote Status", item.quoteStatus ?? "", ),
              detailRow("Approved By", item.approvedFullName ?? "", ),
              detailRow("Approved On", dateApprovedOn ?? "", ),
              //detailRow("Manager Remarks", item.managerRemarks ?? "",),
              detailRow("Reject Reason", item.rejectReason ?? "",),
            ],
          ),
        )
    );
  }

  Widget detailRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "$label  :",
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Flexible(
          child: Tooltip(
            message: value ?? '',
            child: Text(
              value ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              //maxLines: 2,
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),

            ),
          ),
        ),
      ],
    );
  }
}