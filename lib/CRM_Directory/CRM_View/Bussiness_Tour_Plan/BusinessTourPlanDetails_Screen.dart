import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/component/circular_loading.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/Bussiness_Tour_Plan_Vm/BusinessPlanTour_Vm.dart';

class BusinessTourPlanDeatil extends StatelessWidget {
  BusinessTourPlanDeatil({super.key});

  BusinessPlanTourViewModel businessTourPlanController = Get.put(BusinessPlanTourViewModel());
  Size size = Get.size;

  static String _displayApproveRejectForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if(businessTourPlanController.isSendForApproval.value == "TourDetail"){
            businessTourPlanController.clearAllFieldOfFilter();
            businessTourPlanController.pageNumber = 0;
            businessTourPlanController.getBusinessTourPlanData(businessTourPlanController.pageNumber);
            Get.toNamed(RoutesName.BusinessTourPlanScreen);
          }else if(businessTourPlanController.isSendForApproval.value == "ApproveRejectPage"){
            Get.toNamed(RoutesName.BusinessTourApproveRejectListScreen);
          }else {
          Get.toNamed(RoutesName.BusinessTourApprovalListScreen);
          }

          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: AllColors.primaryDark1,
              iconTheme: IconThemeData(
                color: AllColors.whiteColor,
              ),
              title: Row(
                children: [
                  Text(
                    'Tour Header \n(${businessTourPlanController.BusinessTourPlanDetails_list[0].tourId})',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Obx((){
                    return Visibility(
                      visible:businessTourPlanController.isHeadOfficePermission!="1"&&
                      businessTourPlanController.BusinessTourHourLines.isEmpty? true : false,
                      child: ActionChip(
                        elevation: 2,
                        padding: EdgeInsets.all(5),
                        backgroundColor: AllColors.primaryDark1,
                        shadowColor: Colors.black,
                        shape: StadiumBorder(
                            side: BorderSide(color: AllColors.whiteColor)),
                        //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                        //CircleAvatar
                        label: Tooltip(
                          message: "Discard",
                          child: Text('Discard',
                              style: GoogleFonts.poppins(
                                color: AllColors.whiteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        onPressed: () async {
                          ConfirmationDialog(context, businessTourPlanController.BusinessTourPlanDetails_list[0].tourId??"", 'Discard', 'Do You Want To Discard This  Header ?');
                        }, //Text
                      ),
                    );
                  }),
                  Obx((){
                    return Visibility(
                      visible:businessTourPlanController.isHeadOfficePermission!="1"&&
                      businessTourPlanController.BusinessTourHourLines.isNotEmpty &&  businessTourPlanController.BusinessTourPlanDetails_list[0].status == "PENDING"? true : false,
                      child: ActionChip(
                        elevation: 2,
                        padding: EdgeInsets.all(5),
                        backgroundColor: AllColors.primaryDark1,
                        shadowColor: Colors.black,
                        shape: StadiumBorder(
                            side: BorderSide(color: AllColors.whiteColor)),
                        //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                        //CircleAvatar
                        label: Tooltip(
                          message: "Send For Approval",
                          child: Text('Send For Approval',
                              style: GoogleFonts.poppins(
                                color: AllColors.whiteColor,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        onPressed: () async {
                          ConfirmationDialogSendForApproval(context, businessTourPlanController.BusinessTourPlanDetails_list[0].tourId??"");
                        }, //Text
                      ),
                    );
                  }),
                 /* Obx((){
                    return Visibility(
                        visible:((businessTourPlanController.BusinessTourPlanDetails_list[0].reportingManager==businessTourPlanController.email ||
                            businessTourPlanController.isAdminWritePermission=='1')
                            && businessTourPlanController.isHeadOfficePermission!='1'
                            && (businessTourPlanController.isSendForApproval.value == "SendForApproval"||
                                businessTourPlanController.isSendForApproval.value =="TourDetail")
                            && businessTourPlanController.BusinessTourPlanDetails_list[0].status?.toLowerCase().trim()=="pending for approval") ?true:false,
                        child: IconButton(
                          icon: Icon(Icons.edit ,),
                          onPressed: (){
                            showApprovRejectDialog(context, businessTourPlanController.BusinessTourPlanDetails_list[0].tourId??"");

                          },
                        )
                    );
                  }),
                  Obx((){
                    return Visibility(
                      visible:businessTourPlanController.isHeadOfficePermission!="1"&&
                      businessTourPlanController.BusinessTourHourLines.isNotEmpty &&  businessTourPlanController.BusinessTourPlanDetails_list[0].status != "PENDING"? true : false,
                      child: IconButton(
                        icon: Icon(Icons.download_for_offline_sharp ,size: 30,),
                        onPressed: (){
                          businessTourPlanController.businessPlanReportDownload(businessTourPlanController.BusinessTourPlanDetails_list[0].tourId??"");
                        },
                      )
                    );
                  }),*/

                  Obx(() {
                    bool showEdit =
                    ((businessTourPlanController.BusinessTourPlanDetails_list[0].reportingManager ==
                        businessTourPlanController.email ||
                        businessTourPlanController.isAdminWritePermission == '1') &&
                        businessTourPlanController.isHeadOfficePermission != '1' &&
                        (businessTourPlanController.isSendForApproval.value == "SendForApproval" ||
                            businessTourPlanController.isSendForApproval.value == "TourDetail") &&
                        businessTourPlanController.BusinessTourPlanDetails_list[0].status
                            ?.toLowerCase()
                            .trim() ==
                            "pending for approval");

                    bool showDownload =
                        businessTourPlanController.isHeadOfficePermission != "1" &&
                            businessTourPlanController.BusinessTourHourLines.isNotEmpty &&
                            businessTourPlanController.BusinessTourPlanDetails_list[0].status != "PENDING";

                    return Visibility(
                      visible: showEdit || showDownload,
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: AllColors.whiteColor),
                        onSelected: (value) {
                          if (value == "edit") {
                            showApprovRejectDialog(
                                context,
                                businessTourPlanController.BusinessTourPlanDetails_list[0].tourId ?? "");
                          }

                          if (value == "download") {
                            businessTourPlanController.businessPlanReportDownload(
                                businessTourPlanController.BusinessTourPlanDetails_list[0].tourId ?? "");
                          }
                        },
                        itemBuilder: (context) => [

                          if (showEdit)
                            PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 18,color: Colors.black),
                                  SizedBox(width: 10),
                                  Text("Approve / Reject"),
                                ],
                              ),
                            ),

                          if (showDownload)
                            PopupMenuItem(
                              value: "download",
                              child: Row(
                                children: [
                                  Icon(Icons.download_for_offline_sharp, size: 18,color: Colors.black,),
                                  SizedBox(width: 10),
                                  Text("Download Report"),
                                ],
                              ),
                            ),

                        ],
                      ),
                    );
                  })
                ],
              ),
          ),
          drawer: CustomDrawer(),
          body: Obx((){
            if(businessTourPlanController.loading.value){
              return const FullScreenLoader();
            }
            return  Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible: businessTourPlanController.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Expanded(
                    child: ListView(
                      children: [
                        Obx(() {
                          return BindHeaderData(context);
                        }),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tour Lines",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.eighteen,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Visibility(
                                visible: businessTourPlanController.isHeadOfficePermission!="1"&& businessTourPlanController.BusinessTourPlanDetails_list[0].status?.toUpperCase() ==  'PENDING',
                                child: GestureDetector(
                                  onTap: () {
                                    businessTourPlanController.clearAllCreateLinePlanController();
                                    businessTourPlanController.getEmpMstEmailByApi();
                                    businessTourPlanController.getTourPlanDistrictTypeApi('');
                                    businessTourPlanController.getTourTypeApi();
                                    businessTourPlanController.getTourPlanAccountTypeApi("");
                                    Get.toNamed(RoutesName.AddTourLinesPage);
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Icon(
                                        Icons.add,
                                        color: AllColors.primaryDark1,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border:
                                        Border.all(color: AllColors.primaryDark1)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: AllColors.bluegrayColor,
                        ),
                        Obx(() {
                          return bindTourLinesData(context);
                        }),
                      ],
                    ))
              ],
            );
          }),


        ));
  }

  ConfirmationDialog(context, String TourId, String title, String description){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.delete_forever, color: AllColors.redColor,),
                SizedBox(width: 5,),
                Text(
                    title+" !",
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              if(title == 'Discard'){
                                businessTourPlanController.BusinessTourPlanHeaderDelete(TourId);
                              }else if(title == 'Approve'){
                                businessTourPlanController.BusinessTourPlanApproveReject(TourId, 'APPROVED');
                              }else if(title == 'Reject'){
                                businessTourPlanController.BusinessTourPlanApproveReject(TourId, 'REJECTED');
                              }
                              Navigator.pop(context);

                            },
                            child: Container(
                              //width: 60,
                              alignment: Alignment.center,
                              child: Text(title,
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),]
            ),
          );

        });
  }

  showApprovRejectDialog(context, String TaskId) {
    businessTourPlanController.ApproveReject_Controller.clear();
    businessTourPlanController.RejectReason_Controller.value.clear();
    businessTourPlanController.manager_remark_Controller.value.clear();
   // businessTourPlanController.ApproveBool.value = false;
    businessTourPlanController.RejectBool.value = false;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                'Update Tour Header',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              content: Wrap(
                children: [
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  const SizedBox(height: 15,),
                  bindApprovRejectDropDown(context),
                  const SizedBox(height: 15,),
                  bindInputData(businessTourPlanController.remarkController.value,"Enter Manager Remark"),
                  const SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible: businessTourPlanController.RejectBool
                          .value,
                      child: bindInputData(businessTourPlanController.RejectReason_Controller.value,"Reject Reason"),
                    );
                  }),
                  SizedBox(height: 55,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: !businessTourPlanController.RejectBool.value,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: () {
                              if (businessTourPlanController
                                  .ApproveReject_Controller.text.isEmpty ||
                                  businessTourPlanController
                                      .ApproveReject_Controller == null) {
                                Utils.sanckBarError(
                                    'Error : ', 'Please select Type.');
                                return;
                              }
                              Navigator.pop(context);
                              ConfirmationDialog(context, TaskId, 'Approve', 'Do you want to Approve this header?' );
                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Approve',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      ),
                      Obx(() {
                        return Visibility(
                            visible: businessTourPlanController.RejectBool
                                .value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                    Color>(
                                  AllColors.lightredColor,
                                ),
                              ),
                              onPressed: () {
                                if (businessTourPlanController
                                    .ApproveReject_Controller.text ==
                                    "Reject") {
                                  if (businessTourPlanController.RejectReason_Controller.value.text.isEmpty ||
                                      businessTourPlanController.RejectReason_Controller.value == null) {
                                    Utils.sanckBarError('Error : ',
                                        'Please Enter Reject Reason.');
                                  } else {
                                    Navigator.pop(context);
                                    ConfirmationDialog(context, TaskId, "Reject",'Do you want to Reject this header?');
                                    //TaskMaster_page_controller.UpdateTaskStatus(context);
                                  }
                                }
                              },
                              child: Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: Text('Reject',
                                  /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ));
                      })
                      ,
                    ],)
                ],
              )
          );
        });
  }
  Widget bindInputData(TextEditingController controller,String hintdata){
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintdata,
            labelText: hintdata,
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.ten,
                horizontal: AllFontSize.ten),

            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AllColors.primaryDark1)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),

      ),
    );
  }

  Widget bindApprovRejectDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayApproveRejectForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return businessTourPlanController.approveRejectList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return businessTourPlanController.approveRejectList.where((String option) {
          return option.toString().toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        // Update the TextField with the selected
        businessTourPlanController.ApproveReject_Controller.text =
            _displayApproveRejectForOption(selection).toString();
        if (businessTourPlanController.ApproveReject_Controller.text ==
            'Approve') {
          businessTourPlanController.ApproveReject = "Approved";
          businessTourPlanController.RejectBool.value = false;
        } else {
          businessTourPlanController.ApproveReject = "Rejected";
          businessTourPlanController.RejectBool.value = true;

        }
        //print('IsActive.....${accountMaster_page_controller.IsActive_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            onTap: () {
              focusNode.requestFocus();
              controller.clear();
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = businessTourPlanController.ApproveReject_Controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    focusNode.requestFocus();
                    controller.clear();
                  },
                  child: Icon(Icons.arrow_drop_down)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Task Status',
              labelText: 'Task Status',
              /*hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten
              ),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AllColors.primaryDark1), // Change the color to green
              ),*/

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
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
              width: size.width * .5,
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
    );
  }

  ConfirmationDialogSendForApproval(context, String TourId){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.info, color: AllColors.textColor,),
                SizedBox(width: 5,),
                Text(
                    'Send !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do You Want To Send This For Approval?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              businessTourPlanController.BusinessTourPlanHeaderComplete(TourId);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),]
            ),
          );

        });
  }

  ConfirmationDeleteLineDialog(context, String TourId, String LineNo){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.delete_forever, color: AllColors.redColor,),
                SizedBox(width: 5,),
                Text(
                    'Delete !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do You Want To Delete This Line ?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              businessTourPlanController.BusinessTourPlanLinesDelete(TourId, LineNo);
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Delete',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),]
            ),
          );

        });
  }

  Widget BindHeaderData(BuildContext context) {
    String? dateTimeCreatedOn = StaticMethod.dateTimeToDate(
        businessTourPlanController.BusinessTourPlanDetails_list[0].createdOn ??
            "");
    String? StartDate = StaticMethod.convertDateFormat1(
        businessTourPlanController.BusinessTourPlanDetails_list[0].startDate ??
            "");
    String? EndDate = StaticMethod.convertDateFormat1(
        businessTourPlanController.BusinessTourPlanDetails_list[0].endDate ??
            "");
    String Status =
        businessTourPlanController.BusinessTourPlanDetails_list[0].status ?? "";
    Color getStatusColor(String status) {
      switch (status) {
        case 'PENDING' || 'Pending':
          return Colors.yellow[900]!;
        case 'Rejected' || 'REJECTED':
          return AllColors.redColor;
        case 'APPROVED' || 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL' || 'Pending For Approval':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
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
                labelText: 'Sales Details',
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
                  _buildLabelWithValue(label: "Tour ID: ", value: businessTourPlanController.BusinessTourPlanDetails_list[0].tourId ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Cluster: ", value: businessTourPlanController.BusinessTourPlanDetails_list[0].cluster ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Region: ", value: businessTourPlanController.BusinessTourPlanDetails_list[0].region ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Touring Region: ", value: businessTourPlanController.BusinessTourPlanDetails_list[0].touringRegion ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Reporting Manager: ", value: businessTourPlanController.BusinessTourPlanDetails_list[0].reportingFullName ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Status: ", value: Status, color:  getStatusColor(Status)),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Start Date: ", value:StartDate ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "End Date: ", value:EndDate ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(label: "Created On: ", value:dateTimeCreatedOn ?? "",),
                  const SizedBox(height: 3,),
                  _buildLabelWithValue(
                    label: "Remark: ",
                    value: businessTourPlanController.BusinessTourPlanDetails_list[0].remarks??"",
                  ),
                  const SizedBox(height: 3,),
                  Visibility(
                    visible: (Status=="Rejected" || Status=="REJECTED" || Status=="APPROVED"|| Status=="Approved"),
                    child: _buildLabelWithValue(
                      label: "Manager Remark: ",
                      value: businessTourPlanController.BusinessTourPlanDetails_list[0].managerRemarks??"",
                    ),),

                ],
              ),
            ),
          ),
        ],
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

  Widget bindTourLinesData(BuildContext context) {
    if (businessTourPlanController.BusinessTourHourLines.value.isNotEmpty &&
        businessTourPlanController.BusinessTourHourLines.value.length > 0) {
      ScrollController scrollController = ScrollController();
      return Obx(
        () {
          return Container(
            height: size.height / 2,
            child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.only(bottom: 10),
                separatorBuilder: (context, index) => Divider(
                      height: .05,
                      color: Colors.transparent,
                    ),
                shrinkWrap: true,
                itemCount: businessTourPlanController
                    .BusinessTourHourLines.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return bindLinesListView(context, index);
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

  Widget bindLinesListView(BuildContext context, int index) {
    String? dateCreatedOn = StaticMethod.convertDateFormat1(
        businessTourPlanController.BusinessTourHourLines[index].createdOn ??
            "");
    String? TourDate = StaticMethod.convertDateFormat1(
        businessTourPlanController.BusinessTourHourLines[index].tourDate ?? "");

    String MeetingWith = businessTourPlanController.formattedNames(businessTourPlanController.BusinessTourHourLines[index].meetingWith??"");
    String AccompaniedWith = businessTourPlanController.formattedNames(businessTourPlanController.BusinessTourHourLines[index].accompaniedWith??"");

    return Card(
      //margin: EdgeInsets.all(5),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Tour Id : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  businessTourPlanController.BusinessTourHourLines[index].tourId ??
                      "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            Visibility(
              visible: businessTourPlanController.BusinessTourPlanDetails_list[0].status == "PENDING",
              child: InkWell(
                  onTap: () {
                    ConfirmationDeleteLineDialog(context, businessTourPlanController.BusinessTourHourLines[index].tourId??"", businessTourPlanController.BusinessTourHourLines[index].lineNo??"" );
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 30,
                  )),
            ),
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            bindLineData(context,"Tour ID :",businessTourPlanController.BusinessTourHourLines[index].tourId.toString()),
            bindLineData(context,"Line No. :",businessTourPlanController.BusinessTourHourLines[index].lineNo.toString()),
            bindLineData(context,"Touring District : ",businessTourPlanController.BusinessTourHourLines[index].touringDistrict ?? ""),
            bindLineData(context,"Tour Date : ",TourDate.toString()),
            bindLineData(context,"Tour Type : ", businessTourPlanController.BusinessTourHourLines[index].tourType ?? ""),
            bindLineData(context,"Accompanied With : ", AccompaniedWith),
            bindLineData(context,"Customer : ", businessTourPlanController.BusinessTourHourLines[index].customer ?? ""),
            bindLineData(context,"Customer Name : ", businessTourPlanController.BusinessTourHourLines[index].customerName ?? ""),
            bindLineData(context,"Meeting With : ", MeetingWith),
            bindLineData(context,"Objective : ", businessTourPlanController.BusinessTourHourLines[index].objective ?? ""),
            bindLineData(context,"Remark : ", businessTourPlanController.BusinessTourHourLines[index].remark ?? ""),
            bindLineData(context,"Created On : ", dateCreatedOn.toString()),
          ],
        ),
      ),
    );
  }

  Widget bindLineData(BuildContext context,String fixData,String data){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fixData,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.twelve,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Tooltip(
            message: data,
            child: Text(

              data,
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.twelve,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
