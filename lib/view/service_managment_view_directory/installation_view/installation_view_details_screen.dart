import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/models/service_managment_model_directory/serviceInstallationModel/service_installation_details_model.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../models/service_managment_model_directory/reasonModel/reason_master_response.dart';
import '../../../viewModel/service_managment_vm_directory/installation_vm/installation_vm.dart';
import '../../custom_drawer.dart';

class InstallationViewDetailsScreen extends StatelessWidget {
  InstallationViewDetailsScreen({super.key});

  final installation_deatils_page_controller = Get.put(InstallationViewModel());

  Size size = Get.size;

  static String _displayReasonCodeForOption(ReasonModel option) =>
      option.reasonCode??"";

  List<String> ExerciseFilter = ["walking", "running", "cycling", "hiking"];

  @override
  Widget build(BuildContext context) {
    var serViceTatDate = StaticMethod.onlyDate(
        installation_deatils_page_controller
            .service_installation_details_list[0].serviceTatDatetime!);

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.installation_screen);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'View Installation',
            style: GoogleFonts.poppins(
              color: AllColors.whiteColor,
              fontSize: AllFontSize.twentee,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: installation_deatils_page_controller
              .refreshInstallationDetailsData,
          child: ListView(
            children: [
              Container(
                height: size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        return Container(
                          margin: EdgeInsets.only(top: 0.3),
                          child: Visibility(
                            visible: installation_deatils_page_controller
                                .loading.value,
                            child: LinearProgressIndicator(
                              backgroundColor: AllColors.primaryDark1,
                              color: AllColors.textColor,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: size.height * .22,
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0,
                            color: Colors.black54),
                      ], color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Service No.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_deatils_page_controller
                                    .service_installation_details_list[0]
                                    .serviceNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer No.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_deatils_page_controller
                                    .service_installation_details_list[0]
                                    .customerNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: size.width * .6,
                                child: Tooltip(
                                  message: installation_deatils_page_controller
                                          .service_installation_details_list[0]
                                          .customerName ??
                                      "",
                                  child: Text(
                                      installation_deatils_page_controller
                                              .service_installation_details_list[
                                                  0]
                                              .customerName ??
                                          "",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Contact No.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  openDialPad(
                                      installation_deatils_page_controller
                                          .service_installation_details_list[0]
                                          .customerPhoneNo!);
                                },
                                child: Text(
                                  installation_deatils_page_controller
                                      .service_installation_details_list[0]
                                      .customerPhoneNo!,
                                  style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AllColors.textColor,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer Address",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: size.width * .55,
                                child: Tooltip(
                                  message: installation_deatils_page_controller
                                          .service_installation_details_list[0]
                                          .customerAddress ??
                                      "",
                                  child: Text(
                                    installation_deatils_page_controller
                                            .service_installation_details_list[
                                                0]
                                            .customerAddress ??
                                        "",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.textColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer PinCode",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_deatils_page_controller
                                    .service_installation_details_list[0]
                                    .customerPincode!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          Obx(
                            () {
                              return Visibility(
                                visible: installation_deatils_page_controller
                                                .service_installation_details_list[
                                                    0]
                                                .isUnderApproval ==
                                            1 &&
                                        installation_deatils_page_controller
                                                .service_installation_details_list[
                                                    0]
                                                .serviceStatus ==
                                            "Completed"
                                    ? true
                                    : false,
                                child: Row(
                                  children: [
                                    Text(
                                      "Status",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Under Approval",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.redColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Obx(
                            () {
                              return Visibility(
                                visible: installation_deatils_page_controller
                                                .service_installation_details_list[
                                                    0]
                                                .isUnderApproval ==
                                            0 &&
                                        installation_deatils_page_controller
                                                .service_installation_details_list[
                                                    0]
                                                .serviceStatus ==
                                            "Completed"
                                    ? true
                                    : false,
                                child: Row(
                                  children: [
                                    Text(
                                      "Status",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Tooltip(
                                      message: installation_deatils_page_controller
                                              .service_installation_details_list[
                                                  0]
                                              .completeApprovalRemark ??
                                          "",
                                      child: Text(
                                        installation_deatils_page_controller
                                                .service_installation_details_list[
                                                    0]
                                                .completeApprovalStatus ??
                                            "",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.redColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 2),
                        // padding: EdgeInsets.only(left: 10.0, top: 5, right: 10, bottom: 10),
                        //height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0.0, 1.0),
                              color: Colors.black54,
                              blurRadius: 1.0)
                        ], color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 5, right: 10, bottom: 10),
                              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                                BoxShadow(
                                    offset: Offset(0.0, 1.0),
                                    color: Colors.black54,
                                    blurRadius: 1.0)
                              ], color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Details ",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      installation_deatils_page_controller
                                          .getItemDetails();
                                      ShowItemDetailsDialog(context);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Product",
                                          style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: size.width * .55,
                                          child: Tooltip(
                                            message:
                                                "${installation_deatils_page_controller.service_installation_details_list[0].itemName!} (${installation_deatils_page_controller.service_installation_details_list[0].itemNo!}) ",
                                            child: Text(
                                              "${installation_deatils_page_controller.service_installation_details_list[0].itemName!} (${installation_deatils_page_controller.service_installation_details_list[0].itemNo!}) ",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.textColor,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Category",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: size.width * .55,
                                        child: Tooltip(
                                          message:
                                              installation_deatils_page_controller
                                                      .service_installation_details_list[
                                                          0]
                                                      .categoryName ??
                                                  "",
                                          child: Text(
                                            "${installation_deatils_page_controller.service_installation_details_list[0].categoryName ?? ""} ",
                                            style: GoogleFonts.poppins(
                                              color: AllColors.textColor,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Serial No. ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        installation_deatils_page_controller
                                            .service_installation_details_list[
                                                0]
                                            .serialNo!,
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Service Tat",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        serViceTatDate!,
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Qty",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        installation_deatils_page_controller
                                            .service_installation_details_list[
                                                0]
                                            .qty
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),

                            Obx(
                              () {
                                return Visibility(
                                  visible: installation_deatils_page_controller
                                                  .service_installation_details_list[
                                                      0]
                                                  .complainReasonCode !=
                                              null &&
                                          installation_deatils_page_controller
                                                  .service_installation_details_list[
                                                      0]
                                                  .complainReasonCode !=
                                              ""
                                      ? true
                                      : false,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 2),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: Offset(0.0, 1.0),
                                              color: Colors.black54,
                                              blurRadius: 1.0)
                                        ],
                                        color: Colors.white),
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        top: 5,
                                        right: 10,
                                        bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Complain Details ",
                                          style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.sisxteen,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Complain Code",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * .55,
                                              child: Tooltip(
                                                message:
                                                    " ${installation_deatils_page_controller.service_installation_details_list[0].complainReasonCode ?? ""}(${installation_deatils_page_controller.service_installation_details_list[0].complainReasonDesc ?? ""} )",
                                                child: Text(
                                                  " ${installation_deatils_page_controller.service_installation_details_list[0].complainReasonCode ?? ""}(${installation_deatils_page_controller.service_installation_details_list[0].complainReasonDesc ?? ""} )",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Obx(
                                          () {
                                            return Visibility(
                                              visible: installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .complainRemark !=
                                                          null &&
                                                      installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .complainRemark !=
                                                          "" &&
                                                      installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .complainRemark!
                                                          .isNotEmpty
                                                  ? true
                                                  : false,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Complain Remark",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      fontSize:
                                                          AllFontSize.fourtine,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: size.width * .55,
                                                    child: Tooltip(
                                                      message: installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .complainRemark ??
                                                          "",
                                                      child: Text(
                                                        installation_deatils_page_controller
                                                                .service_installation_details_list[
                                                                    0]
                                                                .complainRemark ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AllColors
                                                              .textColor,
                                                          fontSize: AllFontSize
                                                              .fourtine,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Obx(
                              () {
                                var reschedule_date = StaticMethod.onlyDate(
                                    installation_deatils_page_controller
                                            .service_installation_details_list[
                                                0]
                                            .rescheduleDatetime ??
                                        "");
                                return Visibility(
                                  visible: installation_deatils_page_controller
                                              .service_installation_details_list[
                                                  0]
                                              .serviceStatus! ==
                                          "Rescheduled"
                                      ? true
                                      : false,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: Offset(0.0, 1.0),
                                              color: Colors.black54,
                                              blurRadius: 1.0)
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Re-Schedule Details ",
                                          style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.sisxteen,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Code",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * .55,
                                              child: Tooltip(
                                                message:
                                                    " ${installation_deatils_page_controller.service_installation_details_list[0].rescheduleReasonCode ?? ""} ",
                                                child: Text(
                                                  " ${installation_deatils_page_controller.service_installation_details_list[0].rescheduleReasonCode ?? ""}",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Description",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * .5,
                                              child: Tooltip(
                                                message: installation_deatils_page_controller
                                                        .service_installation_details_list[
                                                            0]
                                                        .rescheduleReasonDesc ??
                                                    "",
                                                child: Text(
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .rescheduleReasonDesc ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Remark",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * .5,
                                              child: Tooltip(
                                                message:
                                                    installation_deatils_page_controller
                                                            .service_installation_details_list[
                                                                0]
                                                            .rescheduleRemark ??
                                                        "",
                                                child: Text(
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .rescheduleRemark ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Date",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              //width: size.width * .5,
                                              child: Text(
                                                reschedule_date ?? "",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.textColor,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Obx(
                                          () {
                                            return Visibility(
                                              visible: installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .isUnderApproval ==
                                                          0 &&
                                                      installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .serviceStatus ==
                                                          "Rescheduled"
                                                  ? true
                                                  : false,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Status",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      fontSize:
                                                          AllFontSize.fourtine,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Tooltip(
                                                    message: installation_deatils_page_controller
                                                            .service_installation_details_list[
                                                                0]
                                                            .recheduleApprovalRemark ??
                                                        "",
                                                    child: Text(
                                                      installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .recheduleApprovalStatus ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AllColors.redColor,
                                                        fontSize: AllFontSize
                                                            .fourtine,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          // child:
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Obx(
                                          () {
                                            return Visibility(
                                              visible: installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .isUnderApproval ==
                                                          1 &&
                                                      installation_deatils_page_controller
                                                              .service_installation_details_list[
                                                                  0]
                                                              .serviceStatus ==
                                                          "Rescheduled"
                                                  ? true
                                                  : false,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Status",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      fontSize:
                                                          AllFontSize.fourtine,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "Under Approval",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors.redColor,
                                                      fontSize:
                                                          AllFontSize.fourtine,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          // child:
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            Obx(
                              () {
                                return Visibility(
                                  visible: installation_deatils_page_controller
                                              .service_installation_details_list[
                                                  0]
                                              .serviceStatus ==
                                          "Reassignment"
                                      ? true
                                      : false,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: Offset(0.0, 1.0),
                                              color: Colors.black54,
                                              blurRadius: 1.0)
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Reassignment Details",
                                          style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.sisxteen,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Code",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              //width: size.width*.4,
                                              child: Tooltip(
                                                message:
                                                    " ${installation_deatils_page_controller.service_installation_details_list[0].assignedReasonCode ?? ""} ",
                                                child: Text(
                                                  " ${installation_deatils_page_controller.service_installation_details_list[0].assignedReasonCode ?? ""}",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Description",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * .5,
                                              child: Tooltip(
                                                message: installation_deatils_page_controller
                                                        .service_installation_details_list[
                                                            0]
                                                        .assignedReasonDesc ??
                                                    "",
                                                child: Text(
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .assignedReasonDesc ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Remark",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * .5,
                                              child: Tooltip(
                                                message:
                                                    installation_deatils_page_controller
                                                            .service_installation_details_list[
                                                                0]
                                                            .assignedRemark ??
                                                        "",
                                                child: Text(
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .assignedRemark ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.textColor,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Obx(() {
                            // return
                            Container(
                              //   alignment: Alignment.bottomRight,
                              padding: EdgeInsets.all(5),
                              child: Wrap(
                                // spacing: 35,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Visibility(
                                          visible: installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceStatus ==
                                                      "Reassignment" ||
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceStatus ==
                                                      "Completed"
                                              ? false
                                              : true,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AllColors.textColor2,
                                                side: BorderSide(
                                                    color:
                                                        AllColors.primaryDark1,
                                                    width: 1),
                                              ),
                                              onPressed: () {
                                                installation_deatils_page_controller
                                                    .reason_description_controller
                                                    .clear();
                                                installation_deatils_page_controller
                                                    .reason_code_controller
                                                    .clear();
                                                ReAssignRequestDialog(context);
                                              },
                                              child: Text(
                                                "Re- Assignment",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                //overflow: TextOverflow.ellipsis,
                                              )),
                                          /*
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [


                                          ],
                                        ),*/
                                        ),
                                      );
                                    },
                                  ),
                                  Obx(() {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Visibility(
                                        visible: (installation_deatils_page_controller
                                                            .service_installation_details_list[
                                                                0]
                                                            .serviceStatus ==
                                                        "Rescheduled" &&
                                                    installation_deatils_page_controller
                                                            .service_installation_details_list[
                                                                0]
                                                            .recheduleApprovalStatus ==
                                                        "Pending") ||
                                                installation_deatils_page_controller
                                                        .service_installation_details_list[
                                                            0]
                                                        .serviceStatus ==
                                                    "Completed"
                                            ? false
                                            : true,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AllColors.textColor2,
                                                side: BorderSide(
                                                    color:
                                                        AllColors.primaryDark1,
                                                    width: 1)),
                                            onPressed: () {
                                              installation_deatils_page_controller
                                                  .reschdule_date_controller
                                                  .clear();
                                              installation_deatils_page_controller
                                                  .reschdule_remark_controller
                                                  .clear();
                                              installation_deatils_page_controller
                                                  .reason_code_controller
                                                  .clear();
                                              ReSchduleRequestDialog(context);
                                            },
                                            child: Text(
                                              "Re-Schedule",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                      ),
                                    );
                                  }
                                      // child:
                                      ),
                                  Obx(
                                    () {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Visibility(
                                          visible: installation_deatils_page_controller
                                                      .service_installation_details_list[
                                                          0]
                                                      .serviceStatus
                                                      ?.toLowerCase() !=
                                                  "completed" &&
                                              installation_deatils_page_controller
                                                      .service_installation_details_list[
                                                          0]
                                                      .isReplaceSerial ==
                                                  1,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AllColors.textColor2,
                                                  side: BorderSide(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      width: 1)),
                                              onPressed: () {
                                                updateSerialDialog(context,installation_deatils_page_controller
                                                    .service_installation_details_list[
                                                0]);
                                              },
                                              child: Text(
                                                "Update Serial",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                  Obx(
                                    () {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Visibility(
                                          visible: installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceStatus ==
                                                      "Reassignment" ||
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceStatus ==
                                                      "Completed"
                                              ? false
                                              : true,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AllColors.textColor2,
                                                  side: BorderSide(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      width: 1)),
                                              onPressed: () {
                                                installation_deatils_page_controller
                                                    .InstallationMarkVisitApi();

                                                //  markVisitDialog(context);
                                              },
                                              child: Text(
                                                "Mark Visit",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                  Obx(
                                    () {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Visibility(
                                          visible: installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceStatus ==
                                                      "Completed" ||
                                                  installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceStatus ==
                                                      "Reassignment"
                                              ? true
                                              : false,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AllColors.textColor2,
                                                  side: BorderSide(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      width: 1)),
                                              onPressed: () {
                                                Get.toNamed(RoutesName
                                                    .installation_mark_visit);
                                                installation_deatils_page_controller
                                                    .IndentHeaderListApi();

                                                //  markVisitDialog(context);
                                              },
                                              child: Text(
                                                "GoTo Next",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            /*   Container(
                            //  height: size.height*.16,
                              margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
                              padding: EdgeInsets.only(left: 6.0, top: 0, right: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                  //  height: size.height*.1,
                                    child: Obx(() {
                                        return Visibility(
                                          visible: installation_deatils_page_controller
                                              .service_installation_details_list[
                                          0]
                                              .serviceStatus ==
                                              "Reassignment" ||
                                              installation_deatils_page_controller
                                                  .service_installation_details_list[
                                              0]
                                                  .serviceStatus ==
                                                  "Completed"
                                              ? false
                                              : true,
                                          child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                            AllColors.textColor2,
                                                            side: BorderSide(
                                                                color: AllColors
                                                                    .primaryDark1,
                                                                width: 1),

                                                        ),
                                                        onPressed: () {
                                                          ReAssignRequestDialog(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Re- Assignment",
                                                          style: GoogleFonts.poppins(
                                                            color:
                                                            AllColors.primaryDark1,
                                                            fontSize:
                                                            AllFontSize.fourtine,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          //overflow: TextOverflow.ellipsis,
                                                        )
                                                    ),
                                                  ),
                                                  Obx((){
                                                    return Visibility(
                                                      visible: installation_deatils_page_controller
                                                          .service_installation_details_list[0]
                                                          .serviceStatus ==
                                                          "Rescheduled"?false:true,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                              AllColors.textColor2,
                                                              side: BorderSide(
                                                                  color: AllColors
                                                                      .primaryDark1,
                                                                  width: 1)),
                                                          onPressed: () {
                                                            ReSchduleRequestDialog(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Re-Schedule",
                                                            style: GoogleFonts.poppins(
                                                              color:
                                                              AllColors.primaryDark1,
                                                              fontSize:
                                                              AllFontSize.fourtine,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          )),
                                                    );
                                            }
                                                   // child:
                                                  ),
                                                ],
                                              )),
                                        );
                                      },

                                    ),
                                  ),

                                   SizedBox(height:1.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () {
                                          return Visibility(
                                            visible:
                                                installation_deatils_page_controller.
                                                service_installation_details_list[0].serviceStatus ==
                                                            "Reassignment" ||
                                                        installation_deatils_page_controller.
                                               service_installation_details_list[0].serviceStatus  ==
                                                            "Completed"
                                                    ? false
                                                    : true,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AllColors.textColor2,
                                                    side: BorderSide(
                                                        color: AllColors
                                                            .primaryDark1,
                                                        width: 1)),
                                                onPressed: () {
                                                  installation_deatils_page_controller
                                                      .InstallationMarkVisitApi();
                                                  //  markVisitDialog(context);
                                                },
                                                child: Text(
                                                  "Mark Visit",
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        AllColors.primaryDark1,
                                                    fontSize:
                                                        AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                          );
                                        },
                                        //child:
                                      ),
                                        Container(
                                          child:   Obx(() {
                                            return Visibility(
                                              visible:
                                              installation_deatils_page_controller.
                                              service_installation_details_list[0].serviceStatus ==
                                                  "Completed" ||  installation_deatils_page_controller.
                                              service_installation_details_list[0].serviceStatus ==
                                                  "Reassignment"
                                                  ? true
                                                  : false,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      AllColors.textColor2,
                                                      side: BorderSide(
                                                          color: AllColors
                                                              .primaryDark1,
                                                          width: 1)),
                                                  onPressed: () {
                                                    Get.toNamed(RoutesName
                                                        .installation_mark_visit);
                                                    installation_deatils_page_controller
                                                        .IndentHeaderListApi();

                                                    //  markVisitDialog(context);
                                                  },
                                                  child: Text(
                                                    "GoTo Next",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                      AllColors.primaryDark1,
                                                      fontSize:
                                                      AllFontSize.fourtine,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  )),
                                            );
                                          },
                                        ),
                                       ),
                                       SizedBox(width: size.width*.1,),

                                      Obx(() {
                                        return Visibility(
                                          visible:
                                          installation_deatils_page_controller.
                                          service_installation_details_list[0].serviceStatus !=
                                              "Completed"
                                              ? true
                                              : false,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  AllColors.textColor2,
                                                  side: BorderSide(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      width: 1)),
                                              onPressed: () {
                                                showOffsetClosureDialog(context);
                                              },
                                              child: Text(
                                                "Offsite Closure",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                  AllColors.primaryDark1,
                                                  fontSize:
                                                  AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        );
                                      },
                                        //child:
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),*/

                            // },)
                          ],
                        )),
                    Obx(
                      () {
                        return Container(
                          // padding: EdgeInsets.only(right: 30),
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Service History(${installation_deatils_page_controller.service_installation_details_list[0].serviceStatus})",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Obx(
                                () {
                                  return IconButton(
                                    onPressed: () {
                                      installation_deatils_page_controller
                                          .toggle();
                                      if (installation_deatils_page_controller
                                              .isExpand.value ==
                                          true) {
                                        print(
                                            "If......${installation_deatils_page_controller.isExpand.value}");
                                      } else {
                                        print(
                                            "else......${installation_deatils_page_controller.isExpand.value}");
                                      }
                                    },
                                    icon: Icon(
                                      installation_deatils_page_controller
                                              .isExpand.value
                                          ? Icons.arrow_drop_down
                                          : Icons.arrow_drop_up,
                                      size: 25,
                                      color: AllColors.primaryDark1,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                      // child:
                    ),
                    Divider(
                      height: 3,
                      color: AllColors.primaryDark1,
                    ),
                    Obx(
                      () => bindListView(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ReAssignRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Fill Details...',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            height: 200,
            child: Column(
              children: [
                bindReasonDropDown(context,'Reassignment'),
                TextFormField(
                  controller: installation_deatils_page_controller
                      .reason_description_controller,
                  //   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Reason Remark ",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        //  Navigator.pop(context);
                        installation_deatils_page_controller
                            .reAssignRequestApi(context);
                        // todo  Your onPressed logic...
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Ok',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        installation_deatils_page_controller
                            .reason_code_controller
                            .clear();
                        installation_deatils_page_controller
                            .reason_description_controller
                            .clear();
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bindReasonDropDown(context, String sub_reason_type) {
    installation_deatils_page_controller.reason_master_list.value = [];
    return Autocomplete<ReasonModel>(
      displayStringForOption: _displayReasonCodeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return installation_deatils_page_controller.reason_master_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return await installation_deatils_page_controller
            .getSearchReasonMaster(textEditingValue.text,sub_reason_type);
      },
      onSelected: (ReasonModel selection) {
        print(selection.reasonCode);
        installation_deatils_page_controller.reason_code_controller.text =
            _displayReasonCodeForOption(selection).toString();
        installation_deatils_page_controller.reason_code =
            selection.reasonCode!;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              FocusScope.of(context).unfocus();
            }
            installation_deatils_page_controller.reason_code_controller.text =
                value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = installation_deatils_page_controller
                .reason_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Enter Reason Code.',
            labelText: 'Enter Reason Code',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ReasonModel> onSelected,
          Iterable<ReasonModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              width: size.width * .61,
              height: size.height * .15,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ReasonModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.reasonCode.toString(),
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

  ReSchduleRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Fill Details...',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            height: 220,
            child: Column(
              children: [
                bindReasonDropDown(context, 'Reschedule'),
                TextFormField(
                  controller: installation_deatils_page_controller
                      .reschdule_remark_controller,
                  //   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Reschedule Remark ",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                bindDatePicker(context),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        //Navigator.pop(context);

                        installation_deatils_page_controller
                            .reSchduleRequestApi(context);
                        // todo  Your onPressed logic...
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Ok',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        installation_deatils_page_controller
                            .reason_code_controller
                            .clear();
                        installation_deatils_page_controller
                            .reschdule_date_controller
                            .clear();
                        installation_deatils_page_controller
                            .reschdule_remark_controller
                            .clear();
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /* Widget bindDatePicker(context) {
    return TextFormField(
      controller:
          installation_deatils_page_controller.reschdule_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w500,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
        DateTime ending_date = new DateTime(2200);
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: stating_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                //accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        //var outputFormat = DateFormat('dd-MM-yyyy');
        var outputFormat = DateFormat('yyyy-MM-dd');

        if (date != null && date != "")
          installation_deatils_page_controller.reschdule_date_controller.text =
              outputFormat.format(date);
        else
          installation_deatils_page_controller.reschdule_date_controller.text =
              "";
      },
    );
  }*/

  Widget bindDatePicker(BuildContext context) {
    return TextFormField(
      controller:
          installation_deatils_page_controller.reschdule_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          /*fontWeight: FontWeight.w500,
            fontSize: AllFontSize.sisxteen*/
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime starting_date = DateTime.now();
        DateTime ending_date = DateTime(2200);
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: starting_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        var outputFormat = DateFormat('yyyy-MM-dd');

        if (date != null) {
          installation_deatils_page_controller.reschdule_date_controller.text =
              outputFormat.format(date);
        } else {
          installation_deatils_page_controller.reschdule_date_controller.text =
              "";
        }
      },
    );
  }

  Widget setupAlertDialoadContainer() {
    if (installation_deatils_page_controller.item_details_list.length > 0 &&
        installation_deatils_page_controller.item_details_list.isNotEmpty &&
        installation_deatils_page_controller.item_details_list.value != null) {
      return Obx(
        () {
          return Container(
            height: 300.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: AllColors.lightgreyColor,
                );
              },
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount:
                  installation_deatils_page_controller.item_details_list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Item :",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w500,
                                fontSize: AllFontSize.fourtine),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * .2,
                            child: Tooltip(
                              message:
                                  "${installation_deatils_page_controller.item_details_list[index].displayName ?? ""}${installation_deatils_page_controller.item_details_list[index].componentProductCode.toString()})",
                              child: Text(
                                "${installation_deatils_page_controller.item_details_list[index].displayName ?? ""}"
                                "(${installation_deatils_page_controller.item_details_list[index].componentProductCode.toString()})",
                                style: GoogleFonts.poppins(
                                    color: AllColors.textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AllFontSize.fourtine),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "Quality :",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w500,
                                fontSize: AllFontSize.fourtine),
                          ),
                          Spacer(),
                          Text(
                            installation_deatils_page_controller
                                .item_details_list[index].componentQuantity
                                .toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: AllFontSize.fourtine),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "Price :",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w500,
                                fontSize: AllFontSize.fourtine),
                          ),
                          Spacer(),
                          Text(
                            installation_deatils_page_controller
                                .item_details_list[index].componentPrice
                                .toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: AllFontSize.fourtine),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
        // child:
      );
    } else {
      return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0,
        child: Center(
          child: Image.asset(
            "assests/images/no_data_remove.png",
            width: 300,
            height: 180,
          ),
        ),
      );
    }
  }

  void ShowItemDetailsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Item  Details',
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.sisxteen),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: AllColors.primaryDark1,
                          size: 20,
                        ))
                  ],
                ),
                Divider(
                  color: AllColors.lightgreyColor,
                  height: 1,
                )
              ],
            ),
            content: Obx(
              () {
                return setupAlertDialoadContainer();
              },

              //   child:
            ),
          );
        });
  }

  showOffsetClosureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Fill  Details...',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            height: 180,
            child: Column(
              children: [
                TextFormField(
                  controller: installation_deatils_page_controller
                      .closure_remark_controller,
                  decoration: InputDecoration(
                    labelText: "Enter Closure Remark ",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        installation_deatils_page_controller.MarkClosureApi();

                        // todo  Your onPressed logic...
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Ok',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        installation_deatils_page_controller
                            .closure_remark_controller
                            .clear();
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bindListView(BuildContext context) {
    ScrollController scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    return installation_deatils_page_controller
                    .service_installation_details_list[0]
                    .serviceHistory!
                    .length >
                0 &&
            installation_deatils_page_controller
                .service_installation_details_list[0]
                .serviceHistory!
                .isNotEmpty &&
            installation_deatils_page_controller
                    .service_installation_details_list[0].serviceHistory !=
                null
        ? Flexible(
            child: Obx(
              () {
                return Visibility(
                  visible:
                      installation_deatils_page_controller.isExpand.value ==
                              true
                          ? true
                          : false,
                  child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: installation_deatils_page_controller
                          .service_installation_details_list![0]!
                          .serviceHistory!
                          .length,
                      itemBuilder: (context, index) {
                        var count = index + 1;
                        var timeLine_date_month = StaticMethod.dateTimeToDate(
                            installation_deatils_page_controller
                                .service_installation_details_list[0]
                                .serviceHistory![index]
                                .createdOn!);
                        var timeLine_date =
                            StaticMethod.onlyMonthNameThreeCharacter(
                                installation_deatils_page_controller
                                    .service_installation_details_list[0]
                                    .serviceHistory![index]
                                    .createdOn!);

                        var timeLine_time = StaticMethod.onlyTime(
                            installation_deatils_page_controller
                                    .service_installation_details_list[0]
                                    .serviceHistory![index]
                                    .createdOn ??
                                "");
                        print(installation_deatils_page_controller
                            .service_installation_details_list[0]
                            .serviceHistory![index]
                            .createdOn);
                        return Container(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        //right: 10,
                                        bottom: 10,
                                        top: 40),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Tooltip(
                                            message: timeLine_date_month,
                                            child: Text(
                                              timeLine_date!,
                                              style: GoogleFonts.poppins(
                                                color: AllColors.textColor,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          width: size.width * 0.11,
                                        ),
                                        SizedBox(width: size.width * 0.12),
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 4),
                                                width: size.width * .71,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          offset:
                                                              Offset(0.0, 0.55),
                                                          blurRadius: 0.7,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color:
                                                              Colors.black54),
                                                    ],
                                                    color:
                                                        AllColors.whiteColor),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceHistory![
                                                              index]
                                                          .documentStatus!,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AllColors.textColor,
                                                        fontSize: AllFontSize
                                                            .fourtine,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      installation_deatils_page_controller
                                                          .service_installation_details_list[
                                                              0]
                                                          .serviceHistory![
                                                              index]
                                                          .createdBy!,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AllColors.textColor,
                                                        fontSize:
                                                            AllFontSize.nine,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                decoration: BoxDecoration(
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          offset:
                                                              Offset(0.0, 0.55),
                                                          blurRadius: 0.5,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color: Colors.black54)
                                                    ],
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3),
                                                        width: size.width * .7,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "Message:  ",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AllColors
                                                                            .primaryDark1,
                                                                        // Change this to your desired color for "Message:"
                                                                        fontSize:
                                                                            AllFontSize.fourtine,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: installation_deatils_page_controller
                                                                          .service_installation_details_list[
                                                                              0]
                                                                          .serviceHistory![
                                                                              index]
                                                                          .actionMessage
                                                                          .toString()!,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AllColors
                                                                            .textColor,
                                                                        // This keeps the rest of the text color unchanged
                                                                        fontSize:
                                                                            AllFontSize.twelve,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                              Obx(
                                                                () {
                                                                  return Visibility(
                                                                    visible: installation_deatils_page_controller.service_installation_details_list[0].serviceHistory![index].remark !=
                                                                            null &&
                                                                        installation_deatils_page_controller
                                                                            .service_installation_details_list[0]
                                                                            .serviceHistory![index]
                                                                            .remark!
                                                                            .isNotEmpty,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              1.0),
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: RichText(
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: "Remark:  ",
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: AllColors.primaryDark1,
                                                                                        fontSize: AllFontSize.fourtine,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                    if (installation_deatils_page_controller.service_installation_details_list[0].serviceHistory![index].remark != null && installation_deatils_page_controller.service_installation_details_list[0].serviceHistory![index].remark!.isNotEmpty)
                                                                                      TextSpan(
                                                                                        text: installation_deatils_page_controller.service_installation_details_list[0].serviceHistory![index].remark.toString()!,
                                                                                        style: GoogleFonts.poppins(
                                                                                          color: AllColors.textColor,
                                                                                          fontSize: AllFontSize.fourtine,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                                softWrap: true,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            2.0),
                                                                    child: Text(
                                                                      timeLine_time
                                                                          .toString(),
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AllColors
                                                                            .textColor,
                                                                        fontSize:
                                                                            AllFontSize.ten,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ])),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 70,
                                    // left: 10,
                                    child: new Container(
                                      height: size.height * 0.7,
                                      width: 1.0,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          bottom: 70,
                                          right: 20),
                                      child: Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            count.toString(),
                                            style: GoogleFonts.poppins(
                                              color: AllColors.whiteColor,
                                              fontSize: AllFontSize.ten,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              },
            ),
          )
        : Text("");
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

  Future updateSerialDialog(BuildContext context, ServiceInstallationDetails service_installation_details_list) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text("Update Serial",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w500,
              ),
            ),
            content:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: installation_deatils_page_controller
                      .serialNoController,
                  decoration: InputDecoration(
                    labelText: "Enter Serial No.",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DefaultButton(
                        text: 'Ok',
                        press: (){
                          installation_deatils_page_controller.serviceSerialNumberUpdate(
                              service_installation_details_list.id??0, service_installation_details_list.serialNo??"", context
                          );
                        },
                      ),
                    ),
                     SizedBox(width: 10,),
                    Expanded(
                      child: DefaultButton(
                        text: 'Cancel',
                        press: (){
                          Navigator.pop(context);
                          installation_deatils_page_controller
                              .serialNoController
                              .clear();
                        },
                      ),
                    ),

                  ],
                )
              ],
            ),
            );
        });
  }
}
